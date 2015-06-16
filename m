From: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Subject: [PATCH v2 7/7] bisect: allows any terms set by user
Date: Tue, 16 Jun 2015 23:07:00 +0200 (CEST)
Message-ID: <1482001285.562840.1434488820667.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433962918-6536-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr> <1433962918-6536-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr> <vpqy4jq2rjr.fsf@anie.imag.fr> <323480549.485629.1434310820944.JavaMail.zimbra@ensimag.grenoble-inp.fr> <vpq8ubl73py.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 16 23:05:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4y3K-0003us-3C
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 23:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332AbbFPVFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 17:05:44 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:37886 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752280AbbFPVFn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Jun 2015 17:05:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 3FC3C2916;
	Tue, 16 Jun 2015 23:05:40 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fm5OieLyHJ1c; Tue, 16 Jun 2015 23:05:40 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 2BA36290E;
	Tue, 16 Jun 2015 23:05:40 +0200 (CEST)
In-Reply-To: <vpq8ubl73py.fsf@anie.imag.fr>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF10 (Linux)/8.0.9_GA_6191)
Thread-Topic: bisect: allows any terms set by user
Thread-Index: Cn6m7Lwgpguhx425RDb4n1TeGap5TA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271797>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes: 

>I would say "for the current bisection", i.e. 
> 
>$ git bisect start 
>$ git bisect terms foo bar # Scope starts here 
>... 
>The first 'bar' commit is deadbeef. # Scope ends here 
> 
>$ git bisect terms foo bar 
>You need to start by "git bisect start" 
>Do you want me to do it for you [Y/n]? 

I personnaly don't like this autostart. In the first version of this patch 
7/7 'git bisect terms' has to be called before the start. I think it is 
better because we can then use 'git bisect start rev1 rev2 ...' 

>> The next 'bisect start rev1 rev2' would be in bad/good mode. But this 
>> have to be discuted, do the user have to type 'git bisect terms' each 
>> bisection if he wants to use special terms ? 
> 
>To me, yes. If we allow arbitrary terms, then they will most likely be 
>specific to one bisect session (e.g. if I bisect "present/absent" once, 
>it tells me nothing about what I'll want for my next bisection). 

Ok. 

Thanks. 
