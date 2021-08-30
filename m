Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354D2C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 13:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AEAA60E90
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 13:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236775AbhH3NrP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 09:47:15 -0400
Received: from beige.elm.relay.mailchannels.net ([23.83.212.16]:39158 "EHLO
        beige.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231669AbhH3NrP (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 30 Aug 2021 09:47:15 -0400
X-Sender-Id: dreamhost|x-authsender|novalis@novalis.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id B15BD922714;
        Mon, 30 Aug 2021 13:46:17 +0000 (UTC)
Received: from pdx1-sub0-mail-a13.g.dreamhost.com (100-96-17-88.trex-nlb.outbound.svc.cluster.local [100.96.17.88])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 1D79A92286D;
        Mon, 30 Aug 2021 13:46:04 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|novalis@novalis.org
Received: from pdx1-sub0-mail-a13.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.96.17.88 (trex/6.4.3);
        Mon, 30 Aug 2021 13:46:17 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|novalis@novalis.org
X-MailChannels-Auth-Id: dreamhost
X-Wipe-Versed: 7ac435416740ad8d_1630331167467_4088751637
X-MC-Loop-Signature: 1630331167467:233660582
X-MC-Ingress-Time: 1630331167467
Received: from pdx1-sub0-mail-a13.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a13.g.dreamhost.com (Postfix) with ESMTP id 3E85A806B3;
        Mon, 30 Aug 2021 06:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:date:in-reply-to:references:content-type
        :mime-version:content-transfer-encoding; s=novalis.org; bh=HxGyl
        vq0ffg2S+Zch+ZY41UZE+I=; b=qnp0n1p6bFsIP7u788cXztTLzZqLQhPFLnjOF
        CtZzd8KXewks22ktOHOBRYJUinb5ahQvmU+bg/5K5eYH2hiuOxfRfjVL+fmcYy/o
        BsD+ArZQt/p9Jtik52UL20+uY3gXZn8TaOm0aggIGidjwA7cqD2VH0o5s9f53cga
        ROUCAM=
Received: from corey.lan (unknown [98.113.183.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by pdx1-sub0-mail-a13.g.dreamhost.com (Postfix) with ESMTPSA id BBA0980694;
        Mon, 30 Aug 2021 06:45:58 -0700 (PDT)
Message-ID: <d14d2c180f59b9115754318e4d3567a404769d06.camel@novalis.org>
Subject: Re: [PATCH v3 3/3] diff --submodule=diff: Don't print failure
 message twice
X-DH-BACKEND: pdx1-sub0-mail-a13
From:   David Turner <novalis@novalis.org>
To:     David Turner <dturner@twosigma.com>, git@vger.kernel.org
Date:   Mon, 30 Aug 2021 09:45:56 -0400
In-Reply-To: <20210812001332.715876-3-dturner@twosigma.com>
References: <20210812001332.715876-1-dturner@twosigma.com>
         <20210812001332.715876-3-dturner@twosigma.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I keep seeing these as "will merge to next?" in the "what's cooking"
emails.  But I don't see any direct replies, and they don't seem to be
merged.  Is there something I need to do to get these merged?

Thanks.

On Wed, 2021-08-11 at 20:13 -0400, David Turner wrote:
> When we fail to start a diff command inside a submodule, immediately
> exit the routine rather than trying to finish the command and
> printing
> a second message.
>=20
> Signed-off-by: David Turner <dturner@twosigma.com>
> ---
> =C2=A0submodule.c | 4 +++-
> =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/submodule.c b/submodule.c
> index d13d103975..2e98e840af 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -720,8 +720,10 @@ void show_submodule_inline_diff(struct
> diff_options *o, const char *path,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0strvec_push(&cp.env_array, GIT_WORK_TREE_ENVIRONM=
ENT
> "=3D.");
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (start_command(&cp))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (start_command(&cp)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0diff_emit_submodule_error(o, "(diff failed)\n");
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0goto done;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0while (strbuf_getwholel=
ine_fd(&sb, cp.out, '\n') !=3D EOF)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0diff_emit_submodule_pipethrough(o, sb.buf, sb.len=
);


