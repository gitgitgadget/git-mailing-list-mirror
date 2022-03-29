Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5036C433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 16:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239665AbiC2QhC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 12:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbiC2QhA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 12:37:00 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C969B2F9
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 09:35:16 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 15950118BB8;
        Tue, 29 Mar 2022 12:35:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GC+8FPFAQfkbpmjcscJDBAyt5Reu6Yir9vjsv9
        LtF5E=; b=GI4L3afSdEcGDY8OwJ4dGiaIZPDuZhQlB2YN+B3dztZz9HiLIHPC72
        FjAhF8OgC9ksSDe4LPzcFno7QHkKN0xnR6XS+ecMV37P/RgtCSC8fiy/swh5GPI+
        y0Xqx2XlwUXDpZYH++sc9V33o+RhPs7XAVl9bkW3NV9oTOm05IQMg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0CE37118BB7;
        Tue, 29 Mar 2022 12:35:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5C603118BAD;
        Tue, 29 Mar 2022 12:35:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Fernando Ramos <greenfoo@u92.eu>, git@vger.kernel.org,
        davvid@gmail.com, sunshine@sunshineco.com, seth@eseth.com,
        rogi@skylittlesystem.org, bagasdotme@gmail.com
Subject: Re: [PATCH v7 3/4] vimdiff: add tool documentation
References: <20220328223019.271270-1-greenfoo@u92.eu>
        <20220328223019.271270-4-greenfoo@u92.eu>
        <1bc25dd7-fca6-eab9-c850-3dc2b2dc9e8c@gmail.com>
Date:   Tue, 29 Mar 2022 09:35:12 -0700
In-Reply-To: <1bc25dd7-fca6-eab9-c850-3dc2b2dc9e8c@gmail.com> (Philippe
        Blain's message of "Tue, 29 Mar 2022 10:07:34 -0400")
Message-ID: <xmqqmth8wwcf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3524ED88-AF7E-11EC-BCBF-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

>> Running 'git {merge,diff}tool --tool-help' now also prints usage
>> information about the vimdiff tool (and its variantes) instead of just
>> its name.
>> 
>> Two new functions ('diff_cmd_help()' and 'merge_cmd_help()') have been
>> added to the set of functions that each merge tool (ie. scripts found
>> inside "mergetools/") can overwrite to provided tool specific
>> information.
>> 
>> Right now, only 'mergetools/vimdiff' implements these functions, but
>> other tools are encouraged to do so in the future, specially if they
>> take configuration options not explained anywhere else (as it is the
>> case with the 'vimdiff' tool and the new 'layout' option)
>> 
>> In addition, a section has been added to
>> "Documentation/git-mergetool.txt" to explain the new "layout"
>> configuration option with examples.
>> 
>> Signed-off-by: Fernando Ramos <greenfoo@u92.eu>
>> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
>
> Thanks :) I think the project convention is to also use the 
> 'Co-authored-by' trailer as well :) 

If co-authors closely worked together (possibly but not necessarily
outside the public view), exchanging drafts and agreeing on the
final version before sending it to the list, by one approving the
other's final draft, Co-authored-by may be appropriate.

I am not sure if that is what happened.

I would prefer to see more use of Helped-by when suggestions for
improvements were made, possibly but not necessarily in a concrete
"squashable patch" form, the original author accepted before sending
the new version out, and the party who made suggestions saw the
updated version at the same time as the general public.

In addition, especially if it was not co-authored, the chain of
sign-off should mirror how the patches flowed.  If philippe helped
to improve Fernando's original idea, and Fernando assembled this
version before sending it out to the list, then 

    Helped-by: Philippe
    Signed-off-by: Philippe
    Signed-off-by: Fernando

Philippe's sign-off would help when his contribution is so big that
it by itself makes a copyrightable work, which may be the case.  If
not (e.g. when pointing out trivial typo or grammo), it is simpler
to omit it.

If this were truly co-authored, then replace "Helped-by" in the
above sequence with "Co-authored-by".

>> +mergetool.vimdiff.layout::
>> +	The vimdiff backend uses this variable to control how its split
>> +	windows look like. Applies even if you are using Neovim (`nvim`) or
>> +	gVim (`gvim`) as the merge tool. See BACKEND SPECIFIC HINTS section
>> +ifndef::git-mergetool[]
>> +	(on linkgit:git-mergetool[1])
>
> small nit: "in linkgit:git-mergetool[1]" would read slightly better I think,
> but that may be just me... and I think I would drop the parentheses.

I agree on both counts.

>>  				shown_any=yes
>> -				printf "%s%s\n" "$per_line_prefix" "$toolname"
>> +				printf "%s%-15s  %s\n" "$per_line_prefix" "$toolname" $(diff_mode && diff_cmd_help "$toolname" || merge_cmd_help "$toolname")
>>  			fi
>
> I tried this and it looks much better on a single line, nice!

You mean that the output on a single line is better than multiple lines?

> I also noticed that the list of available tools is embedded in 'git help config'
> (see the rule for "mergetools-list.made" in Documentation/Makefile). I looked 
> at the generated 'git-config.html' and it is not ideal; it would be better if 
> the tool names would be enclosed in backticks. I tried the following tweak:
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index ed656db2ae..a2201680a2 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -333,10 +333,10 @@ mergetools-list.made: ../git-mergetool--lib.sh $(wildcard ../mergetools/*)
>  	$(QUIET_GEN) \
>  	$(SHELL_PATH) -c 'MERGE_TOOLS_DIR=../mergetools && \
>  		. ../git-mergetool--lib.sh && \
> -		show_tool_names can_diff "* " || :' >mergetools-diff.txt && \
> +		show_tool_names can_diff "* " || :' | sed -e "s/* \([a-z0-9]*\)/* \`\1\`:/" >mergetools-diff.txt && \

If you are piping the output into a sed command, then you discard
the exit status of the upstream of the pipe, so " || :" at the end
of the shell command can be discarded, no?

>  	$(SHELL_PATH) -c 'MERGE_TOOLS_DIR=../mergetools && \
>  		. ../git-mergetool--lib.sh && \
> -		show_tool_names can_merge "* " || :' >mergetools-merge.txt && \
> +		show_tool_names can_merge "* " || :' | sed -e "s/* \([a-z0-9]*\)/* \`\1\`:/" >mergetools-merge.txt && \
>  	date >$@

Ditto.

In any case, the raw output from the command are of the form

    * <name of the tool> <explanation>

Is the idea that you want to enclose the <name of the tool> part
inside `literal`?

I do not know if the inclusion of <explanation> part in the output
is sensible in the first place (without this series, we only showed
the possible values, right), but if we wanted to do this, shouldn't
we be doing, instead of doing

    * araxis	Use Araxis Merge

more like

    araxis;;
		Use Araxis

I wonder.  The logical structure of each line is unclear with the
current output (the asterisk is meaningful in that it tells that the
line is an item in a bulleted list, but among the words on the rest
of the line, the first line is special only by convention, so in a
manpage for example, it looks like a gramatically correct sentence
"Use Araxis Merge" is somehow prefixed by a stray word that does not
begin with uppercase).

