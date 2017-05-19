Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 339D52023D
	for <e@80x24.org>; Fri, 19 May 2017 19:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932207AbdESTfB (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 15:35:01 -0400
Received: from mail-ua0-f169.google.com ([209.85.217.169]:32815 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753364AbdESTe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 15:34:59 -0400
Received: by mail-ua0-f169.google.com with SMTP id e28so31833419uah.0
        for <git@vger.kernel.org>; Fri, 19 May 2017 12:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VXXI8pHu5BhjYU+p6iIn+5i0Gso+M6s2vY5qql6b+OQ=;
        b=CRcI5y6SsdHAOpXGpvON/2fpgTbCy+ju0mmevlDa9gMLM7nD7cyzs2+Z000xXzsbF/
         O1VJta8yDERtPGtJsWp6J/1CO99HY4UK2qeNMMYQjrgUatz3sruBbgfpWVDnWLgLzvNY
         EQ5fjSh0EvjwwFz0qOxIV1RgxE841rbVRjRmaJKr9qEuZzh0MGo2BVbg7H80iFwfvG6U
         ktQcRfe1GxcSpPPTjsz/ceXHNNdfCcZpok5sf2ZrCHtgDRjl9YcGm2QZWeDpDwSyILkH
         hfcyvMp/PSFDiFK6yxVJHagf1gP/lD6YzvODvo7dpcRpp1C6UqZ8YCkmYMO8fO+tJMxy
         Y05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VXXI8pHu5BhjYU+p6iIn+5i0Gso+M6s2vY5qql6b+OQ=;
        b=iULAHuEjAHOrDOyRlQCLEA+NVYQyemRGURPyPRv5awv1Db+q24jCyWxagJAJVVyr/Z
         123+F64lux8JyUQShHhtQssjkIa1pP/3v71l1oBjfgxNEENhmn3gJI11c30XtuPSrMwI
         URs2X20DnGSFUW3iK+YiFZFJ/22jaoWA6qHMSMfSDnNHasTcrdFOzsVKhMut3MAktvxh
         phzRz9OtiQL3t/PK92/luB/zc//Bz68Rm6hZyOuvsKpHJ675jesaDEJN5er+3MPFWrS2
         7PuJeBYkMFtnIgDQQftViytHKG6RINSk3Xi22MSA4XL8URTPAhhyNjMsBLuV2p/vXroy
         yOZQ==
X-Gm-Message-State: AODbwcAvhgjfkVLdcE/yIXmaxnVNl4Ty+GO4mZW0mJUp5fwnzGlbOBDe
        3pHr1K9Ve8i3sCx99d+rp1WOGgP2280f
X-Received: by 10.176.83.16 with SMTP id x16mr1642211uax.11.1495222498484;
 Fri, 19 May 2017 12:34:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.147.198 with HTTP; Fri, 19 May 2017 12:34:57 -0700 (PDT)
In-Reply-To: <CAGZ79kYzgZeAnYsEODEYAEavvABS89oSq9Zj80=eS2ObtnMmNg@mail.gmail.com>
References: <20170517025857.32320-1-sbeller@google.com> <20170518193746.486-1-sbeller@google.com>
 <20170518193746.486-21-sbeller@google.com> <20170519112330.731ecc66@twelve2.svl.corp.google.com>
 <CAGZ79kYzgZeAnYsEODEYAEavvABS89oSq9Zj80=eS2ObtnMmNg@mail.gmail.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Date:   Fri, 19 May 2017 12:34:57 -0700
Message-ID: <CAGf8dgLRsHPdvxza6YJQXi4C8Q7QLw5A6LfFARSZ9639cGvb+w@mail.gmail.com>
Subject: Re: [PATCHv3 20/20] diff.c: color moved lines differently
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 19, 2017 at 11:40 AM, Stefan Beller <sbeller@google.com> wrote:
>>> +static unsigned get_line_hash(struct buffered_patch_line *line, unsigned ignore_ws)
>>> +{
>>> +     static struct strbuf sb = STRBUF_INIT;
>>> +
>>> +     if (ignore_ws) {
>>> +             strbuf_reset(&sb);
>>> +             get_ws_cleaned_string(line, &sb);
>>
>> Memory leak here, I think.
>
> It's static, so we don't care.
> I can make it non-static and release the memory in a resend.

Ah, I missed the "static". It seems that "static" is used elsewhere
too, so these functions are not reentrant anyway, so this is fine.
