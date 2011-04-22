From: Mike <xandrani@gmail.com>
Subject: git incorrectly infers rename i.e. (delete file1 + creation of new
 file2) != (file => file2)
Date: Fri, 22 Apr 2011 01:31:06 +0100
Message-ID: <BANLkTimqk5xP6X7NcGqZ6w05GfYe02iAhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 02:31:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QD4HO-0007A9-6h
	for gcvg-git-2@lo.gmane.org; Fri, 22 Apr 2011 02:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511Ab1DVAbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2011 20:31:09 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:55433 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994Ab1DVAbI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2011 20:31:08 -0400
Received: by vxi39 with SMTP id 39so175845vxi.19
        for <git@vger.kernel.org>; Thu, 21 Apr 2011 17:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=7A751KagxIy3RQ6c5F4uSL+s1PbEqv5VsjdMz0Lfefc=;
        b=cKy352Z8oMm4S6fS0vWU0E/95x03+rRnSmhpqtMb401vwMgBK5hgSDTYlGTjcEZUfO
         4FdD1doGtiGQMSEqnw6vOE1vuLO1TJ6/Lr/zZUDQ9VjicMqIIZTe9WyuPR+W3PCL1Sm8
         q8qyYYyF7dx2XVNVHLugoh8/NYwiX1iHc0uKA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=XzxNx9Y7BhVXllLJnhztpm9Nab7NnzKb1OkLxHumt8n55zgFvGqXfxJgqnIOnU8Xbn
         ZStHHq8JdfIF11UXnUArykcpji2oTRB2vczSzNCvoydEXmmrhjoRdVHDX6GhjwOSAjmF
         PQONlKroKmKPr1l34aAKWdzZ3qZy+Nz29lPcA=
Received: by 10.52.95.46 with SMTP id dh14mr490460vdb.60.1303432266353; Thu,
 21 Apr 2011 17:31:06 -0700 (PDT)
Received: by 10.52.161.39 with HTTP; Thu, 21 Apr 2011 17:31:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171929>

Hi

I deleted a file called 'class.NumberOfResultsCache.php' and created a
completely different file called
'cgi-bin/___php/class.NumberOfResults.php'. I deleted the file using
rm followed by 'git rm'.

When I do a 'git status' I now get told:

   renamed:    cgi-bin/___php/class.NumberOfResultsCache.php ->
cgi-bin/___php/class.NumberOfResults.php

However I want to commit 'class.NumberOfResultsCache.php' as having
been deleted, and I want to commit 'class.NumberOfResults.php' as a
brand new file.

How do I get git to do this? Apologies for a 'noob' question. Only
been using the superb git for a couple of weeks!

Thanks :)
