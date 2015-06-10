From: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Subject: [PATCH 4/4] bisect: add the terms old/new
Date: Wed, 10 Jun 2015 09:11:57 +0200 (CEST)
Message-ID: <1839018688.331427.1433920317370.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <78277223.323387.1433874176840.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 09:11:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2aB0-00011P-MV
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 09:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933456AbbFJHLY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 03:11:24 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:36055 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753766AbbFJHLO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jun 2015 03:11:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 98A9148875;
	Wed, 10 Jun 2015 09:11:12 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7duG2D+T0aSF; Wed, 10 Jun 2015 09:11:12 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 8135248800;
	Wed, 10 Jun 2015 09:11:12 +0200 (CEST)
In-Reply-To: <78277223.323387.1433874176840.JavaMail.zimbra@ensimag.grenoble-inp.fr>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - GC43 (Win)/8.0.9_GA_6191)
Thread-Topic: bisect: add the terms old/new
Thread-Index: iJEZB+wCpniTwRHKZvZhZbEdCbO80g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271260>

Hi,

thanks for the review, 

(sorry if you received this twice) 

Junio C Hamano <gitster@pobox.com> writes: 

>Just throwing a suggestion. You could perhaps add a new verb to be 
>used before starting to do anything, e.g. 
> 
> $ git bisect terms new old 

Yes it would be nice and should not be hard to implement. But it was not 
the idea of how the code was made by our elders. For now we just rebased, 
corrected and finishing to implement functionalities. 

>> * git rev-list --bisect does not treat the revs/bisect/new and 
>> revs/bisect/old-SHA1 files. 
> 
>That shouldn't be hard to add, I would imagine, either by 
> 
> git rev-list --bisect=new,old
> 
>or teaching "git rev-list --bisect" to read the "terms" itself, as a 
>follow-up patch.
> 
>> * git bisect visualize seem to work partially: the tags are 
>> displayed correctly but the tree is not limited to the bisect 
>> section. 
> 
>This is directly related to the lack of "git rev-list --bisect" 
>support, I would imagine. If you make the command read "terms", I 
>suspect that it would solve itself.

It will be corrected in the next patch.

>After reading the previous patches in the series, I expected that 
>this new code would know to read "terms" and does not limit us only 
>to "new" and "old". Somewhat disappointing.

It is still nice and necessary to have new/old as builtin tags but 
if we have time we will do that.

The others point have been taken in account.
