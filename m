From: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>
Subject: Re: [PATCH] git-remote-mediawiki: Fix a bug in a regexp
Date: Sat, 08 Jun 2013 22:08:36 +0200
Message-ID: <51B38F44.6080304@ensimag.fr>
References: <1370698510-11649-1-git-send-email-celestin.matte@ensimag.fr> <vpqmwr0v45b.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>,
	git@vger.kernel.org, benoit.person@ensimag.fr
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Jun 08 22:08:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlPRT-0005kH-Kh
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 22:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609Ab3FHUIm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Jun 2013 16:08:42 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45236 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752515Ab3FHUIl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 16:08:41 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r58K8XT7028456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 8 Jun 2013 22:08:33 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r58K8Ztu018121;
	Sat, 8 Jun 2013 22:08:35 +0200
Received: from [127.0.0.1] (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r58K8YAQ000517;
	Sat, 8 Jun 2013 22:08:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <vpqmwr0v45b.fsf@anie.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 08 Jun 2013 22:08:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r58K8XT7028456
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: celestin.matte@ensimag.fr
MailScanner-NULL-Check: 1371326917.67494@p0YoD2VsmQpQmp6ur1Cr0Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226860>

Le 08/06/2013 20:38, Matthieu Moy a =E9crit :> This is right, but the c=
ode
actually worked the way it was. I'm not
> sure, but my understanding is that '\n' is the string "backslash
> followed by n", but interpreted as a regexp, it is a newline.
>
> The new code looks better than the old one, but the log message may b=
e
> improved.

Is this better?

"
In Perl, '\n' is not a newline, but instead the string composed of a
backslash followed by an "n". To match newlines, one has to use the /\n=
/
regexp. As the output of "rev-list --first-parent" is line-oriented,
what we want here is to match newlines, and not the "\n" string.
"

--=20
C=E9lestin Matte
