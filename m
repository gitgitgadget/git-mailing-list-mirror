Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30346203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 20:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610AbcGYUJV (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 16:09:21 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34444 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265AbcGYUJT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jul 2016 16:09:19 -0400
Received: by mail-wm0-f65.google.com with SMTP id q128so18265301wma.1
        for <git@vger.kernel.org>; Mon, 25 Jul 2016 13:09:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MX77n8s2QjYDUxQTQf8HC2gALx7kqAUhm6f69PRNJ2c=;
        b=xoCvYEWibuWgDMGHetfGtCvwzMs+BJlvAzqI2+ITyAJ4fNa46owFWU4hDV2S9yuYhj
         H9fO2nLuA4hy+LWVZK2tPOpPvnURAAkdnLTuoZx8NSkPBNU8jJEHJ1pijjeQZ/SRNzfx
         Htyev/F7T/vqkpNvNqQguoS8XrPmXqo3Io25JenRSj00crohx+iMVCdhwgabXVX/D1Hy
         yph0SqfKzEbq96R7Rqrs9KUX5ya3unXL1q7Pll+XKQLrp4GTg9/pQGCnMzNVU3+k2pKT
         IX+DIxvrdSGt1P+qH9c0DQI28P9AjVmGe1JkXkznPaM5hS+E5hJntY2wAOFsiCoCRlhC
         4KyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MX77n8s2QjYDUxQTQf8HC2gALx7kqAUhm6f69PRNJ2c=;
        b=RcYpf3qwEExw9DQMZ0hl15yy7na+xdFhMbHdE8HMxNqGzNpLDjNTTbX1Ffs09kJtnB
         9MViEyge8XZ8cBlT1WTzg38cUjqWqU/S+PVWhWFru/loTzOMSxEEpwz3lyXRhZz78XDA
         HT6LzQP1MNmbUfzYeA8PNQJcnhcSeQRtTlgv5bpEsAl0X1VoP1qMmlDpm7fYLoX/3IVX
         4jOjJrdg8PALyYzLVo5Rh2HGNpP0zmldL9uBvKEfEAazrSUvvmx+e8fIvCkABAaL/KJC
         C/SqsD2oBkcaHBl/QiXwdM5azabEdLFN8KfBUP5Rxs8Hmo0KNojRYRv27ozZoSf8sP72
         gDrw==
X-Gm-Message-State: ALyK8tKvRtibpysgHvLgfuiN+cyD5oT82RKfYGtK42vFR+xVyT3an/6OU7CYcrq2Rn4Qcw==
X-Received: by 10.28.17.9 with SMTP id 9mr43230485wmr.73.1469477357056;
        Mon, 25 Jul 2016 13:09:17 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB7A6F.dip0.t-ipconnect.de. [93.219.122.111])
        by smtp.gmail.com with ESMTPSA id 3sm29086246wms.1.2016.07.25.13.09.11
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Jul 2016 13:09:14 -0700 (PDT)
Content-Type: text/plain; charset=iso-8859-2
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v1 3/3] convert: add filter.<driver>.useProtocol option
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <579521A1.4070501@gmail.com>
Date:	Mon, 25 Jul 2016 22:09:10 +0200
Cc:	Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?iso-8859-2?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	mlbright@gmail.com
Content-Transfer-Encoding: 8BIT
Message-Id: <1EF550A7-F6D4-4BFE-A4A7-D375268215DE@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com> <20160722154900.19477-4-larsxschneider@gmail.com> <5792B622.5040306@gmail.com> <0FB8A921-3465-4081-A36D-D2F19A8ED63D@gmail.com> <579521A1.4070501@gmail.com>
To:	=?iso-8859-2?Q?Jakub_Nar=EAbski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


On 24 Jul 2016, at 22:14, Jakub Narêbski <jnareb@gmail.com> wrote:

