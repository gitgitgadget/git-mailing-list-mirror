Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E736C203E2
	for <e@80x24.org>; Sat, 23 Jul 2016 00:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbcGWAL0 (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 20:11:26 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35399 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbcGWALZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 20:11:25 -0400
Received: by mail-wm0-f66.google.com with SMTP id i5so8048961wmg.2
        for <git@vger.kernel.org>; Fri, 22 Jul 2016 17:11:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=3sh9ZcRciTASsVPAVXb3XhHtIPtPh3WcDhu1HiFnj8s=;
        b=R0UaOHw+l6Wby7ObJVtEG9BwQNoDZN+Scf+Nmt1BDiLjcnc+W9NKBp/gRDT3W5Ci/B
         4GE2wGaXD2sAxdJh3NkYx8VzNSldfBoAVuMgXI/qlK3Jm4ldBWb0gxg0z8KC+shIGOLe
         pnhvbzXEilWMBTNtOVehkd5F2HYGM7pP6mUrd1yMxC8Zwyp1/hx6exa7Dee0OHDV43gv
         hJitjcUeyrkR4pe24fT7YWlOL3quQ69/MAttAY3Akm4D75sr05m5YvTqUEci934zwGFo
         KqYJDHD0YSebCA3jCe64MgR9pB519srt+slYFJPT1RV00IufOp2wcRFRgfVEPFCCJQfQ
         +dKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=3sh9ZcRciTASsVPAVXb3XhHtIPtPh3WcDhu1HiFnj8s=;
        b=N1Iac7cCQbQGxmK6M2wtmCoI+qbNlZdTD9MTwFkA+rMKO+a3+VXt1CAPrKfK3YqzPK
         TOcSAl897mwZDk+BK3/eJZ8x4TUgRkTBNr0vB4dmgT+DW8Pd+yeXGFx4HMVmuqY7/7u/
         LGbj/mBBQGwFG7kXHMQl7D+6ldFHgK0qLON67VBuPXuPjIz0XCNvytTXKp9p9iVUxAEJ
         WKAy44Ub8jYfBBBhU8A6mA5GgRvUC0uKlyrNEZ3/R1410YtU1UiWBhffDw/1qUIFuo/E
         1mjRs4SI1AQFYl75chEd6tLFiZQXf2pt5BWiqw7g934RwGOnQ3UnsCVGwQE/tUXxYpGh
         Yf6A==
X-Gm-Message-State: AEkoouvoSWnDe7LL+QpBSSYPq1q0BVExHyo+TB4oh3VLygRNQY+VXpQvtU2mMp1wa2VAyQ==
X-Received: by 10.194.77.174 with SMTP id t14mr3711647wjw.146.1469232683497;
        Fri, 22 Jul 2016 17:11:23 -0700 (PDT)
Received: from [192.168.1.26] (afd102.neoplus.adsl.tpnet.pl. [83.25.133.102])
        by smtp.googlemail.com with ESMTPSA id a21sm14860208wma.10.2016.07.22.17.11.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jul 2016 17:11:22 -0700 (PDT)
Subject: Re: [PATCH v1 3/3] convert: add filter.<driver>.useProtocol option
To:	larsxschneider@gmail.com, git@vger.kernel.org
References: <20160722154900.19477-1-larsxschneider@gmail.com>
 <20160722154900.19477-4-larsxschneider@gmail.com>
Cc:	peff@peff.net, tboegi@web.de
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <5792B622.5040306@gmail.com>
Date:	Sat, 23 Jul 2016 02:11:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <20160722154900.19477-4-larsxschneider@gmail.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-22 o 17:49, larsxschneider@gmail.com pisze:
> From: Lars Schneider <larsxschneider@gmail.com>

Nb. this line is only needed if you want author name and/or date
different from the email sender, or if you have sender line misconfigured
(e.g. lacking the human readable name).

> 
> Git's clean/smudge mechanism invokes an external filter process for every
> single blob that is affected by a filter. If Git filters a lot of blobs
> then the startup time of the external filter processes can become a
> significant part of the overall Git execution time.

Do I understand it correctly (from the commit description) that with
this new option you start one filter process for the whole life of
the Git command (e.g. `git add .`), which may perform more than one
cleanup, but do not create a daemon or daemon-like process which
would live for several commands invocations?

> 
> This patch adds the filter.<driver>.useProtocol option which, if enabled,
> keeps the external filter process running and processes all blobs with
> the following protocol over stdin/stdout.

I agree with Junio that the name "useProtocol" is bad, and not quite
right. Perhaps "persistent" would be better? Also, what is the value
of `filter.<driver>.useProtocol`: boolean? or a script name?

I also agree that we might wat to be able to keep clean and smudge
filters separate, but be able to run a single program if they are
both the same. I think there is a special case for filter unset,
and/or filter being "cat" -- we would want to keep that.

My proposal is to use `filter.<driver>.persistent` as an addition
to 'clean' and 'smudge' variables, with the following possible
values:

  * none (the default)
  * clean
  * smudge
  * both

I assume that either Git would have to start multiple filter
commands for multi-threaded operation, or the protocol would have
to be extended to make persistent filter fork itself.


BTW. what would happen in your original proposal if the user had
*both* filter.<driver>.useProtocol and filter.<driver>.smudge
(and/or filter.<driver>.clean) set?

> 
> 1. Git starts the filter on first usage and expects a welcome message
> with protocol version number:
> 	Git <-- Filter: "git-filter-protocol\n"
> 	Git <-- Filter: "version 1"

I was wondering how Git would know that filter executable was started,
but then I realized it was once-per-command invocation, not a daemon.

I agree with Torsten that there should be a terminator after the
version number.

Also, for future extendability this should be probably followed by
possibly empty list of script capabilities, that is:

 	Git <-- Filter: "git-filter-protocol\n"
 	Git <-- Filter: "version 1.1\n"
 	Git <-- Filter: "capabilities clean smudge\n"

Or we can add capabilities in later version...

BTW. why not follow e.g. HTTP protocol example, and use

 	Git <-- Filter: "git-filter-protocol/1\n"

> 2. Git sends the command (either "smudge" or "clean"), the filename, the
> content size in bytes, and the content separated by a newline character:
> 	Git --> Filter: "smudge\n"

Would it help (for some cases) to pass the name of filter that
is being invoked?

> 	Git --> Filter: "testfile.dat\n"

Unfortunately, while sane filenames should not contain newlines[1],
the unfortunate fact is that *filenames can include newlines*, and
you need to be able to handle that[2].  Therefore you need either to
choose a different separator (the only one that can be safely used
is "\0", i.e. the NUL character - but it is not something easy to
handle by shell scripts), or C-quote filenames as needed, or always
C-quote filenames.  C-quoting at minimum should include quoting newline
character, and the escape character itself.

BTW. is it the basename of a file, or a full pathname?

[1]: http://www.dwheeler.com/essays/fixing-unix-linux-filenames.html
[2]: http://www.dwheeler.com/essays/filenames-in-shell.html

> 	Git --> Filter: "7\n"

That's the content size in bytes written as an ASCII number.

> 	Git --> Filter: "CONTENT"

Can filter ignore the content size, and just read all what it was
sent, that is until eof or something?

> 
> 3. The filter is expected to answer with the result content size in
> bytes and the result content separated by a newline character:
> 	Git <-- Filter: "15\n"
> 	Git <-- Filter: "SMUDGED_CONTENT"

I wonder how hard would be to write filters for this protocol...

> 
> 4. The filter is expected to wait for the next file in step 2, again.
> 
> Please note that the protocol filters do not support stream processing
> with this implemenatation because the filter needs to know the length of
            ^^^^^^^^~^^^^^^

implementation

> the result in advance. A protocol version 2 could address this in a
> future patch.
> 
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> Helped-by: Martin-Louis Bright <mlbright@gmail.com>
> ---
>  Documentation/gitattributes.txt |  41 +++++++-
>  convert.c                       | 210 ++++++++++++++++++++++++++++++++++++++--
>  t/t0021-conversion.sh           | 170 ++++++++++++++++++++++++++++++++

Wouldn't it be better to name the test case something more
descriptive, for example

   t/t0021-filter-driver-useProtocol.sh

The name of test should be adjusted to final name of the feature,
of course.

>  t/t0021/rot13.pl                |  80 +++++++++++++++
>  4 files changed, 494 insertions(+), 7 deletions(-)
>  create mode 100755 t/t0021/rot13.pl
> 
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index 8882a3e..7026d62 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -300,7 +300,10 @@ checkout, when the `smudge` command is specified, the command is
>  fed the blob object from its standard input, and its standard
>  output is used to update the worktree file.  Similarly, the
>  `clean` command is used to convert the contents of worktree file
> -upon checkin.
> +upon checkin. By default these commands process only a single
> +blob and terminate. If the setting filter.<driver>.useProtocol is
> +enabled then Git can process all blobs with a single filter command
> +invocation (see filter protocol below).

This does not tell the precedence between `smudge`, `clean` and
filter.<driver>.useProtocol, see above. Also, discrepancy in how
config variables are referenced.

>  
>  One use of the content filtering is to massage the content into a shape
>  that is more convenient for the platform, filesystem, and the user to use.
> @@ -375,6 +378,42 @@ substitution.  For example:
>  ------------------------
>  
>  
> +Filter Protocol
> +^^^^^^^^^^^^^^^
> +
> +If the setting filter.<driver>.useProtocol is enabled then Git

This seems to tell that `useProtocol` is boolean-valued (?)

> +can process all blobs with a single filter command invocation
> +by talking with the following protocol over stdin/stdout.

Should we use stdin/stdout shortcut, or spell standard input
and standard output in full?

> diff --git a/convert.c b/convert.c
> index 522e2c5..91ce86f 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -481,12 +481,188 @@ static int apply_filter(const char *path, const char *src, size_t len, int fd,
>  	return ret;
>  }
>  
> +static int cmd_process_map_init = 0;
> +static struct hashmap cmd_process_map;
> +
> +struct cmd2process {
> +	struct hashmap_entry ent; /* must be the first member! */
> +	const char *cmd;
> +	long protocol;
> +	struct child_process process;
> +};
[...]
> +static struct cmd2process *find_protocol_filter_entry(const char *cmd)
> +{
> +	struct cmd2process k;
> +	hashmap_entry_init(&k, strhash(cmd));
> +	k.cmd = cmd;
> +	return hashmap_get(&cmd_process_map, &k, NULL);

Should we use global variable cmd_process_map, or pass it as parameter?
The same question apply for other procedures and functions.

Note that I am not saying that it is a bad thing to use global
variable here.

[...]
> +static struct cmd2process *start_protocol_filter(const char *cmd)
> +{
> +	int ret = 1;
> +	struct cmd2process *entry = NULL;
> +	struct child_process *process = NULL;
> +	struct strbuf nbuf = STRBUF_INIT;
> +	struct string_list split = STRING_LIST_INIT_NODUP;
> +	const char *argv[] = { NULL, NULL };
> +	const char *header = "git-filter-protocol\nversion";
> +
> +	entry = xmalloc(sizeof(*entry));
> +	hashmap_entry_init(entry, strhash(cmd));
> +	entry->cmd = cmd;
> +	process = &entry->process;
> +
> +	child_process_init(process);
> +	argv[0] = cmd;
> +	process->argv = argv;
> +	process->use_shell = 1;
> +	process->in = -1;
> +	process->out = -1;
> +
> +	if (start_command(process)) {
> +		error("cannot fork to run external persistent filter '%s'", cmd);
> +		return NULL;
> +	}
> +	strbuf_reset(&nbuf);

Is strbuf_reset needed here? We have not used nbuf variable yet.

> +
> +	sigchain_push(SIGPIPE, SIG_IGN);
> +	ret &= strbuf_read_once(&nbuf, process->out, 0) > 0;
> +	sigchain_pop(SIGPIPE);
> +
> +	strbuf_stripspace(&nbuf, 0);
> +	string_list_split_in_place(&split, nbuf.buf, ' ', 2);
> +	ret &= split.nr > 1;
> +	ret &= strncmp(header, split.items[0].string, strlen(header)) == 0;
> +	if (ret) {
> +		entry->protocol = strtol(split.items[1].string, NULL, 10);

This does not handle at least some errors in version number parsing,
for example junk after version number. Don't we have some helper
functions for this?

Nb. this code makes it so that the version number must be integer.

> +		switch (entry->protocol) {
> +			case 1:
> +				break;
> +			default:
> +				ret = 0;
> +				error("unsupported protocol version %s for external persistent filter '%s'",
> +					nbuf.buf, cmd);
> +		}
> +	}
> +	string_list_clear(&split, 0);
> +	strbuf_release(&nbuf);
> +
> +	if (!ret) {
> +		error("initialization for external persistent filter '%s' failed", cmd);
> +		return NULL;
> +	}

Do we handle persistent filter command being killed before it finishes?
Or exiting with error? I don't know this Git API...

> +
> +	hashmap_add(&cmd_process_map, entry);
> +	return entry;
> +}
[...]

> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index a05a8d2..d9077ea 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -268,4 +268,174 @@ test_expect_success 'disable filter with empty override' '
>  	test_must_be_empty err
>  '
>  
> +test_expect_success 'required protocol filter should filter data' '
> +	test_config_global filter.protocol.smudge \"$TEST_DIRECTORY/t0021/rot13.pl\" &&
> +	test_config_global filter.protocol.clean \"$TEST_DIRECTORY/t0021/rot13.pl\" &&

Perhaps align it?

  +	test_config_global filter.protocol.clean  \"$TEST_DIRECTORY/t0021/rot13.pl\" &&


> diff --git a/t/t0021/rot13.pl b/t/t0021/rot13.pl

That's bit more than rot13... but it might be O.K. for a filename here.

> new file mode 100755
> index 0000000..f2d7a03
> --- /dev/null
> +++ b/t/t0021/rot13.pl
> @@ -0,0 +1,80 @@
> +#!/usr/bin/env perl

Don't we use other way to specify perl path for Git, and for its
test suite?

> +#
> +# Example implementation for the Git filter protocol version 1
> +# See Documentation/gitattributes.txt, section "Filter Protocol"
> +#
> +
> +use strict;
> +use warnings;
> +use autodie;

autodie?

> +
> +sub rot13 {
> +    my ($str) = @_;
> +    $str =~ y/A-Za-z/N-ZA-Mn-za-m/;
> +    return $str;
> +}
> +
> +$| = 1; # autoflush STDOUT

Perhaps *STDOUT->autoflush(1), if I remember my Perl correctly?
Should this matter? Why it is needed?

> +
> +open my $debug, ">>", "output.log";
> +$debug->autoflush(1);
> +
> +print $debug "start\n";
> +
> +print STDOUT "git-filter-protocol\nversion 1";
> +print $debug "wrote version\n";
> +
> +while (1) {
> +    my $command = <STDIN>;
> +    unless (defined($command)) {
> +        exit();
> +    }
> +    chomp $command;
> +    print $debug "IN: $command";
> +    my $filename = <STDIN>;
> +    chomp $filename;
> +    print $debug " $filename";
> +    my $filelen  = <STDIN>;
> +    chomp $filelen;
> +    print $debug " $filelen";
> +
> +    $filelen = int($filelen);
> +    my $output;
> +
> +    if ( $filelen > 0 ) {

Inconsistent style. You use

       unless (defined($command)) {

without extra whitespace after and before parentheses, but

       if ( $filelen > 0 ) {

instead of simply

       if ($filelen > 0) {

> +        my $input;
> +        {
> +            binmode(STDIN);
> +            my $bytes_read = 0;
> +            $bytes_read = read STDIN, $input, $filelen;
> +            if ( $bytes_read != $filelen ) {
> +                die "not enough to read";

I know it's only a test script (well, a part of one), but we would probably
want to have more information in the case of a real filter.

> +            }
> +            print $debug " [OK] -- ";
> +        }
> +
> +        if ( $command eq "clean") {
> +            $output = rot13($input);
> +        }
> +        elsif ( $command eq "smudge" ) {

Style; I think we use

  +        } elsif ( $command eq "smudge" ) {

> +            $output = rot13($input);
> +        }
> +        else {
> +            die "bad command\n";

Same here (both about style, and error message).

> +        }
> +    }

What happens if $filelen is zero, or negative? Ah, I see that $output
would be undef... which is bad, I think.

> +
> +    my $output_len = length($output);
> +    print STDOUT "$output_len\n";
> +    print $debug "OUT: $output_len";
> +    if ( $output_len > 0 ) {
> +        if ( ($command eq "clean" and $filename eq "clean-write-fail.r") or
> +             ($command eq "smudge" and $filename eq "smudge-write-fail.r") ) {

Hardcoded filenames, without it being described in the file header?

> +            print STDOUT "fail";

This is not defined in the protocol description!  Unless anything that
does not conform to the specification would work here, but at least it
is a recommended practice to be described in the documentation, don't
you think?

What would happen in $output_len is 4?

> +            print $debug " [FAIL]\n"
> +        } else {
> +            print STDOUT $output;
> +            print $debug " [OK]\n";
> +        }
> +    }
> +}

-- 
Jakub Narêbski
 

