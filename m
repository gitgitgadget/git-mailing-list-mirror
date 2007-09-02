From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] send-email: Add support for SSL and SMTP-AUTH
Date: Sun, 2 Sep 2007 11:43:56 +0200
Message-ID: <3533A53F-9120-4151-A9E7-C23CB1C84E1B@wincent.com>
References: <11887028854022-git-send-email-doug@11011.net> <7vveatpklg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Douglas Stockwell <douglas.stockwell@gmail.com>,
	git@vger.kernel.org, Douglas Stockwell <doug@11011.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 02 11:44:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRm0X-0007vT-0n
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 11:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755584AbXIBJoh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 2 Sep 2007 05:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753348AbXIBJoh
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 05:44:37 -0400
Received: from wincent.com ([72.3.236.74]:34339 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755538AbXIBJog convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Sep 2007 05:44:36 -0400
Received: from [192.168.1.99] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l829iTxq012367;
	Sun, 2 Sep 2007 04:44:30 -0500
In-Reply-To: <7vveatpklg.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57310>

El 2/9/2007, a las 9:55, Junio C Hamano escribi=F3:

> So it might be better to split the configuration variables in this
> way:
>
>  (1) in ~/.gitconfig (that is hopefully readable only by the
>      user):
>
> 	[sendemail "default"]
>         	server =3D mail.isp.com
>                 user =3D junkio
>                 pass =3D junkio-password-for-mail-isp-com
>
> 	[sendemail "git"]
>         	server =3D mail.git.xz
>                 user =3D gitster
>                 pass =3D gitster-password-for-mail-git.xz
>
>      This defines two "mail identities" I could use, depending
>      on which project's repository I run send-email.
>
>  (2) in project/.git/config:
>
> 	[sendemail]
>         	identity =3D git
>
>      This defines which "mail identity" I want to use for this
>      particular project.
>
> This way, you can maintain more than one identity by having
> multiple [sendemail "$identity"] sections in ~/.gitconfig, and
> avoid having to expose and duplicate user/pass in various
> project's .git/config.

Sounds like a good plan.

Wincent
