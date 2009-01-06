From: "=?ISO-8859-1?Q?=D8yvind_Harboe?=" <oyvind.harboe@zylin.com>
Subject: Problems getting rid of large files using git-filter-branch
Date: Tue, 6 Jan 2009 22:59:44 +0100
Message-ID: <c09652430901061359q7a02291fk656ab23e54b19f5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 06 23:01:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKJzH-0007Rp-Oh
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 23:01:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbZAFV7s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jan 2009 16:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbZAFV7s
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 16:59:48 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:34723 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbZAFV7r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jan 2009 16:59:47 -0500
Received: by bwz14 with SMTP id 14so24728399bwz.13
        for <git@vger.kernel.org>; Tue, 06 Jan 2009 13:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=4KLr/QIMM3GMt0Ae466+5ocpymAbnqwJYaqyq0wCj4c=;
        b=YrspfMp1ewytIvgVoBR3SDAguySnn2/cmeheABORe2eeujAJu/w2m1zC+mQwQwBa9e
         3twWTmrjz9JfjNALOYjc3hB8hwcBTfW2seZnCYxv8gflsXpypgZefx01GhDK79I3105u
         gYFbeSIRWIOdFwCpDgzqlU8m/mg/0uNRjHd4c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=U6ACldC/cyerYVxDoyccrf2w9apaPcyhqW/rxgLdyLn4d3hu+0JFMc8Jl8KOEIJ8dK
         EEXTylonLIqFaVAx7AM9WLtp+MAkEdEUinObY/GDwpA8UeZK9a4FwCHi+3z2YCRKDq5U
         lPOgbgrFg57PTJDv/G8W7aWCKLUZ3R/rJ1C1g=
Received: by 10.223.115.193 with SMTP id j1mr7758459faq.98.1231279185103;
        Tue, 06 Jan 2009 13:59:45 -0800 (PST)
Received: by 10.223.121.142 with HTTP; Tue, 6 Jan 2009 13:59:44 -0800 (PST)
Content-Disposition: inline
X-Google-Sender-Auth: b3b278002b0d63bd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104729>

I'm trying to get rid of some large objects in my .git repository
using git-filter-branch. These are remnants from conversion from
CVS.


Q1: How can I figure out what it is in .git that takes so much space?

Q2: Where can I read more about what to do after running git-filter-bra=
nch to
removing the offending objects?



1. I ran this command to get rid of the offending files and that appear=
s to
have worked. I can't find any traces of them anymore...

git filter-branch --tree-filter 'find . -regex ".*toolchain\..*" -exec
rm -f {} \;' HEAD

2. Running "git gc" takes a few seconds. The repository is still
huge(it should be
perhaps 10-20mByte).

du -skh .git/
187M    .git/

3. I tried "git reflog expire --all" + lots of other tricks in the
link below, but no luck.



I tried the tricks I could find in this thread, but no luck:

http://article.gmane.org/gmane.comp.version-control.git/60219/match=3Dt=
rying+use+git+filter+branch+compress

--=20
=D8yvind Harboe
http://www.zylin.com/zy1000.html
ARM7 ARM9 XScale Cortex
JTAG debugger and flash programmer
