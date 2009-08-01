From: Phil Lawrence <prlawrence@gmail.com>
Subject: interactive rebase of binary files?
Date: Fri, 31 Jul 2009 22:58:58 -0500
Message-ID: <530ac78e0907312058i1fbc3685qad060d5c01f5b8ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 01 05:59:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MX5kc-0003ga-HB
	for gcvg-git-2@gmane.org; Sat, 01 Aug 2009 05:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbZHAD67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 23:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbZHAD67
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 23:58:59 -0400
Received: from mail-yw0-f183.google.com ([209.85.211.183]:65112 "EHLO
	mail-yw0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbZHAD66 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 23:58:58 -0400
Received: by ywh13 with SMTP id 13so2381148ywh.15
        for <git@vger.kernel.org>; Fri, 31 Jul 2009 20:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=YSKlDj7bHYK7tL14UM21f3QOMnTORJHi431l512+0FU=;
        b=V65MwyHVdVZ2E0SV8g+t9Ln8cqSxJawOLbP0uiTljDyXYxkaIipX6XF0mVi6tK3enb
         hHqcodjGTQPa7gCsurxG5SupNX0WNicDCs5Uj7/FS3+87+Q3I/pPvXi395FCbb/8qXbT
         vlOSjLSO7GDgvEGFA4Jdb72T/0OsJUDhCLtKk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=lx5CiM0Yl1qtV2LEiodY5Nwymajam+heLX+JnSvtPmgRSzj69CrpBY5PQqd0dxzFkA
         YT6sxYB4Y/D4WzGGeiV7bHghNCWipZI/CoY8Cxv8zeRkBJ03TRtypESJPBEYctFLNw5n
         SJHY9oyJUGoBOlqB8O/ppa/GB8a7fROOR/lAo=
Received: by 10.231.13.141 with SMTP id c13mr863163iba.56.1249099138247; Fri, 
	31 Jul 2009 20:58:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124606>

With the help of some friends, I now have an understanding of how to
tease interleaved commits out of a branch (dev, branched from master),
into two new branches (foo and bar, branched from dev):

git checkout dev
git checkout -b foo
git rebase -i master   #rebase everything SINCE master
etc., repeat for bar...

However, there is a problem with binary files.  For example, if I
specify "edit" in the git-rebase-todo list for one of the binary file
commits, only one version of the binary file is presented to me in the
working copy.  If it were a text file, I'd expect to see the standard
conflict stuff within the one file.  I'd edit and save that one file.
However, in the case of binary files, should I not see binary_file.a
and binary_file.b both in the working copy, so that I can compare and
pick a winner (or edit one of them into a winner)?

More likely, my expectations are due to my ignorance, and someone can
point me to the "git" way of doing this.  Please?

Phil Lawrence