> W dniu 2016-07-24 o 20:36, Lars Schneider pisze:
>> On 23 Jul 2016, at 02:11, Jakub Narêbski <jnareb@gmail.com> wrote:
>>> W dniu 2016-07-22 o 17:49, larsxschneider@gmail.com pisze:
>>>> From: Lars Schneider <larsxschneider@gmail.com>
>>> 
>>> Nb. this line is only needed if you want author name and/or date
>>> different from the email sender, or if you have sender line misconfigured
>>> (e.g. lacking the human readable name).
>> 
>> I use "git format-patch" to generate these emails:
>> 
>> git format-patch --cover-letter --subject-prefix="PATCH ..." -M $BASE -o $OUTPUT
>> 
>> How would I disable this line? (I already checked the man page to no avail).
> 
> If you are using `git send-email` or equivalent, I think it is
> stripped automatically if it is not needed (in you case it was,
> because Sender was lacking human readable name... at least I think
> it was because of what my email reader inserted as reply line).
> If you are using an ordinary email client, you need to remove it
> yourself, if needed.

Weird. I am sending the patches with this command:

git send-email mystuff/* --to=git@vger.kernel.org --cc=...

Maybe I need to try the "--suppress-from" switch?!


>> Plus, what does "Nb" stand for? :-)
> 
> Nb. (or N.b.) stands for "nota bene", which I meant do denote
> as a note on a certain side aspect; I'll switch to "note", or
> "BTW" / "by the way".

OK, thanks for the explanation :-)


>>>> Git's clean/smudge mechanism invokes an external filter process for every
>>>> single blob that is affected by a filter. If Git filters a lot of blobs
>>>> then the startup time of the external filter processes can become a
>>>> significant part of the overall Git execution time.
>>> 
>>> Do I understand it correctly (from the commit description) that with
>>> this new option you start one filter process for the whole life of
>>> the Git command (e.g. `git add .`), which may perform more than one
>>> cleanup, but do not create a daemon or daemon-like process which
>>> would live for several commands invocations?
>> 
>> Correct!
> 
> It would be nice to make it more obvious.

OK, I will try in v2.

> 
>>>> This patch adds the filter.<driver>.useProtocol option which, if enabled,
>>>> keeps the external filter process running and processes all blobs with
>>>> the following protocol over stdin/stdout.
>>> 
>>> I agree with Junio that the name "useProtocol" is bad, and not quite
>>> right. Perhaps "persistent" would be better? Also, what is the value
>>> of `filter.<driver>.useProtocol`: boolean? or a script name?
> 
> As you see I was not sure if `useProtocol` was boolean or a script name,
> which means that it should be stated more explicitly.  Of course this
> would end to not matter if the way new protocol is used were changed.
> 
>> I agree that the name is not ideal. "UseProtocol" as it is would be a boolean. 
>> I thought about "persistent" but this name wouldn't convey the scope of the 
>> persistency ("persistent for one Git operation" vs. "persistent for many Git 
>> operations"). What do you think about the protocol as int version idea
>> described in $gmane/300155 ?
> 
> You mean the `protocol` as a config variable name (fully name being
> `filter.<driver>.protocol`), being integer-valued, isn't it? Wouldn't
> `protocolVersion` be a more explicit?

Yes, but based on your other feedback I plan to use this variable differently
anyways.


>>> I also agree that we might wat to be able to keep clean and smudge
>>> filters separate, but be able to run a single program if they are
>>> both the same. I think there is a special case for filter unset,
>>> and/or filter being "cat" -- we would want to keep that.
>> 
>> Since 1a8630d there is a more efficient way to unset a filter ;-)
>> Can you think of other cases where the separation would be useful?
> 
> I can't think of any, but it doesn't mean that it does not exist.
> It also does not mean that you need to consider situation that may
> not happen. Covering one-way filters, like "indent" filter for `clean`,
> should be enough... they do work with your proposal, don't they?

This should work right now but it would be a bit inefficient (the filter
would just pass the data unchanged through the smudge command). I plan to
add a "capabilities" flag to the protocol. Then you can define only
the "clean" capability and nothing or the current filter mechanism 
would happen for smudge (I will make a test case to demonstrate that
behavior in v2).


>>> My proposal is to use `filter.<driver>.persistent` as an addition
>>> to 'clean' and 'smudge' variables, with the following possible
>>> values:
>>> 
>>> * none (the default)
>>> * clean
>>> * smudge
>>> * both
>> 
>> That could work. However, I am not convinced, yet, that separate
>> filters are an actual use case.
> 
> YAGNI (You Ain't Gonna Need It), right.

That will work in v2.


>>> I assume that either Git would have to start multiple filter
>>> commands for multi-threaded operation, or the protocol would have
>>> to be extended to make persistent filter fork itself.
>> 
>> I think it would be better to have Git start multiple filter commands
>> to keep the protocol as simple and error free as possible.
> 
> Right. Also, I am not sure if exec+fork would be much faster than
> fork+exec (where fork is n-way fork, and n is number of threads
> that Git command invoking filter is using).
> 
>>> BTW. what would happen in your original proposal if the user had
>>> *both* filter.<driver>.useProtocol and filter.<driver>.smudge
>>> (and/or filter.<driver>.clean) set?
>> 
>> That wouldn't be an issue as "useProtocol" is just a boolean that
>> tells Git how to talk to "filter.<driver>.smudge" and "filter.<driver>.clean".
>> I need to make this more clear in the documentation.
>> 
>> 
>>>> 1. Git starts the filter on first usage and expects a welcome message
>>>> with protocol version number:
>>>> 	Git <-- Filter: "git-filter-protocol\n"
>>>> 	Git <-- Filter: "version 1"
>>> 
>>> I was wondering how Git would know that filter executable was started,
>>> but then I realized it was once-per-command invocation, not a daemon.
>>> 
>>> I agree with Torsten that there should be a terminator after the
>>> version number.
>> 
>> I agree, too :)
> 
> Note that if we agree about switch to `protocol` / `protocolVersion`
> as a way to specify this protocol, it would probably need to be "protocol 2"
> (assuming that "protocol 1" is the original implementation, with one fork
> per affected file).

Agreed.


>>> Also, for future extendability this should be probably followed by
>>> possibly empty list of script capabilities, that is:
>>> 
>>> 	Git <-- Filter: "git-filter-protocol\n"
>>> 	Git <-- Filter: "version 1.1\n"
> 
> Note that "version 1.1" would not work with current implementation;
> it accepts only integer version numbers. Which might be a good idea,
> anyway.

Agreed.


>>> 	Git <-- Filter: "capabilities clean smudge\n"
>>> 
>>> Or we can add capabilities in later version...
>> 
>> That is an interesting idea. My initial thought was to make the capabilities
>> of a certain version fix. If we want to add new capabilities then we would 
>> bump the version. I wonder what others think about your suggestion!
> 
> Using capabilities (like git-upload-pack / git-receive-pack, that is
> smart Git transfer protocols do) is probably slightly more difficult on
> the Git side (assuming no capabilities negotiation), but also much more
> flexible than pure version numbers.
> 
> One possible idea for a capability is support for passing input
> and output of a filter via filesystem, like cleanToFile and smudgeFromFile
> proposal in 'jh/clean-smudge-annex' (in 'pu').
> 
> For example:
> 
> 	Git <-- Filter: "capabilities clean smudge cleanToFile smudgeFromFile\n"

Yes, I like that very much. As stated above, I will add that in v2.


>>> BTW. why not follow e.g. HTTP protocol example, and use
>>> 
>>> 	Git <-- Filter: "git-filter-protocol/1\n"
>> 
>> I think my proposal is a bit more explicit as it states "version". If
>> you feel strongly about it, I could be convinced otherwise.
> 
> No, I don't feel strongly about this. I think SSH also uses a separate
> "version"-like line.
> 
>>>> 2. Git sends the command (either "smudge" or "clean"), the filename, the
>>>> content size in bytes, and the content separated by a newline character:
>>>> 	Git --> Filter: "smudge\n"
>>> 
>>> Would it help (for some cases) to pass the name of filter that
>>> is being invoked?
>> 
>> Interesting thought! Can you imagine a case where this would be useful?
> 
> Actually... no, I don't think so. I don't think there is a situation
> where we might want to use the same filter commands for different filters
> and have it behave differently depending on the filter name.

OK


>>>> 	Git --> Filter: "testfile.dat\n"
>>> 
>>> Unfortunately, while sane filenames should not contain newlines[1],
>>> the unfortunate fact is that *filenames can include newlines*, and
>>> you need to be able to handle that[2].  Therefore you need either to
>>> choose a different separator (the only one that can be safely used
>>> is "\0", i.e. the NUL character - but it is not something easy to
>>> handle by shell scripts), or C-quote filenames as needed, or always
>>> C-quote filenames.  C-quoting at minimum should include quoting newline
>>> character, and the escape character itself.
>>> 
>>> BTW. is it the basename of a file, or a full pathname?
>>> 
>>> [1]: http://www.dwheeler.com/essays/fixing-unix-linux-filenames.html
>>> [2]: http://www.dwheeler.com/essays/filenames-in-shell.html
>> 
>> Thanks for this explanation. A bash version of the protocol is not
>> trivial (I tried it but ended up using Perl). Therefore I think "\0"
>> would be a good choice?
> 
> That, or use git convention of surrounding C-quoted filenames in
> double quotes (which means that if it begins with quote, it is C-quoted).
> 
> For example:
> 
>  $ git commit -m 'Initial commit'
>  [master (root-commit) 266dab0] Initial commit
>   2 files changed, 2 insertions(+)
>   create mode 100644 foo
>   create mode 100644 "foo \" \\ ,"
>  $ ls -1
>  foo " \ ,
>  foo
> 
> I'm not sure which solution would be easier for filter writers,
> NUL termination, or C-quoting.

Unless someone has a convincing argument for one solution or the other
I will go with the \0 termination as it seems easier.


>>>> 	Git --> Filter: "7\n"
>>> 
>>> That's the content size in bytes written as an ASCII number.
>> 
>> Correct.
> 
> But not obvious from the description / documentation.

I will improve that in v2. Should I add the info that it is base10 or
would you consider that a given?


>>>> 	Git --> Filter: "CONTENT"
>>> 
>>> Can filter ignore the content size, and just read all what it was
>>> sent, that is until eof or something?
>> 
>> What would that something be? Since CONTENT is binary it can contain
>> any character (even "\0")...
> 
> Here by "or something" I meant some other way of detecting that there
> is nothing more to read. But providing the size upfront (or size of
> chunk / packet in the streaming interface, if/when it gets implemented)
> is probably a better idea. Git knows it anyway, cheaply.
> 
>>>> 3. The filter is expected to answer with the result content size in
>>>> bytes and the result content separated by a newline character:
>>>> 	Git <-- Filter: "15\n"
>>>> 	Git <-- Filter: "SMUDGED_CONTENT"
>>> 
>>> I wonder how hard would be to write filters for this protocol...
>> 
>> Easy :-) Plus you can look at a Perl (see t/t0021) and a golang implementation
>> already (https://github.com/github/git-lfs/pull/1382).
> 
> Right. Any programming language that has a way to specify "read N bytes"
> would work. I think even bash would work, with 'read -N $len -r'... I think.
> 
>>>> ---
>>>> Documentation/gitattributes.txt |  41 +++++++-
>>>> convert.c                       | 210 ++++++++++++++++++++++++++++++++++++++--
>>>> t/t0021-conversion.sh           | 170 ++++++++++++++++++++++++++++++++
>>> 
>>> Wouldn't it be better to name the test case something more
>>> descriptive, for example
>>> 
>>>  t/t0021-filter-driver-useProtocol.sh
>>> 
>>> The name of test should be adjusted to final name of the feature,
>>> of course.
>> 
>> I think the prefix numbers should be unique, no? And t0022 is already taken.
> 
> I meant here that the "conversion" part of "t/t0021-conversion.sh" test
> filename is not descriptive enough.

Ah, I see. You suggest to rename the test case? Would that be OK with the Git
community?


>>>> t/t0021/rot13.pl                |  80 +++++++++++++++
> 
> This is all right, because it is in t0021 context.
> 
>>>> 4 files changed, 494 insertions(+), 7 deletions(-)
>>>> create mode 100755 t/t0021/rot13.pl
>>>> 
>>>> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
>>>> index 8882a3e..7026d62 100644
>>>> --- a/Documentation/gitattributes.txt
>>>> +++ b/Documentation/gitattributes.txt
>>>> @@ -300,7 +300,10 @@ checkout, when the `smudge` command is specified, the command is
>>>> fed the blob object from its standard input, and its standard
>>>> output is used to update the worktree file.  Similarly, the
>>>> `clean` command is used to convert the contents of worktree file
>>>> -upon checkin.
>>>> +upon checkin. By default these commands process only a single
>>>> +blob and terminate. If the setting filter.<driver>.useProtocol is
>>>> +enabled then Git can process all blobs with a single filter command
>>>> +invocation (see filter protocol below).
>>> 
>>> This does not tell the precedence between `smudge`, `clean` and
>>> filter.<driver>.useProtocol, see above. Also, discrepancy in how
>>> config variables are referenced.
>> 
>> As mentioned above "useProtocol" is a boolean. Therefore precedence shouldn't
>> be a problem.
> 
> Which was not obvious (but might not matter in the end).
> 
>>             What do you mean by "discrepancy in how config variables are 
>> referenced"?
> 
> What I meant here that filter.<driver>.smudge and filter.<driver>.clean
> were referenced as "`smudge` command" and "`clean` command" in the paragraph
> you modified.
> 
> Perhaps filter.<driver>.useProtocol is all right (I have not looked further),
> but it should be formatted as `filter.<driver>.useProtocol` IMVHO.

Initially I thought so, too. But "filter.<driver>.required", which is already
mentioned in gitattributes.txt, does not use this style. Should I change that, too,
or use the existing style?


> [...]
>>>> diff --git a/convert.c b/convert.c
>>>> index 522e2c5..91ce86f 100644
>>>> --- a/convert.c
>>>> +++ b/convert.c
>>>> @@ -481,12 +481,188 @@ static int apply_filter(const char *path, const char *src, size_t len, int fd,
>>>> 	return ret;
>>>> }
>>>> 
>>>> +static int cmd_process_map_init = 0;
>>>> +static struct hashmap cmd_process_map;
>>>> +
>>>> +struct cmd2process {
>>>> +	struct hashmap_entry ent; /* must be the first member! */
>>>> +	const char *cmd;
>>>> +	long protocol;
>>>> +	struct child_process process;
>>>> +};
>>> [...]
>>>> +static struct cmd2process *find_protocol_filter_entry(const char *cmd)
>>>> +{
>>>> +	struct cmd2process k;
>>>> +	hashmap_entry_init(&k, strhash(cmd));
>>>> +	k.cmd = cmd;
>>>> +	return hashmap_get(&cmd_process_map, &k, NULL);
>>> 
>>> Should we use global variable cmd_process_map, or pass it as parameter?
>>> The same question apply for other procedures and functions.
>>> 
>>> Note that I am not saying that it is a bad thing to use global
>>> variable here.
>> 
>> Passing it would be nicer as this would make at least a few functions "pure".
>> I will change that!
> 
> You can always provide convenience functions that use global variable.
> That's what Git code does with the_index, if I remember it correctly.
> 
> [...]
>>>> +
>>>> +	sigchain_push(SIGPIPE, SIG_IGN);
>>>> +	ret &= strbuf_read_once(&nbuf, process->out, 0) > 0;
>>>> +	sigchain_pop(SIGPIPE);
>>>> +
>>>> +	strbuf_stripspace(&nbuf, 0);
>>>> +	string_list_split_in_place(&split, nbuf.buf, ' ', 2);
>>>> +	ret &= split.nr > 1;
>>>> +	ret &= strncmp(header, split.items[0].string, strlen(header)) == 0;
>>>> +	if (ret) {
>>>> +		entry->protocol = strtol(split.items[1].string, NULL, 10);
>>> 
>>> This does not handle at least some errors in version number parsing,
>>> for example junk after version number. Don't we have some helper
>>> functions for this?
>> 
>> I am not sure. I haven't found one.
> 
> Hmmm... I remember there were some patches about this, but I don't know
> if they were accepted.  We have strtol_i() in git-compat-util.h. 
> 
> And you can always check where the parsing ended (by not passing NULL,
> of course).

OK, try to make this nicer in v2.


> [...]
>>>> +		switch (entry->protocol) {
>>>> +			case 1:
>>>> +				break;
>>>> +			default:
>>>> +				ret = 0;
>>>> +				error("unsupported protocol version %s for external persistent filter '%s'",
>>>> +					nbuf.buf, cmd);
>>>> +		}
>>>> +	}
>>>> +	string_list_clear(&split, 0);
>>>> +	strbuf_release(&nbuf);
>>>> +
>>>> +	if (!ret) {
>>>> +		error("initialization for external persistent filter '%s' failed", cmd);
>>>> +		return NULL;
>>>> +	}
>>> 
>>> Do we handle persistent filter command being killed before it finishes?
>>> Or exiting with error? I don't know this Git API...
>> 
>> If the "apply_filter" function fails then Git would proceed and just not
>> filter the content. If you define the "required" flag for the filter then
>> Git would error in that case.
> 
> Ah, right. 
> 
> [...]
>>>> diff --git a/t/t0021/rot13.pl b/t/t0021/rot13.pl
>>> 
>>> That's bit more than rot13... but it might be O.K. for a filename here.
>> 
>> "rot13-$FEATURE_NAME.pl" ?
> 
> As I said, rot13.pl is all right; if change, then perhaps to rot13-filter.pl 

OK.


> [...]
>>>> +        my $input;
>>>> +        {
>>>> +            binmode(STDIN);
>>>> +            my $bytes_read = 0;
>>>> +            $bytes_read = read STDIN, $input, $filelen;
>>>> +            if ( $bytes_read != $filelen ) {
>>>> +                die "not enough to read";
>>> 
>>> I know it's only a test script (well, a part of one), but we would probably
>>> want to have more information in the case of a real filter.
>> 
>> True. Do you think there is anything to change in the script, though?
> 
> No, I don't think so. It is enough that the test script would crash
> if fed incorrect data from Git. Better error messages would be nice,
> but are not necessary.
> 
>    +                die "not enough to read: expected $filelen, got $bytes_read";
> 
> I have noticed that some 'die' have "\n" at the end, and some do
> not. If I remember correctly it is for supressing error message from
> Perl, with filename and line number, isn't it? Anyway, we probably
> want to be consistent.

OK.


>>>> +        }
>>>> +    }
>>> 
>>> What happens if $filelen is zero, or negative? Ah, I see that $output
>>> would be undef... which is bad, I think.
>> 
>> Is this something we need to consider in the test script?
> 
> I think the test script should die if it gets incorrect content length
> (e.g. negative), so that it catches bug on the Git side. It should
> work for zero-length files, even if we don't test it -- we can in the
> future.

OK.


> [...]
>>>> +            print STDOUT "fail";
>>> 
>>> This is not defined in the protocol description!  Unless anything that
>>> does not conform to the specification would work here, but at least it
>>> is a recommended practice to be described in the documentation, don't
>>> you think?
>>> 
>>> What would happen in $output_len is 4?
>> 
>> Then it would work :D
>> I understand your point. However, this is not a reference implementation.
>> It is a test script that is supposed to trigger bad behavior which we can test. 
>> Therefore, I would argue that such a return value is OK. I will document it in 
>> the header, though. 
> 
> Why print "fail", and not die?

Agree, "die" is better.


> The problem is do the protocol need to have some way of communicating
> errors from the filter to Git?  Perhaps using stderr would be enough
> (but then Git would need to drain it, I think... unless it is not
> redirected), perhaps some command is needed?
> 
> For example, instead of:
> 
> 	Git <-- Filter: "15\n"
> 	Git <-- Filter: "SMUDGED_CONTENT"
> 
> perhaps filter should return
> 
> 	Git <-- Filter: "error\n"
> 	Git <-- Filter: "ONE_LINE_OF_ERROR_DESCRIPTION\n"
> 
> on error? Or if printing expected output length upfront is easier,
> use a signal (but that is supposedly not that reliable as message
> passing mechanism)?
> 
> It might be the case that some files return errors, but some do not.

I would prefer it if the filter just dies in case of trouble and that
way communicates to Git that something went wrong. Everything else
just complicates the protocol.


> BTW. do we test the case where filter fails, or returns wrong output?

Yes, I added a failure test in v2.

Thanks a lot,
Lars