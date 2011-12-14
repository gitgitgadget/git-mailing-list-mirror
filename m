From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Add '-P' as a synonym for '--no-pager' in the git command
Date: Wed, 14 Dec 2011 08:44:00 +0100
Message-ID: <4EE853C0.20505@viscovery.net>
References: <1323815706-10560-1-git-send-email-jratt0@gmail.com> <1323815706-10560-2-git-send-email-jratt0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Joe Ratterman <jratt0@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 08:44:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RajVa-0004lq-RS
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 08:44:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753736Ab1LNHoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 02:44:06 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:16784 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751782Ab1LNHoF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 02:44:05 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RajVQ-0002Um-RE; Wed, 14 Dec 2011 08:44:01 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 884C41660F;
	Wed, 14 Dec 2011 08:44:00 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <1323815706-10560-2-git-send-email-jratt0@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187098>

Am 12/13/2011 23:35, schrieb Joe Ratterman:
> +test_expect_success TTY 'no pager with -P' '
> +	rm -f paginated.out ||
> +	cleanup_fail &&
> +
> +	test_terminal git -P log &&
> +	! test -e paginated.out
> +'
> +
>  test_expect_success TTY 'no pager with --no-pager' '
>  	rm -f paginated.out ||
>  	cleanup_fail &&

What kind of bogosity do I see in the context of this hunk (and in the new
text as well, but it is not entirely your fault, Joe, since you obviously
have only copied an existing test snippet)?

Wouldn't rm -f always succeed under normal circumstances, and then the
rest of the test would be skipped? This use of || was introduced by
fdf1bc48 (t7006: guard cleanup with test_expect_success).

-- Hannes
