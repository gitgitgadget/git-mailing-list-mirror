Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BE6D1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 12:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbeFFMVU (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 08:21:20 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35255 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751864AbeFFMVT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 08:21:19 -0400
Received: by mail-wm0-f51.google.com with SMTP id j15-v6so11671753wme.0
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 05:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=nW5RJUDU251bYTNDVShUhv5Nuuhm1WvUDyM5TTsXGGc=;
        b=Fz6w4in0D/nM15uK/+/wcdq4Z7XvR3xBfWOTjhPVT3Z5fM/va1c/CWePFcg/F6jkCY
         QNVTPc/Fbg5VwgDynkOxypLV0mIoLMHCB1ncgQ0q4kPV2LJThdzkOzPJkRwjwfgJo+6I
         SoeF1ZuoDtqDUls+05HM9LSKzC8Ktu5o2m68DBCJORsun1M8mb/cuoAcfMsqwlwadZfI
         5c061C7I0+np4KyJuh9jGv+2dVa81prElxmUYP1EwgyoJT6qY+bf20RS/B3V43VE8mOq
         CxRw3xW+CNCH+BL5W5XBXJMe6XZcynsIRtbpX7OPpmcZtniAm/AImOy5sWidH/tDNaOX
         0e4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=nW5RJUDU251bYTNDVShUhv5Nuuhm1WvUDyM5TTsXGGc=;
        b=aUzha3SGycfcVuuT6nR48YBpxoNomZ25mn8sAJRPDK90/AKTd045CmeARTz42aExan
         R5Dhc83pjMkWlI0ixt2gSNbxUOnUKeTAvoPijxESj+qdcCZRytXFF/w9RxQQECbAouOc
         q3rycG06cAYASxLeb6o/D7atPeyRONf9z4FEmqFN9sECRE1XwPeCX+SJtnsiVb3iDR+j
         MXgssApXphWpV7M/SmTQLohDxMEmT/FzjCMrwDE4jv4du0a2DeLl6Yuvb1jQ0OtdRnrV
         k7+jzz/CzKM9S4tURxjpKgP9ivkZ7fnXixkXNFW0+nCYUsKnKI08y0T0EBi0O7OVKEZY
         8W+g==
X-Gm-Message-State: APt69E0ccmckKowtgO4a9+nHMQtHffP/vjyE395A9fuH3JvOXiiU7+wd
        R2bDCpk9BJFsq7hZXBtBu9s=
X-Google-Smtp-Source: ADUXVKK6AmF9mWW9mJkB7h2H5PSFfpO25cJ4sNuHYCcSOJ0oVAkiytSXmDq8hGKpcYkTpqQZugnVcQ==
X-Received: by 2002:a50:f043:: with SMTP id u3-v6mr3494314edl.91.1528287678339;
        Wed, 06 Jun 2018 05:21:18 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id j5-v6sm29460039edd.37.2018.06.06.05.21.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 05:21:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "stolee\@gmail.com" <stolee@gmail.com>,
        "jnareb\@gmail.com" <jnareb@gmail.com>,
        "marten.agren\@gmail.com" <marten.agren@gmail.com>,
        "gitster\@pobox.com" <gitster@pobox.com>
Subject: Re: [PATCH v5 08/21] commit-graph: verify required chunks are present
References: <20180604165200.29261-1-dstolee@microsoft.com> <20180606113611.87822-1-dstolee@microsoft.com> <20180606113611.87822-9-dstolee@microsoft.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180606113611.87822-9-dstolee@microsoft.com>
Date:   Wed, 06 Jun 2018 14:21:16 +0200
Message-ID: <87fu20yukj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 06 2018, Derrick Stolee wrote:

> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index c0c1ff09b9..846396665e 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -249,6 +249,15 @@ test_expect_success 'git commit-graph verify' '
>
>  GRAPH_BYTE_VERSION=4
>  GRAPH_BYTE_HASH=5
> +GRAPH_BYTE_CHUNK_COUNT=6
> +GRAPH_CHUNK_LOOKUP_OFFSET=8
> +GRAPH_CHUNK_LOOKUP_WIDTH=12
> +GRAPH_CHUNK_LOOKUP_ROWS=5
> +GRAPH_BYTE_OID_FANOUT_ID=$GRAPH_CHUNK_LOOKUP_OFFSET
> +GRAPH_BYTE_OID_LOOKUP_ID=$(($GRAPH_CHUNK_LOOKUP_OFFSET + \
> +			    1 \* $GRAPH_CHUNK_LOOKUP_WIDTH))

On GNU bash, version 4.1.2(2)-release (x86_64-redhat-linux-gnu) this
emits:

./t5318-commit-graph.sh: line 285: 8 +                      1 \* 12: syntax error: invalid arithmetic operator (error token is "\* 12")

The same goes for the rest of this "\*" within $((...)) in this file, it
should just be "*"..

> +GRAPH_BYTE_COMMIT_DATA_ID=$(($GRAPH_CHUNK_LOOKUP_OFFSET + \
> +			     2 \* $GRAPH_CHUNK_LOOKUP_WIDTH))
