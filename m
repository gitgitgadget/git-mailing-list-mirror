From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [Wishlist] could git tell which password it is asking when asking
 a password.
Date: Fri, 1 Jul 2011 10:18:15 -0700
Message-ID: <BANLkTi=aAinh=0jxb5MoqVOdUB7zxoy2XdSqk+pdsewLXU62ZA@mail.gmail.com>
References: <877h82nlua.dlv@debian.org> <7v62nmos0k.fsf@alter.siamese.dyndns.org>
 <7v1uy9q5v1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?R=E9mi_Vanicat?= <vanicat@debian.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 01 19:18:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QchMY-0007kI-6P
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jul 2011 19:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757270Ab1GARSh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jul 2011 13:18:37 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46914 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754855Ab1GARSg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jul 2011 13:18:36 -0400
Received: by bwd5 with SMTP id 5so2757916bwd.19
        for <git@vger.kernel.org>; Fri, 01 Jul 2011 10:18:35 -0700 (PDT)
Received: by 10.204.142.147 with SMTP id q19mr3359230bku.84.1309540715164;
 Fri, 01 Jul 2011 10:18:35 -0700 (PDT)
Received: by 10.204.84.12 with HTTP; Fri, 1 Jul 2011 10:18:15 -0700 (PDT)
In-Reply-To: <7v1uy9q5v1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176526>

On Fri, Jul 1, 2011 at 10:16, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> diff --git a/http.c b/http.c
> index b2ae8de..44948a7 100644
> --- a/http.c
> +++ b/http.c
> @@ -209,8 +209,11 @@ static void init_curl_http_auth(CURL *result)
> =A0{
> =A0 =A0 =A0 =A0if (user_name) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct strbuf up =3D STRBUF_INIT;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!user_pass)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 user_pass =3D xstrdup(g=
it_getpass("Password: "));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!user_pass) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf_addf(&up, "Passw=
ord for %s: ", user_name);

The user_name by itself may not be sufficient. I may also need the URL
to correctly answer the question. I don't always use the same password
on every website. :-)

As a human sure, I know what URL I asked Git to poke for me. But if I
want to write a script that looks this up in a password manager for
me, that script needs the URL.

=46ood for thought.

--=20
Shawn.
