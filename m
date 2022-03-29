Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620D9C433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 17:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240056AbiC2RKW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 13:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240049AbiC2RKS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 13:10:18 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634ECE1A
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 10:08:33 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id f3so14848192qvz.10
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 10:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HK30H6J9XLSBF3ismyLYGQGxAGN9L3dx0qIe5CbXjnU=;
        b=Sw4dU7xCFUnEV5b3YweVZZ+MEwKkEs5Q/Zee/XO2LSzESRguIdKG69rVvdIqFk2E1W
         r26VzRlYXrJ/pTK6ackqs2QDHnGqHnjoNu1GCFYuXm3YvorJ6WpUXzLRCDOwPIQIwj1b
         +jrFc8uJeHIOqU5WvoWvxdNU9UYTUVzTNAQ4TlbJBCsHBA271d42rcbqhAedIooyxYVt
         yZfQlQgb8nIz76bR8PgRUfaJgCJhBJ7aPgm98nEumvBygkvbOGZOLMllC1hvDUJXuOyH
         RqujKSbUBjvLZAYKlA/wFsniZdpkJIccSWS7XcMFciAL4O5/uZd9JpSaMrWEyGmJ1eqN
         q9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HK30H6J9XLSBF3ismyLYGQGxAGN9L3dx0qIe5CbXjnU=;
        b=zjjwa9ALBHpczTI9HOG2mdkAohYw3sv3bhTjH9X7lUzraZJ5T9Pjo6VFvLvFVrTnt4
         agY2G7QeWm6WE6eWTEgnMiteQJmvMbilQCK1bFQO7D22BKmO+pAd0QQW1CgQneE7J36A
         EsdCC2L9e7cPMzS8mP1pjsztPEOzYn/PNNXLsCB5YhGpBzkr/edAQL3MNvc4OIX3/ian
         NHvuSafU8KlTDfpIFVWIkM1rfRnX3u4rtQKHcJRUXSctAKL0VaCEVx2zUuFwnba2Jzje
         Nqwg6qVPfrAYSZ8Ptf48UceIGDURq/u/s0qEsuiFk1sxu99IZbd/aGAxtfbJzT63bHCU
         BgAg==
X-Gm-Message-State: AOAM530+4YaNgJp/Ra50MC4Xgx6MinTN2Er2s4SSN6mSmPbirMBIzqPl
        wOh9nQEd/WBO63y56wwi+Z0=
X-Google-Smtp-Source: ABdhPJxwYcalG75+/h4TgbmJSdS2Bdy2Ip2pcxozEHMZWXiiZyzTD9NZDYFi72hBjaCPU8Dl4ijg9A==
X-Received: by 2002:a05:6214:508a:b0:440:f89a:af4e with SMTP id kk10-20020a056214508a00b00440f89aaf4emr27570944qvb.110.1648573712289;
        Tue, 29 Mar 2022 10:08:32 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id u13-20020a05622a010d00b002e1d653c2e1sm15197232qtw.46.2022.03.29.10.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 10:08:31 -0700 (PDT)
Subject: Re: [PATCH v7 3/4] vimdiff: add tool documentation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Fernando Ramos <greenfoo@u92.eu>, git@vger.kernel.org,
        davvid@gmail.com, sunshine@sunshineco.com, seth@eseth.com,
        rogi@skylittlesystem.org, bagasdotme@gmail.com
References: <20220328223019.271270-1-greenfoo@u92.eu>
 <20220328223019.271270-4-greenfoo@u92.eu>
 <1bc25dd7-fca6-eab9-c850-3dc2b2dc9e8c@gmail.com> <xmqqmth8wwcf.fsf@gitster.g>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <d0a0d00b-5c1a-4a0c-a91c-b03403578f80@gmail.com>
