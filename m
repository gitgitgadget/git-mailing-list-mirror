Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 052871F4F8
	for <e@80x24.org>; Sat,  8 Oct 2016 23:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752306AbcJHXGq (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Oct 2016 19:06:46 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33645 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752115AbcJHXGp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2016 19:06:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id i130so8390089wmg.0
        for <git@vger.kernel.org>; Sat, 08 Oct 2016 16:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=82DJ24cR4Z3ev8o6I2KZaooHAZAmik1h0E2b1tnR4ZY=;
        b=iNospZvooknJPNiZcQ2Hhri8kePAWLWoGRUNKBjdGG7uzsYv5sp9d0bZUYxmg7IU5H
         d1ryiuCiNKM/AZ3T+crtJgLP7co9I0B1i8MYEG3M4dfTzAXhR9J+qSlwHkRYPgYbeWCm
         f9XGjGeUbl2rdXmFxZhbNxANVNb5pDcLxXaqViDVmuTq7/MRV7HdgLRerQXoqMR7EA5N
         f6V/OV5WFWV4LpwhSH0Z7FqO4aeYN9MdSyIrSebh/rf4cjz566PXNnuSFD0sLqCSvDfZ
         z2IHJcHAYgo0xhmMR/quH1DoQMbeXTDVHATijfkLqqE6cTs3QoEoIwI2sneoLvJhPr2M
         eCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=82DJ24cR4Z3ev8o6I2KZaooHAZAmik1h0E2b1tnR4ZY=;
        b=HZrb+JiQipZu8lnW0nVWxuc0UNI03yEad2kMoQV81ppueznnp+S/6mhF3mASBpjn62
         lOlvlaZ38uw2fkOz1XB568dxX2E398rEMerTJc9udFifI+isMdRk6nNbX2kKjZK+/yKb
         kdrDYIATaqarNi9UOzotMQYTtmIPsNYbH8oK25jVY103vgvns6l7PbLbpippS3+U2jZm
         //KV+1+LjPXpu21HMIDe4QuOAidryM1GFjlZpkqzvuldQ1EOGXDlPbOpkx/dYUF2UHlO
         ZMMNtDwNvIIZZpPqrm3AG88tWMqvSyBpWlfOyfeANwb/KLEWq/d4JbbTorPJXBeuXAYK
         8zUA==
X-Gm-Message-State: AA6/9RnMtZOoUoWNnmw5Vv35PWQsidbFbNFB1mlnr2DFeVdLul6Sf4/4adl23jp55Rsw/w==
X-Received: by 10.28.10.136 with SMTP id 130mr4769298wmk.115.1475968003188;
        Sat, 08 Oct 2016 16:06:43 -0700 (PDT)
Received: from [192.168.1.26] (abpn165.neoplus.adsl.tpnet.pl. [83.8.55.165])
        by smtp.googlemail.com with ESMTPSA id o196sm10425769wmg.8.2016.10.08.16.06.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Oct 2016 16:06:42 -0700 (PDT)
Subject: Re: [PATCH v10 13/14] convert: add filter.<driver>.process option
To:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
References: <20161008112530.15506-1-larsxschneider@gmail.com>
 <20161008112530.15506-14-larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <e09a63ee-dad2-a8fb-e47f-0559d9507e1c@gmail.com>
Date:   Sun, 9 Oct 2016 01:06:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161008112530.15506-14-larsxschneider@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Part 1 of review, starting with the protocol v2 itself.

W dniu 08.10.2016 o 13:25, larsxschneider@gmail.com pisze:
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
> 
> A few key decisions:
> 
> * The long running filter process is referred to as filter protocol
>   version 2 because the existing single shot filter invocation is
>   considered version 1.
> * Git sends a welcome message and expects a response right after the
>   external filter process has started. This ensures that Git will not
>   hang if a version 1 filter is incorrectly used with the
>   filter.<driver>.process option for version 2 filters. In addition,
>   Git can detect this kind of error and warn the user.
> * The status of a filter operation (e.g. "success" or "error) is set
>   before the actual response and (if necessary!) re-set after the
>   response. The advantage of this two step status response is that if
>   the filter detects an error early, then the filter can communicate
>   this and Git does not even need to create structures to read the
>   response.
> * All status responses are pkt-line lists terminated with a flush
>   packet. This allows us to send other status fields with the same
>   protocol in the future.

Looks good to me.

> 
> Helped-by: Martin-Louis Bright <mlbright@gmail.com>
> Reviewed-by: Jakub Narebski <jnareb@gmail.com>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/gitattributes.txt | 157 +++++++++++++-
>  convert.c                       | 297 +++++++++++++++++++++++++-
>  t/t0021-conversion.sh           | 447 +++++++++++++++++++++++++++++++++++++++-
>  t/t0021/rot13-filter.pl         | 191 +++++++++++++++++
>  4 files changed, 1082 insertions(+), 10 deletions(-)
>  create mode 100755 t/t0021/rot13-filter.pl
> 
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index 7aff940..5868f00 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -293,7 +293,13 @@ checkout, when the `smudge` command is specified, the command is
>  fed the blob object from its standard input, and its standard
>  output is used to update the worktree file.  Similarly, the
>  `clean` command is used to convert the contents of worktree file
> -upon checkin.
> +upon checkin. By default these commands process only a single
> +blob and terminate.  If a long running `process` filter is used
> +in place of `clean` and/or `smudge` filters, then Git can process
> +all blobs with a single filter command invocation for the entire
> +life of a single Git command, for example `git add --all`.  See
> +section below for the description of the protocol used to
> +communicate with a `process` filter.

I don't remember how this part looked like in previous versions
of this patch series, but "... is used in place of `clean` ..."
does not tell explicitly about the precedence of those 
configuration variables.  I think it should be stated explicitly
that `process` takes precedence over any `clean` and/or `smudge`
settings for the same `filter.<driver>` (regardless of whether
the long running `process` filter support "clean" and/or "smudge"
operations or not).

>  
>  One use of the content filtering is to massage the content into a shape
>  that is more convenient for the platform, filesystem, and the user to use.
> @@ -373,6 +379,155 @@ not exist, or may have different contents. So, smudge and clean commands
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
> +input and standard output as follows. All packets, except for the
> +"*CONTENT" packets and the "0000" flush packet, are considered
> +text and therefore are terminated by a LF.

Maybe s/standard input and output/\& of filter process,/ (that is,
add "... of filter process," to the third sentence in the above
paragraph).

I guess what LF (line-feed character, "\n") is should be obvious
for anybody who will be reading this part.  All right.

> +
> +Git starts the filter when it encounters the first file
> +that needs to be cleaned or smudged. After the filter started
> +Git sends a welcome message ("git-filter-client"), a list of
> +supported protocol version numbers, and a flush packet.

I guess there is no need to be more explicit in description here,
as the exact format should be obvious from the example below.
We could add that the list of supported protocol version numbers
is send as series of "version=<integer number>" text-packet
lines.

>                                                          Git expects
> +to read a welcome response message ("git-filter-server") and exactly
> +one protocol version number from the previously sent list. All further
> +communication will be based on the selected version. The remaining
> +protocol description below documents "version=2". Please note that
> +"version=42" in the example below does not exist and is only there
> +to illustrate how the protocol would look like with more than one
> +version.
> +
> +After the version negotiation Git sends a list of all capabilities that
> +it supports and a flush packet. Git expects to read a list of desired
> +capabilities, which must be a subset of the supported capabilities list,
> +and a flush packet as response:
> +------------------------
> +packet:          git> git-filter-client
> +packet:          git> version=2
> +packet:          git> version=42
> +packet:          git> 0000
> +packet:          git< git-filter-server
> +packet:          git< version=2
> +packet:          git> clean=true
> +packet:          git> smudge=true
> +packet:          git> not-yet-invented=true
> +packet:          git> 0000
> +packet:          git< clean=true
> +packet:          git< smudge=true
> +packet:          git< 0000

WARNING: This example is different from description!!!

In example you have Git sending "git-filter-client" and list of supported
protocol versions, terminated with flush packet, then filter driver
process sends "git-filter-server", exactly one version, *AND* list of
supported capabilities in "<capability>=true" format, terminated with
flush packet.

In description above the example you have 4-part handshake, not 3-part;
the filter is described to send list of supported capabilities last
(a subset of what Git command supports).  Moreover in the example in
previous version at least as far as v8 of this series, the response
from filter driver was fixed length list of two lines: magic string
"git-filter-server" and exactly one line with protocol version; this
part was *not* terminated with a flush packet (complicating code of
filter driver program a bit, I think).

I think this version of protocol is *better*, just the text needs to
be updated to match.  I wanted to propose something like this in v9,...


By the way, now I look at it, the argument for using the
"<capability>=true" format instead of "capability=<capability>"
(or "supported-command=<capability>") is weak.  The argument for
using "<variable>=<value>" to make it easier to implement parsing
is sound, but the argument for "<capability>=true" is weak.

The argument was that with "<capability>=true" one can simply
parse metadata into hash / dictionary / hashmap, and choose
response based on that.  Hash / hashmap / associative array
needs different keys, so the reasoning went for "<capability>=true"
over "capability=<capability>"... but the filter process still
needs to handle lines with repeating keys, namely "version=<N>"
lines!

So the argument doesn't hold water IMVHO, and we can choose
version which reads better / is more natural.

> +------------------------
> +Supported filter capabilities in version 2 are "clean" and
> +"smudge".

I think it would be good to have something here separating the
handshake part of protocol from the description of the working
part.  The latter loops over each file to be affected by given
filter driver; handshake is done only once per filter.

Maybe subsections?

> +
> +Afterwards Git sends a list of "key=value" pairs terminated with
> +a flush packet. The list will contain at least the filter command
> +(based on the supported capabilities) and the pathname of the file
> +to filter relative to the repository root. Right after these packets

I think you meant here "right after the flush packet", isn't it?
It would be more explicit.

> +Git sends the content split in zero or more pkt-line packets and a
> +flush packet to terminate content. Please note, that the filter
> +must not send any response before it received the content and the
> +final flush packet.

That's good to have this information in the documentation.

BTW. I hope that in the future this restriction could be lifted with
"stream" capability / option, by having Git read response from filter
driver in an asynchronous process, like for one-shot v1 filters.
But that is certainly for later.  Let's polish this series and have
it accepted first.

> +------------------------
> +packet:          git> command=smudge
> +packet:          git> pathname=path/testfile.dat
> +packet:          git> 0000
> +packet:          git> CONTENT
> +packet:          git> 0000
> +------------------------
> +
> +The filter is expected to respond with a list of "key=value" pairs
> +terminated with a flush packet.

I wonder if we could be more explicit that it is about "status"
response.  But I don't have good idea how to improve this sentence;
not that it is really needed, I don't think.

>                                  If the filter does not experience
> +problems then the list must contain a "success" status. Right after
> +these packets the filter is expected to send the content in zero
> +or more pkt-line packets and a flush packet at the end.

Perhaps "terminating it with a flush packet"?  But it is quite all
right as it is now.

>                                                       Finally, a
> +second list of "key=value" pairs terminated with a flush packet
> +is expected. The filter can change the status in the second list.

I would add here, to be more explicit:

  This second list of "key=value" pairs may be empty, and usually
  would be if there is nothing wrong with response or filter; the
  terminating flush packet must be here regardless.

Or something like that.  The above proposal could be certainly
improved.

> +------------------------
> +packet:          git< status=success
> +packet:          git< 0000
> +packet:          git< SMUDGED_CONTENT
> +packet:          git< 0000
> +packet:          git< 0000  # empty list, keep "status=success" unchanged!

All right, looks good.  Is this exclamation mark "!" necessary / wanted?

> +------------------------
> +
> +If the result content is empty then the filter is expected to respond
> +with a "success" status and an empty list.

Actually, it is empty content, not empty list; that is response (filter
output) composed entirely of flush packet.

Sidenote: I first thought that "empty list" here was about the post-content
information, which may be empty, and for empty contents it would almost
certainly be empty list - there is nothing I think that can change status
of filter...

> +------------------------
> +packet:          git< status=success
> +packet:          git< 0000
> +packet:          git< 0000  # empty content!
> +packet:          git< 0000  # empty list, keep "status=success" unchanged!
> +------------------------
> +
> +In case the filter cannot or does not want to process the content,
> +it is expected to respond with an "error" status. Depending on the
> +`filter.<driver>.required` flag Git will interpret that as error
> +but it will not stop or restart the filter process.

I think those two parts of last sentence: the part of 'required' flag,
and the part about restarting process would be better either split,
or their order reversed: first, tell that Git would not restart filter;
second, that it would continue with next file without 'required' flag,
and error-out if filter has 'required' flag.  Though perhaps this should
be known at this point of documentation, and doesn't need repeating...

Ugh.  Well, it's quite good as it is now.

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

Errr... this is literal repetition.  You need to decide whether to
put it before example, or after example.  Or maybe split it.

> +------------------------
> +packet:          git< status=success
> +packet:          git< 0000
> +packet:          git< HALF_WRITTEN_ERRONEOUS_CONTENT
> +packet:          git< 0000
> +packet:          git< status=error
> +packet:          git< 0000
> +------------------------
> +
> +If the filter dies during the communication or does not adhere to
> +the protocol then Git will stop the filter process and restart it
> +with the next file that needs to be processed. Depending on the
> +`filter.<driver>.required` flag Git will interpret that as error.

Uhh... until now the order was explanation, then example.  From the
duplicated description above, it is now first example, then
description.  Consistency would be good.

> +
> +The error handling for all cases above mimic the behavior of
> +the `filter.<driver>.clean` / `filter.<driver>.smudge` error
> +handling.

You have "error handling" repeated here.

> +
> +In case the filter cannot or does not want to process the content
> +as well as any future content for the lifetime of the Git process,
> +it is expected to respond with an "abort" status at any point in
> +the protocol. Depending on the `filter.<driver>.required` flag Git
> +will interpret that as error for the content as well as any future
> +content for the lifetime of the Git process but it will not stop or
> +restart the filter process.

Here the order, first about `required` then without, looks all right
to me: the result wrt process is the same, only the error or not
changes.

And here we have description first, example second.

> +------------------------
> +packet:          git< status=abort
> +packet:          git< 0000
> +------------------------
> +
> +After the filter has processed a blob it is expected to wait for
> +the next "key=value" list containing a command. Git will close
> +the command pipe on exit. The filter is expected to detect EOF
> +and exit gracefully on its own.

Any "kill filter" solutions should probably be put here.  I guess
that filter exiting means EOF on its standard output when read
by Git command, isn't it?

> +
> +If you develop your own long running filter
> +process then the `GIT_TRACE_PACKET` environment variables can be
> +very helpful for debugging (see linkgit:git[1]).

s/environment variables/environment variable/  - there is only
one GIT_TRACE_PACKET.  Unless you wanted to write about GIT_TRACE?

> +
> +If a `filter.<driver>.process` command is configured then it
> +always takes precedence over a configured `filter.<driver>.clean`
> +or `filter.<driver>.smudge` command.

Ah, it is here! I think it would be better to put it upfront; you
don't need information about the protocol to *use* the existing
filter, but you need this info.

Or maybe we can repeat this information.

> +
> +Please note that you cannot use an existing `filter.<driver>.clean`
> +or `filter.<driver>.smudge` command with `filter.<driver>.process`
> +because the former two use a different inter process communication
> +protocol than the latter one.

I'm not sure where this should be (but it is needed)

> +
> +
>  Interaction between checkin/checkout attributes
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

-- 
Jakub Narębski

