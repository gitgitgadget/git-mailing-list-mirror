Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FEBC1F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 22:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752822AbcG3WGA (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 18:06:00 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34769 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638AbcG3WF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 18:05:58 -0400
Received: by mail-wm0-f65.google.com with SMTP id q128so20760632wma.1
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 15:05:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=8MbswjN7njrsD5jnmLobWPp5SlzhadjjALvhztuZUrM=;
        b=AhIH5SV39XETth/lcqLLE06H/rxji1TuTNZXFDJfv479aWqTX4LswhCY0AyC0UuNVG
         ACIfuuE0oYB+H6zew2dcU1nAQN7S/7BA61AXynPMu2zpRqaQypwPfbvOS4bEtf2hVjt0
         Y6Gnu+NJTOJ2StZOAJZeGbXxsqMhTVoEVIMVBSGYF3ogox+zop2CMKbg8SwALYL/Mrv9
         GdZ5ryP71k6sH3Bme8zbDekaWyIXE4PevvOHxhv/DpcE6QrY79ArU4MPBQVaiS3CUqwn
         FHj/GX8OEIs9wm8eBiAreON2n8rGE4gC9t5wUUv+NnbdWJYRBWGxXjCHSCuLixfK8q04
         gaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=8MbswjN7njrsD5jnmLobWPp5SlzhadjjALvhztuZUrM=;
        b=ey40HPjvhsHlLIyCNX52Kzs9etkFjQl72XmGbXwtHQVZ5MLv8QOBulBRWCvp0mOsxg
         /L/ZxaWSWGVypmDBRxXRCSzOhOJZLBciSpUDSdfFxew1EW6dQC1I5u4OSuC61elYLOnA
         52xiXegxYx1tFQI7KNMdEQH5BYXApnRUN5Ped1BBvtgCdaCId0GzsYNUgFTTSRRceZBW
         Suw0L02cE4YxapNR49fXEdczTyq6lnaBRQ4WzOB4YxlAsa5EgC6pptAO/SntHcc+sdgO
         Tabl6MTNRsPnBMxceKwXicQeXYeK9Qh7QZD8+tTVUqqQOvXx3VYV31e8su35rYgP/hFr
         eYDw==
X-Gm-Message-State: AEkooutGA2kyDk1eXfwKOdNGuV76ZgAgasUstuFtAYHHmzEqy1zZdKdLpd6dpiHG3Ym9kw==
X-Received: by 10.194.192.195 with SMTP id hi3mr43374607wjc.108.1469916356476;
        Sat, 30 Jul 2016 15:05:56 -0700 (PDT)
Received: from [192.168.1.26] (dad247.neoplus.adsl.tpnet.pl. [83.23.3.247])
        by smtp.googlemail.com with ESMTPSA id r13sm9463569wmf.12.2016.07.30.15.05.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jul 2016 15:05:55 -0700 (PDT)
Subject: Re: [PATCH v3 10/10] convert: add filter.<driver>.process option
To:	Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
References: <20160727000605.49982-1-larsxschneider%40gmail.com/>
 <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160729233801.82844-11-larsxschneider@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	Martin-Louis Bright <mlbright@gmail.com>,
	Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <b4c9ac5d-bd6b-141b-5b85-ab4aa719ccb0@gmail.com>
Date:	Sun, 31 Jul 2016 00:05:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160729233801.82844-11-larsxschneider@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 30.07.2016 o 01:38, larsxschneider@gmail.com pisze:
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> Git's clean/smudge mechanism invokes an external filter process for every
> single blob that is affected by a filter. If Git filters a lot of blobs
> then the startup time of the external filter processes can become a
> significant part of the overall Git execution time.
> 
> This patch adds the filter.<driver>.process string option which, if used,
> keeps the external filter process running and processes all blobs with
> the following packet format (pkt-line) based protocol over standard input
> and standard output.

I think it would be nice to have here at least summary of the benchmarks
you did in https://github.com/github/git-lfs/pull/1382

> 
> Git starts the filter on first usage and expects a welcome
> message, protocol version number, and filter capabilities
> separated by spaces:
> ------------------------
> packet:          git< git-filter-protocol\n
> packet:          git< version 2\n
> packet:          git< capabilities clean smudge\n

Sorry for going back and forth, but now I think that 'capabilities' are
not really needed here, though they are in line with "version" in
the second packet / line, namely "version 2".  If it does not make
parsing more difficult...

> ------------------------
> Supported filter capabilities are "clean", "smudge", "stream",
> and "shutdown".

I'd rather put "stream" and "shutdown" capabilities into separate
patches, for easier review.

> 
> Afterwards Git sends a command (based on the supported
> capabilities), the filename including its path
> relative to the repository root, the content size as ASCII number
> in bytes, the content split in zero or many pkt-line packets,
> and a flush packet at the end:

I guess the following is the most basic example, with mode detailed
description left for the documentation.

> ------------------------
> packet:          git> smudge\n
> packet:          git> filename=path/testfile.dat\n
> packet:          git> size=7\n

So I see you went with "<variable>=<value>" idea, rather than "<value>"
(with <variable> defined by position in a sequence of 'header' packets),
or "<variable> <value>..." that introductory header uses.

> packet:          git> CONTENT
> packet:          git> 0000
> ------------------------
> 
> The filter is expected to respond with the result content size as
> ASCII number in bytes. If the capability "stream" is defined then
> the filter must not send the content size. Afterwards the result
> content in send in zero or many pkt-line packets and a flush packet
> at the end. 

If it does not cost filter anything, it could send size upfront
(based on size of original, or based on external data), even if
it is prepared for streaming.

In the opposite case, where filter cannot stream because it requires
whole contents upfront (e.g. to calculate hash of the contents, or
to do operation that needs whole file like sorting or reversing lines),
it should always be able to calculate the size... or not.  For
example 'sort | uniq' filter needs whole input upfront for sort,
but it does not know how many lines will be in output without doing
the 'uniq' part.

So I think the ability of filter to provide size (or size hint) of
its output should be decoupled from streaming support.

>             Finally a "success" packet is send to indicate that
> everything went well.

That's a nice addition, and probably a necessary one, to the stream
protocol.  Git must know and consume it - we wouldn't be able to
retrofit it later.

> ------------------------
> packet:          git< size=57\n   (omitted with capability "stream")

I was thinking about having possible responses to receiving file
contents (or starting receiving in the streaming case) to be:

  packet:          git< ok size=7\n    (or "ok 7\n", if size is known)

or

  packet:          git< ok\n           (if filter does not know size upfront)

or

  packet:          git< fail <msg>\n   (or just "fail" + packet with msg)

The last would be when filter knows upfront that it cannot perform
the operation.  Though sending an empty file with non-"success" final
would work as well.

For example LFS filter (that is configured as not required) may refuse
to store files which are smaller than some pre-defined constant threshold.

> packet:          git< SMUDGED_CONTENT
> packet:          git< 0000
> packet:          git< success\n
> ------------------------
> 
> In case the filter cannot process the content, it is expected
> to respond with the result content size 0 (only if "stream" is
> not defined) and a "reject" packet.
> ------------------------
> packet:          git< size=0\n    (omitted with capability "stream")
> packet:          git< reject\n
> ------------------------

This is *wrong* idea!  Empty file, with size=0, can be a perfectly
legitimate response.  

For example rot13 filter should respond to an empty file on input
with an empty file on output.  LFS-like filters and encryption
mechanism should return empty file on fetch / decryption
if such empty file was stored / encrypted.

A strange LFS could even use filenames (with files being empty
themselves) as a lookup key for artifactory.  For example a kind
of CDN for common libraries, with version embedded in filename,
like 'libs/jquery-1.9.0.min.js', etc.

> 
> After the filter has processed a blob it is expected to wait for
> the next command. A demo implementation can be found in
> `t/t0021/rot13-filter.pl` located in the Git core repository.

If filter does not support "shutdown" capability (or if said
capability is postponed for later patch), it should behave sanely
when Git command reaps it (SIGTERM + wait + SIGKILL?, SIGCHLD?).

> 
> If the filter supports the "shutdown" capability then Git will
> send the "shutdown" command and wait until the filter answers
> with "done". This gives the filter the opportunity to perform
> cleanup tasks. Afterwards the filter is expected to exit.
> ------------------------
> packet:          git> shutdown\n
> packet:          git< done\n
> ------------------------

I guess there is no timeout mechanism: if filter hangs on shutdown,
then git command would also hang waiting for signal to exit.

> 
> If a filter.<driver>.clean or filter.<driver>.smudge command
> is configured then these commands always take precedence over
> a configured filter.<driver>.process command.

Note: the value of `clean`, `smudge` and `process` is a command,
not just a string.

I wonder if it would be worth it to explain the reasoning behind
this solution and show alternate ones.

 * Using a separate variable to signal that filters are invoked
   per-command rather than per-file, and use pkt-line interface,
   like boolean-valued `useProtocol`, or `protocolVersion` set
   to '2' or 'v2', or `persistence` set to 'per-command', there
   is high risk of user's trying to use exiting one-shot per-file
   filters... and Git hanging.

 * Using new variables for each capability, e.g. `processSmudge`
   and `processClean` would lead to explosion of variable names;
   I think.

 * Current solution of using `process` in addition to `clean`
   and `smudge` clearly says that you need to use different
   command for per-file (`clean` and `smudge`), and per-command
   filter, while allowing to use them together.

   The possible disadvantage is Git command starting `process`
   filter, only to see that it doesn't offer required capability,
   for example offering only "clean" but not "smudge".  There
   is simple workaround - set `smudge` variable (same as not
   present capability) to empty string.

> 
> Please note that you cannot use an existing filter.<driver>.clean
> or filter.<driver>.smudge command as filter.<driver>.process
> command. As soon as Git would detect a file that needs to be
> processed by this filter, it would stop responding.

I think this needs to be in the documentation (I have not checked
yet if it is), but is not needed in the already long commit message.

> 
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> Helped-by: Martin-Louis Bright <mlbright@gmail.com>
> ---
>  Documentation/gitattributes.txt |  84 ++++++++-
>  convert.c                       | 400 +++++++++++++++++++++++++++++++++++++--
>  t/t0021-conversion.sh           | 405 ++++++++++++++++++++++++++++++++++++++++
>  t/t0021/rot13-filter.pl         | 177 ++++++++++++++++++
>  4 files changed, 1053 insertions(+), 13 deletions(-)
>  create mode 100755 t/t0021/rot13-filter.pl
> 
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index 8882a3e..e3fbcc2 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -300,7 +300,11 @@ checkout, when the `smudge` command is specified, the command is
>  fed the blob object from its standard input, and its standard
>  output is used to update the worktree file.  Similarly, the
>  `clean` command is used to convert the contents of worktree file
> -upon checkin.
> +upon checkin. By default these commands process only a single
> +blob and terminate. If a long running filter process (see section
> +below) is used then Git can process all blobs with a single filter
> +invocation for the entire life of a single Git command (e.g.
> +`git add .`).

Proposed improvement:

                       If a long running `process` filter is used
   in place of `clean` and/or `smudge` filters, then Git can process
   all blobs with a single filter command invocation for the entire
   life of a single Git command, for example `git add --all`.  See
   section below for the description of the protocol used to
   communicate with a `process` filter.

>  
>  One use of the content filtering is to massage the content into a shape
>  that is more convenient for the platform, filesystem, and the user to use.
> @@ -375,6 +379,84 @@ substitution.  For example:
>  ------------------------
>  
>  
> +Long Running Filter Process
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +If the filter command (string value) is defined via

This is no mere string value, this is command invocation (with its
own rules, e.g. splitting parameters on whitespace, etc.).  Though
I'm not sure how to say it succintly.  Maybe skip "(string value)"?
But it is there for a reason...

> +filter.<driver>.process then Git can process all blobs with a

Shouldn't it be `filter.<driver>.process`?

> +single filter invocation for the entire life of a single Git
> +command. This is achieved by using the following packet
> +format (pkt-line, see protocol-common.txt) based protocol over

Can we linkgit-it (to technical documentation)?

> +standard input and standard output.
> +
> +Git starts the filter on first usage and expects a welcome

Is "usage" here correct?  Perhaps it would be more readable
to say that Git starts filter when encountering first file
that needs cleaning or smudgeing.

> +message, protocol version number, and filter capabilities
> +separated by spaces:
> +------------------------
> +packet:          git< git-filter-protocol\n
> +packet:          git< version 2\n
> +packet:          git< capabilities clean smudge\n
> +------------------------
> +Supported filter capabilities are "clean", "smudge", "stream",
> +and "shutdown".

Filter should include at least one of "clean" and "smudge"
capabilities (currently), otherwise it wouldn't do anything.

I don't know if it is a good place to say that because of pkt-line
recommendations about text-content packets, each of those should
terminate in endline, with "\n" included in pkt-line length.

> +
> +Afterwards Git sends a command (based on the supported
> +capabilities),

I think it should be something like the following:

   If among filter `process` capabilities there is capability
   that corresponds to the operation performed by a Git command
   (that is, either "clean" or "smudge"), then Git would send,
   in separate packets, a command (based on supported capabilites),

though it feels too "chatty" (and the sentence gets quite long).

>                the filename including its path
> +relative to the repository root, 

Errr... "the filename including its path"? Wouldn't be it simpler
to just say:

  the pathname of a file relative to the repository root,

Also, isn't it now "filename=<pathname>\n"?

>                                   the content size as ASCII number
> +in bytes, 

Could Git not give the size, for example if fstat() fails? Do
we reserve space for other information here?

Also, isn't it now "size=<bytes>\n"?

>             the content split in zero or many pkt-line packets,

s/zero or many/zero or more/

> +and a flush packet at the end:

I wonder if instead of long sentence, it would be more readable
to use enumeration (ordered list) or itemize (unordered list).

> +------------------------
> +packet:          git> smudge\n
> +packet:          git> filename=path/testfile.dat\n
> +packet:          git> size=7\n
> +packet:          git> CONTENT
> +packet:          git> 0000
> +------------------------
> +
> +The filter is expected to respond with the result content size as
> +ASCII number in bytes. If the capability "stream" is defined then
> +the filter must not send the content size.

As I wrote earlier, I think sending or not the size of the output
should be decoupled from the "stream" capability.

Streaming is IMVHO rather a capability of starting to send parts
of response before the whole contents of input arrives.  I think
per-file filters support that and that's what start_async() there
is about.

>                                             Afterwards the result
> +content in send in zero or many pkt-line packets and a flush packet
> +at the end. Finally a "success" packet is send to indicate that
> +everything went well.

I guess it is "success" packet if everything went well, and place
for informing about errors in the future - filter is assumed to die
if there are errors in filtering, isn't it?

That is, not "send to indicate", but "send if".

> +------------------------
> +packet:          git< size=57\n   (omitted with capability "stream")
> +packet:          git< SMUDGED_CONTENT
> +packet:          git< 0000
> +packet:          git< success\n
> +------------------------
> +
> +In case the filter cannot process the content, it is expected
> +to respond with the result content size 0 (only if "stream" is
> +not defined) and a "reject" packet.
> +------------------------
> +packet:          git< size=0\n    (omitted with capability "stream")
> +packet:          git< reject\n
> +------------------------

I would assume that we have two error conditions.  

First situation is when the filter knows upfront (after receiving name
and size of file, and after receiving contents for not-streaming filters)
that it cannot process the file (like e.g. LFS filter with artifactory
replica/shard being a bit behind master, and not including contents of
the file being filtered).

My proposal is to reply with "fail" _in place of_ size of reply:

   packet:         git< fail\n       (any case: size known or not, stream or not)

It could be "reject", or "error" instead of "fail".


Another situation is if filter encounters error during output,
either with streaming filter (or non-stream, but not storing whole
input upfront) realizing in the middle of output that there is something
wrong with input (e.g. converting between encoding, and encountering
character that cannot be represented in output encoding), or e.g. filter
process being killed, or network connection dropping with LFS filter, etc.
The filter has send some packets with output already.  In this case
filter should flush, and send "reject" or "error" packet.

   <error condition>
   packet:         git< "0000"       (flush packet)
   packet:         git< reject\n

Should there be a place for an error message, or would standard error
(stderr) be used for this?

> +
> +After the filter has processed a blob it is expected to wait for
> +the next command. A demo implementation can be found in
> +`t/t0021/rot13-filter.pl` located in the Git core repository.

It is actually in Git sources.  Is it the best way to refer to
such files?

> +
> +If the filter supports the "shutdown" capability then Git will
> +send the "shutdown" command and wait until the filter answers
> +with "done". This gives the filter the opportunity to perform
> +cleanup tasks. Afterwards the filter is expected to exit.
> +------------------------
> +packet:          git> shutdown\n
> +packet:          git< done\n
> +------------------------
> +
> +If a filter.<driver>.clean or filter.<driver>.smudge command
> +is configured then these commands always take precedence over
> +a configured filter.<driver>.process command.

All right; this is quite clear.

> +
> +Please note that you cannot use an existing filter.<driver>.clean
> +or filter.<driver>.smudge command as filter.<driver>.process
> +command. As soon as Git would detect a file that needs to be
> +processed by this filter, it would stop responding.

This isn't.


P.S. I will comment about the implementation part in the next email.
-- 
Jakub Narębski

