From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [POSSIBLE BUG] 'git log' option --no-color adds bogus empty line
Date: Sat, 27 Oct 2007 11:10:00 +0200
Message-ID: <e5bfff550710270210g6d363b40of597c3160124fb85@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git list" <git@vger.kernel.org>,
	"Yaacov Akiba Slama" <ya@slamail.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 27 11:10:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlhgO-0005ji-4D
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 11:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400AbXJ0JKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 05:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753981AbXJ0JKF
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 05:10:05 -0400
Received: from rv-out-0910.google.com ([209.85.198.184]:41106 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbXJ0JKB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 05:10:01 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1022520rvb
        for <git@vger.kernel.org>; Sat, 27 Oct 2007 02:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=gS3Funt4aZiuWsSvMRoefPQgHRThVFEotnFUoA/6LPA=;
        b=otS/Zdjlq+nhqnhhCWSICYfH8//bZrK81w2nLwocdHF/P6E+ekrjKzk7kuAWWEz9HXTBbynVbKXlesNM9Y64abSQugp11V4W6eKOcRt3EeS47J7BM5AFsWhIUz/znU527AKZJjkTGku/O0sC+QyFukKwllCHPlYIfIJjrPf//iQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=WJbsFg7Bul5pYVJ78s92abh1ojRTUmCYdmn90ZAaOONA5HtI72s71I47Jvqd99s1z9kCwoYtXW4hrwVk79VLWN9ZDpoDO9+AVuEJaB+iGbqAeFgqCA5mBxEMtOhwYypgW1KFq2VSsMJmHOo73I1mkkKV7pR6lZhUf3QKNEVVH5c=
Received: by 10.140.249.20 with SMTP id w20mr1937589rvh.1193476200556;
        Sat, 27 Oct 2007 02:10:00 -0700 (PDT)
Received: by 10.141.203.3 with HTTP; Sat, 27 Oct 2007 02:10:00 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62480>

Form git tree:

$ git log -n 1 8d863c98b2f9b0d37 | wc
      7      28     246

$ git log --no-color -n 1 8d863c98b2f9b0d37 | wc
      8      28     247

$ git --version
git version 1.5.3.2.124.g648db

What's worst is that when using --log-size option, the size is always
the same (198 in this case) breaking qgit parsing when --no-color
option is used.

BTW --no-color option is needed to correctly handle repositories where
"diff.color = true" in the configuration as pointed out (and patched)
by Yaacov Akiba Slama.

Thanks
Marco
