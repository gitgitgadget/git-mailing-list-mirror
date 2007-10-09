From: =?ISO-8859-1?Q?V=E4in=F6_J=E4rvel=E4?= <v@pp.inet.fi>
Subject: Re: [PATCH] Fixed crash in fetching remote tags when there is not tags.
Date: Tue, 09 Oct 2007 13:52:01 +0300
Message-ID: <81553116-3A4F-4526-A772-9A43C53D3E22@pp.inet.fi>
References: <1191919868-4963-1-git-send-email-v@pp.inet.fi>
 <1191919868-4963-2-git-send-email-v@pp.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 12:53:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfCig-00075V-4D
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 12:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346AbXJIKxh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Oct 2007 06:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752313AbXJIKxh
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 06:53:37 -0400
Received: from astana.suomi.net ([82.128.152.18]:57092 "EHLO astana.suomi.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752094AbXJIKxf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Oct 2007 06:53:35 -0400
Received: from tiku.suomi.net ([82.128.154.67])
 by astana.suomi.net (Sun Java System Messaging Server 6.2-3.04 (built Jul 15
 2005)) with ESMTP id <0JPN005Y84V6NV60@astana.suomi.net> for
 git@vger.kernel.org; Tue, 09 Oct 2007 13:52:18 +0300 (EEST)
Received: from spam3.suomi.net (spam3.suomi.net [212.50.131.167])
 by mailstore.suomi.net
 (Sun Java(tm) System Messaging Server 6.3-1.04 (built May  9 2007; 32bit))
 with ESMTP id <0JPN00CZ54X9Y9C0@mailstore.suomi.net> for git@vger.kernel.org;
 Tue, 09 Oct 2007 13:53:33 +0300 (EEST)
Received: from [192.168.0.138]
 (addr-213-139-166-27.baananet.fi [213.139.166.27])
	by spam3.suomi.net (Postfix) with ESMTP id B9D681FED5F; Tue,
 09 Oct 2007 13:52:30 +0300 (EEST)
In-reply-to: <1191919868-4963-2-git-send-email-v@pp.inet.fi>
X-Mailer: Apple Mail (2.752.3)
X-DNA-MailScanner-Information: Please contact the ISP for more information
X-DNA-MailScanner: Found to be clean
X-DNA-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,	score=-0.667,
 required 5, AWL 0.23, BAYES_00 -1.00,	RDNS_DYNAMIC 0.10)
X-DNA-MailScanner-From: v@pp.inet.fi
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60384>

Hi,

These patches should have been numbered, sorry, The test patch was =20
supposed be number 1 of 2.

The patches were done on top of next. The fix should be checked, as =20
it's mostly a quick fix to get it to work, probably not the correct =20
way to fix that bug, or is it?

--
V=E4in=F6

On Oct 9, 2007, at 11:51, V=E4in=F6 J=E4rvel=E4 wrote:

> Signed-off-by: V=E4in=F6 J=E4rvel=E4 <v@pp.inet.fi>
> ---
>  remote.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/remote.c b/remote.c
> index e7d735b..5e92378 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -537,6 +537,8 @@ static int count_refspec_match(const char =20
> *pattern,
>
>  static void tail_link_ref(struct ref *ref, struct ref ***tail)
>  {
> +	if (!ref) return;
> +=09
>  	**tail =3D ref;
>  	while (ref->next)
>  		ref =3D ref->next;
> --=20
> 1.5.3.4.1156.g5407-dirty
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
