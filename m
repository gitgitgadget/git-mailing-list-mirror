Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCD521F803
	for <e@80x24.org>; Tue,  8 Jan 2019 16:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbfAHQlL (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 11:41:11 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40239 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfAHQlL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 11:41:11 -0500
Received: by mail-pf1-f193.google.com with SMTP id i12so2181744pfo.7
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 08:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kTeG3eQd0jFo1RJBvo9qlY4r+5S2Y4wNtZRPVU9eXrY=;
        b=ZCGhTJhoVs/hAUQZ9jxz9hZxKhmFL+KAGGBz37FKMzrPs+3KHCKhR1uXIcKtj+dHOY
         xrx0GfX8aAnHvBTqBjgqMJaJ/PkhgtrjlaiL59zlUTGjY9xPg2e6nQ5xGGJq9l00udXD
         eeCZXVHEfzHTXbEIRbjGgNjBhW8KhX9sAi6ZvBTtfDueeTjC3gWNiwPBAun2WfG5OL9q
         0+mKMF3eVZUhphArqpm4taslnXLiOiddeXl3QX68jeXHRe9TtW4z832nXZ+lwCYPccOi
         5QY0E+7Wjg+/c2QBnICGc1r1uqhsrZiN1RpooGoBOQf2o6OOE9zAkjXNNmf15Gljz3cT
         sKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kTeG3eQd0jFo1RJBvo9qlY4r+5S2Y4wNtZRPVU9eXrY=;
        b=XosKD1nmrwjAeCaNuE7pBBZrEfr1HphZxPwg7fqzWQyMdhmzx9Zx1fMueCeiKgHa4k
         rc4aiSIi/C0kjU8j4gbIgYTaTIohYAHh+wqb0VtAAS9obKDv6Adp7nSCM3YMuEz2PCpr
         1/L8TdifkaTNpkqhrt2KpUR9w38xTkJhFGXdiOE+x8fPhodlcCx+T/HfRJ/dZ0NJvxZb
         qWj/ibAoAL1eWNFl33VyhFMyjjMpwZbzze+TwsyxXJNYDXww/jjdxRsN6T31Y6w41TVq
         oWABi82TUAKzPTZZBwAIBqTD8Hply5oK50uk4bK4d8Ch4QOt920nFxOTxWAZXkk5PnaQ
         slHw==
X-Gm-Message-State: AJcUukdx/c+7y0ZrVhQIdBgrdT5qMRDTXQvAk//DKRykpjs3EVWarwuC
        nj0eoOJrvVp46/qv3lx/nQUo6Q==
X-Google-Smtp-Source: ALg8bN44m3Ga4LDLTJ5/DcboTU886UnAeThYo7W7Tt7U1pdm6rqz7K1E0H3ol0teN4j3czqMevyLEQ==
X-Received: by 2002:a62:2044:: with SMTP id g65mr2382225pfg.127.1546965670146;
        Tue, 08 Jan 2019 08:41:10 -0800 (PST)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.gmail.com with ESMTPSA id v184sm98623241pfb.182.2019.01.08.08.41.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 08:41:09 -0800 (PST)
Date:   Tue, 8 Jan 2019 11:41:06 -0500
From:   Barret Rhoden <brho@google.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] blame: add the ability to ignore commits
Message-ID: <20190108114106.5cf57e67@gnomeregan.cam.corp.google.com>
In-Reply-To: <8736q3qon0.fsf@evledraar.gmail.com>
References: <20190107213013.231514-1-brho@google.com>
        <8736q3qon0.fsf@evledraar.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-01-08 at 14:12 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail=
.com> wrote:
> On Mon, Jan 07 2019, Barret Rhoden wrote:
>=20
> > +static int handle_ignore_file(const char *path, struct string_list *ig=
nores)
> > +{
> > +	FILE *fp =3D fopen(path, "r");
> > +	struct strbuf sb =3D STRBUF_INIT;
> > +
> > +	if (!fp)
> > +		return -1;
> > +	while (!strbuf_getline(&sb, fp)) {
> > +		const char *hash;
> > +
> > +		hash =3D strchr(sb.buf, '#');
> > +		if (hash)
> > +			strbuf_setlen(&sb, hash - sb.buf);
> > +		strbuf_trim(&sb);
> > +		if (!sb.len)
> > +			continue;
> > +		string_list_append(ignores, sb.buf);
> > +	}
> > +	fclose(fp);
> > +	strbuf_release(&sb);
> > +	return 0;
> > +} =20
>=20
> Aside from other comments on this patch that Junio had either you mostly
> copy-pasted this from init_skiplist() or you've come up with almost the
> same code on your own.
>=20
> In any case, if we're going to integrate something like this patch let's
> split this "parse file with SHA-1s or comments/whitespace" into a
> utility function that both this and init_skiplist() can call.

One minor difference is that fsck wants an unabbreviated SHA-1, using
parse_oid_hex() instead of get_oid_committish().  Would you be OK with
also changing fsck to take a committish instead of a full SHA-1?

Is there a good place for the common helper?  Since it's an oidset, I
could put it in oidset.c.  oidset_parse_file() or something.

> Then we could split up the description for the fsck.skipList config
> variable to reference that format, and say that both it and this new
> thing should consult those docs for how it's parsed.

Is there a good spot for the generic skipList documentation?  The only
common text would be:=20

	... comments ('#'), empty lines, and any leading and trailing
	whitespace is ignored

Thanks,

Barret

