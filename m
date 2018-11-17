Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 874311F87F
	for <e@80x24.org>; Sat, 17 Nov 2018 14:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbeKRBQt (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Nov 2018 20:16:49 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:26242 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbeKRBQt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Nov 2018 20:16:49 -0500
Received: from [192.168.2.240] ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id O24cg6HuIpXFjO24dgO0Dj; Sat, 17 Nov 2018 14:59:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1542466791;
        bh=vMCiis9OWiJqkVz0i19DUTR6yo7vXDQdYIvguQOoP1o=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TLWH1kKy+yfptAuOjRQyn24QeWwwdXhP1HAvJuAtvbEuvH7ozyc0zRlPTkY/bcJ6m
         ZkNC7zh8HXVaePjLkji0SoF5NbZVtVRDJcYiQQJL38ufur7RZ3i39XPNbNXCnfH9ny
         8Z3ToSa9+OKNlETu2HZyNubTE8Utl2BVC9Twe30E=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=Ob228CbY c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=evINK-nbAAAA:8 a=TFlf1opLq2_i-tt265IA:9 a=8qCO3bjdynbjrWmr:21
 a=O0Rjr6cStY6haPJq:21 a=QEXdDO2ut3YA:10 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v1 8/9] diff --color-moved-ws: modify
 allow-indentation-change
To:     Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git <git@vger.kernel.org>
References: <20180924100604.32208-1-phillip.wood@talktalk.net>
 <20181116110356.12311-1-phillip.wood@talktalk.net>
 <20181116110356.12311-9-phillip.wood@talktalk.net>
 <CAGZ79kb2fY+6xg=B+t=gSEBQ+u-wKAff++z5A=KiN2u0yYFF6g@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <42818e32-8774-722d-b46d-9a23f4097315@talktalk.net>
Date:   Sat, 17 Nov 2018 14:59:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CAGZ79kb2fY+6xg=B+t=gSEBQ+u-wKAff++z5A=KiN2u0yYFF6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfF+00o83OJT1rhNe/H61IcsL+cOd5m3lJ26HvDg+9hY4i6c31v8RzhTMw2aE5Lzmg9AQZIt3e0kQ0Qaa1iYbabQJjqdCekOhrKM59MMBGN6qeSeFcxCh
 smRgkNalWh/3A9e+u2XFj7SZkFVQyK46lTDweUqyVm1eHRGFbFhisExUDhvBrHgOnD5FvS83Z6aDwEXqworeG21Pzauh8U+LimL+OkxyA3GxOG4EcF1DQVY6
 4+DjUvwwpjaJ1FWdOYdWzQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan

On 16/11/2018 21:47, Stefan Beller wrote:
> On Fri, Nov 16, 2018 at 3:04 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
>>
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Currently diff --color-moved-ws=allow-indentation-change does not
>> support indentation that contains a mix of tabs and spaces. For
>> example in commit 546f70f377 ("convert.h: drop 'extern' from function
>> declaration", 2018-06-30) the function parameters in the following
>> lines are not colored as moved [1].
>>
>> -extern int stream_filter(struct stream_filter *,
>> -                        const char *input, size_t *isize_p,
>> -                        char *output, size_t *osize_p);
>> +int stream_filter(struct stream_filter *,
>> +                 const char *input, size_t *isize_p,
>> +                 char *output, size_t *osize_p);
>>
>> This commit changes the way the indentation is handled to track the
>> visual size of the indentation rather than the characters in the
>> indentation. This has they benefit that any whitespace errors do not
> 
> s/they/the/

Thanks, well spotted

> 
>> interfer with the move detection (the whitespace errors will still be
>> highlighted according to --ws-error-highlight). During the discussion
>> of this feature there were concerns about the correct detection of
>> indentation for python. However those concerns apply whether or not
>> we're detecting moved lines so no attempt is made to determine if the
>> indentation is 'pythonic'.
>>
>> [1] Note that before the commit to fix the erroneous coloring of moved
>>      lines each line was colored as a different block, since that commit
>>      they are uncolored.
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>
>> Notes:
>>      Changes since rfc:
>>       - It now replaces the existing implementation rather than adding a new
>>         mode.
>>       - The indentation deltas are now calculated once for each line and
>>         cached.
>>       - Optimized the whitespace delta comparison to compare string lengths
>>         before comparing the actual strings.
>>       - Modified the calculation of tabs as suggested by Stefan.
>>       - Split out the blank line handling into a separate commit as suggest
>>         by Stefan.
>>       - Fixed some comments pointed out by Stefan.
>>
>>   diff.c                     | 130 +++++++++++++++++++++----------------
>>   t/t4015-diff-whitespace.sh |  56 ++++++++++++++++
>>   2 files changed, 129 insertions(+), 57 deletions(-)
>>
>> diff --git a/diff.c b/diff.c
>> index c378ce3daf..89559293e7 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -750,6 +750,8 @@ struct emitted_diff_symbol {
>>          const char *line;
>>          int len;
>>          int flags;
>> +       int indent_off;
>> +       int indent_width;
> 
> So this is the trick how we compute the ws related
> data only once per line. :-)
> 
> On the other hand, we do not save memory by disabling
> the ws detection, but I guess that is not a problem for now.

I did wonder about that, but decided the increase was small compared to 
all the strings that are copied when creating the emitted_diff_symbols. 
If we want to save memory then we should stop struct 
emitted_diff_symbol() from carrying a copy of all the strings.

> Would it make sense to have the new variables be
> unsigned? (Also a comment on what they are, I
> needed to read the code to understand off to be
> offset into the line, where the content starts, and
> width to be the visual width, as I did not recall
> the RFC.)

Yes a comment would make sense. I don't think I have a strong preference 
for signed/unsigned, I can change it if you want.

Thanks for looking at these so promptly

Best Wishes

Phillip
>> +static void fill_es_indent_data(struct emitted_diff_symbol *es)
>> [...]
> 
>> +               if (o->color_moved_ws_handling &
>> +                   COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
>> +                       fill_es_indent_data(&o->emitted_symbols->buf[n]);
> 
> Nice.
> 
> By reducing the information kept around to ints, we also do not need
> to alloc/free
> memory for each line.
> 
>> +++ b/t/t4015-diff-whitespace.sh
>> @@ -1901,4 +1901,60 @@ test_expect_success 'compare whitespace delta incompatible with other space opti
>>          test_i18ngrep allow-indentation-change err
>>   '
>>
>> +test_expect_success 'compare mixed whitespace delta across moved blocks' '
> 
> Looks good,
> 
> Thanks!
> Stefan
> 

