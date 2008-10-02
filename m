From: "Giovanni Funchal" <gafunchal@gmail.com>
Subject: Files with colons under Cygwin
Date: Thu, 2 Oct 2008 16:02:23 +0200
Message-ID: <c475e2e60810020702q573570dcp31a5dc18bf98ef30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 02 16:09:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlOmK-0000Fu-S7
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 16:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752143AbYJBOCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 10:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753635AbYJBOCZ
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 10:02:25 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:19580 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684AbYJBOCY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 10:02:24 -0400
Received: by fk-out-0910.google.com with SMTP id 18so613364fkq.5
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 07:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=BqdYsmvSZX3IdKBftIFt9hPQCh7n6dXV5+XsGGbQpB4=;
        b=bBSiMjNFppDN458FGanicP1Mjw1kNhAtkaUMs+/HohhbV8f+Kqcl16xsrPdFKGBX6+
         EySSh5GFClvq3FKjLOurxVNNOBOeYhlubRuR+AvQZAmcG9ck2AsQBK/Hugwz2OgPnvca
         79gAoKmM8ClV0L2Q0xKv8x7paHdJemJFnFfOk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=aCDwj3zYiKNAEdWYvTKgiix48nvabUVhWm+0NZ9BVKaQ8EbFMbp88mInPNxR8rt6CA
         ibkc4gToreudTPi39/z/j9JEtKO++3Mppz/r6naAMYHmIGlYx49Ja9Om3WhAYnC0acoT
         magOfeD+606sDitA9ANcShySS/+E17+OFHgbU=
Received: by 10.187.224.14 with SMTP id b14mr1949807far.4.1222956143073;
        Thu, 02 Oct 2008 07:02:23 -0700 (PDT)
Received: by 10.187.245.17 with HTTP; Thu, 2 Oct 2008 07:02:23 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97334>

Hello,

Cygwin does not allow files with colons, I think this is Windows stuff
one just can't avoid. If you have files with colons in a git
repository and try pulling them on cygwin, the file is empty, its name
is truncated and the status is wrong.

linux $ date > a:b
linux $ git init
linux $ git add a:b
linux $ git commit -m test
linux $ git push
cygwin $ git pull
cygwin $ ls
-rw-r--r-- 1 funchal funchal        0 Oct  2 15:15 a
cygwin $ git status
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       a
nothing added to commit but untracked files present (use "git add" to track)

Any ideas on what should be done? (for instance, warn when pulling
this kind of files on Cygwin)

Has anyone noticed this before?

Regards,
-- Giovanni
