Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B94C20248
	for <e@80x24.org>; Fri,  1 Mar 2019 11:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732823AbfCALJD (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 06:09:03 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53824 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbfCALJD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 06:09:03 -0500
Received: by mail-wm1-f68.google.com with SMTP id e74so12041733wmg.3
        for <git@vger.kernel.org>; Fri, 01 Mar 2019 03:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=xv2yQvHb1pFpeCUgneZhEfERsQhjvP/DLaQbuuVKaKQ=;
        b=KxUvVXewOUrffoPxmODSXftVdUjqUFW7slNEMjuPQ7vME/JhTjlApIwiuwauwm9VNd
         71AJpO34WHMOzWpmBquSw2peHcgGAmdciBUQK9BglrxWAzGBuTSMDLnl6P8f4R/3nZlR
         AqTuHz7dkKf9lF97z94ncfh52d+BONSaDG4YNlhwmO/GTjw1ZNyPz3Ui1CAk0+/zTf9S
         o159gJag+O/cV3uqSia+eC4g62Io16pc1LZenKWiRTxRp0PeD+WB0jpbw6Eu4vFiq4zb
         Gk99vscL4npRbIGNJ+IDHh0g6V0bK3GaRMqV/mb9U6XgBqwia/Z1Q/+YpBrD42IzzcrK
         Atag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xv2yQvHb1pFpeCUgneZhEfERsQhjvP/DLaQbuuVKaKQ=;
        b=kva3yhF5Vo/lOaKrcLHLbVbcpghgy2GyRWJ7YKjb1zsTFmPifjhAaItwXZ7pIxaqQR
         bqIT/Qs3Cb5zaLwFbcllfdHNTMN4+DYXfF+Ol0YF0b+hjA4VFFp0ygSZ8Gl4XxPWggdd
         SdVmWq6xW2g6jnSdH1qTCoj8edlOtCvhqdzi4A6+M3zISv1UjcWy5tRPccKljuvQDHVf
         DYOQvoBD/qu7CtSLkZTjwVL17ovfs3Jqbtxd9O25bTPsisRrsYjmFZGmAtUh53HGmcTZ
         hhrgFepuo1dY/u9f3mqagvgz5vCscXhGW2SM5zDQQFBrKtg6Wn96O2GUm9s0McP7lyyI
         Mpaw==
X-Gm-Message-State: AHQUAuZWhUSGDJb1zkZomKLqs0WzaFsO6m0cKOOFtia2IdccLL9hwBpz
        oonyKmDzmQkIpTMWbZWpurA=
X-Google-Smtp-Source: APXvYqySX30ULhzwhHBs5htAistobhMDwfWXalqcGaahsgN75lWWTEN2DDLFZ6SIl9797YfUsBmZqg==
X-Received: by 2002:a1c:a8d7:: with SMTP id r206mr2904776wme.115.1551438541352;
        Fri, 01 Mar 2019 03:09:01 -0800 (PST)
Received: from [192.168.1.5] ([31.223.156.168])
        by smtp.gmail.com with ESMTPSA id g10sm30482259wrq.61.2019.03.01.03.08.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 03:09:00 -0800 (PST)
Subject: Re: [PATCH v5 05/10] add-interactive.c: implement status command
To:     Junio C Hamano <gitster@pobox.com>,
        Slavica Djukic via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.103.v4.git.gitgitgadget@gmail.com>
 <pull.103.v5.git.gitgitgadget@gmail.com>
 <9a72aabe6cf1001d373c933086a79ace29b98806.1550662887.git.gitgitgadget@gmail.com>
 <xmqq4l8vpj6x.fsf@gitster-ct.c.googlers.com>
From:   Slavica Djukic <slavicadj.ip2018@gmail.com>
Message-ID: <22f856ad-8248-7f1b-a720-636da6286e82@gmail.com>
Date:   Fri, 1 Mar 2019 12:08:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <xmqq4l8vpj6x.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 22-Feb-19 11:11 PM, Junio C Hamano wrote:
> "Slavica Djukic via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> +static int parse_color_slot(const char *slot)
>> +{
>> +	if (!strcasecmp(slot, "prompt"))
>> +		return COLOR_PROMPT;
>> +	if (!strcasecmp(slot, "header"))
>> +		return COLOR_HEADER;
>> +	if (!strcasecmp(slot, "help"))
>> +		return COLOR_HELP;
>> +	if (!strcasecmp(slot, "error"))
>> +		return COLOR_ERROR;
> As these are "color.interactive.<name>", matching case-insensitively
> is the right thing to do.  Good.
>
> If we would end up increasing the number of slots, we may need to
> switch to LOOKUP_CONFIG(), but for just four of them, this will do.
>
>> @@ -313,3 +357,78 @@ static struct choices *list_and_choose(struct choices *data,
>>   		return NULL;
>>   	}
>>   }
>> +
>> +static struct choice *make_choice(const char *name )
> Excess SP before ')'?
>
>> +{
>> +	struct choice *choice;
> Style: have a blank line here to delineate decls (at the beginning
> of a function) and stmts (at all the decls).
>
>> +	FLEXPTR_ALLOC_STR(choice, name, name);
>> +	return choice;
>> +}
>> +
>> +static struct choice *add_choice(struct choices *choices, const char type,
>> +				 struct file_stat *file, struct command *command)
>> +{
>> +	struct choice *choice;
> Ditto here.
>
>> +	switch (type) {
>> +		case 'f':
> Style: in our codebase, switch and case are indented to the same
> level, with the body of each case arm indented one more level.
>
>> +			choice = make_choice(file->name);
>> +			choice->u.file.index.added = file->index.added;
>> +			choice->u.file.index.deleted = file->index.deleted;
>> +			choice->u.file.worktree.added = file->worktree.added;
>> +			choice->u.file.worktree.deleted = file->worktree.deleted;
> Would it make sense to make sure that all of file->index,
> u.file.index, file->wt, u.file.wt are exactly the same type of
> struct by introducing
>
> 	struct adddel { uintmax_t add, del; };
>
> in a very early part of the series, and embed that structure as a
> member in "struct choice" and "struct file_stat"?  That way, these
> assignments would become two structure assignments, that would be
> much easier to read.


Yes, definitely. I worked on this and it will be included in the next 
iteration.


>
>> +void add_i_status(void)
>> +{
>> +	struct collection_status *s;
>> +	struct list_and_choose_options opts = { 0 };
>> +	struct hashmap *map;
>> +	struct hashmap_iter iter;
>> +	struct choices choices = CHOICES_INIT;
>> +	struct file_stat *entry;
>> +	const char *modified_fmt = _("%12s %12s %s");
>> +	const char type = 'f';
>> +
>> +	opts.header = xmalloc(sizeof(char) * (HEADER_MAXLEN + 1));
>> +	snprintf(opts.header, HEADER_MAXLEN + 1, modified_fmt,
>> +		 _("staged"), _("unstaged"), _("path"));
> Is there aversion to use of strbuf among your mentors?
>
>
>> +	s = list_modified(the_repository, NULL);
>> +	if (s == NULL)
>> +		return;
>> +
>> +	map = &s->file_map;
>> +	hashmap_iter_init(map, &iter);
>> +	while ((entry = hashmap_iter_next(&iter))) {
>> +		add_choice(&choices, type, entry, NULL);
>> +	}
>> +
>> +	list_and_choose(&choices, &opts);
> In what order are these filenames given?  Whatever random order the
> hashmap happens to store them in?
>
> I vaguely recall in an earlier step the code used hashmap to collect
> but at the end produced a sorted list out of the final result.
> Shouldn't we be iterating over that sorted list instead?  Do we even
> need the hashmap at this point?


We actually don't need hashmap at this point, I've changed this so that
list_modified returns produced sorted list.
I've also applied all other suggestions in this message.
Thank you.

>> +	hashmap_free(&s->file_map, 1);
>> +	free(s);
>> +	free_choices(&choices);
> Did we just leak opt.header?
>
>> +}
>> diff --git a/add-interactive.h b/add-interactive.h
>> new file mode 100644
>> index 0000000000..8ef3d2e82b
>> --- /dev/null
>> +++ b/add-interactive.h
>> @@ -0,0 +1,8 @@
>> +#ifndef ADD_INTERACTIVE_H
>> +#define ADD_INTERACTIVE_H
>> +
>> +int add_i_config(const char *var, const char *value, void *cbdata);
>> +
>> +void add_i_status(void);
>> +
>> +#endif
>> diff --git a/builtin/add--helper.c b/builtin/add--helper.c
>> index 6a97f0e191..464d2245f3 100644
>> --- a/builtin/add--helper.c
>> +++ b/builtin/add--helper.c
>> @@ -1,6 +1,38 @@
>> +#include "add-interactive.h"
>>   #include "builtin.h"
>> +#include "config.h"
>> +#include "revision.h"
>> +
>> +static const char * const builtin_add_helper_usage[] = {
>> +	N_("git add-interactive--helper <command>"),
>> +	NULL
>> +};
>> +
>> +enum cmd_mode {
>> +	DEFAULT = 0,
>> +	STATUS
>> +};
>>   
>>   int cmd_add__helper(int argc, const char **argv, const char *prefix)
>>   {
>> +	enum cmd_mode mode = DEFAULT;
>> +
>> +	struct option options[] = {
>> +		OPT_CMDMODE(0, "status", &mode,
>> +			    N_("print status information with diffstat"), STATUS),
>> +		OPT_END()
>> +	};
>> +
>> +	git_config(add_i_config, NULL);
>> +	argc = parse_options(argc, argv, NULL, options,
>> +			     builtin_add_helper_usage,
>> +			     PARSE_OPT_KEEP_ARGV0);
>> +
>> +	if (mode == STATUS)
>> +		add_i_status();
>> +	else
>> +		usage_with_options(builtin_add_helper_usage,
>> +				   options);
>> +
>>   	return 0;
>>   }
