From: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Subject: [PATCH 3/4] bisect: simplify the add of new bisect terms
Date: Wed, 10 Jun 2015 09:09:42 +0200 (CEST)
Message-ID: <1975406107.331328.1433920182747.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1183699596.323718.1433875699237.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Nguy <thomasxnguy@gmail.com>,
	Valentin Duperray <valentinduperray@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 09:09:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2a8P-0007HP-9A
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 09:09:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753984AbbFJHJC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 03:09:02 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:49970 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933160AbbFJHJA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jun 2015 03:09:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 0D00827D0;
	Wed, 10 Jun 2015 09:08:58 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ta2EUQZMmYBP; Wed, 10 Jun 2015 09:08:57 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id EC96827BC;
	Wed, 10 Jun 2015 09:08:57 +0200 (CEST)
In-Reply-To: <1183699596.323718.1433875699237.JavaMail.zimbra@ensimag.grenoble-inp.fr>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - GC43 (Win)/8.0.9_GA_6191)
Thread-Topic: bisect: simplify the add of new bisect terms
Thread-Index: ZpczoEJYOKofx4VfuRuYKZPqByiANw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271257>

Hi, 

Thanks for the review ! 
(sorry if you received this twice)

Christian Couder <christian.couder@gmail.com> wrote : 

>>> + name_bad = "bad"; 
>>> + name_good = "good"; 
>>> + } else { 
>>> + strbuf_getline(&str, fp, '\n'); 
>>> + name_bad = strbuf_detach(&str, NULL); 
>>> + strbuf_getline(&str, fp, '\n'); 
>>> + name_good = strbuf_detach(&str, NULL); 
>>> + } 
>> 
>> I would have kept just 
>> 
>> name_bad = "bad"; 
>> name_good = "good"; 
>> 
>> in this patch, and introduce BISECT_TERMS in a separate one. 
> 
>Yeah I agree that it is more logical to have first a patch that does 
>on bisect.c the same thing as patch 2 does on git-bisect.sh. 
> 
>For example the patch series could be for now: 
> 
>1) bisect: typo fix 
>2) bisect: replace hardcoded "bad|good" with variables 
>3) git-bisect: replace hardcoded "bad|good" with variables 
>4) bisect: simplify adding new terms 
>5) bisect: add old/new terms 

For now we will keep name_bad and name_good as variables. 
About the patch series shouldn't I squash the commit 2) and 3) into one? 
