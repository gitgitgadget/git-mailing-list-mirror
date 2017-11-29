Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 484FE20954
	for <e@80x24.org>; Wed, 29 Nov 2017 02:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752348AbdK2CKu (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 21:10:50 -0500
Received: from mail-it0-f54.google.com ([209.85.214.54]:38191 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751867AbdK2CKt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 21:10:49 -0500
Received: by mail-it0-f54.google.com with SMTP id r6so2268376itr.3
        for <git@vger.kernel.org>; Tue, 28 Nov 2017 18:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/JXe1Z6eLE1tV/f7RHJtOHQragUuQ0HJqrLxETgO9mU=;
        b=Bw6PR8Hww/7Lg0Xza4m0stORMIZ3bLuBHxzkdI984wXVdSTB5WX5NPUXzDrlXKtLB9
         +g/2wpFWr2bMJCgAfl6kooX1OH2xsgSMb7QzEx5BvbZ2axb3Y+6FzgvgItXAgk2/06RO
         MZOcq6qqHPrq4oXWR8c+fpmnsBzU0yFCZFP8IAlIwEdb4ru4J/DW1rDYaNmv58N29DI3
         jOLEtdCMzx8gi7yrrIV3TaLXl2/mBQmSNAvJ2c2pQtZdtLdEBycFiuu6rHsHrBipLrgf
         /8K8glEUsImW7fypCctMSPLCpxk8M7A1EU5k7PPnNBLrCZmE4hHscM4awzn1hXceKBKY
         w8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/JXe1Z6eLE1tV/f7RHJtOHQragUuQ0HJqrLxETgO9mU=;
        b=kQbxTVQKx1Ol/nRBNScILstyNK8d+aSsO/+el3uU5OXMgx1+0DX2xap94hlW3rdjAx
         HOHhwtqMU/5/12SDjDEVWsnly6Wb0SUGYYyqcDNjoTENJ/acVvnvL+fyPU1vNLDAxbUd
         NcYvztBDmlj2zTSLRYHWpZc8d7CiFkXW3NTXr6OoixsxLcQwl9ig2Ir9SeHJdblIOfux
         ZXgyL7NhwPHivOqzfScszTCQx3/Ssqyv6cteUW2OwkLJCUeduNfnKyBtlEvv0nSdu7Mv
         G37GNO2KDB/Qu8+liZBm5cyiXYFxfO/Me93fYgB6bVimDcYUL3pNWYDrDTgzYsiBuC8S
         u+tg==
X-Gm-Message-State: AJaThX5YYqiUwPi3tD0SnAz7O77XWvCYNjfomYpXpOfybfecCcLlOD4P
        lc5/JPGm9uY2LWhaAr+4brM=
X-Google-Smtp-Source: AGs4zMb35E96pObo/elb/aQSiCqtlMsD/gVwzt0mMKORo749mtYBz56Blch9omkIWgSWrwtsxNcSIQ==
X-Received: by 10.36.158.135 with SMTP id p129mr5064995itd.64.1511921448797;
        Tue, 28 Nov 2017 18:10:48 -0800 (PST)
Received: from [192.168.3.104] (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id u127sm290694ioe.28.2017.11.28.18.10.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Nov 2017 18:10:48 -0800 (PST)
From:   liam Beguin <liambeguin@gmail.com>
Subject: Re: [PATCH 4/5] rebase -i: learn to abbreviate command names
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
References: <20171127045514.25647-1-liambeguin@gmail.com>
 <20171127045514.25647-5-liambeguin@gmail.com>
 <alpine.DEB.2.21.1.1711272344290.6482@virtualbox>
Message-ID: <b4331bb3-db5d-e4f5-54db-f04d77385ae7@gmail.com>
Date:   Tue, 28 Nov 2017 21:10:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1711272344290.6482@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On 27/11/17 06:04 PM, Johannes Schindelin wrote:
> Hi Liam,
> 
> On Sun, 26 Nov 2017, Liam Beguin wrote:
> 
>> diff --git a/Documentation/rebase-config.txt b/Documentation/rebase-config.txt
>> index 30ae08cb5a4b..0820b60f6e12 100644
>> --- a/Documentation/rebase-config.txt
>> +++ b/Documentation/rebase-config.txt
>> @@ -30,3 +30,22 @@ rebase.instructionFormat::
>>  	A format string, as specified in linkgit:git-log[1], to be used for the
>>  	todo list during an interactive rebase.  The format will
>>  	automatically have the long commit hash prepended to the format.
>> +
>> +rebase.abbreviateCommands::
>> +	If set to true, `git rebase` will use abbreviated command names in the
>> +	todo list resulting in something like this:
>> +
>> +-------------------------------------------
>> +	p deadbee The oneline of the commit
>> +	p fa1afe1 The oneline of the next commit
>> +	...
>> +-------------------------------------------
> 
> I *think* that AsciiDoc will render this in a different way from what we
> want, but I am not an AsciiDoc expert. In my hands, I always had to add a
> single + in an otherwise empty line to start a new indented paragraph *and
> then continue with non-indented lines*.
> 
>> diff --git a/sequencer.c b/sequencer.c
>> index 810b7850748e..aa01e8bd9280 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -795,6 +795,13 @@ static const char *command_to_string(const enum todo_command command)
>>  	die("Unknown command: %d", command);
>>  }
>>  
>> +static const char command_to_char(const enum todo_command command)
>> +{
>> +	if (command < TODO_COMMENT && todo_command_info[command].c)
>> +		return todo_command_info[command].c;
>> +	return -1;
> 
> My initial reaction was: should we return comment_line_char instead of -1
> here? Only after reading how this is called did I realize that the idea is
> to use full command names if there is no abbreviation. Not sure whether
> this is worth a code comment. What do you think?
> 

I guess it probably deserves a comment!

>> +}
>> +
>>  static int is_noop(const enum todo_command command)
>>  {
>>  	return TODO_NOOP <= command;
>> @@ -1242,15 +1249,16 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
>>  		return 0;
>>  	}
>>  
>> -	for (i = 0; i < TODO_COMMENT; i++)
>> +	for (i = 0; i < TODO_COMMENT; i++) {
>>  		if (skip_prefix(bol, todo_command_info[i].str, &bol)) {
>>  			item->command = i;
>>  			break;
>> -		} else if (bol[1] == ' ' && *bol == todo_command_info[i].c) {
>> +		} else if (bol[1] == ' ' && *bol == command_to_char(i)) {
>>  			bol++;
>>  			item->command = i;
>>  			break;
>>  		}
>> +	}
>>  	if (i >= TODO_COMMENT)
>>  		return -1;
>>  
> 
> I would prefer this hunk to be skipped, it does not really do anything if
> I understand correctly.

Ok, I was not so sure about this but thought it was probably worth it.
Will remove.

> 
>> @@ -2443,8 +2451,8 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
>>  	strbuf_release(&sob);
>>  }
>>  
>> -int sequencer_make_script(int keep_empty, FILE *out,
>> -		int argc, const char **argv)
>> +int sequencer_make_script(int keep_empty, int abbreviate_commands, FILE *out,
>> +			  int argc, const char **argv)
>>  {
>>  	char *format = NULL;
>>  	struct pretty_print_context pp = {0};
>> @@ -2483,7 +2491,9 @@ int sequencer_make_script(int keep_empty, FILE *out,
>>  		strbuf_reset(&buf);
>>  		if (!keep_empty && is_original_commit_empty(commit))
>>  			strbuf_addf(&buf, "%c ", comment_line_char);
>> -		strbuf_addf(&buf, "pick %s ", oid_to_hex(&commit->object.oid));
>> +		strbuf_addf(&buf, "%s %s ",
>> +			    abbreviate_commands ? "p" : "pick",
>> +			    oid_to_hex(&commit->object.oid));
> 
> I guess the compiler will optimize this code so that the conditional is
> evaluated only once. Not that this is performance critical ;-)

Is your guess enough? :-) If not, how could I make sure this is optimized?
Should I do that check before the while() loop?

> 
>>  		pretty_print_commit(&pp, commit, &buf);
>>  		strbuf_addch(&buf, '\n');
>>  		fputs(buf.buf, out);
>> @@ -2539,7 +2549,7 @@ int add_exec_commands(const char *command)
>>  	return 0;
>>  }
>>  
>> -int transform_todo_ids(int shorten_ids)
>> +int transform_todo_ids(int shorten_ids, int abbreviate_commands)
>>  {
>>  	const char *todo_file = rebase_path_todo();
>>  	struct todo_list todo_list = TODO_LIST_INIT;
>> @@ -2575,19 +2585,33 @@ int transform_todo_ids(int shorten_ids)
>>  			todo_list.items[i + 1].offset_in_buf :
>>  			todo_list.buf.len;
>>  
>> -		if (item->command >= TODO_EXEC && item->command != TODO_DROP)
>> -			fwrite(p, eol - bol, 1, out);
>> -		else {
>> +		if (item->command >= TODO_EXEC && item->command != TODO_DROP) {
>> +			if (!abbreviate_commands || command_to_char(item->command) < 0) {
>> +				fwrite(p, eol - bol, 1, out);
>> +			} else {
>> +				const char *end_of_line = strchrnul(p, '\n');
>> +				p += strspn(p, " \t"); /* skip whitespace */
>> +				p += strcspn(p, " \t"); /* skip command */
>> +				fprintf(out, "%c%.*s\n",
>> +					command_to_char(item->command),
>> +					(int)(end_of_line - p), p);
>> +			}
>> +		} else {
>>  			const char *id = shorten_ids ?
>>  				short_commit_name(item->commit) :
>>  				oid_to_hex(&item->commit->object.oid);
>> -			int len;
>>  
>> -			p += strspn(p, " \t"); /* left-trim command */
>> -			len = strcspn(p, " \t"); /* length of command */
>> -
>> -			fprintf(out, "%.*s %s %.*s\n",
>> -				len, p, id, item->arg_len, item->arg);
>> +			if (abbreviate_commands) {
>> +				fprintf(out, "%c %s %.*s\n",
>> +					command_to_char(item->command),
>> +					id, item->arg_len, item->arg);
>> +			} else {
>> +				int len;
>> +				p += strspn(p, " \t"); /* left-trim command */
>> +				len = strcspn(p, " \t"); /* length of command */
>> +				fprintf(out, "%.*s %s %.*s\n",
>> +					len, p, id, item->arg_len, item->arg);
>> +			}
> 
> This hunk changes indentation quite a bit, therefore it is a bit harder to
> read than necessary (and the resulting code, too, as it is more smooshed
> against the 80-column boundary on the right).
> 
> How about this instead:
> 
> -		if (item->command >= TODO_EXEC && item->command != TODO_DROP)
> +		if (abbreviate_commands && command_to_char(item->command)) {
> +			const char *id = shorten_ids ?
> +				short_commit_name(item->commit) :
> +				oid_to_hex(&item->commit->object.oid);
> +			fprintf(out, "%c %s %.*s\n",
> +				command_to_char(item->command),
> +				id, item->arg_len, item->arg);
> +		} else if (item->command >= TODO_EXEC &&
> +			 item->command != TODO_DROP)
> 
> i.e. test first for the short and sweet case that we want (and can)
> abbreviate the command, otherwise keep the code as before?

That looks quite better! I'll update.

> 
> Ciao,
> Dscho
> 

Thanks,
Liam
