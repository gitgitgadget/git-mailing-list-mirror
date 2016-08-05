Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8672E2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 10:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759563AbcHEKcd (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 06:32:33 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34786 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799AbcHEKcb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Aug 2016 06:32:31 -0400
Received: by mail-wm0-f65.google.com with SMTP id q128so3176097wma.1
        for <git@vger.kernel.org>; Fri, 05 Aug 2016 03:32:30 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=y4r1vH2gghCZxGRSlyKrFykooNrdEacYbVL1C+4vIHk=;
        b=ZbnVDjY0Z64tvosK1i9sPHaYS4w28I9lp/hju4qlhksKGYnghrah1Z3sbTVqy0CDZP
         3y9bCnpQPnHHox34/pTvuLjDOU17z4he18IHNgA22tI4k5uJ/ahGF94bZ55wQyhY5kF8
         OG4lzcJJ2L2rhaQTJuq3YuYDKM3ReU3WttWhh2OsXf8pvwn86RH9Ny2V1buKu99dkLWd
         991irSlNaUpUy2Vq62PFOoBiIYOFwiAabDNUERYQvjuIHwRs0FSgh2EAyNeOAqPa0pOL
         Yf7SV8n/Feij3CBBuHvx4nvhoYqpmaeOdrB5YS3xc2hGssAGIzQkC5yQeqDHlYa2bDsm
         8PyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=y4r1vH2gghCZxGRSlyKrFykooNrdEacYbVL1C+4vIHk=;
        b=Lm1aKFdBQk+QjEocXFUyB5hJr5oqfHIcO9eZvGukGm9qmPfKMC/RG7UvagM2o0KGfu
         uL9vFCghDUnB1zjV6tWM/sqTxhKkGLYRB7UAfe5t2svK6VS7v4bM+xF65p+WzlyEIGsS
         ACYW9rOy2PKII6RE+5KpKdbl7JItkO1YjIAepl/qJbJp82Gf/Ao3U3m3mW4ssfEds0vT
         PByU0DIDwDXlTEtPHvhEJqK7IZBrAuE8ZqGAzHrEQSIhW0S4m7NnHH80YbkINBP1UtZr
         ZyMBtt+gnr5iz4MV6BWQhCtDZCjyuaO3ysix2evrUQfTNe+WByP4+aack5OXiufmmd+D
         83cA==
X-Gm-Message-State: AEkoousCPC02tt3jBdnVsdrf9hr1peG6+IzJC/tcNDOeGloS289iNqp9COEVqXs7M+yfjw==
X-Received: by 10.28.236.24 with SMTP id k24mr2649997wmh.47.1470393149811;
        Fri, 05 Aug 2016 03:32:29 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id g7sm17174571wjx.10.2016.08.05.03.32.27
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Aug 2016 03:32:29 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Designing the filter process protocol (was: Re: [PATCH v3 10/10] convert: add filter.<driver>.process option)
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <607c07fe-5b6f-fd67-13e1-705020c267ee@gmail.com>
Date:	Fri, 5 Aug 2016 12:32:27 +0200
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Martin-Louis Bright <mlbright@gmail.com>,
	Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>
Content-Transfer-Encoding: 8BIT
Message-Id: <FE7B04D2-C017-42AF-BD30-6160D251028C@gmail.com>
References: <20160727000605.49982-1-larsxschneider%40gmail.com/> <20160729233801.82844-1-larsxschneider@gmail.com> <20160729233801.82844-11-larsxschneider@gmail.com> <b4c9ac5d-bd6b-141b-5b85-ab4aa719ccb0@gmail.com> <ABE7D2DB-C45F-4F29-8CC2-8D873FD6C36A@gmail.com> <607c07fe-5b6f-fd67-13e1-705020c267ee@gmail.com>
To:	=?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 03 Aug 2016, at 20:30, Jakub Narębski <jnareb@gmail.com> wrote:
> 
> The ultimate goal is to be able to run filter drivers faster for both `clean`
> and `smudge` operations.  This is done by starting filter driver once per
> git command invocation, instead of once per file being processed.  Git needs
> to pass actual contents of files to filter driver, and get its output.
> 
> We want the protocol between Git and filter driver process to be extensible,
> so that new features can be added without modifying protocol.
> 
> 
> 1. CONFIGURATION
> 
> As I wrote, there are different ways of configuring new-type filter driver:
> 
> ...
> 
> # Using a single variable for new filter type, and decide on which phase
>   (which operation) is supported by filter driver during the handshake
>   *(current approach)*
> 
>   	[filter "protocol"]
>   		process = rot13-filtes.pl
> 
>   PROS: per-file and per-command filters possible with precedence rule;
>         extensible to other types of drivers: textconv, diff, etc.
>         only one invocation for commands which use both clean and smudge
>   CONS: need single driver to be responsible for both clean and smudge;
>         need to run driver to know that it does not support given
>           operation (workaround exists)
> 
> 
> 2. HANDSHAKE (INITIALIZATION)
> 
> Next, there is deciding on and designing the handshake between Git (between
> Git command) and the filter driver process.  With the `filter.<driver>.process`
> solution the driver needs to tell which operations among (for now) "clean"
> and "smudge" it does support.  Plus it provides a way to extend protocol,
> adding new features, like support for streaming, cleaning from file or
> smudging to file, providing size upfront, perhaps even progress report.
> 
> Current handshake consist of filter driver printing a signature, version
> number and capabilities, in that order.  Git checks that it is well formed
> and matches expectations, and notes which of "clean" and "smudge" operations
> are supported by the filter.
> 
> There is no interaction from the Git side in the handshake, for example to
> set options and expectations common to all files being filtered.  Take
> one possible extension of protocol: supporting streaming.  The filter
> driver needs to know whether it needs to read all the input, or whether
> it can start printing output while input is incoming (e.g. to reduce
> memory consumption)... though we may simply decide it to be next version
> of the protocol.
> 
> On the other hand if the handshake began with Git sending some initializer
> info to the filter driver, we probably could detect one-shot filter
> misconfigured as process-filter.

OK, I'll look into this.


> Note that we need some way of deciding where handshake ends, either by
> specifying number of entries (currently: three lines / pkt-line packets),
> or providing some terminator ("smart" transport protocol uses flush packet
> for this).
> 
> ...

Would you be OK with Peff's suggestion?

  version=2
  clean=true
  smudge=true
  0000

http://public-inbox.org/git/20160803224619.bwtbvmslhuicx2qi%40sigill.intra.peff.net/



> 3. SENDING CONTENTS (FILE TO BE FILTERED AND FILTER OUTPUT)
> 
> Next thing to design is decision how to send contents to be filtered
> to the filter driver process, and how to get filtered output from the
> filter driver process.
> 
> ...
> 
> # Send/receive data file by file, using some kind of chunking,
>   with a end-of-file marker.  The solution used by Git is
>   pkt-line, with flush packet used to signal end of file.
> 
>   This is protocol used by the current implementation.
> 
>   PROS:
>   - no need to know size upfront, so easier streaming support
>   - you can signal error that happened during output, after
>     some data were sent, as well as error known upfront
>   - tracing support for free (GIT_TRACE_PACKET)
>   CONS:
>   - filter driver program slightly more difficult to implement
>   - some negligible amount of overhead
> 
> If we want in the end to implement streaming, then the last solution
> is the way to go.
> 
> 
> 4. PER-FILE HANDSHAKE - SENDING FILE TO FILTER
> 
> Let's assume that for simplicity we want to implement (for now) only
> the synchronous (non-streaming) case, where we send whole contents
> of a file to filter driver process, and *then* read filter driver
> output.
> ...
> 
> If we are using pkt-line, then the convention is that text lines
> are terminated using LF ("\n") character.  This needs to be stated
> explicitly in the documentation for filter.<driver>.process writers.
> 
>    git> packet:  [operation] clean size=67\n
> 
> We could denote that it is operation name, but it is obvious from
> position in the stream, thus not really needed.

I would prefer not to mix command and size in one packet as it
makes parsing a little more difficult.


> ...
> 
> The Git would sent contents of the file to be filtered, using
> as many pack lines as needed (note: large file support needs
> to be tested, at least as expensive test).  Flush packet is
> used to signal the end of the file.
> 
>    git> packets:  <file contents>
>    git> flush packet

If expensive tests are enabled the test suite will process data
larger then max pkt size.


> 5. FILTER DRIVER PROCESS RESPONSE
> 
> First filter should, in my opinion, reply that it received the
> request (or the command, in the case of streaming supported).
> Also, in this response it can provide further information to
> Git process.
> 
>    git< packet: [received]  ok size=67\n

I think this would be different for real streaming and the current
non-streaming... therefore it would complicate the protocol?!
I wonder if it is truly necessary.


> This response could be used to refuse to filter specific file
> upfront (for example if the file is not present in the artifactory
> for git-LFS solutions).
> 
>   git< packet: [rejected]  reject\n

Reject is already supported in v4.


> We can even provide the reasoning to Git (maybe in the future
> extension)... or filter driver can print the explanation to the
> standard error (but then, no --quiet / --verbose support).
> 
>   git< packet: [rejected]  reject with-message\n
>   git< packet: [message]   File not found on server\n
>   git< flush packet

I think Git shouldn't care about these details. If the filter
needs to tell something then it should use stderr. 


> Another response, which I think should be standarized, or at
> least described in the documentation, is filter driver refusing
> to filter further (e.g. git-LFS and network is down), to be not
> restarted by Git.
> 
>   git< packet: [quit]      quit msg=Server error\n
> 
> or
> 
>   git< packet: [quit]      quit Server error\n
> 
> or
> 
>   git< packet: [quit]      quit with-message\n
>   git< packet: [message]   Server error\n
>   git< flush packet
> 
> Maybe this is over-engineering, but I don't think so.

Interesting idea! I will look into this for v5!


> Next comes the output from the filter driver (filtered contents),
> using possibly multiple pkt-lines, ending with a flush packet:
> 
>    git< packets:  <filtered contents>
>    git< flush packet
> 
> Note that empty file would consist of zero pack lines of contents,
> and one flush packet.
> 
> Finally, to allow handling of [resumable] errors that occurred
> during sending file contents, especially for the future streaming
> filters case, we want to confirm that we send whole file
> successfully.
> 
>    git< packet: [status]   success\n
> 
> If there was an error during process, making data receives so far
> invalid, filter driver should tell about it
> 
>    git< packet: [status]   fail\n
> 
> or
> 
>    git< packet: [status]   reject\n
> 
> This may happen for example for UCS-2 <-> UTF-8 filter when invalid
> byte sequence is encountered.  This may happen for git-LFS if the
> server fails during fetch, and spare / slave server doesn't have
> a file.

Correct!


> We may want to quit filtering at this point, and not to send another
> file.
> 
>   git< packet: [status]    quit\n

I don't get this one. Git would restart the filter as soon as it finds
another file that needs to be filtered, right?


Thanks a lot for this write up!

- Lars