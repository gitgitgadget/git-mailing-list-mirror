From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [Patch] Use a default for a bad env config file variable
Date: Tue, 10 Aug 2010 18:08:21 +0200
Message-ID: <4C617975.8000501@drmicha.warpmail.net>
References: <AANLkTi=42V8=26oEwcNOHubuK+VAf-QaYnvCLAKQ0xtg@mail.gmail.com>	<vpq4of2scen.fsf@bauges.imag.fr> <AANLkTi=UCJa9uT5i9TRB9hGsH1D8b9DgB49TPM5k1htQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: James <purpleidea@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 10 18:08:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OirN7-0003JY-PJ
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 18:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149Ab0HJQIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Aug 2010 12:08:10 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:50409 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932331Ab0HJQIH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Aug 2010 12:08:07 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 534A24E6;
	Tue, 10 Aug 2010 12:08:06 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 10 Aug 2010 12:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=LnzGjCYaakZ0Dnw8y3k3L0MPtKc=; b=j3Q0uqNOcb9bG7dsJuShjg9pVDTMU2v0K65O2MJUxKAbUruMsZBv1rzafWKIXBf/LdwHbQZ+PEBxHGOoSAQPxzdv3dsy4ko8XwfSnqmU1NGyrhrZ357xcGD4cI1YCNtigd///a+1GKErgeSQ0O/D1eUsjkZc8e0FJSGqPHecvZw=
X-Sasl-enc: UilBKzohUW+hQNJwhUfDq8HEguhfQFz2U7tmFexp8ibM 1281456486
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B8BAC400C90;
	Tue, 10 Aug 2010 12:08:05 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9pre) Gecko/20100806 Lightning/1.0b2pre Lanikai/3.1.2
In-Reply-To: <AANLkTi=UCJa9uT5i9TRB9hGsH1D8b9DgB49TPM5k1htQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153127>

James venit, vidit, dixit 10.08.2010 17:54:
> Sorry about that,
> I guess I had only read the README.
> Hope this is better:
> 
> From d29adf8c788b8a747bfd38dd7e10f684de9aa8e9 Mon Sep 17 00:00:00 2001
> From: James Shubin <purpleidea@gmail.com>
> Date: Tue, 10 Aug 2010 10:30:22 -0400
> Subject: [PATCH] Use a default for a bad env config file variable.

Now, make that commit subject

gitweb: Use a default for a bad env config file variable

(i.e. insert "gitweb: ", delete the stop) and you're good to go ;)

Michael

> 
> 
> Signed-off-by: James Shubin <purpleidea@gmail.com>
> ---
>  gitweb/gitweb.perl |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 4efeebc..43294e1 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -605,6 +605,10 @@ sub evaluate_gitweb_config {
>  	} elsif (-e $GITWEB_CONFIG_SYSTEM) {
>  		do $GITWEB_CONFIG_SYSTEM;
>  		die $@ if $@;
> +	# if config file from env is missing, then try the default anyways
> +	} elsif (-e "++GITWEB_CONFIG_SYSTEM++") {
> +		do "++GITWEB_CONFIG_SYSTEM++";
> +		die $@ if $@;
>  	}
>  }
> 
