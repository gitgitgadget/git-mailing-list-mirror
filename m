From: skillzero@gmail.com
Subject: Merge into locally modified files?
Date: Mon, 8 Jun 2009 10:30:22 -0700
Message-ID: <2729632a0906081030k5048cb27p6950a0decaa7396a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 08 19:30:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDigH-0007V9-Ho
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 19:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636AbZFHRaY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 13:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753769AbZFHRaX
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 13:30:23 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:24617 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270AbZFHRaV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 13:30:21 -0400
Received: by an-out-0708.google.com with SMTP id d40so6047463and.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2009 10:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=tAxieZhl67b0Dxy00sD+xifGZqsDcAOojU6JRup2DPg=;
        b=jYz+62F368sNSOfkUTefG6ODUZxP6PoSpUUWEUD/rWclz4rNZ+dRGLcDgmm+08vAm6
         Z7XihYGyT7bLbo6m7K8qOOqpoZtXdmnbu8+GW6kivFdwiikPO8KULZeFxq6o0yWwtBZE
         zxIU1V1KB2tFC2d8vNskPJvvAkgui06RbQ/Oo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=B2Brir8VAwHcU8AvVJUtfx/iqHxJc02sWPZi8Pkm5wz+TIRZKW8vN+r3vfIdOmRLu3
         b1SCK9hOIfVtMYqYKvwtm3OPX4mkv1lVBt2aIYSZaHas77SShTLt2kKbhCtWzRzeOX3v
         9DgQVqvw/h4iPaHnxYN4tHrFGuI8b9nB6hPcs=
Received: by 10.100.251.8 with SMTP id y8mr378564anh.74.1244482223000; Mon, 08 
	Jun 2009 10:30:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121094>

If I have some local changes to a file that I don't want to commit
(e.g. temp debug changes like printf's) and I see somebody else has
pushed some changes to that file, how do I merge their changes to the
file while trying to preserve my local changes (and conflicting if
it's not possible)?

After a git fetch, I tried 'git checkout --merge origin/master <path
to my locally modified file>', but that just overwrote my local
changes.

I'm converting people from CVS to git and this is a common thing
people do with CVS. They have some local changes and see that the
server has some other changes so they do 'cvs up' and it tries to
merge changes from the server into the locally modified file. The
local changes are often things that will never be committed. I know
git tries to avoid things you can't undo, but like a 'git checkout
<file>' that can't be undone, is there a way to say "merge what you
can and generate conflict markers for things you can't?".

I think what I want to do is the equivalent of rebasing for local
modified files rather than committed files.