Date:   Tue, 29 Mar 2022 13:08:30 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqmth8wwcf.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 2022-03-29 à 12:35, Junio C Hamano a écrit :
> Philippe Blain <levraiphilippeblain@gmail.com> writes:
> 
>>> Running 'git {merge,diff}tool --tool-help' now also prints usage
>>> information about the vimdiff tool (and its variantes) instead of just
>>> its name.
>>>
>>> Two new functions ('diff_cmd_help()' and 'merge_cmd_help()') have been
>>> added to the set of functions that each merge tool (ie. scripts found
>>> inside "mergetools/") can overwrite to provided tool specific
>>> information.
>>>
>>> Right now, only 'mergetools/vimdiff' implements these functions, but
>>> other tools are encouraged to do so in the future, specially if they
>>> take configuration options not explained anywhere else (as it is the
>>> case with the 'vimdiff' tool and the new 'layout' option)
>>>
>>> In addition, a section has been added to
>>> "Documentation/git-mergetool.txt" to explain the new "layout"
>>> configuration option with examples.
>>>
>>> Signed-off-by: Fernando Ramos <greenfoo@u92.eu>
>>> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
>>
>> Thanks :) I think the project convention is to also use the 
>> 'Co-authored-by' trailer as well :) 
> 
> If co-authors closely worked together (possibly but not necessarily
> outside the public view), exchanging drafts and agreeing on the
> final version before sending it to the list, by one approving the
> other's final draft, Co-authored-by may be appropriate.
> 
> I am not sure if that is what happened.
> 
> I would prefer to see more use of Helped-by when suggestions for
> improvements were made, possibly but not necessarily in a concrete
> "squashable patch" form, the original author accepted before sending
> the new version out, and the party who made suggestions saw the
> updated version at the same time as the general public.
> 
> In addition, especially if it was not co-authored, the chain of
> sign-off should mirror how the patches flowed.  If philippe helped
> to improve Fernando's original idea, and Fernando assembled this
> version before sending it out to the list, then 
> 
>     Helped-by: Philippe
>     Signed-off-by: Philippe
>     Signed-off-by: Fernando
> 
> Philippe's sign-off would help when his contribution is so big that
> it by itself makes a copyrightable work, which may be the case.  If
> not (e.g. when pointing out trivial typo or grammo), it is simpler
> to omit it.
> 
> If this were truly co-authored, then replace "Helped-by" in the
> above sequence with "Co-authored-by".

Thanks for clarifying all that (whatever happened to the "Mailing
list etiquette series [1]... it would be nice to revive this:).

I did not mean to "claim" co-authorship by the way, I agree that 
"Helped-by" is more appropriate in this case. I included my sign-off
mostly by accident as my 'ci' Git alias in this project is 'commit --sign-off' ;)

> 
>>> +mergetool.vimdiff.layout::
>>> +	The vimdiff backend uses this variable to control how its split
>>> +	windows look like. Applies even if you are using Neovim (`nvim`) or
>>> +	gVim (`gvim`) as the merge tool. See BACKEND SPECIFIC HINTS section
>>> +ifndef::git-mergetool[]
>>> +	(on linkgit:git-mergetool[1])
>>
>> small nit: "in linkgit:git-mergetool[1]" would read slightly better I think,
>> but that may be just me... and I think I would drop the parentheses.
> 
> I agree on both counts.
> 
>>>  				shown_any=yes
>>> -				printf "%s%s\n" "$per_line_prefix" "$toolname"
>>> +				printf "%s%-15s  %s\n" "$per_line_prefix" "$toolname" $(diff_mode && diff_cmd_help "$toolname" || merge_cmd_help "$toolname")
>>>  			fi
>>
>> I tried this and it looks much better on a single line, nice!
> 
> You mean that the output on a single line is better than multiple lines?

Yes.

