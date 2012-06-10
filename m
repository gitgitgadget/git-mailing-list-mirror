From: nguyenhu@minatec.inpg.fr
Subject: Re: [PATCHv6 1/4] Read (but not write) from
 $XDG_CONFIG_HOME/git/config file
Date: Sun, 10 Jun 2012 22:02:39 +0200
Message-ID: <20120610220239.Horde.UcGZQnwdC4BP1P1fPg1GEMA@webmail.minatec.grenoble-inp.fr>
References: <1338754481-27012-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <1338988885-21933-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <7vpq9aenl0.fsf@alter.siamese.dyndns.org>
 <20120608142601.Horde.Tq7UO3wdC4BP0e9ZGAy1EwA@webmail.minatec.grenoble-inp.fr>
 <7vvcj1dep7.fsf@alter.siamese.dyndns.org>
 <20120609125336.Horde.iUq0R3wdC4BP0yswpGlGBZA@webmail.minatec.grenoble-inp.fr>
 <7v4nqjbrdo.fsf@alter.siamese.dyndns.org>
 <20120610154850.Horde.gYrJO3wdC4BP1KXCOvLEiCA@webmail.minatec.grenoble-inp.fr>
 <CABPQNSYd0hCU8nrfKJJjR+T_jQn4WC6jEaSCJPjKsuPdumEdtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu.Moy@grenoble-inp.fr,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 22:03:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdoLv-0006a4-JW
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 22:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941Ab2FJUCo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Jun 2012 16:02:44 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:33995 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751334Ab2FJUCn (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jun 2012 16:02:43 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id CE3F11A025F;
	Sun, 10 Jun 2012 22:02:39 +0200 (CEST)
Received: from etu-190-143.vpn-inp.grenoble-inp.fr
 (etu-190-143.vpn-inp.grenoble-inp.fr [147.171.190.143]) by
 webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Sun, 10 Jun
 2012 22:02:39 +0200
In-Reply-To: <CABPQNSYd0hCU8nrfKJJjR+T_jQn4WC6jEaSCJPjKsuPdumEdtw@mail.gmail.com>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199621>


Erik Faye-Lund <kusmabite@gmail.com> a =E9crit=A0:

>> char *mkpathdup(const char *fmt, ...)
>> {
>> =A0 =A0 =A0 =A0struct strbuf sb =3D STRBUF_INIT;
>> =A0 =A0 =A0 =A0va_list args;
>>
>> =A0 =A0 =A0 =A0va_start(args, fmt);
>> =A0 =A0 =A0 =A0strbuf_vaddf(&sb, fmt, args);
>> =A0 =A0 =A0 =A0va_end(args);
>>
>> =A0 =A0 =A0 =A0return cleanup_path(strbuf_detach(&sb, NULL));
>>
>> }
>
> The awkward thing about doing this, is that the memory allocated by
> the strbuf cannot be reclaimed if you go with this. A pointer that ha=
s
> been adjusted (like cleanup_path can do) cannot be successfully fed t=
o
> free.

Do you mean that the previous version is preferable in keeping =20
clean-up-path function ?
