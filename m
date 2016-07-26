Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D30C4203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 14:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755929AbcGZOSW (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 10:18:22 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34244 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753920AbcGZOSR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 10:18:17 -0400
Received: by mail-wm0-f68.google.com with SMTP id q128so1914349wma.1
        for <git@vger.kernel.org>; Tue, 26 Jul 2016 07:18:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=W3KAJTr4MuOm++l2gZurqWF9O2YNyxhduZvee+F/bTg=;
        b=VAnaIf8MI7SKMwUtbJ990cV3gFQ+KjZs30ZSDkHKdeLurr76jS+pvBdawcGqVMg4Yl
         bJH1cgvUcVPNmOkyrnE4pxda+k4ym6Oa3u6HBg6EN31+A50OkVvyxqRfH33ZvfDi1AUU
         XzuDm/41VLqLlaUEejh+/gbVXGcRFPj2kK3FCUFdSvQQjovddUZF1lF9KR4WgAYaWg79
         jxS1Oo4bLa0J51+p2uZy9OKfgnIuwGGDBVAEhuur+QIxO/hd/wLopmrHYWqDGiL/vhVM
         FYstVENEBy2jiLbqyj8BoUwZTl7jgwNyX/4BIbPlSLLONtNIGvmln/o3VYM08DPLxMTE
         zKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=W3KAJTr4MuOm++l2gZurqWF9O2YNyxhduZvee+F/bTg=;
        b=kykEQRb7yemwhiz1nhzxsoJphZeengQfuF1430afJVr/jcioZrpfkk4RYuWMf7NQKk
         T06V7r8WwKB76RbMgcGU2mdz2HE4uGv4m4ZHuM4CG708kKEP15FYEfzVJPxW48flPJBF
         hiIdDYFc6LJ23CPEZGzt4GGTP2GcGoJyWVwxGT9gM4DWZuis7McqbQSqZiqqyW1IwBUb
         7xqAak8zv7mqNoJectbnY7NJCaSjzOZ6kw2fNSvNkHFXoJKP46nID4RS/GqMrzmDNu3H
         OYiDaMnLxqlbm7OYRpjJStpnUGKz5tXHKK+oqJvrHtWBTLAdUIuIyxK45iam8LWpPeeQ
         68Mg==
X-Gm-Message-State: ALyK8tJxEEz7aXS5ndNdEfTwYWPx6JGVrtIE0xjrn/nZTX5vJY4PQDYe/loodYr+eRnZDw==
X-Received: by 10.28.215.81 with SMTP id o78mr47906795wmg.42.1469542695003;
        Tue, 26 Jul 2016 07:18:15 -0700 (PDT)
Received: from [192.168.1.26] (afq129.neoplus.adsl.tpnet.pl. [83.25.146.129])
        by smtp.googlemail.com with ESMTPSA id u72sm33193847wmf.5.2016.07.26.07.18.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jul 2016 07:18:14 -0700 (PDT)
Subject: Re: [PATCH v1 3/3] convert: add filter.<driver>.useProtocol option
To:	Lars Schneider <larsxschneider@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com>
 <20160722154900.19477-4-larsxschneider@gmail.com>
 <5792B622.5040306@gmail.com> <0FB8A921-3465-4081-A36D-D2F19A8ED63D@gmail.com>
 <579521A1.4070501@gmail.com> <1EF550A7-F6D4-4BFE-A4A7-D375268215DE@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	mlbright@gmail.com
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <57977118.1020006@gmail.com>
Date:	Tue, 26 Jul 2016 16:18:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <1EF550A7-F6D4-4BFE-A4A7-D375268215DE@gmail.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-25 o 22:09, Lars Schneider pisze:
> On 24 Jul 2016, at 22:14, Jakub Narêbski <jnareb@gmail.com> wrote:
>> W dniu 2016-07-24 o 20:36, Lars Schneider pisze:
>>> On 23 Jul 2016, at 02:11, Jakub Narêbski <jnareb@gmail.com> wrote:
>>>> W dniu 2016-07-22 o 17:49, larsxschneider@gmail.com pisze:
>>>>> From: Lars Schneider <larsxschneider@gmail.com>
>>>>
>>>> Nb. this line is only needed if you want author name and/or date
>>>> different from the email sender, or if you have sender line misconfigured
>>>> (e.g. lacking the human readable name).
>>>
>>> I use "git format-patch" to generate these emails:
>>>
>>> git format-patch --cover-letter --subject-prefix="PATCH ..." -M $BASE -o $OUTPUT
>>>
>>> How would I disable this line? (I already checked the man page to no avail).
>>
>> If you are using `git send-email` or equivalent, I think it is
>> stripped automatically if it is not needed (in you case it was,
>> because Sender was lacking human readable name... at least I think
>> it was because of what my email reader inserted as reply line).
>> If you are using an ordinary email client, you need to remove it
>> yourself, if needed.
> 
> Weird. I am sending the patches with this command:
> 
> git send-email mystuff/* --to=git@vger.kernel.org --cc=...
> 
> Maybe I need to try the "--suppress-from" switch?!

No, the "From:" line is needed, but only because your Sender seems
to be lacking human-readable name (for some strange reason).

But let's stop this here.
 

[...]
>>>> I also agree that we might want to be able to keep clean and smudge
>>>> filters separate, but be able to run a single program if they are
>>>> both the same. I think there is a special case for filter unset,
>>>> and/or filter being "cat" -- we would want to keep that.
>>>
>>> Since 1a8630d there is a more efficient way to unset a filter ;-)
>>> Can you think of other cases where the separation would be useful?
>>
>> I can't think of any, but it doesn't mean that it does not exist.
>> It also does not mean that you need to consider situation that may
>> not happen. Covering one-way filters, like "indent" filter for `clean`,
>> should be enough... they do work with your proposal, don't they?
> 
> This should work right now but it would be a bit inefficient (the filter
> would just pass the data unchanged through the smudge command). I plan to
> add a "capabilities" flag to the protocol. Then you can define only
> the "clean" capability and nothing or the current filter mechanism 
> would happen for smudge (I will make a test case to demonstrate that
> behavior in v2).

Isn't no-op filter (value not set, value set to empty string, "cat")
caught earlier in a common code?  We would certainly want to keep
one-way filter configuration mechanism without many changes.

Also, this should be of course tested.
 
>>>> 	Git <-- Filter: "capabilities clean smudge\n"
>>>>
>>>> Or we can add capabilities in later version...
>>>
>>> That is an interesting idea. My initial thought was to make the capabilities
>>> of a certain version fix. If we want to add new capabilities then we would 
>>> bump the version. I wonder what others think about your suggestion!
>>
>> Using capabilities (like git-upload-pack / git-receive-pack, that is
>> smart Git transfer protocols do) is probably slightly more difficult on
>> the Git side (assuming no capabilities negotiation), but also much more
>> flexible than pure version numbers.
>>
>> One possible idea for a capability is support for passing input
>> and output of a filter via filesystem, like cleanToFile and smudgeFromFile
>> proposal in 'jh/clean-smudge-annex' (in 'pu').
>>
>> For example:
>>
>> 	Git <-- Filter: "capabilities clean smudge cleanToFile smudgeFromFile\n"
> 
> Yes, I like that very much. As stated above, I will add that in v2.

I guess that you would add the idea of capabilities (though this
could be left for v3), not support for "cleanToFile" / "smudgeFromFile"
capabilities, and accompanying extension to the protocol, isn't it?
 
 
>>>>> 	Git --> Filter: "testfile.dat\n"
>>>>
>>>> Unfortunately, while sane filenames should not contain newlines[1],
>>>> the unfortunate fact is that *filenames can include newlines*, and
>>>> you need to be able to handle that[2].  Therefore you need either to
>>>> choose a different separator (the only one that can be safely used
>>>> is "\0", i.e. the NUL character - but it is not something easy to
>>>> handle by shell scripts), or C-quote filenames as needed, or always
>>>> C-quote filenames.  C-quoting at minimum should include quoting newline
>>>> character, and the escape character itself.
>>>>
>>>> BTW. is it the basename of a file, or a full pathname?
>>>>
>>>> [1]: http://www.dwheeler.com/essays/fixing-unix-linux-filenames.html
>>>> [2]: http://www.dwheeler.com/essays/filenames-in-shell.html
>>>
>>> Thanks for this explanation. A bash version of the protocol is not
>>> trivial (I tried it but ended up using Perl). Therefore I think "\0"
>>> would be a good choice?
>>
>> That, or use git convention of surrounding C-quoted filenames in
>> double quotes (which means that if it begins with quote, it is C-quoted).
>>
>> For example:
>>
>>  $ git commit -m 'Initial commit'
>>  [master (root-commit) 266dab0] Initial commit
>>   2 files changed, 2 insertions(+)
>>   create mode 100644 foo
>>   create mode 100644 "foo \" \\ ,"
>>  $ ls -1
>>  foo " \ ,
>>  foo
>>
>> I'm not sure which solution would be easier for filter writers,
>> NUL termination, or C-quoting.
> 
> Unless someone has a convincing argument for one solution or the other
> I will go with the \0 termination as it seems easier.

Well, I think both C-quoting when necessary, and NUL-terminating
is easy from the Git side, but I guess that handling NUL-terminated
filenames is easier from scripts.
 
>>>>> 	Git --> Filter: "7\n"
>>>>
>>>> That's the content size in bytes written as an ASCII number.
>>>
>>> Correct.
>>
>> But not obvious from the description / documentation.
> 
> I will improve that in v2. Should I add the info that it is base10 or
> would you consider that a given?

No, this is obvious, and used thorough Git code / formats. 

>>>>> ---
>>>>> Documentation/gitattributes.txt |  41 +++++++-
>>>>> convert.c                       | 210 ++++++++++++++++++++++++++++++++++++++--
>>>>> t/t0021-conversion.sh           | 170 ++++++++++++++++++++++++++++++++
>>>>
>>>> Wouldn't it be better to name the test case something more
>>>> descriptive, for example
>>>>
>>>>  t/t0021-filter-driver-useProtocol.sh
>>>>
>>>> The name of test should be adjusted to final name of the feature,
>>>> of course.
>>>
>>> I think the prefix numbers should be unique, no? And t0022 is already taken.
>>
>> I meant here that the "conversion" part of "t/t0021-conversion.sh" test
>> filename is not descriptive enough.
> 
> Ah, I see. You suggest to rename the test case? Would that be OK with the Git
> community?

Ah, I'm sorry.  I was in mistaken assumption that it is a new test,
not an extension to an existing test case.  In this case the filename
change can come as a separate patch, anyway.
 
 
>>>             What do you mean by "discrepancy in how config variables are 
>>> referenced"?
>>
>> What I meant here that filter.<driver>.smudge and filter.<driver>.clean
>> were referenced as "`smudge` command" and "`clean` command" in the paragraph
>> you modified.
>>
>> Perhaps filter.<driver>.useProtocol is all right (I have not looked further),
>> but it should be formatted as `filter.<driver>.useProtocol` IMVHO.
> 
> Initially I thought so, too. But "filter.<driver>.required", which is already
> mentioned in gitattributes.txt, does not use this style. Should I change that, too,
> or use the existing style?

All right, if there is a precedent for using this style, it would
be all right.
 
 
>> The problem is do the protocol need to have some way of communicating
>> errors from the filter to Git?  Perhaps using stderr would be enough
>> (but then Git would need to drain it, I think... unless it is not
>> redirected), perhaps some command is needed?
>>
>> For example, instead of:
>>
>> 	Git <-- Filter: "15\n"
>> 	Git <-- Filter: "SMUDGED_CONTENT"
>>
>> perhaps filter should return
>>
>> 	Git <-- Filter: "error\n"
>> 	Git <-- Filter: "ONE_LINE_OF_ERROR_DESCRIPTION\n"
>>
>> on error? Or if printing expected output length upfront is easier,
>> use a signal (but that is supposedly not that reliable as message
>> passing mechanism)?
>>
>> It might be the case that some files return errors, but some do not.
> 
> I would prefer it if the filter just dies in case of trouble and that
> way communicates to Git that something went wrong. Everything else
> just complicates the protocol.

All right, this makes protocol simpler.  One thing we might want
to do is to ensure that stderr from the filter driver (where error
messages should be sent IMVHO, and which of course needs to be
documented) goes to the user, possibly with prefixing (like for
errors from the remote hooks).

Best,
-- 
Jakub Narêbski

