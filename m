From: Brent Goodrick <bgoodr@gmail.com>
Subject: How to list files that are pending for commit from a merge, including 
	hand modified files
Date: Sat, 21 Feb 2009 15:20:21 -0800
Message-ID: <e38bce640902211520j3f3c2787y28640b0ebcba5e27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 22 00:21:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lb1AO-0007Gw-W5
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 00:21:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754455AbZBUXUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 18:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754447AbZBUXUX
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 18:20:23 -0500
Received: from el-out-1112.google.com ([209.85.162.179]:59078 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754429AbZBUXUX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 18:20:23 -0500
Received: by el-out-1112.google.com with SMTP id b25so758085elf.1
        for <git@vger.kernel.org>; Sat, 21 Feb 2009 15:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=fHhu/vuH/i2ftGW7G4PVf38ZOTpHDi43n5zKLEr23Co=;
        b=MuzEY6kacTUQSI6LprnPBU2JvfznC/CkSIOmbULZYfXSmQpt3rxqNShSe5zf/v015R
         KHFv+a8S0qKKDnN67gsWlZ3gGMGSEs71xZ0lIkgnuDLpfd7QPVz65e/OfNdMcwZt72st
         5PNe9eulL2sNY4is6OFVnLCv546vIGOPZnBHU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=UP9PC7IBFG8Sld+0LICE2MWPHg85czQITA7LAv8dtebxNXIsqkfGigWfvzf7oxXuoO
         /zirlPBKVyJPJLVlSTsIvJGL7JVm3KFkSXCAsOkJmg2MHAfDOfwJmK6zVPl0VYXV3zZx
         uZcO/ZEa6YqjzjqTs9+WdiiA7P3ig0KgYzVYE=
Received: by 10.90.93.13 with SMTP id q13mr650004agb.51.1235258421785; Sat, 21 
	Feb 2009 15:20:21 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110985>

Hi,

git-ls-files does not seem to show files pending to be committed. The
-m option does seem to work for files that I might have edited outside
of git via an editor, but not all of the other ones pending for merge.
The -t option "seems" to imply that the info would be shown, but only
lists all files in the repo. Only git-status seems to show these files
but in a fashion that makes filtering a bit clunky. Is there some way
in which to get a listing of the files that git-status shows in its
"changes to be committed" section, but not the "Untracked files"
section, short of postprocessing the git-status output with sed/awk
gymnastics?  E.g., the first section of "modified" files and "new
file" type files, but not the junk/ directory:

# On branch work
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	modified:   .Xmodmap
#	new file:   .some_file
#	modified:   .gitignore
#	modified:   .zone.profile
#	modified:   Vncviewer
#	new file:   bin/gitw-merge-common.sh
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	junk/

Thanks,
Brent
