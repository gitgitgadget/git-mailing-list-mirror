Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3523202A4
	for <e@80x24.org>; Sun, 10 Sep 2017 12:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbdIJMMc (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Sep 2017 08:12:32 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33236 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751451AbdIJMMb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2017 08:12:31 -0400
Received: by mail-wr0-f193.google.com with SMTP id b9so3198173wra.0
        for <git@vger.kernel.org>; Sun, 10 Sep 2017 05:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PavbcBxi4DuPGz2MQ98e5VqeVnKhZ9ObG322Qj3e7Nc=;
        b=gA80dyxuGsFV/ECFe40We8SUO+vZTZPSBqGkb8IF1AaE9gUB91ukoWkdJMHdYvPGb/
         ro83srm3tTWPrmXGUcBQdmA8yrMV7QWU3yK66AnrxFcArkr91pcnMTG12zDkULmAK0fx
         HChigiOZ+fK22vZp9tSoj3df6wcNnUu+mPd9sH/z6bsyN9nZRTk2UiYeGgDyhSUfdMaz
         3oxVL8vpAfk2meCnUMvLpRGmfPOyjUxIiyAFxDtqVO4nUtYyuiXkyWeWlig18PlAt0J9
         42dX+Bh4ESJVXAFizb/bhUxzP93ptczJz5WWw/a2MUPYPwekOfgdFydk++T5RG9q04lb
         ZV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PavbcBxi4DuPGz2MQ98e5VqeVnKhZ9ObG322Qj3e7Nc=;
        b=RNJJauD171EXWAQLkWgJO/LTWPHCRUMQ+qKzCasr0I7sG8PoL7ijj4By5ixRe3orEk
         oiyneeEbP5fKnE16JuVN5LguaYpL4ob+6rJYW3bHwVjgxqL4gArrUBRv++l7ovH5I0FI
         btRpuY6NjcbwVoi54mmbK9bBG8Zt78yHDTanVrMzSh668ZArnAe8s8SCdxY4hK6ueL2k
         CKAPX6fvxzXFCshVwOMdw8pTzgT5hgVeiGYlizQ6gAKMxMz5jDgymDSzSmmdF53iL3y9
         IKsZIlou3pONRIS08Pb9ROU9HBMMkrBKbwZqRDLSJgAfrv1b7sk0zPsfTfjlTz4SBmZt
         vhzA==
X-Gm-Message-State: AHPjjUgZ7dlyNhsWUN2ZI3FOqqG+anqhaRswBk8RE+NlTauZJENPAz+O
        jQYj8FnlesItmg==
X-Google-Smtp-Source: ADKCNb6ps11m9f1Dxc6rPKw7TwUtf5xFMyGSCiZbjKR+iT4EQxYwzKjfsZEIqlFmqi4zCHvTRbeLvA==
X-Received: by 10.223.182.10 with SMTP id f10mr3138389wre.38.1505045550135;
        Sun, 10 Sep 2017 05:12:30 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB7AFE.dip0.t-ipconnect.de. [93.219.122.254])
        by smtp.gmail.com with ESMTPSA id 193sm11452563wmh.47.2017.09.10.05.12.28
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 10 Sep 2017 05:12:28 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 11/40] odb-helper: add odb_helper_init() to send 'init' instruction
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170803091926.1755-12-chriscool@tuxfamily.org>
Date:   Sun, 10 Sep 2017 14:12:27 +0200
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>, Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C327746B-3E57-4AA9-B29E-AA3C33722D3B@gmail.com>
References: <20170803091926.1755-1-chriscool@tuxfamily.org> <20170803091926.1755-12-chriscool@tuxfamily.org>
To:     Christian Couder <christian.couder@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 03 Aug 2017, at 10:18, Christian Couder =
<christian.couder@gmail.com> wrote:
>=20
> Let's add an odb_helper_init() function to send an 'init'
> instruction to the helpers. This 'init' instruction is
> especially useful to get the capabilities that are supported
> by the helpers.
>=20
> So while at it, let's also add a parse_capabilities()
> function to parse them and a supported_capabilities
> variable in struct odb_helper to store them.
>=20
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> ...
>=20
> +static void parse_capabilities(char *cap_buf,
> +			       unsigned int *supported_capabilities,
> +			       const char *process_name)
> +{
> +	struct string_list cap_list =3D STRING_LIST_INIT_NODUP;
> +
> +	string_list_split_in_place(&cap_list, cap_buf, '=3D', 1);
> +
> +	if (cap_list.nr =3D=3D 2 && !strcmp(cap_list.items[0].string, =
"capability")) {
> +		const char *cap_name =3D cap_list.items[1].string;
> +
> +		if (!strcmp(cap_name, "get_git_obj")) {
> +			*supported_capabilities |=3D =
ODB_HELPER_CAP_GET_GIT_OBJ;
> +		} else if (!strcmp(cap_name, "get_raw_obj")) {
> +			*supported_capabilities |=3D =
ODB_HELPER_CAP_GET_RAW_OBJ;
> +		} else if (!strcmp(cap_name, "get_direct")) {
> +			*supported_capabilities |=3D =
ODB_HELPER_CAP_GET_DIRECT;
> +		} else if (!strcmp(cap_name, "put_git_obj")) {
> +			*supported_capabilities |=3D =
ODB_HELPER_CAP_PUT_GIT_OBJ;
> +		} else if (!strcmp(cap_name, "put_raw_obj")) {
> +			*supported_capabilities |=3D =
ODB_HELPER_CAP_PUT_RAW_OBJ;
> +		} else if (!strcmp(cap_name, "put_direct")) {
> +			*supported_capabilities |=3D =
ODB_HELPER_CAP_PUT_DIRECT;
> +		} else if (!strcmp(cap_name, "have")) {
> +			*supported_capabilities |=3D =
ODB_HELPER_CAP_HAVE;
> +		} else {
> +			warning("external process '%s' requested =
unsupported read-object capability '%s'",
> +				process_name, cap_name);
> +		}

In 1514c8ed ("convert: refactor capabilities negotiation", 2017-06-30) I =
introduced
a simpler version of the capabilities negotiation. Maybe useful for you =
here, too?=20

- Lars=
