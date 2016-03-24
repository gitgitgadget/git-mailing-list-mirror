From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@dwim.me>
Subject: Re: [PATCH] Disown ssh+git and git+ssh
Date: Thu, 24 Mar 2016 17:56:07 +0100
Message-ID: <1458838567.179868.6.camel@dwim.me>
References: <xmqq7fi8s4dx.fsf@gitster.mtv.corp.google.com>
	 <1455546546-65710-1-git-send-email-cmn@dwim.me>
	 <CAPig+cQ6JC65QkH=8nJ9Qwghr6cwv0BsB5TRDeg=gZmDpcdcHg@mail.gmail.com>
	 <xmqqbn6ngvs8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 17:56:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj8YT-0005Yo-F6
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 17:56:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757698AbcCXQ4N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Mar 2016 12:56:13 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:45887 "EHLO
	new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755849AbcCXQ4M (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Mar 2016 12:56:12 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailnew.nyi.internal (Postfix) with ESMTP id 1965FA86
	for <git@vger.kernel.org>; Thu, 24 Mar 2016 12:56:10 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Thu, 24 Mar 2016 12:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=dwim.me; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=4ldHq1tGeglVT4NLrKRkjo1sYNs=; b=r4TMKP
	XH+DVppvTCoNWlVQqvlp+Of8eURXZej8Ny7l6XxVlhoQ6lLqv5BoGq/4sqGFuIhD
	oh34BURiuKoQJvNXXKGwxZVhX0eAmbIO19POg4/RUNTcZ4s0OMls4KlrmKSKqIJG
	Z471hLKWHeJZf2JkM7opVtRAIMmknhtaYM31M=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=4ldHq1tGeglVT4N
	LrKRkjo1sYNs=; b=jmWSwzGnJ6m18pO4GQy/tNXVeAcQQlQVYXS1icl/EKBO7N2
	Qke1wojdmzoWCapl8GgRu53QhCrXYxc9evMKOkOLtUaCb9JPEAmc2m9eBXBqWHpg
	FTfDBoQhEGS5oT3f9w0A11ITM9b3I+pIE8t3B4pE4XpJrbtBVY9eQ8XOYCFQ=
X-Sasl-enc: vRfSQVoCbT0mV3pFxywuaWgQqbPQjqHxx4l7Ap8GcXb8 1458838569
Received: from ip5b40609c.dynamic.kabel-deutschland.de (ip5b40609c.dynamic.kabel-deutschland.de [91.64.96.156])
	by mail.messagingengine.com (Postfix) with ESMTPA id 0AFB1680101;
	Thu, 24 Mar 2016 12:56:08 -0400 (EDT)
In-Reply-To: <xmqqbn6ngvs8.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.18.5.1-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289762>

On Wed, 2016-03-09 at 13:56 -0800, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>=20
> >=20
> > It might be helpful to cite some reference to support the claim
> > that
> > they are "silly" since it's not necessarily obvious to readers who
> > did
> > not following the discussion.
> > ...
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|| starts_with(url, "ssh://")
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* These ways to spell the ssh transport r=
emain
> > > supported for
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* compat but are undocumented and their u=
se is
> > > discouraged
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|| starts_with(url, "git+ssh://")
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|| starts_with(url, "ssh+git://")) {
> > A little "comment" bikeshedding: Aside from undesirably
> > interrupting
> > the code flow, these large comment blocks draw far too much
> > attention
> > from the reader than these deprecated spellings of "ssh" deserve,
> > thus
> > making them seem overly important.
> I've been waiting for an update for it but got tired of it.
> Instead of discarding the topic, let's amend it like so:

Sorry, I missed the call for the rewording. The below looks good to me.
Thanks.

>=20
> -- >8 --
> From: Carlos Mart=C3=ADn Nieto <cmn@dwim.me>
> Date: Mon, 15 Feb 2016 15:29:06 +0100
> Subject: [PATCH] Disown ssh+git and git+ssh
>=20
> Some people argue that these were silly from the beginning (see
> http://thread.gmane.org/gmane.comp.version-control.git/285590/focus=3D=
2
> 85601
> for example), but we have to support them for compatibility.
>=20
> That doesn't mean we have to show them in the documentation.=C2=A0=C2=
=A0These
> were already left out of the main list, but a reference in the main
> manpage was left, so remove that.
>=20
> Also add a note to discourage their use if anybody goes looking for
> them
> in the source code.
>=20
> Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@dwim.me>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> =C2=A0Documentation/git.txt | 2 +-
> =C2=A0connect.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0| 4 ++--
> =C2=A0transport.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0| 5 +++--
> =C2=A03 files changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index d987ad2..2f90635 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -1122,7 +1122,7 @@ of clones and fetches.
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0connection (or proxy, if configured)
> =C2=A0
> =C2=A0	=C2=A0=C2=A0- `ssh`: git over ssh (including `host:path` synta=
x,
> -	=C2=A0=C2=A0=C2=A0=C2=A0`git+ssh://`, etc).
> +	=C2=A0=C2=A0=C2=A0=C2=A0`ssh://`, etc).
> =C2=A0
> =C2=A0	=C2=A0=C2=A0- `rsync`: git over rsync
> =C2=A0
> diff --git a/connect.c b/connect.c
> index fd7ffe1..3babb81 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -267,9 +267,9 @@ static enum protocol get_protocol(const char
> *name)
> =C2=A0		return PROTO_SSH;
> =C2=A0	if (!strcmp(name, "git"))
> =C2=A0		return PROTO_GIT;
> -	if (!strcmp(name, "git+ssh"))
> +	if (!strcmp(name, "git+ssh")) /* deprecated - do not use */
> =C2=A0		return PROTO_SSH;
> -	if (!strcmp(name, "ssh+git"))
> +	if (!strcmp(name, "ssh+git")) /* deprecated - do not use */
> =C2=A0		return PROTO_SSH;
> =C2=A0	if (!strcmp(name, "file"))
> =C2=A0		return PROTO_FILE;
> diff --git a/transport.c b/transport.c
> index 67f3666..908e08b 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1001,8 +1001,9 @@ struct transport *transport_get(struct remote
> *remote, const char *url)
> =C2=A0		|| starts_with(url, "file://")
> =C2=A0		|| starts_with(url, "git://")
> =C2=A0		|| starts_with(url, "ssh://")
> -		|| starts_with(url, "git+ssh://")
> -		|| starts_with(url, "ssh+git://")) {
> +		|| starts_with(url, "git+ssh://") /* deprecated - do
> not use */
> +		|| starts_with(url, "ssh+git://") /* deprecated - do
> not use */
> +		) {
> =C2=A0		/*
> =C2=A0		=C2=A0* These are builtin smart transports; "allowed"
> transports
> =C2=A0		=C2=A0* will be checked individually in git_connect.
