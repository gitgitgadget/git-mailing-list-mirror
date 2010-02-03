From: Zack Brown <zacharyb@gmail.com>
Subject: Using "git log" to find the files patched at the same time as a named 
	file
Date: Wed, 3 Feb 2010 15:38:03 -0500
Message-ID: <218b69371002031238y6a377b06x76b8f8e87ea0ee46@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 03 21:38:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NclzK-0007O7-Sf
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 21:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932756Ab0BCUiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 15:38:08 -0500
Received: from mail-yx0-f189.google.com ([209.85.210.189]:63337 "EHLO
	mail-yx0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932343Ab0BCUiG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 15:38:06 -0500
Received: by yxe27 with SMTP id 27so1525150yxe.4
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 12:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=OwcjcNXiMCcoTdCYi1S69sGVyM6s/4OcBJF/h99jKXk=;
        b=wwKKnOiGQy8z+14ELdXFpkF7mLqFwpKLqlxRh0vyy8vtsaKxmAE0RJ1K5PvMZ37BKP
         8bABZv6OQXsQIwSFTWTzhKqIIapNgFvLzQKqjm1cfiX1xt8/k7Whd153AxHu2+Z7MsNx
         8lThemTWyJPLFAHwslGPxJFQH6aVAueIsVfA0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=rblcPDxTuuu0bY96+1PYPoXQK6V0H6s6S1xfntC5k5bLciWc4lZM42HkboZLQBE1m8
         imtRt3L+oIlpUMdD4j74nLtbdPtOb8bqmYdm9qOVcCOYaxUy4I1/bV7daUORCfxp5zBX
         VSHRPrNcl+QJDRFlNIl20LeIjsaM2UQhhZEu4=
Received: by 10.150.120.25 with SMTP id s25mr688721ybc.27.1265229483647; Wed, 
	03 Feb 2010 12:38:03 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138889>

Hi folks,

If I have a filename I'm interested in, and I want to find other files
that have been modified in the same commits that modified the file I'm
interested in, how could I do that with git?

If I give the command
$ git log --name-only
then the bottom of each log entry will list all the files that were
modified by that commit. That's basically what I want, except that the
command will list all log entries, not just the ones that modified the
file I'm interested in.

If I give the command
$ git log --name-only fs/fuse/file.c
then the bottom of each log entry only lists fs/fuse/file.c, even if
the very same commit showed up in the output from the previous command
with multiple files in addition to that one. In other words, the "git
log --name-only fs/fuse/file.c" command will only list fs/fuse/file.c
as being changed, in commits that I know changed more than just that
one file.

Is there a git command that will run in roughly the same amount of
time as the ones given above (i.e. with only a single invocation of
git), but that will only output the commits that affected the file I'm
interested in, and that will also list any other files changed in
those same commits?

Many thanks,
Zack

-- 
Zack Brown
