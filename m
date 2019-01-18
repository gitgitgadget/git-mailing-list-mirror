Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC0331F453
	for <e@80x24.org>; Fri, 18 Jan 2019 12:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfARMTq (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 07:19:46 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36072 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbfARMTq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 07:19:46 -0500
Received: by mail-wr1-f67.google.com with SMTP id u4so14818996wrp.3
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 04:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2qpt0oGSbu0JNxlj04NuME7TXKVy+Iq2Qu4nJTRloLI=;
        b=KhGVbmXDOgysbdj19Uj5XAEwyZZ6IdnGR4ja6KVM1R5o+EmoXvPWoyXlHkUV1F2SpQ
         TAX5BdhEj717mVejz1mlPIL6oBIw+NL0hsdFKne/Q5Dw4yklgjrRXQnPnaP39rxC890K
         /YoFe/ExgN0xmpGnymCtpxLyu7ECu649hJe9GTI66daRJRm644EPNg8FD0aPS6+OT2j0
         oFlbuPxu1LOxSB4njM3mO0M42wQj6N+HOFzjGzDYOZjCrRURVrPt3Uf7TJdlbNSzlE7w
         LfCGnAgEEMp0K49sf7DJ5LxtJClktvsbExG35PDrS5vsH83oVusnfDBPIKofdUtM6q/i
         XWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2qpt0oGSbu0JNxlj04NuME7TXKVy+Iq2Qu4nJTRloLI=;
        b=jO1XCiShEiqbSB2SeabUhTbJSKIHUJErL5G1DDh4uYZSmzKS056ujof9jplaEHT345
         m9jD1PGXEP0sfMFO5ih5jpSbIcTb23lXXIHDYFVaGvLaCdYz5x9D5GG8EZzOfJwE+Uck
         +PGXKTIdOdCL3wer3eQyxFy2JjUdxlwO1++gCCGLGgfQ3OWbEPjVraqscmAYDn088YDB
         2kjmMlrMgiQAq86cnBEMwmwr+iUnOS/Xa4O51MX5bTlSCpBYksnlJhWpmYl88GuXC4bJ
         CrwnPJaKENrYdi1LTKi1+FheDYV8NHYTNcge01oDHS865PufYAAueUgfG2aw4sYlPftw
         FTdA==
X-Gm-Message-State: AJcUukelMdvXp4HYWKcpG4TpFpknwV+wgqWJhM/QRNiaW23O5HB5a61h
        ND4Cs7uro9ODJX/eD+xJ8xI=
X-Google-Smtp-Source: ALg8bN4xmXwRP2RWjcVYHb74obkXACoi00PmHm8Gb0m5+LW97dsDrGHZBTYdgMrOgaf4NW5WJLuciQ==
X-Received: by 2002:adf:9d08:: with SMTP id k8mr17237780wre.203.1547813983816;
        Fri, 18 Jan 2019 04:19:43 -0800 (PST)
Received: from [192.168.1.2] ([31.223.156.10])
        by smtp.gmail.com with ESMTPSA id f18sm71869093wrs.92.2019.01.18.04.19.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 04:19:43 -0800 (PST)
Subject: Re: [PATCH v2 5/7] add-interactive.c: implement show-help command
To:     phillip.wood@dunelm.org.uk,
        Slavica Djukic via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <pull.103.git.gitgitgadget@gmail.com>
 <pull.103.v2.git.gitgitgadget@gmail.com>
 <cf4e913a5a01cfb9e9b8b83b222cd4647fbc0bf2.1547797620.git.gitgitgadget@gmail.com>
 <01255e61-a3b1-e509-9f33-36ad07640b4f@talktalk.net>
From:   Slavica Djukic <slavicadj.ip2018@gmail.com>
Message-ID: <f44a034a-fa67-c345-e4eb-e3410c4543ba@gmail.com>
Date:   Fri, 18 Jan 2019 13:19:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <01255e61-a3b1-e509-9f33-36ad07640b4f@talktalk.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On 18-Jan-19 12:20 PM, Phillip Wood wrote:
> Hi Slavica
>
> I think this round is looking good I've got a couple of comments about
> the translation of the help text but everything else looks fine to me
> now. In future when you're posting a new version it's helpful CC the
> people who commented on the previous version(s).


Thanks for taking your time to review patches again. I'm sorry for 
omitting you

in CC, but I've sent re-roll through GitGitGadget, and I guess I thought 
it would pick it up.

I'll see what happened and keep that in mind.


>
> On 18/01/2019 07:47, Slavica Djukic via GitGitGadget wrote:
>> From: Slavica Djukic <slawica92@hotmail.com>
>>
>> Implement show-help command in add-interactive.c and use it in
>> builtin add--helper.c.
>>
>> Use command name "show-help" instead of "help": add--helper is
>> builtin, hence add--helper --help would be intercepted by
>> handle_builtin and re-routed to the help command, without ever
>> calling cmd_add__helper().
>>
>> Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
>> ---
>>   add-interactive.c     | 23 +++++++++++++++++++++++
>>   add-interactive.h     |  4 +++-
>>   builtin/add--helper.c |  7 ++++++-
>>   3 files changed, 32 insertions(+), 2 deletions(-)
>>
>> diff --git a/add-interactive.c b/add-interactive.c
>> index c55d934186..76c3f4c3eb 100644
>> --- a/add-interactive.c
>> +++ b/add-interactive.c
>> @@ -244,3 +244,26 @@ void add_i_print_modified(void)
>>   	free(files);
>>   	hashmap_free(&s.file_map, 1);
>>   }
>> +
>> +void add_i_show_help(void)
>> +{
>> +	const char *help_color = get_color(COLOR_HELP);
>> +	color_fprintf(stdout, help_color, "%s%s", _("status"),
>> +		N_("        - show paths with changes"));
>> +	printf("\n");
> There seems to be a bit of confusion with the translation of these
> messages. "status" does not want to be translated so it shouldn't be in
> _() - it can just go in the format string as can the indentation and the
> "\n" (or we could use color_fprintf_ln() to automatically add a newline
> at the end. N_() is used to mark static strings for translation so the
> gettext utilities pick up the text to be translated but (because
> initializes for static variables must be compile-time constants) does
> not do anything when the program runs - if you have 'const char *s =
> N_(hello);' you have to do '_(s)' to get the translated version. Here we
> can just pass the untranslated string directly to gettext so it should
> be _("show paths with changes"). Putting all that together we get
>
> 	color_fprintf(stdout, help_color, "status        - %s\n",
> 			_("show paths with changes");


I thought _() was for strings that were already translated,

and N_() for strings that weren't. And I now see that I also tried to 
translate command

names as well, just the opposite of what you suggested... Thanks for 
clarifying this.


>
>
> Best Wishes
>
> Phillip
>
>> +	color_fprintf(stdout, help_color, "%s%s", _("update"),
>> +		N_("        - add working tree state to the staged set of changes"));
>> +	printf("\n");	
>> +	color_fprintf(stdout, help_color, "%s%s", _("revert"),
>> +		N_("        - revert staged set of changes back to the HEAD version"));
>> +	printf("\n");
>> +	color_fprintf(stdout, help_color, "%s%s", _("patch"),
>> +		N_("         - pick hunks and update selectively"));
>> +	printf("\n");
>> +	color_fprintf(stdout, help_color, "%s%s", _("diff"),
>> +		N_("          - view diff between HEAD and index"));
>> +	printf("\n");
>> +	color_fprintf(stdout, help_color, "%s%s", _("add untracked"),
>> +		N_(" - add contents of untracked files to the staged set of changes"));
>> +	printf("\n");
>> +}
>> diff --git a/add-interactive.h b/add-interactive.h
>> index 1f4747553c..46e17c5c71 100644
>> --- a/add-interactive.h
>> +++ b/add-interactive.h
>> @@ -5,4 +5,6 @@ int add_i_config(const char *var, const char *value, void *cbdata);
>>   
>>   void add_i_print_modified(void);
>>   
>> -#endif
>> \ No newline at end of file
>> +void add_i_show_help(void);
>> +
>> +#endif
>> diff --git a/builtin/add--helper.c b/builtin/add--helper.c
>> index 43545d9af5..a3b3a68b68 100644
>> --- a/builtin/add--helper.c
>> +++ b/builtin/add--helper.c
>> @@ -10,7 +10,8 @@ static const char * const builtin_add_helper_usage[] = {
>>   
>>   enum cmd_mode {
>>   	DEFAULT = 0,
>> -	STATUS
>> +	STATUS,
>> +	HELP
>>   };
>>   
>>   int cmd_add__helper(int argc, const char **argv, const char *prefix)
>> @@ -20,6 +21,8 @@ int cmd_add__helper(int argc, const char **argv, const char *prefix)
>>   	struct option options[] = {
>>   		OPT_CMDMODE(0, "status", &mode,
>>   			 N_("print status information with diffstat"), STATUS),
>> +		OPT_CMDMODE(0, "show-help", &mode,
>> +			 N_("show help"), HELP),
>>   		OPT_END()
>>   	};
>>   
>> @@ -30,6 +33,8 @@ int cmd_add__helper(int argc, const char **argv, const char *prefix)
>>   
>>   	if (mode == STATUS)
>>   		add_i_print_modified();
>> +	else if (mode == HELP)
>> +		add_i_show_help();
>>   	else
>>   		usage_with_options(builtin_add_helper_usage,
>>   				   options);
>>
