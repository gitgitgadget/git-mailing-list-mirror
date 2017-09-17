Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BF8A20281
	for <e@80x24.org>; Sun, 17 Sep 2017 10:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751282AbdIQKTt (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Sep 2017 06:19:49 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:47189 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751263AbdIQKTr (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 17 Sep 2017 06:19:47 -0400
X-AuditID: 1207440d-86bff70000000f42-61-59be4c426c74
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id D4.F8.03906.24C4EB95; Sun, 17 Sep 2017 06:19:46 -0400 (EDT)
Received: from [192.168.69.190] (p57BCC30B.dip0.t-ipconnect.de [87.188.195.11])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8HAJimP000727
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sun, 17 Sep 2017 06:19:45 -0400
Subject: Re: [PATCH] for_each_string_list_item(): behave correctly for empty
 list
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
References: <20170916115118.15490-1-szeder.dev@gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <9d4eb543-7abc-abf5-ed14-73ee75d87547@alum.mit.edu>
Date:   Sun, 17 Sep 2017 12:19:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170916115118.15490-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42IRYndR1HXy2RdpsPaBtUXXlW4mi4beK8wW
        b28uYbT43/aOzaK38Q+rA6vHzll32T0uXlL2+LxJLoA5issmJTUnsyy1SN8ugStj62q+gvUy
        FV+2/2dsYLwl1sXIySEhYCJxsPMaWxcjF4eQwA4miRmrt7FCOOeZJO4u7mUGqRIWCJY4/+sI
        SxcjB4eIgIXEhzmJIDXMAj2MEmtnt7KD1AgJWEp03PzABGKzCehKLOppBrN5Bewljl5ezAhi
        swioSnxcCTKHk0NUIEKi7+1ldogaQYmTM5+AxTkFrCRmPtgHFmcWUJf4M+8SM4QtLnHryXwm
        CFteonnrbOYJjAKzkLTPQtIyC0nLLCQtCxhZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGunl
        ZpbopaaUbmKEBDnvDsb/62QOMQpwMCrx8G4o2RspxJpYVlyZe4hRkoNJSZTXym9PpBBfUn5K
        ZUZicUZ8UWlOavEhRgkOZiURXg77fZFCvCmJlVWpRfkwKWkOFiVxXrUl6n5CAumJJanZqakF
        qUUwWRkODiUJ3rXeQI2CRanpqRVpmTklCGkmDk6Q4TxAw7VBaniLCxJzizPTIfKnGBWlxHnl
        QRICIImM0jy4XlgSesUoDvSKMK8MMCUJ8QATGFz3K6DBTECDW3bsARlckoiQkmpgnC5q1sDb
        8qCGk+WJ5eQQvWXaWhPv+YklbE14ftb+3UnTFV5zeZlOBZd9LWv+6W5bzfSmTPK6jtu8q3+u
        2K26pXpYXuTsn23TCyWMZQuOGrg/nmrR6P92Sfnqs+tOKV36dej2/8nHukRmLi/75zXvVTqj
        g/7JZkXhs6KTylk10lMd9PJD7AOOKbEUZyQaajEXFScCANmwu2kdAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/16/2017 01:51 PM, SZEDER Gábor wrote:
>>>> It would be a pain to have to change the signature of this macro, and
>>>> we'd prefer not to add overhead to each iteration of the loop. So
>>>> instead, whenever `list->items` is NULL, initialize `item` to point at
>>>> a dummy `string_list_item` created for the purpose.
>>>
>>> What signature change do you mean?  I don't understand what this
>>> paragraph is alluding to.
>>
>> I was thinking that one solution would be for the caller to provide a
>> `size_t` variable for the macro's use as a counter (since I don't see a
>> way for the macro to declare its own counter). The options are pretty
>> limited because whatever the macro expands to has to play the same
>> syntactic role as `for (...; ...; ...)`.
> 
> Another option to consider is to squeeze in an if-else before the for
> loop header to handle the empty list case like this:
> 
> diff --git a/string-list.h b/string-list.h
> index 29bfb7ae4..9eed47de0 100644
> --- a/string-list.h
> +++ b/string-list.h
> @@ -32,8 +32,11 @@ void string_list_clear_func(struct string_list *list, string_list_clear_func_t c
>  typedef int (*string_list_each_func_t)(struct string_list_item *, void *);
>  int for_each_string_list(struct string_list *list,
>  			 string_list_each_func_t, void *cb_data);
> -#define for_each_string_list_item(item,list) \
> -	for (item = (list)->items; item < (list)->items + (list)->nr; ++item)
> +#define for_each_string_list_item(item,list) 	\
> +	if ((list)->items == NULL) {		\
> +		/* empty list, do nothing */	\
> +	} else					\
> +		for (item = (list)->items; item < (list)->items + (list)->nr; ++item)
>  
>  /*
>   * Apply want to each item in list, retaining only the ones for which
> 
> This way there would be neither additional overhead in each iteration
> nor a new global.
> 
> Alas, there is a catch.  We can't use curly braces in the macro's else
> branch, because the macro would contain only the opening brace but not
> the closing one, which must come after the end of the loop's body.
> This means that the modified macro couldn't be used in if-else
> branches which themselves don't have curly braces, because it causes
> ambiguity:
> 
>   if (condition)
>       for_each_string_list_item(item, list)
>           a_simple_oneliner(item);

It's not ambiguous as far as the language standard is concerned. The
latter is clear that an `else` binds to the nearest `if`. The problem is
that this is a common programmer error, so compilers "helpfully" warn
about it even though it would do exactly what we want.

> Our coding guidelines encourage this style for one-liner loop bodies,
> and there is indeed one such place in our codebase, so the following
> hunk is needed as well:
> 
> diff --git a/send-pack.c b/send-pack.c
> index 11d6f3d98..00fa1622f 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -295,9 +295,10 @@ static int generate_push_cert(struct strbuf *req_buf,
>  	}
>  	if (push_cert_nonce[0])
>  		strbuf_addf(&cert, "nonce %s\n", push_cert_nonce);
> -	if (args->push_options)
> +	if (args->push_options) {
>  		for_each_string_list_item(item, args->push_options)
>  			strbuf_addf(&cert, "push-option %s\n", item->string);
> +	}
>  	strbuf_addstr(&cert, "\n");
>  
>  	for (ref = remote_refs; ref; ref = ref->next) {
> 
> 
> Luckily, reasonably modern compilers warn about such ambiguity, so
> perhaps this is an acceptable compromise?

This change kindof goes *against* our coding guidelines, so it's not
ideal either, but I suppose we could probably live with it.

Michael
