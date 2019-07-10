Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5FB01F461
	for <e@80x24.org>; Wed, 10 Jul 2019 18:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbfGJSdD (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jul 2019 14:33:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38105 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfGJSdC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jul 2019 14:33:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id g17so3518828wrr.5
        for <git@vger.kernel.org>; Wed, 10 Jul 2019 11:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=tulKnroNuSDIoOAhHme/uy6q6ha1+v+ip7QSZTmeWtk=;
        b=FmTomECkADQ2CQUPBYRAZuEI6VcQGOeIcq2eC/y2+SbWB5uR6ZDdUBp4N+W6TF2S8E
         uOiBdoEu8C3GWXtFaEMDSAos8mToPHpfNE3qn+4HmfwFo7/3ZNsL2gg/HzD55xYJLUkf
         NktBu6tbbAHCC6mM6H4cGIpGBSsTdVRsOQJs6QE4GM48IghjoFH8shHYeqUXLqlnzLy7
         AEktBaUwhhLuDBeBMAcyzxEy2lHqVtoktJ3Ta1KfF7de7XQR56BZ9te8RGB30Ziq5NdJ
         /GniBaBqbZR3IxgTB9QF8RaVsJWjctTLXQOYR5jbip8Gl4NDk49+pj66Ej3z647Js8qZ
         XUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=tulKnroNuSDIoOAhHme/uy6q6ha1+v+ip7QSZTmeWtk=;
        b=tFS41r0kTkwpY8o7pi9e5I2pK99psODVOcSn/R5TCz7kj//YRjPktRmsqoC2r7/Dcg
         CiDZizhdZvlRfTBx3U9XsI3vlevADd4wIBWuBQfgeDW1wn36Z5+l16b8npTpIzw5Ur6u
         xPaHwos66Q81kcb/ak+zvrg4e2LeJMEKdOVOf4GG9+iTfnHMvlLlQIFCPxlZQTNyapks
         4RwKrChwxySupNKCCk7z/yhw8jrkYj2InrgN0gzHLkuUl4qj5cCuBq71WqBGY479ndrZ
         8UkLCcT89hEluzqTRRi+PZVqhmw1j4j/pTBHFGGNNOeQgG74WmxsWEV4L3IpmXsVZwEm
         P00Q==
X-Gm-Message-State: APjAAAXcncKVLPEu32T0sFmnmxNEZ9uSAOmntEM3HHm1kUttB6jgjDiA
        Rlw2Ufmdh33z10JTrkkvaHbD/3ItbS8=
X-Google-Smtp-Source: APXvYqwlGlxRq8KGsDheFcSzNcnvOlFxP+ElNgTbtdlNxiSiKMmec6BOSxL1g9zPwBD7mp9ROeePow==
X-Received: by 2002:a05:6000:2:: with SMTP id h2mr14051463wrx.90.1562783580766;
        Wed, 10 Jul 2019 11:33:00 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egd227.neoplus.adsl.tpnet.pl. [83.21.67.227])
        by smtp.gmail.com with ESMTPSA id f17sm2911082wmf.27.2019.07.10.11.32.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jul 2019 11:33:00 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, git@jeffhostetler.com,
        avarab@gmail.com, peff@peff.net
Subject: Re: [RFC PATCH v2 1/3] trace2: Add a JSON schema for trace2 events
References: <cover.1560295286.git.steadmon@google.com>
        <cover.1562712943.git.steadmon@google.com>
        <a949db776c77e5c97c78055f1bb0f2101096f861.1562712943.git.steadmon@google.com>
Date:   Wed, 10 Jul 2019 20:32:55 +0200
In-Reply-To: <a949db776c77e5c97c78055f1bb0f2101096f861.1562712943.git.steadmon@google.com>
        (Josh Steadmon's message of "Tue, 9 Jul 2019 16:05:43 -0700")
Message-ID: <86wogp68q0.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> Define a JSON schema[1] that can be used to validate trace2 event
> objects. This can be used to add regression tests to verify that the
> event output format does not change unexpectedly.
>
> Two versions of the schema are provided:

Actually, four versions of the schema are provided, as you have written
in the t/trace_schema_validator/README file.

> * event_schema.json is more permissive. It verifies that all expected
>   fields are present in each trace event, but it allows traces to have
>   unexpected additional fields. This allows the schema to be specified
>   more concisely by factoring out the common fields into a reusable
>   sub-schema.
> * strict_schema.json is more restrictive. It verifies that all expected
>   fields are present and no unexpected fields are present in each trace
>   event. Due to this additional restriction, the common fields cannot be
>   factored out into a re-usable subschema (at least as-of draft-07) [2],
>   and must be repeated for each event definition.
>
> [1]: https://json-schema.org/
> [2]: https://json-schema.org/understanding-json-schema/reference/combinin=
g.html#allof
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  t/trace_schema_validator/README               |  23 +
>  t/trace_schema_validator/event_schema.json    | 398 ++++++++++++++
>  t/trace_schema_validator/list_schema.json     | 401 ++++++++++++++
>  .../strict_list_schema.json                   | 514 ++++++++++++++++++
>  t/trace_schema_validator/strict_schema.json   | 511 +++++++++++++++++
>  5 files changed, 1847 insertions(+)
>  create mode 100644 t/trace_schema_validator/README
>  create mode 100644 t/trace_schema_validator/event_schema.json
>  create mode 100644 t/trace_schema_validator/list_schema.json
>  create mode 100644 t/trace_schema_validator/strict_list_schema.json
>  create mode 100644 t/trace_schema_validator/strict_schema.json
>
> diff --git a/t/trace_schema_validator/README b/t/trace_schema_validator/R=
EADME
> new file mode 100644
> index 0000000000..45f0e6f0c4
> --- /dev/null
> +++ b/t/trace_schema_validator/README
> @@ -0,0 +1,23 @@
> +These JSON schemas[1] can be used to validate trace2 event objects. They
> +can be used to add regression tests to verify that the event output
> +format does not change unexpectedly.
> +
> +Four versions of the schema are provided:
> +* event_schema.json is more permissive. It verifies that all expected
> +  fields are present in a trace event, but it allows traces to have
> +  unexpected additional fields. This allows the schema to be specified
> +  more concisely by factoring out the common fields into a reusable
> +  sub-schema.
> +* strict_schema.json is more restrictive. It verifies that all expected
> +  fields are present and no unexpected fields are present in the trace
> +  event. Due to this additional restriction, the common fields cannot be
> +  factored out into a re-usable subschema (at least as-of draft-07) [2],
> +  and must be repeated for each event definition.
> +* list_schema.json is like event_schema.json above, but validates a JSON
> +  array of trace events, rather than a single event.
> +* strict_list_schema.json is like strict_schema.json above, but
> +  validates a JSON array of trace events, rather than a single event.
> +
> +[1]: https://json-schema.org/
> +[2]: https://json-schema.org/understanding-json-schema/reference/combini=
ng.html#allof
[...]

--=20
Jakub Nar=C4=99bski
