From: Jeremy Rosen <jeremy.rosen@openwide.fr>
Subject: Re: [PATCH v8 2/2] status: always show tracking branch even no
 change
Date: Mon, 26 Aug 2013 09:47:18 +0200 (CEST)
Message-ID: <1861495981.5462037.1377503238201.JavaMail.root@openwide.fr>
References: <2f3a942d7049e80dca689aa68d494b70c288f2c7.1377500206.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 26 09:54:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDrdD-0005il-2x
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 09:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756243Ab3HZHya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 03:54:30 -0400
Received: from zimbra3.corp.accelance.fr ([213.162.49.233]:46127 "EHLO
	zimbra3.corp.accelance.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756050Ab3HZHya (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 03:54:30 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Aug 2013 03:54:29 EDT
Received: from localhost (localhost [127.0.0.1])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id 0597F687DC;
	Mon, 26 Aug 2013 09:47:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra3.corp.accelance.fr
Received: from zimbra3.corp.accelance.fr ([127.0.0.1])
	by localhost (zimbra3.corp.accelance.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ql4A06hmRNy2; Mon, 26 Aug 2013 09:47:18 +0200 (CEST)
Received: from zimbra2.corp.accelance.fr (zimbra2.corp.accelance.fr [213.162.49.232])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id 73D14687D9;
	Mon, 26 Aug 2013 09:47:18 +0200 (CEST)
In-Reply-To: <2f3a942d7049e80dca689aa68d494b70c288f2c7.1377500206.git.worldhello.net@gmail.com>
X-Originating-IP: [213.162.49.238]
X-Mailer: Zimbra 7.2.2_GA_2852 (ZimbraWebClient - GC29 (Linux)/7.2.2_GA_2852)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232984>

> 
> But this will not work if there is no change between the current
> branch and its upstream. Always report upstream tracking info
> even if there is no difference, so that "git status" is consistent
> for checking tracking info for current branch. E.g.
> 
>     $ git status
>     # On branch feature1
>     # Your branch is identical to 'github/feature1'.
>     ...
> 
>     $ git status -bs
>     ## feature1...github/feature1
>     ...
> 
>     $ git checkout feature1
>     Already on 'feature1'
>     Your branch is identical to 'github/feature1'.
>     ...
> 


nitpicking, but shouldn't this be worded as "up to date" rather than "identical" ?

The reason is that identical gives the idea that the two branch happen to be on the same
commit wheras "up to date" gives the idea that there is a special relationship between
these two particular branches. We are not just listing all branches on the same
commit as us, we are actively telling you about this branch because it's interesting
to you.
