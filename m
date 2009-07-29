From: demerphq <demerphq@gmail.com>
Subject: Adding files to a git-archive when it is generated, and whats the 
	best way to find out what branch a commit is on?
Date: Wed, 29 Jul 2009 10:15:29 +0200
Message-ID: <9b18b3110907290115v1f30eeat748631bb09f92517@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 29 10:15:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW4K5-0002gK-BU
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 10:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbZG2IPc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 04:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbZG2IPb
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 04:15:31 -0400
Received: from mail-gx0-f213.google.com ([209.85.217.213]:44975 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581AbZG2IPa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 04:15:30 -0400
Received: by gxk9 with SMTP id 9so1151723gxk.13
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 01:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=t3X9zY8akgOmYQTtOSKpykqlPrJjUCUWaCzBz3a4jww=;
        b=Arw3rpgo77I6+03leL7mdDtNOVSSUKA7ea4pPVh1MX/2YwFdGFV4IGd3dw50Mcd+s0
         /SNTZRMHl3kq3HESm4ChGeySSkQJE+JpnrOBr6Oy8f007d5MsXkoAsz/+SseIq/z91WL
         5kFYps13kGQuSQlRGu67xsW2zIiY1zptY0APk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=mZuhRXuhvfLj7JH6Am8BLnNHlUnpVcaDCxm6taQqLa1lsjFOGXMEciHYav2z45GOYV
         hwL3Zzq8osDaSxM3sLTwuqkOZsgs4EN7RK87SGAi8T8JHEaSRkySNCpVFJkmPaMTGzEN
         b6GNxRhFZv9gXiiV73G7saftuEg1TydV51les=
Received: by 10.231.35.205 with SMTP id q13mr2745111ibd.17.1248855329402; Wed, 
	29 Jul 2009 01:15:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124318>

I was wondering if anybody had any suggestions on a sane way to add a
file to a git-archive when it is being produced.

For  instance build procedures that expect to be run inside of a git
WD wont work if built from an archived version of the tree. Being able
to provide a file of additional data to the archive package would be a
very convenient way to work around this.

Ideally id like to be able to specify a set of additional files to
include in the archive as part of the git-archive command line
interface, but I'd be nearly as a happy with almost any solution other
than the one I came up with, which is to use archive to generate a tar
file, then use tar to append the additional files to the tar, and then
compress it. This process turns out to be quite slow in comparison to
producing a compressed archive directly from git-archive.

Another question is whether anyone has any advice on the best way to
find out the "best" branch an arbitrary commit is on. Where best can
be flexibly definied to handle commits that are reachable from
multiple branches.  I have hacked a solution involving git-log and
grep, but it performs quite poorly. I was wondering if there is a
better solution.

cheers,
Yves



-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
