From: "Ping Yin" <pkufranky@gmail.com>
Subject: [RFC] git reset --recover
Date: Mon, 3 Mar 2008 22:59:14 +0800
Message-ID: <46dff0320803030659j2fa0325lf9c88b915ddb70da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 16:00:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWC8x-0008ES-2c
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 15:59:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863AbYCCO7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 09:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753886AbYCCO7Q
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 09:59:16 -0500
Received: from an-out-0708.google.com ([209.85.132.244]:8092 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753594AbYCCO7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 09:59:16 -0500
Received: by an-out-0708.google.com with SMTP id d31so8642and.103
        for <git@vger.kernel.org>; Mon, 03 Mar 2008 06:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=QEnv1+mvtmPK9ULCDAEuxp0OJe0Xbu5Tcnxf5Lqcorc=;
        b=KlfPtKf+XWHLfdsf7jsW+lHVZlYw4oZR/iBOGuL7i4+To58iGIUm55sT7fgOlDumgj1asKvuP+7tpqn5ErM44Wz5D3EgaSXEQ/EvXh7WadI/4Lx1JZcvCgtbtso2tfh449wvMgAKliepHii1kK/EsGL6HcwynzUPqWVFzHSqUKE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=xHckICaks8tswFSt7BB7ame6g2tgSAh0/MRdsrHGW12Yb0A9pH8d07UI6vpHxLRWxRhELEKT5JNFoxxFyIkcOxPjZYJw03qPMJRpYLHM/Dwoy8AMgTh3PTTaUIAEOp9jeP7fR0oKAKBikoG7GdawTbykMTMj2/6n5XCDlzd0zPM=
Received: by 10.100.215.5 with SMTP id n5mr63727ang.41.1204556354992;
        Mon, 03 Mar 2008 06:59:14 -0800 (PST)
Received: by 10.100.95.20 with HTTP; Mon, 3 Mar 2008 06:59:14 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75932>

Today i use git reset carelessly and lose all my changes!

To remind other people not do the same wrong thing, i share my
experience and propose a new option to avoid this happens again.
------------------------------------
foo
   .git
    bar
        file1
        file2
------------------------------------

In the direcotry structure above, i want to make bar as a repository
(which hasn't yet been tracked by foo repository). I should have done
this as follows

-------------------------------------------
cd bar
git init
git add
------------------------------------------

but i fogot to type "git init" which results that file1 and file2 are
added to index of foo repository. I tried to revert the operation
using "git reset". And the tragedy happened at that time because i
made so fatal  a mistake that i typed "git reset --hard". And i lost
all my files in bar dir!

So, can we introduce a --recover option for "git reset" to save the
foolish or careless people like me?

-- 
Ping Yin
