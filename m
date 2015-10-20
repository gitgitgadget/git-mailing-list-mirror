From: Francis Moreau <francis.moro@gmail.com>
Subject: How to handle false-positive with git-cherry ?
Date: Tue, 20 Oct 2015 18:25:02 +0200
Message-ID: <CAC9WiBjGVAq-i+-ELG4rH-axU3e0GfMDOBZgZiy9iYU37BQ=cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 20 18:25:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoZim-0005wY-Mr
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 18:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232AbbJTQZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 12:25:04 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:33845 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbbJTQZD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 12:25:03 -0400
Received: by iow1 with SMTP id 1so27928570iow.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 09:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=hGBDXlLkfHlSMUGSE05mZtFvnPcRddO2WHUnm5Zw2OA=;
        b=G1Qr0IBRZPt9PVz21qEWCfOvYxuprp0JLaKfu4zGGRFkOeMbtVTRxvKpIH+fkJSagd
         1gLqNIC9oM0OFjLpl7rPDgh8zqbhAOuIUKi/rhs/ePghjexGv6r2PCpLpK9bf/rEA6WD
         S/fJH15a8O5fBT6ByQCByP8fR3Rmtu93PUUwR7BMv8Wi2dmonEUfJjnYSIwmCXrcYsKa
         PVqUYf9c04KyzU0d3iKPVLi4VK4rQfNquHxSGTSH4vHrJ17eFC0nACgjEZPGZtbaHzPJ
         77Ma3eRRQ4uCOi/bT/KgwG744Mn6wdSaJp+AYGnuv6ESOvu3gzlNON6tc5i1vV3QuXcH
         cceg==
X-Received: by 10.107.136.140 with SMTP id s12mr4724433ioi.197.1445358302620;
 Tue, 20 Oct 2015 09:25:02 -0700 (PDT)
Received: by 10.79.77.1 with HTTP; Tue, 20 Oct 2015 09:25:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279921>

Hi,

I have several "maintainance" branches which are based on
different version of my software, which contains only fixes,
imported with 'git cherry-pick'.

I use to comparing stable branches to see if one of them is not
missing a fix for instance. For that purpose I use "git cherry"
of "git log --cherry".

But sometimes git reports me some false-positives because one fix
in a particular branch has been slighlty modified when cherry-picking
it (because the context has slighly changed between 2 versions of
my soft).

Basically I'd like to force git-cherry to assume that the
patch-id of a commit is the same as the one it's been cherry
picked from even if the diff is not exactly the same.

One way to do this would be for    git-cherry to use the string
added by "git-cherry-pick -x":

     (cherry picked from commit xxx)

and to handle the indirection in order to calculate the patch-id.

I couldn't find something equivalent of this with git, but maybe
I've missed an option... could anybody tell me if something
similar already exist ?

Thanks.
-- 
Francis
