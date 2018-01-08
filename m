Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 675361FAE2
	for <e@80x24.org>; Mon,  8 Jan 2018 20:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752351AbeAHUJP (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 15:09:15 -0500
Received: from mail-qt0-f169.google.com ([209.85.216.169]:40413 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751553AbeAHUJN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 15:09:13 -0500
Received: by mail-qt0-f169.google.com with SMTP id u42so15148031qte.7
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 12:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GEEPxJpuAR2bKFE6zx3K7bWzs21OWDA7NoFq2FiRxNU=;
        b=n9iUlm9QEVBts6iXAqBCMh/1tf4vIs69sGhK7UfXcOFFs27W8pTWFSjS5PYtxp8kd2
         MRp42eFc8Rqh2Z5sg4ZQGXATV0ngpLkveuk46UcfSkHNV1Sa5aWFPjgsZ/mMB8heAc+8
         Y130xMbDCWfVeNEw5cq7wI7cpxImbw9EUtehs6cbmiE1LKKXv7Q4LdTv5iTH0GKsEZIJ
         uC7ykhU0uzloyPes9RAt2wuBBXYFhKsvETVgMoOa2At4Kmystc0zTc7ucmrEdWFNcq8+
         IwGPRJokFq7XNOn7/YvOO2wovxHcRbcRqJ97WMvOqZVPE9SNwnUXmGu5ZPF5tuEQWwYu
         vnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GEEPxJpuAR2bKFE6zx3K7bWzs21OWDA7NoFq2FiRxNU=;
        b=FqWS8UU8AG8n8CDGkNi5QySk4pYeKLG1FtcE8I0vPtefotiRS3GzQXTDxzQFekYV+0
         8jYN55veIQ+iwEanJTp/DAKyOxPDWUYVFky+PjP0Z6kgJuGbYMd6/attmEgKnhdxgbKi
         o0w0jxkoBG/A7PRPK2ibqDkg7Zu3ZEQGbwutsUi/d6ORejWP/XbzQFECp87PTyQ9YbeS
         i6Ghe7lD/fVMxd/y2/zhgsltv6ld3pYEgt1q1y9hrwkqeO4wBS3ou0x/WAhsudHAIzQz
         ub5CnzwYpMceYBXKxz5Cuz71x4HnNZtRavHlU+p8LZoCOwbQ9bJDwsmPRosuBzeLDqpP
         zKIA==
X-Gm-Message-State: AKwxytdAByW3wNbjqdZSOmuk8OlgQF1guQez/lUsQz0rJIcTT3G6yLIS
        gG7CSHmAmuTDv/2EUl10s45mEpYU2WKRdBK6MhoPwNzA
X-Google-Smtp-Source: ACJfBovPSTGKNXdHHZSXlzRXxw7M37cyQWVyFK+AjN7dQ4FInheq9b/d+ijtj2bXcckIckH4hY6LLwJ+uWX82L/jbek=
X-Received: by 10.237.38.35 with SMTP id z32mr18246514qtc.180.1515442152819;
 Mon, 08 Jan 2018 12:09:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Mon, 8 Jan 2018 12:09:12 -0800 (PST)
In-Reply-To: <xmqqfu7g86qs.fsf@gitster.mtv.corp.google.com>
References: <20171110011002.10179-1-sbeller@google.com> <20180104224007.214548-1-sbeller@google.com>
 <20180104224007.214548-5-sbeller@google.com> <xmqqfu7g86qs.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 8 Jan 2018 12:09:12 -0800
Message-ID: <CAGZ79kays4c89quf+8g7vCzydoWxUCnZ0GmC-SP7tgE1vd=fzg@mail.gmail.com>
Subject: Re: [PATCHv3 4/4] builtin/blame: highlight recently changed lines
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 8, 2018 at 11:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> +static struct color_field {
>> +     timestamp_t hop;
>> +     char col[COLOR_MAXLEN];
>> +} *colorfield;
>> +static int colorfield_nr, colorfield_alloc;
>> +
>> +static void parse_color_fields(const char *s)
>> +{
>> +     struct string_list l = STRING_LIST_INIT_DUP;
>> +     struct string_list_item *item;
>> +     enum { EXPECT_DATE, EXPECT_COLOR } next = EXPECT_COLOR;
>> +
>> +     /* Ideally this would be stripped and split at the same time? */
>> +     string_list_split(&l, s, ',', -1);
>> +     ALLOC_GROW(colorfield, colorfield_nr + 1, colorfield_alloc);
>> +
>> +     for_each_string_list_item(item, &l) {
>> +             switch (next) {
>> +             case EXPECT_DATE:
>> +                     colorfield[colorfield_nr].hop = approxidate(item->string);
>> +                     next = EXPECT_COLOR;
>> +                     colorfield_nr++;
>> +                     ALLOC_GROW(colorfield, colorfield_nr + 1, colorfield_alloc);
>> +                     break;
>
> This should make sure cf[i].hop is monotonically increasing to avoid
> end-user mistakes, I would think (what's 'hop' by the way?).
>
>> +             case EXPECT_COLOR:
>> +                     if (color_parse(item->string, colorfield[colorfield_nr].col))
>> +                             die(_("expecting a color: %s"), item->string);
>
> When you have a typo in one of your configuration files, say "[color
> "blame"] highlightrecent = 1,week,blue,...", you'd want to see a bit
> more than just "expecting a color: week" to help you diagnose and
> resolve the issue.  Giving the name of the variable and the file the
> wrong definition was found in would be needed, givin that this is
> called from the config callback git_blame_config() below.
>
>> +                     next = EXPECT_DATE;
>> +                     break;
>> +             }
>> +     }
>> +
>> +     if (next == EXPECT_COLOR)
>> +             die (_("must end with a color"));
>
> Same here.
>
>>               OPT_BIT(0, "color-lines", &output_option, N_("color redundant metadata from previous line differently"), OUTPUT_COLOR_LINE),
>>               OPT_BIT(0, "color-fields", &output_option, N_("color redundant metadata fields from previous line differently"), OUTPUT_COLOR_FIELDS),
>> +             OPT_BIT(0, "heated-lines", &output_option, N_("color lines by age"), OUTPUT_HEATED_LINES),
>
> These options may be useful while having fun experimenting, but my
> gut feeling is that these are too fine-grained for end-users to
> tweak per invocation basis (which is what command line options are
> for).
>
> But perhaps I am biased (as anybody else), as personally I find
> anything beyond step 2/4 uninteresting, and not adding too many of
> these options is consistent with that viewpoint ;-)

See, I find 2 and 3 uninteresting and just did it 'because someone else
hinted at that is what they want'. Maybe I was a bad listener.

4 (maybe with 2 in combination) would be all I need as that allows me
to quickly judge the trustworthiness of code (old code is better,
just like most liquors? ;)

> In any case, thanks for a fun read.

Thanks, I'll reread the comments and see if I can remove some
options to make it useful for upstream consumption.

Thanks,
Stefan
