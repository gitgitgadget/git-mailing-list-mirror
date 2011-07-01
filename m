From: =?utf-8?Q?R=C3=A9mi_Vanicat?= <vanicat@debian.org>
Subject: Re: [Wishlist] could git tell which password it is asking when asking a password.
Date: Fri, 01 Jul 2011 21:25:59 +0200
Organization: none
Message-ID: <87tyb5n6pk.dlv@debian.org>
References: <877h82nlua.dlv@debian.org>
	<7v62nmos0k.fsf@alter.siamese.dyndns.org>
	<7v1uy9q5v1.fsf@alter.siamese.dyndns.org>
	<BANLkTi=aAinh=0jxb5MoqVOdUB7zxoy2XdSqk+pdsewLXU62ZA@mail.gmail.com>
	<7vwrg1opov.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 01 21:26:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcjM2-0006f1-VQ
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jul 2011 21:26:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762Ab1GAT0O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jul 2011 15:26:14 -0400
Received: from lo.gmane.org ([80.91.229.12]:45654 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751141Ab1GAT0N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2011 15:26:13 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QcjLu-0006cQ-Sq
	for git@vger.kernel.org; Fri, 01 Jul 2011 21:26:10 +0200
Received: from 29.191.138.88.rev.sfr.net ([88.138.191.29])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Jul 2011 21:26:10 +0200
Received: from vanicat by 29.191.138.88.rev.sfr.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Jul 2011 21:26:10 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 29.191.138.88.rev.sfr.net
User-Agent: Gnus/5.110016 (No Gnus v0.16) Emacs/23.3 (gnu/linux)
Cancel-Lock: sha1:2ZQrxzxi38vBbiaw9EMWtFasJKk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176532>

Junio C Hamano <gitster@pobox.com> writes:

> Shawn Pearce <spearce@spearce.org> writes:
>
>> On Fri, Jul 1, 2011 at 10:16, Junio C Hamano <gitster@pobox.com> wro=
te:
>>> Junio C Hamano <gitster@pobox.com> writes:
>>> diff --git a/http.c b/http.c
>>> index b2ae8de..44948a7 100644
>>> --- a/http.c
>>> +++ b/http.c
>>> @@ -209,8 +209,11 @@ static void init_curl_http_auth(CURL *result)
>>> =C2=A0{
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (user_name) {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct strbu=
f up =3D STRBUF_INIT;
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!user_pass)
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 user_pass =3D xstrdup(git_getpass("Password: "));
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!user_pass) =
{
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 strbuf_addf(&up, "Password for %s: ", user_name);
>>
>> The user_name by itself may not be sufficient. I may also need the U=
RL
>> to correctly answer the question. I don't always use the same passwo=
rd
>> on every website. :-)
>>
>> As a human sure, I know what URL I asked Git to poke for me.
>
> I was wondering about that when I gave that quick patch.  And "as a h=
uman"
> may not necessarily apply when you are letting submodule fetch to rec=
urse.

I also believe that having the host name would be useful, both for huma=
n
(another example would be git remote update when there are several
remote) and script. =20

--=20
R=C3=A9mi Vanicat
