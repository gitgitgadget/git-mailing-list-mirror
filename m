From: konglu@minatec.inpg.fr
Subject: Re: How can I specify the "sendmail" program for git-send-email?
Date: Mon, 11 Jun 2012 11:25:16 +0200
Message-ID: <20120611112516.Horde.jg0rcXwdC4BP1bl8bOMwLoA@webmail.minatec.grenoble-inp.fr>
References: <20120611073232.GA5602@richard>
 <CABPQNSbwtP0hp8QYznwXjLAaoKVj_ZUWXQQCDG80Xb+TME1MWw@mail.gmail.com>
 <20120611090431.GA23447@richard>
 <CABPQNSZ1dyAfCVLGcLxbeBdS_9A_arYOhzgKBtndReK5zxu_MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Richard Yang <weiyang@linux.vnet.ibm.com>, git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 11:25:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se0sF-0002Tw-Ty
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 11:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966Ab2FKJZT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jun 2012 05:25:19 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:54931 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750825Ab2FKJZT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jun 2012 05:25:19 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id B1F4A1A0240;
	Mon, 11 Jun 2012 11:25:16 +0200 (CEST)
Received: from wifi-029112.grenet.fr (wifi-029112.grenet.fr
 [130.190.29.112]) by webmail.minatec.grenoble-inp.fr (Horde Framework) with
 HTTP; Mon, 11 Jun 2012 11:25:16 +0200
In-Reply-To: <CABPQNSZ1dyAfCVLGcLxbeBdS_9A_arYOhzgKBtndReK5zxu_MA@mail.gmail.com>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199635>


Erik Faye-Lund <kusmabite@gmail.com> a =E9crit=A0:

> Well, I've always been slightly annoyed by the "send-mail" vs
> "sendemail" inconsistency. Perhaps we could do something along these
> lines (plus all documentation-updates, omitted for clarity) to reduce
> the risk of confusion?
>
> Yeah, the leaking of $identity between different sections is a bit
> suboptimal, but as a fallback-mechanism I don't think it actually
> matters much.

[...]

> -# read configuration from [sendemail "$identity"], fall back on [sen=
demail]
> +# read configuration from [sendmail "$identity"], fall back on [send=
mail]
> +$identity =3D Git::config(@repo, "sendmail.identity") unless (define=
d =20
> $identity);
> +read_config("sendmail.$identity") if (defined $identity);
> +read_config("sendmail");
> +# same as above, but with legacy "sendemail"
>  $identity =3D Git::config(@repo, "sendemail.identity") unless (defin=
ed
> $identity);
>  read_config("sendemail.$identity") if (defined $identity);
>  read_config("sendemail");

I'm not very familiar with perl, but do you mean to replace "sendemail"=
 by
"sendmail" or just make "sendmail" usable in the config file, along wit=
h
"sendemail" ?
