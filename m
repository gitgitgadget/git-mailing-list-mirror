Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1678F207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 22:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933164AbcIZWmH (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 18:42:07 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34533 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757777AbcIZWmC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 18:42:02 -0400
Received: by mail-lf0-f67.google.com with SMTP id b71so10498454lfg.1
        for <git@vger.kernel.org>; Mon, 26 Sep 2016 15:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=J+xnKeQjDMGUDz5Q7I6Y7HCjOQq/ZvbUYIbQOG0zuZQ=;
        b=nNDLCEPzOjCvlqMjObN7Hynp+yGReyhZudvTSZVnBszCQV/gWXpLyvz4Jfhrqw3Wjd
         07cAd//sLjX2d7reQ+fUYMNDrLozd5zMpqx8tjOdmOQ7iecVVD3dXtLEXtH/YSvKzzxD
         Ouallg97HcWOhDUoKbPQClVyntUkf+FS84Qg6htJ3lgXRxdcoSEENqptR/+NY0+TCQq0
         g7A/s4SOhfoIBMsFM2RPwouwqwmuQBQw90dH5JFTT0v/pvwAnMJW7T5KFTV9ocfI2YBy
         Nt21RtPOiSfp31Er7jy4MxKHvlMYIrruPsYXt6iWyDJvE1tplh2XI4Xy+I58abm/s3Ho
         lhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=J+xnKeQjDMGUDz5Q7I6Y7HCjOQq/ZvbUYIbQOG0zuZQ=;
        b=EI+PqSoqERXvvKV+YO2lgFGBPlZyCxtIiW7jYeNpoWviCvUhtpiBNgEUtpfmHNS7qS
         ex8SB6XxEJgiX5YZzSq810y+CucZbus80pHNQlwm6pXXcdVnjaocKkNkh9FkZVABaCZu
         yX5OuJrW3HrMUXRw57jecBza425xbphq6+IfOD4Nw4tIuLo/S0LIrrJqTUpBAKPLCdAt
         SI8y51nNlxUU3VUb/sh+HcgL9Df10JNjdsU0sbxnH87ROvtGZYUUPO193YFOCR5h6XO4
         N+w5KPIUx3td9vCIcl6Mo2lBZQdaOKdx/5imDWi3qYUGPFuPk5RzSFeqyZqNydWXD70K
         aOjw==
X-Gm-Message-State: AA6/9Rn1Jh2dR3RJaCogCj60Pa4WOCYZqYPxNltOSXyRJSnbsU3zBMHj+ztkYrVPzfrfxg==
X-Received: by 10.28.12.209 with SMTP id 200mr218864wmm.118.1474929720050;
        Mon, 26 Sep 2016 15:42:00 -0700 (PDT)
Received: from [192.168.1.26] (adby40.neoplus.adsl.tpnet.pl. [79.184.24.40])
        by smtp.googlemail.com with ESMTPSA id uw3sm24602061wjb.21.2016.09.26.15.41.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Sep 2016 15:41:58 -0700 (PDT)
Subject: Re: [PATCH v8 11/11] convert: add filter.<driver>.process option
To:     Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>
References: <20160920190247.82189-1-larsxschneider@gmail.com>
 <20160920190247.82189-12-larsxschneider@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <91589466-439e-7200-7256-b9288beae685@gmail.com>
Date:   Tue, 27 Sep 2016 00:41:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20160920190247.82189-12-larsxschneider@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Part first of the review of 11/11.

W dniu 20.09.2016 o 21:02, larsxschneider@gmail.com pisze:
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> Git's clean/smudge mechanism invokes an external filter process for
> every single blob that is affected by a filter. If Git filters a lot of
> blobs then the startup time of the external filter processes can become
> a significant part of the overall Git execution time.
> 
> In a preliminary performance test this developer used a clean/smudge
> filter written in golang to filter 12,000 files. This process took 364s
> with the existing filter mechanism and 5s with the new mechanism. See
> details here: https://github.com/github/git-lfs/pull/1382
> 
> This patch adds the `filter.<driver>.process` string option which, if
> used, keeps the external filter process running and processes all blobs
> with the packet format (pkt-line) based protocol over standard input and
> standard output. The full protocol is explained in detail in
> `Documentation/gitattributes.txt`.

That is a good description.  Enough detail to explain the new feature,
all without duplicating information with (added) docs.

> 
> A few key decisions:
> 
> * The long running filter process is referred to as filter protocol
>   version 2 because the existing single shot filter invocation is
>   considered version 1.

All right.

> * Git sends a welcome message and expects a response right after the
>   external filter process has started. This ensures that Git will not
>   hang if a version 1 filter is incorrectly used with the
>   filter.<driver>.process option for version 2 filters. In addition,
>   Git can detect this kind of error and warn the user.

On one hand side, this involved handshake means that implementing
a filter process script is harder; you need to write quite a lot of
boilerplate (though the example or examples would help).

On the other hand, this handshake is what allows good error detection,
easy extendability of the protocol, and forward-compatibility.  Which,
as we agreed (AFAIU), is more important.

> * The status of a filter operation (e.g. "success" or "error) is set
>   before the actual response and (if necessary!) re-set after the
>   response. The advantage of this two step status response is that if
>   the filter detects an error early, then the filter can communicate
>   this and Git does not even need to create structures to read the
>   response.

That's nice (well, among others I have argued for this :-))

> * All status responses are pkt-line lists terminated with a flush
>   packet. This allows us to send other status fields with the same
>   protocol in the future.

Good.

This also makes protocol simple, easier to implement (on Git side),
and easier to parse (on filter side).

> 
> Helped-by: Martin-Louis Bright <mlbright@gmail.com>
> Reviewed-by: Jakub Narebski <jnareb@gmail.com>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  Documentation/gitattributes.txt        | 156 +++++++++++++-
>  contrib/long-running-filter/example.pl | 123 +++++++++++
>  convert.c                              | 348 ++++++++++++++++++++++++++++---
>  pkt-line.h                             |   1 +
>  t/t0021-conversion.sh                  | 365 ++++++++++++++++++++++++++++++++-
>  t/t0021/rot13-filter.pl                | 191 +++++++++++++++++
>  6 files changed, 1153 insertions(+), 31 deletions(-)

That's quite a large change.  Large changes are harder to review.
I was thinking about how one could split this change.  I guess
that it is better to keep the new feature, its documentation, and
its tests together.  But perhaps the example in `contrib/`
(which is newer, and thus less reviewed) would be better in
separate commit.

There is also another change that could be split off this patch
into purely preparatory commit, that is one that stands alone
but doesn't make much sense alone.  I would write about this
proposal (important only if there would be yet another iteration
of this patch series) a bit later.

>  create mode 100755 contrib/long-running-filter/example.pl
>  create mode 100755 t/t0021/rot13-filter.pl
> 
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index 7aff940..946dcad 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -293,7 +293,13 @@ checkout, when the `smudge` command is specified, the command is
>  fed the blob object from its standard input, and its standard
>  output is used to update the worktree file.  Similarly, the
>  `clean` command is used to convert the contents of worktree file
> -upon checkin.
> +upon checkin. By default these commands process only a single
> +blob and terminate.  If a long running `process` filter is used
   ^^^^

Should we use this terminology here?  I have not read the preceding
part of documentation, so I don't know if it talks about "blobs" or
if it uses "files" and/or "file contents".

Though this is very minor nitpick.

> +in place of `clean` and/or `smudge` filters, then Git can process
> +all blobs with a single filter command invocation for the entire
> +life of a single Git command, for example `git add --all`.  See
> +section below for the description of the protocol used to
> +communicate with a `process` filter.

Good introduction of long lived filter feature (`process` filter).

>  
>  One use of the content filtering is to massage the content into a shape
>  that is more convenient for the platform, filesystem, and the user to use.
> @@ -373,6 +379,154 @@ not exist, or may have different contents. So, smudge and clean commands
>  should not try to access the file on disk, but only act as filters on the
>  content provided to them on standard input.
>  
> +Long Running Filter Process
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +If the filter command (a string value) is defined via
> +`filter.<driver>.process` then Git can process all blobs with a
> +single filter invocation for the entire life of a single Git
> +command. This is achieved by using a packet format (pkt-line,
> +see technical/protocol-common.txt) based protocol over standard
> +input and standard output as follows. All packets are considered
> +text and therefore are terminated by an LF. Exceptions are the
> +"*CONTENT" packets and the flush packet.

I guess that reasoning here is that all but CONTENT packets are
metadata, and thus to aid debuggability of the protocol are "text",
as considered by pkt-line.

Perhaps a bit more readable would be the following (but current is
just fine; I am nitpicking):

  All packets, except for the "{star}CONTENT" packets and the "0000"
  flush packer, are considered text and therefore are terminated by
  a LF.

Or maybe:

  All metadata is considered text, and thus send as a text packet,
  that is terminated with the newline (LF) character.  The file
  contents is send as binary data, as is, without appending LF.
  The flush packet is a packet composed of 4 bytes, represented
  in ASCII as "0000".

Anyway, this is all right as it is now; we can always polish it
later.

> +
> +Git starts the filter when it encounters the first file
> +that needs to be cleaned or smudged. After the filter started
> +Git sends a welcome message ("git-filter-client"), a list of
> +supported protocol version numbers, and a flush packet. Git expects

I see that example below explains what is the format of sending
this list of process filter protocol version numbers supported by
Git (I suppose it is to future proof adding new versions of protocol,
and removing old ones if they are somehow buggy). It would be nice,
I think, to explain it in more detail:

  a list of supported protocol version numbers, each version in
  a separate text packet using the "version=<n>" format,

But with an example few paragraphs below it might be not necessary.

I think it might be a good idea to describe what flush packet is
somewhere in this document; on the other hand referring (especially
if hyperlinked) to pkt-line technical documentation might be good
enough / better.  I'm unsure, but I tend on the side that referring
to technical documentation is better.

> +to read a welcome response message ("git-filter-server") and exactly
> +one protocol version number from the previously sent list. All further

I guess that is to provide forward-compatibility, isn't it?  Also,
"Git expects..." probably means filter process MUST send, in the
RFC2119 (https://tools.ietf.org/html/rfc2119) meaning.

> +communication will be based on the selected version. The remaining
> +protocol description below documents "version=2". Please note that
> +"version=42" in the example below does not exist and is only there
> +to illustrate how the protocol would look like with more than one
> +version.

All right.

> +
> +After the version negotiation Git sends a list of supported capabilities
> +and a flush packet.

Is it that Git SHOULD send list of ALL supported capabilities, or is
it that Git SHOULD NOT send capabilities it does not support, and that
it MAY send only those capabilities it needs (so for example if command
uses only `smudge`, it may not send `clean`, so that filter driver doesn't
need to initialize data it would not need).

I guess with the example few lines below there is no need to explain
the format of capabilities (or use BNF / EBNF notation to define it).

I wonder why it is "<capability>=true", and not "capability=<capability>".
Is there a case where we would want to send "<capability>=false".  Or
is it to allow configurable / value based capabilities?  Isn't it going
a bit too far: is there even a hind of an idea for parametrize-able
capability? YAGNI is a thing...

A few new capabilities that we might want to support in the near future
is "size", "stream", which are options describing how to communicate,
and "cleanFromFile", "smudgeToFile", which are new types of operations...
but neither needs any parameter.

I guess that adding new capabilities doesn't require having to come up
with the new version of the protocol, isn't it.

>                       Git expects to read a list of desired capabilities,
> +which must be a subset of the supported capabilities list, and a flush
> +packet as response:

All right, with Git speaking first, having Git provide list of supported
capabilities first is quite natural.

> +------------------------
> +packet:          git> git-filter-client

I guess we assume that from the above description it is obvious that
this is

  +packet:          git> git-filter-client\n

All right.

> +packet:          git> version=2
> +packet:          git> version=42

"List" means "each in separate packet", right.  Here also

  +packet:          git> version=2\n

> +packet:          git> 0000

As I wrote, I hope everybody would understand that is a flush packet,
that is packet composed literally of 4 characters / bytes "0000",
and not binary or text packet with "0000" as contents, that is
"00040000" packet or "00050000\n" packet.

But as it is consistent with other examples, and with GIT_TRACE_PACKET
output, I think both skipping trailing \n for text packets, and
writing "0000" for flush packet is all right.  Sorry for the noise.

Sidenote (you don't have to answer to): do we use "0004" packet as
a keep-alive packet anywhere?

> +packet:          git< git-filter-server
> +packet:          git< version=2
> +packet:          git> clean=true
> +packet:          git> smudge=true
> +packet:          git> not-yet-invented=true

Hmmm... should we hint at the use of kebab-case versus snake_case
or camelCase for new capabilities?

> +packet:          git> 0000
> +packet:          git< clean=true
> +packet:          git< smudge=true
> +packet:          git< 0000
> +------------------------
> +Supported filter capabilities in version 2 are "clean" and
> +"smudge".

I think we can add new capabilities without increasing version number
of the protocol.  But then we can and should update this part of the
documentation.

All right.

> +
> +Afterwards Git sends a list of "key=value" pairs terminated with
> +a flush packet. The list will contain at least the filter command
> +(based on the supported capabilities) and the pathname of the file
> +to filter relative to the repository root. Right after these packets
> +Git sends the content split in zero or more pkt-line packets and a
> +flush packet to terminate content.

All right, the example below shows what are the names of 'variables;
in those packets (that is "command=" ( "clean" | "smudge" ), and
"pathname=" <pathname>).

> +------------------------
> +packet:          git> command=smudge
> +packet:          git> pathname=path/testfile.dat
> +packet:          git> 0000
> +packet:          git> CONTENT
> +packet:          git> 0000
> +------------------------

I think it is important to mention that (at least with current
`filter.<driver>.process` implementation, that is absent future
"stream" capability / option) the filter process needs to read
*whole contents* at once, *before* writing anything.  Otherwise
it can lead to deadlock.

This is especially important in that it is different (!) from the
current behavior of `clean` and `smudge` filters, which can
stream their response because Git invokes them async.

> +
> +The filter is expected to respond with a list of "key=value" pairs
> +terminated with a flush packet. If the filter does not experience
> +problems then the list must contain a "success" status.

Perhaps "status" packet with value "success", or

                                   If the filter does not experience
  +problems then the list must contain a "status=success" line.

Possibly s/line./packet./

But as I see with how it is explained further, 'a "success" status'
works too.  No need to change, then.

>                                                          Right after
> +these packets the filter is expected to send the content in zero
> +or more pkt-line packets and a flush packet at the end. Finally, a
> +second list of "key=value" pairs terminated with a flush packet
> +is expected. The filter can change the status in the second list.
> +------------------------
> +packet:          git< status=success
> +packet:          git< 0000
> +packet:          git< SMUDGED_CONTENT
> +packet:          git< 0000
> +packet:          git< 0000  # empty list!
> +------------------------

All right.  Empty list with no change in status looks good.

An alternative would be to assume different meaning to the "status"
before and after sending contents, e.g.

   packet:          git< received=ok
   packet:          git< 0000
   packet:          git< SMUDGED_CONTENT
   packet:          git< 0000
   packet:          git< sent=ok
   packet:          git< 0000

But I think current solution is good enough.

> +
> +If the result content is empty then the filter is expected to respond
> +with a success status and an empty list.
> +------------------------
> +packet:          git< status=success
> +packet:          git< 0000
> +packet:          git< 0000  # empty content!
> +packet:          git< 0000  # empty list!
> +------------------------

All right.  This follows from the definition, but it is nice to have
it spelled in full.

> +
> +In case the filter cannot or does not want to process the content,
> +it is expected to respond with an "error" status. Depending on the
> +`filter.<driver>.required` flag Git will interpret that as error
> +but it will not stop or restart the filter process.

Right, and Git would not try to read contents from the filter then.

> +------------------------
> +packet:          git< status=error
> +packet:          git< 0000
> +------------------------
> +
> +If the filter experiences an error during processing, then it can
> +send the status "error" after the content was (partially or
> +completely) sent. Depending on the `filter.<driver>.required` flag
> +Git will interpret that as error but it will not stop or restart the
> +filter process.
> +------------------------
> +packet:          git< status=success
> +packet:          git< 0000
> +packet:          git< HALF_WRITTEN_ERRONEOUS_CONTENT
> +packet:          git< 0000
> +packet:          git< status=error
> +packet:          git< 0000
> +------------------------

Good.  A question is if the filter process can send "status=abort"
after partial contents, or does it need to wait for the next command?

> +
> +If the filter dies during the communication or does not adhere to
> +the protocol then Git will stop the filter process and restart it
> +with the next file that needs to be processed. Depending on the
> +`filter.<driver>.required` flag Git will interpret that as error.
> +
> +The error handling for all cases above mimic the behavior of
> +the `filter.<driver>.clean` / `filter.<driver>.smudge` error
> +handling.

Good.

> +
> +In case the filter cannot or does not want to process the content
> +as well as any future content for the lifetime of the Git process,
> +it is expected to respond with an "abort" status. Depending on
> +the `filter.<driver>.required` flag Git will interpret that as error
> +for the content as well as any future content for the lifetime of the
> +Git process but it will not stop or restart the filter process.
> +------------------------
> +packet:          git< status=abort
> +packet:          git< 0000
> +------------------------

I assume this is obvious that if filter process tells "abort", Git
would not try to send further files (regardless of the value of
`filter.<driver>.required`).

> +
> +After the filter has processed a blob it is expected to wait for
> +the next "key=value" list containing a command. Git will close
> +the command pipe on exit. The filter is expected to detect EOF
> +and exit gracefully on its own.

Good to have it documented.  

Anyway, as it is Git command that spawns the filter driver process,
assuming that the filter process doesn't daemonize itself, wouldn't
the operating system reap it after its parent process, that is the
git command it invoked, dies? So detecting EOF is good, but not
strictly necessary for simple filter that do not need to free
its resources, or can leave freeing resources to the operating
system? But I may be wrong here.

> +
> +A long running filter demo implementation can be found in
> +`contrib/long-running-filter/example.pl` located in the Git
> +core repository. If you develop your own long running filter
> +process then the `GIT_TRACE_PACKET` environment variables can be
> +very helpful for debugging (see linkgit:git[1]).

Very good... though I wonder if adding demo implementation should
not be left for a separate commit.

> +
> +If a `filter.<driver>.process` command is configured then it
> +always takes precedence over a configured `filter.<driver>.clean`
> +or `filter.<driver>.smudge` command.

This is a change from what I remember of previous iterations of this
patch series, but I see that it might be the best solution of the
three possible (that I can think of):

* `filter.<driver>.clean` or `filter.<driver>.smudge` command
  always takes precedence over `filter.<driver>.process`

  ADVANTAGES: 
   - can convert only half of filter to process filter

  DISADVANTAGES: 
   - uncommon "older type wins"
   - cannot provide fallback of one-shot filters for older Git

* `filter.<driver>.process` command always takes precedence
  over `filter.<driver>.clean` or `filter.<driver>.smudge` command
  (this is the one chosen)

  ADVANTAGES:
   - can provide `clean` and `smudge` filters as fallback for
     older Git (e.g. installed locally, and not always in PATH)

  DISADVANTAGES:
   - need to convert both `clean` and `smudge` part into `process`
     at once

* `filter.<driver>.process` command takes precedence over
  `filter.<driver>.clean` if it supports "clean" capability, and
  similarly for `filter.<driver>.smudge`

  ADVANTAGES:
   - can convert only half of filter to process filter
   - can provide `clean` and `smudge` filters as fallback for
     older Git (e.g. installed locally, and not always in PATH)
  
  DISADVANTAGES:
   - you need to see the filter implementation to know which
     one would be invoked
   - complicated to understand, reason about, and implement

> +
> +Please note that you cannot use an existing `filter.<driver>.clean`
> +or `filter.<driver>.smudge` command with `filter.<driver>.process`
> +because the former two use a different inter process communication
> +protocol than the latter one.

Good.

> +
> +
>  Interaction between checkin/checkout attributes
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  
> diff --git a/contrib/long-running-filter/example.pl b/contrib/long-running-filter/example.pl
> new file mode 100755
> index 0000000..c13a631
> --- /dev/null
> +++ b/contrib/long-running-filter/example.pl

To repeat myself, I think it would serve better as a separate patch.

Perhaps even you could add the example filter in the Go language
from https://github.com/github/git-lfs/pull/1382 (there is already
at least one Go program in contrib/).  In a separate patch, of course.
The commands/command_filter.go.

> @@ -0,0 +1,123 @@
> +#!/usr/bin/perl
> +#
> +# Example implementation for the Git filter protocol version 2
> +# See Documentation/gitattributes.txt, section "Filter Protocol"

We might add that it is a pass-thru filter, a skeleton to be
modified.

> +#
> +
> +use strict;
> +use warnings;
> +
> +my $MAX_PACKET_CONTENT_SIZE = 65516;

All right, constants (the built in / in core ones) are strange...
Variables are easier to use.

> +
> +sub packet_bin_read {
> +    my $buffer;
> +    my $bytes_read = read STDIN, $buffer, 4;
> +    if ( $bytes_read == 0 ) {
> +
> +        # EOF - Git stopped talking to us!
> +        exit();
> +    }
> +    elsif ( $bytes_read != 4 ) {

That is a different Perl coding convention that the one I am used to,
but it is no less valid.  Consistent style is more important.  This is
the contrib/ area anyway.

> +        die "invalid packet size '$bytes_read' field";

This would read "invalid packet size '000' field", for example.
Perhaps the following would be (slightly) better:

  +        die "invalid packet size field: '$bytes_read'";

> +    }
> +    my $pkt_size = hex($buffer);
> +    if ( $pkt_size == 0 ) {
> +        return ( 1, "" );

It feels a bit strange to me to return a list / a pair combining
status / error condition with the actual result.  I'm more used
to packing such in hash reference.  But I think it is all right.

> +    }
> +    elsif ( $pkt_size > 4 ) {

Isn't a packet of $pkt_size == 4 a valid packet, a keep-alive
one?  Or is it forbidden?

We can declare that Git should not use it for filter process anyway.

> +        my $content_size = $pkt_size - 4;
> +        $bytes_read = read STDIN, $buffer, $content_size;
> +        if ( $bytes_read != $content_size ) {
> +            die "invalid packet ($content_size expected; $bytes_read read)";

This error message would read "invalid packet (12 expected; 10 read)";
I think it would be better to rephrase it as

  +            die "invalid packet ($content_size bytes expected; $bytes_read bytes read)";

> +        }
> +        return ( 0, $buffer );
> +    }
> +    else {
> +        die "invalid packet size";

I'm not sure if it is worth it (especially for the demo script),
but perhaps we could show what this invalid size was?

  +        die "invalid packet size value '$pkt_size'";

> +    }
> +}
> +
> +sub packet_txt_read {
> +    my ( $res, $buf ) = packet_bin_read();
> +    unless ( $buf =~ /\n$/ ) {

Wouldn't

  +    unless ( $buf =~ s/\n$// ) {

or (less so)

  +    unless ( $buf =~ s/\n$\z// ) {

be more idiomatic (and not require use of 'substr')?  Remember,
the s/// substitution quote-like operator returns number of
substitutions in the scalar context.

> +        die "A non-binary line SHOULD BE terminated by an LF.";

This is SHOULD be, not MUST be, so perhaps 'warn' would be enough.
Not that Git should send us such line.

> +    }
> +    return ( $res, substr( $buf, 0, -1 ) );

This would be not necessary if s/// instead of m// was used.

> +}
> +
> +sub packet_bin_write {
> +    my ($packet) = @_;

This is equivalent to

  +    my $packet = shift;

which, I think, is more common for single-parameter subroutines.

Also, this is $data (or $buf), not $packet.

> +    print STDOUT sprintf( "%04x", length($packet) + 4 );
> +    print STDOUT $packet;
> +    STDOUT->flush();
> +}
> +
> +sub packet_txt_write {
> +    packet_bin_write( $_[0] . "\n" );
> +}

Nice.

> +
> +sub packet_flush {
> +    print STDOUT sprintf( "%04x", 0 );

We could use simply

  +    print STDOUT "0000";

but this is more explicit.  Good.

> +    STDOUT->flush();
> +}
> +

Perhaps some comment that main begins here?

> +( packet_txt_read() eq ( 0, "git-filter-client" ) ) || die "bad initialize";
> +( packet_txt_read() eq ( 0, "version=2" ) )         || die "bad version";
> +( packet_bin_read() eq ( 1, "" ) )                  || die "bad version end";

Actually, it is overly strict.  It should not fail if there
are other "version=3", "version=4" etc. lines.

> +
> +packet_txt_write("git-filter-server");
> +packet_txt_write("version=2");

It needs to do

  +packet_flush();

here.

> +
> +( packet_txt_read() eq ( 0, "clean=true" ) )  || die "bad capability";
> +( packet_txt_read() eq ( 0, "smudge=true" ) ) || die "bad capability";
> +( packet_bin_read() eq ( 1, "" ) )            || die "bad capability end";

It is also overly strict.  The capabilities can be ordered in any
way, and there can be additional capabilities which this script
do not understand.  It is all right to have such capabilities.

All this makes it better to extract the handshake / metadata part
into a subroutine.

> +
> +packet_txt_write("clean=true");
> +packet_txt_write("smudge=true");
> +packet_flush();

All right.

> +
> +while (1) {
> +    my ($command)  = packet_txt_read() =~ /^command=([^=]+)$/;
> +    my ($pathname) = packet_txt_read() =~ /^pathname=([^=]+)$/;

Do we require this order?  If it is, is that explained in the
documentation?

> +
> +    packet_bin_read();

I think there can be other auxiliary data (like "size=<n>") that
filter do not need to understand.

Anyway, using packet_bin_read() is quite unreadable.  What you
mean is to wait until flush packet, or expect flush packet.

   	my $done = 0;
   	while ( !$done ) {
   		( $done, undef ) = packet_bin_read();
   	}

Or

   	wait_for_flush();

Or

   	skip_until_flush();

> +
> +    my $input = "";
> +    {
> +        binmode(STDIN);
> +        my $buffer;
> +        my $done = 0;
> +        while ( !$done ) {
> +            ( $done, $buffer ) = packet_bin_read();
> +            $input .= $buffer;
> +        }
> +    }

All right.

> +
> +    my $output;
> +    if ( $command eq "clean" ) {
> +        ### Perform clean here ###
> +        $output = $input;

Perhaps we should also mention here how to handle errors
(the "status=error" and "status=abort" both for upfront
and partial contents case).

> +    }
> +    elsif ( $command eq "smudge" ) {
> +        ### Perform smudge here ###
> +        $output = $input;

Same as above.

> +    }
> +    else {
> +        die "bad command '$command'";
> +    }

All right.

> +
> +    packet_txt_write("status=success");
> +    packet_flush();
> +    while ( length($output) > 0 ) {
> +        my $packet = substr( $output, 0, $MAX_PACKET_CONTENT_SIZE );
> +        packet_bin_write($packet);
> +        if ( length($output) > $MAX_PACKET_CONTENT_SIZE ) {
> +            $output = substr( $output, $MAX_PACKET_CONTENT_SIZE );
> +        }
> +        else {
> +            $output = "";
> +        }
> +    }
> +    packet_flush();    # flush content!

All right.

> +    packet_flush();    # empty list!

This is less "empty list!", and more keeping "status=success" unchanged.

> +}
> diff --git a/convert.c b/convert.c
> index 597f561..bd66257 100644
> --- a/convert.c
> +++ b/convert.c

I'll stop here, and I'll finish the review later.

To be continued,
-- 
Jakub Narębski

