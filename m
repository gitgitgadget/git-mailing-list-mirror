Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E70F20281
	for <e@80x24.org>; Thu, 14 Sep 2017 07:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751354AbdINHno (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 03:43:44 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34543 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751206AbdINHnm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 03:43:42 -0400
Received: by mail-io0-f193.google.com with SMTP id g32so2887529ioj.1
        for <git@vger.kernel.org>; Thu, 14 Sep 2017 00:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wxNSvMZ/fLC300exB1vxFfbajnjEVnyoLHXP+qbQ5rI=;
        b=rEKtte8im7QpgkwiZIOcE1fDGdT2zlT4qe1n8wfsZmPgUHMaThHDN25kvGxi+cPz3X
         mX9ClBKctDaxWWhHyEsMMpsF/R88a1w09zxi9TlAwCHoBKAyuJitDbcBqRnjBZOQfUa2
         os3xOyDXbd9ART4eK4+n2jXpB+9bYjTldflqp+mCembDBFENulyLsE6zhSu60PYeNoGH
         uOArumUofykk/m8//CLFNO0IIDfXpTv1aiINpjscGW/NigBeniAXg4nf8veENNmDCj8V
         rUQrlDa5NqhwrhPCUf2zNVZiLpXAjH7C5+X1VCL+LzQwxQIjlbCQahfwvn8o3cReXMXP
         dmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wxNSvMZ/fLC300exB1vxFfbajnjEVnyoLHXP+qbQ5rI=;
        b=GSSRu8rU2ETI2RBu+DzthnIxZYzKgyQgBAHp9fZUEcqCZZwIsE+0dmovVEmPgKQCqQ
         OI9GjxCQS/NoSqSFhT/J9ZedYaIfn8wdkjSeJhDUwHzSROgWAeLwSYpvyc8q/IWDbZ/z
         uNDS+wihN4fAt4NpBAH/13o84toxCGtOy/KYXuQWJdDeYVuUFwHluykfWBujGDax2COK
         bb/MWpA7KwuGnxt2GjJudVC9r4Jgn1kXJagW7o6rvJZZJeolnltEdx0liLbYsYSik9AW
         zYTL7QI7Df/4afrhtWcs4JiHwX7RE/7A8VwxViMxhYyCmOMomvW9yN3fsS2YMiNHp1mJ
         7RmA==
X-Gm-Message-State: AHPjjUiGF70OTHlIjnhf8RH5Ec8HOHDkG7VFq4muf/9V7hdQ0+0krlb/
        RTiKCf0wwpEMV8lUCeW/D8rPaY98rsjTOcuWvls=
X-Google-Smtp-Source: AOwi7QCs5BHnjnkNINflbcuZTfDcKh7NJMFTMOaNhDHdwsOyguH73NfLm39x61hU5STQJYMeQtjtZrB9vpwYUWmDB7o=
X-Received: by 10.107.20.14 with SMTP id 14mr1327437iou.69.1505375022088; Thu,
 14 Sep 2017 00:43:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.107.136 with HTTP; Thu, 14 Sep 2017 00:43:41 -0700 (PDT)
In-Reply-To: <xmqq3798xvns.fsf@gitster.mtv.corp.google.com>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
 <20170803091926.1755-20-chriscool@tuxfamily.org> <xmqq3798xvns.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 14 Sep 2017 09:43:41 +0200
Message-ID: <CAP8UFD2-V_2UOfp3zrTf0bSX7Y7g66FMAfhWW3==_GNd7oG_zw@mail.gmail.com>
Subject: Re: [PATCH v5 19/40] lib-httpd: add upload.sh
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 3, 2017 at 10:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> +OLDIFS="$IFS"
>> +IFS='&'
>> +set -- $QUERY_STRING
>> +IFS="$OLDIFS"
>> +
>> +while test $# -gt 0
>> +do
>> +    key=${1%=*}
>> +    val=${1#*=}
>
> When you see that ${V%X*} and ${V#*X} appear in a pair for the same
> variable V and same delimiter X, it almost always indicates a bug
> waiting to happen.
>
> What's the definition of "key" here?  A member of known set of short
> tokens, all of which consists only of alphanumeric, or something?

Yeah, the key can be only "sha1", "type", "size" or "delete" as can be
seen later in the code.

> Even if you do not currently plan to deal with a value with '=' in
> it, it may be prudent to double '%' above (and do not double '#').

Yeah I agree. Thanks for spotting this!

> Style: indent your shell script with tabs.

Sure.

>> +    case "$key" in
>> +     "sha1") sha1="$val" ;;
>> +     "type") type="$val" ;;
>> +     "size") size="$val" ;;
>> +     "delete") delete=1 ;;
>> +     *) echo >&2 "unknown key '$key'" ;;
>> +    esac
>
> Indent your shell script with tabs; case/esac and the labels used
> for each case arms all align at the same column.

Yeah, it will be properly indented in the version I will send soon.
