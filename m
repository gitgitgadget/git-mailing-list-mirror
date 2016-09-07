Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7445B1F859
	for <e@80x24.org>; Wed,  7 Sep 2016 21:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932482AbcIGVWU (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 17:22:20 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:36148 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753997AbcIGVWS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 17:22:18 -0400
Received: by mail-yw0-f172.google.com with SMTP id u124so4010241ywg.3
        for <git@vger.kernel.org>; Wed, 07 Sep 2016 14:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dPk80B1YAAZA4G+/gKx5cj6RJy5S92LlmqdbRknR1Q0=;
        b=wP+3WEVNqQdt/M3Yu9CxEI9QFHLSnKKkZ8V6Lp/4GP3aX7eVzxWKbygbkySvNl+Obf
         5QdYdrWapUhTt2rAlqa0WspmY/YT+pdP2TjL3n2xdtn+r2wFU5i6k7+VFyFO7i5fua9g
         c9HAdQy2kWQipJfn7hnkpmVgGTSFCKaDFkxgf2YAHZpLVM4j12UvvZEddoUZ/JgcHcFe
         1uoRddBgwvnXaK8Z3bP7ngRJg9XSZrqoRO9ijMewrLly2SmIdlbfDo0BhAW+VYKN1+Rh
         Vyi/OeSDmutEFePxdxhyPnCOo6901UIfCYTJnplLHwRuAMlUjAtq6k7d4XcOmT8cWhjO
         AaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dPk80B1YAAZA4G+/gKx5cj6RJy5S92LlmqdbRknR1Q0=;
        b=UvqPLww3hWkuJDr3DP7EerptA+fuHSDukVDzfbiS7Ze3von1NEdZJerf/fa4/uKzL0
         GBksoFPsiqwyw089zHg42KTZPlU1sZy5VozXBQWrDcMqEsge+F98ed47/Mz0OwSjaXje
         5LX4dNQfz/b55pgJr2Xn6bzpSanyYGgOifXXzRMK2HjCtPurgLqkqrrC8HqJ05kW19rs
         Kc2z7rxWWR9tuciheAxUofjbdJK9fzgtUNBMa5bgj42WmXAXWMB4cx819/9w5o2SgNHL
         FwOrFxX1j7ebObjmtVfCKmg5w6SticOybm91fKzMt1Y62CdhtQecUn0jri4jbZU+2SvY
         KD5A==
X-Gm-Message-State: AE9vXwMiwPtZOW6v/94o015wZ2v/GvNsETIlQcVUbEpEA3YY7LZ7HU4l42u4+2XOoNQfZ3+/ENvkXRlod77EcQ==
X-Received: by 10.129.168.9 with SMTP id f9mr39719346ywh.258.1473283337786;
 Wed, 07 Sep 2016 14:22:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Wed, 7 Sep 2016 14:21:57 -0700 (PDT)
In-Reply-To: <xmqqy433mvg6.fsf@gitster.mtv.corp.google.com>
References: <cover.1473068229.git.mhagger@alum.mit.edu> <xmqqy433mvg6.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 7 Sep 2016 14:21:57 -0700
Message-ID: <CA+P7+xo7Q0q+Vg4atb23M90HiMazwgiXGFmgty-+hF-r+3veww@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] Better heuristics make prettier diffs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Git mailing list <git@vger.kernel.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 7, 2016 at 11:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> * In "blame: honor the diff heuristic options and config":
>>
>>   * In v2, I suggested making `blame` honor all diff-related options.
>>     Junio explained why this was a bad idea. So this version only
>>     makes `blame` honor `--indent-heuristic` and
>>     `--compaction-heuristic`.
>
> This makes a lot more sense to me.  I am not sure if it is worth
> adding 7/8 to expose these experimental knobs to the end users, but
> the amount of the code needed is very small, so let's take it.
>
> I am hoping that we can lose both of the experimental knobs and use
> the indent heuristic unconditionally in the future, though ;-)
>
> Thanks.
>


Agreed, I think we should drop the knobs and use the feature
unconditionally as well.

Thanks,
Jake