> 
>> I also noticed that the list of available tools is embedded in 'git help config'
>> (see the rule for "mergetools-list.made" in Documentation/Makefile). I looked 
>> at the generated 'git-config.html' and it is not ideal; it would be better if 
>> the tool names would be enclosed in backticks. I tried the following tweak:
>>
>> diff --git a/Documentation/Makefile b/Documentation/Makefile
>> index ed656db2ae..a2201680a2 100644
>> --- a/Documentation/Makefile
>> +++ b/Documentation/Makefile
>> @@ -333,10 +333,10 @@ mergetools-list.made: ../git-mergetool--lib.sh $(wildcard ../mergetools/*)
>>  	$(QUIET_GEN) \
>>  	$(SHELL_PATH) -c 'MERGE_TOOLS_DIR=../mergetools && \
>>  		. ../git-mergetool--lib.sh && \
>> -		show_tool_names can_diff "* " || :' >mergetools-diff.txt && \
>> +		show_tool_names can_diff "* " || :' | sed -e "s/* \([a-z0-9]*\)/* \`\1\`:/" >mergetools-diff.txt && \
> 
> If you are piping the output into a sed command, then you discard
> the exit status of the upstream of the pipe, so " || :" at the end
> of the shell command can be discarded, no?

Yes, you are right.

> 
>>  	$(SHELL_PATH) -c 'MERGE_TOOLS_DIR=../mergetools && \
>>  		. ../git-mergetool--lib.sh && \
>> -		show_tool_names can_merge "* " || :' >mergetools-merge.txt && \
>> +		show_tool_names can_merge "* " || :' | sed -e "s/* \([a-z0-9]*\)/* \`\1\`:/" >mergetools-merge.txt && \
>>  	date >$@
> 
> Ditto.
> 
> In any case, the raw output from the command are of the form
> 
>     * <name of the tool> <explanation>
> 
> Is the idea that you want to enclose the <name of the tool> part
> inside `literal`?

Yes, exactly, and add ': ' after the name of the tool. This makes the
HTML doc for 'git-config' more nicely formatted.

> 
> I do not know if the inclusion of <explanation> part in the output
> is sensible in the first place (without this series, we only showed
> the possible values, right), 

Right. I think it is a very nice addition, as several mergetool "names"
are not the same as the program name or the executable name, so I think
it's nice for the user to spell out exactly which software we are refering
to :) 

> but if we wanted to do this, shouldn't
> we be doing, instead of doing
> 
>     * araxis	Use Araxis Merge
> 
> more like
> 
>     araxis;;
> 		Use Araxis
> 
> I wonder.  The logical structure of each line is unclear with the
> current output (the asterisk is meaningful in that it tells that the
> line is an item in a bulleted list, but among the words on the rest
> of the line, the first line is special only by convention, so in a
> manpage for example, it looks like a gramatically correct sentence
> "Use Araxis Merge" is somehow prefixed by a stray word that does not
> begin with uppercase).
> 

OK, I see you mean using an Asciidoc "description list" [2]. I agree 
with you that it would be more semantically correct. So, let's use this
instead:

diff --git a/Documentation/Makefile b/Documentation/Makefile
index ed656db2ae..de0b5fed42 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -333,10 +333,10 @@ mergetools-list.made: ../git-mergetool--lib.sh $(wildcard ../mergetools/*)
 	$(QUIET_GEN) \
 	$(SHELL_PATH) -c 'MERGE_TOOLS_DIR=../mergetools && \
 		. ../git-mergetool--lib.sh && \
-		show_tool_names can_diff "* " || :' >mergetools-diff.txt && \
+		show_tool_names can_diff' | sed -e "s/\([a-z0-9]*\)/\`\1\`;;/" >mergetools-diff.txt && \
 	$(SHELL_PATH) -c 'MERGE_TOOLS_DIR=../mergetools && \
 		. ../git-mergetool--lib.sh && \
-		show_tool_names can_merge "* " || :' >mergetools-merge.txt && \
+		show_tool_names can_merge' | sed -e "s/\([a-z0-9]*\)/\`\1\`;;/" >mergetools-merge.txt && \
 	date >$@
 
 TRACK_ASCIIDOCFLAGS = $(subst ','\'',$(ASCIIDOC_COMMON):$(ASCIIDOC_HTML):$(ASCIIDOC_DOCBOOK))

[1] https://lore.kernel.org/git/20210512233412.10737-1-dwh@linuxprogrammer.org/
[2] https://docs.asciidoctor.org/asciidoc/latest/lists/description/
