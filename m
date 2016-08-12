Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C67A51F859
	for <e@80x24.org>; Fri, 12 Aug 2016 16:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752586AbcHLQdX (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 12:33:23 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:37664 "EHLO
	mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600AbcHLQdU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 12:33:20 -0400
Received: by mail-it0-f45.google.com with SMTP id f6so18467680ith.0
        for <git@vger.kernel.org>; Fri, 12 Aug 2016 09:33:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AFF+Xxsp5TFL7DS+acQ4y9+fpQ+VCFVDyvV8E03pDKU=;
        b=SRJoWDxFlDcGK1FM4Rod5Ee2oe+6WBn1Pt2i9JrPspl6R46+Ee57/HaDAKGTwfXJX9
         cuIqJ7PHx0dmG+Ey/EeE8OS9EdC04xLxAboNHZKq5Sx9/BM4HJ8O6DHfRGQouQlPL5oY
         wWcMux1WosPYLjU/Q1lIteDqvbM0f/0PQap8gSJDI554QqsqBoZMI0qO98Eikkh817ho
         joFX8HCbFBMYo9Yc21ep04OMtSoP6lVRkhXXJGkb0IZmE2Euz13P8jYkP4bzziizqF3X
         LVFy/QjrAsgQX7MuzHc+ArarbRm0dVyTtQ1Orl39/J3Eaw1eEgR8QTGVoamJHcazYZBE
         /Hmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AFF+Xxsp5TFL7DS+acQ4y9+fpQ+VCFVDyvV8E03pDKU=;
        b=TyPDedVZIkwHH/j81UeNTKObLc2YjycjTv3WHgMrvH9cN2PI7xn5jTJItx5LCZjtBy
         k3mEqNSIk3zZ4796ZP3UuSCMF2/YXLTpPpQeuTUJPowhFtEcF5ftABJxluzBU5eysqFc
         fvl+pXqWanBZ5RfoCYd3INO/HcPmPDQKb4t0SnHTxp4EUiNaSB5HCIwdx4AT5o3hllj4
         sWquXetKarn2Ai6j3S1+8UhhFVQZz1qj9LAfTjzGrXlBgv+1Tz11B0hn8DsMlw7WZwUE
         45P0FvKjQB7wcsJ6US7u0zn7vIVMISreheJCzAHyFkf69xCVmz05xPGCiffhne7Y0R5V
         4xCA==
X-Gm-Message-State: AEkoouubHU4haQ1yJWI5S6CADjum491DauWovfYYllzqTvZ0An+auHIzhGVk71WKJBLcCAn+9uPNnnEylRO0h4yc
X-Received: by 10.36.127.7 with SMTP id r7mr4362013itc.49.1471019598779; Fri,
 12 Aug 2016 09:33:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Fri, 12 Aug 2016 09:33:18 -0700 (PDT)
In-Reply-To: <20160810130411.12419-15-larsxschneider@gmail.com>
References: <20160803164225.46355-1-larsxschneider@gmail.com/>
 <20160810130411.12419-1-larsxschneider@gmail.com> <20160810130411.12419-15-larsxschneider@gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Fri, 12 Aug 2016 09:33:18 -0700
Message-ID: <CAGZ79kboxgBRHSa2s7CKZ1Uo=13WT=rT8VHCNJNj_Q9jQzZAYw@mail.gmail.com>
Subject: Re: [PATCH v5 14/15] convert: add filter.<driver>.process option
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	mlbright@gmail.com, Eric Wong <e@80x24.org>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, ben@wijen.net
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 10, 2016 at 6:04 AM,  <larsxschneider@gmail.com> wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> Git's clean/smudge mechanism invokes an external filter process for every
> single blob that is affected by a filter. If Git filters a lot of blobs
> then the startup time of the external filter processes can become a
> significant part of the overall Git execution time.
>
> In a preliminary performance test this developer used a clean/smudge filter
> written in golang to filter 12,000 files. This process took 364s with the
> existing filter mechanism and 5s with the new mechanism. See details here:
> https://github.com/github/git-lfs/pull/1382
>
> This patch adds the `filter.<driver>.process` string option which, if used,
> keeps the external filter process running and processes all blobs with
> the packet format (pkt-line) based protocol over standard input and standard
> output described below.
>
> Git starts the filter when it encounters the first file
> that needs to be cleaned or smudged. After the filter started
> Git sends a welcome message, a list of supported protocol
> version numbers, and a flush packet. Git expects to read the
> welcome message and one protocol version number from the
> previously sent list. Afterwards Git sends a list of supported
> capabilities and a flush packet. Git expects to read a list of
> desired capabilities, which must be a subset of the supported
> capabilities list, and a flush packet as response:
> ------------------------
> packet:          git> git-filter-client
> packet:          git> version=2
> packet:          git> version=42
> packet:          git> 0000
> packet:          git< git-filter-server
> packet:          git< version=2

what follows is specific to version=2?
version 42 may deem capabilities a bad idea?

> packet:          git> clean=true
> packet:          git> smudge=true
> packet:          git> not-yet-invented=true
> packet:          git> 0000
> packet:          git< clean=true
> packet:          git< smudge=true
> packet:          git< 0000
> ------------------------
> Supported filter capabilities in version 2 are "clean" and
> "smudge".

I assume version 2 is an example here and we actually start with v1?

Can you clarify why we need welcome messages?
(Is there a technical reason, or better debuggability for humans?)

>
> Afterwards Git sends a list of "key=value" pairs terminated with
> a flush packet. The list will contain at least the filter command
> (based on the supported capabilities) and the pathname of the file
> to filter relative to the repository root. Right after these packets
> Git sends the content split in zero or more pkt-line packets and a
> flush packet to terminate content.
> ------------------------
> packet:          git> command=smudge\n
> packet:          git> pathname=path/testfile.dat\n
> packet:          git> 0000
> packet:          git> CONTENT
> packet:          git> 0000
> ------------------------
>
> The filter is expected to respond with a list of "key=value" pairs
> terminated with a flush packet. If the filter does not experience
> problems then the list must contain a "success" status. Right after
> these packets the filter is expected to send the content in zero
> or more pkt-line packets and a flush packet at the end. Finally, a
> second list of "key=value" pairs terminated with a flush packet
> is expected. The filter can change the status in the second list.
> ------------------------
> packet:          git< status=success\n
> packet:          git< 0000
> packet:          git< SMUDGED_CONTENT
> packet:          git< 0000
> packet:          git< 0000  # empty list!
> ------------------------
>
> If the result content is empty then the filter is expected to respond
> with a success status and an empty list.
> ------------------------
> packet:          git< status=success\n
> packet:          git< 0000
> packet:          git< 0000  # empty content!
> packet:          git< 0000  # empty list!
> ------------------------

Why do we need the last flush packet? We'd expect as many successes
as we send out contents? Do we plan on interleaving operation, i.e.
Git sends out 10 files but the filter process is not as fast as Git sending
out and the answers trickle in slowly?

>
> In case the filter cannot or does not want to process the content,
> it is expected to respond with an "error" status. Depending on the
> `filter.<driver>.required` flag Git will interpret that as error
> but it will not stop or restart the filter process.
> ------------------------
> packet:          git< status=error\n
> packet:          git< 0000
> ------------------------
>
> In case the filter cannot or does not want to process the content
> as well as any future content for the lifetime of the Git process,
> it is expected to respond with an "error-all" status. Depending on
> the `filter.<driver>.required` flag Git will interpret that as error
> but it will not stop or restart the filter process.
> ------------------------
> packet:          git< status=error-all\n
> packet:          git< 0000
> ------------------------
>
> If the filter experiences an error during processing, then it can
> send the status "error". Depending on the `filter.<driver>.required`
> flag Git will interpret that as error but it will not stop or restart
> the filter process.
> ------------------------
> packet:          git< status=success\n

So the first success is meaningless essentially?
Would it make sense to move the sucess behind the content sending
in all cases?

> packet:          git< 0000
> packet:          git< HALF_WRITTEN_ERRONEOUS_CONTENT
> packet:          git< 0000
> packet:          git< status=error\n
> packet:          git< 0000
> ------------------------
>
> If the filter dies during the communication or does not adhere to
> the protocol then Git will stop the filter process and restart it
> with the next file that needs to be processed.
>
> After the filter has processed a blob it is expected to wait for
> the next "key=value" list containing a command. When the Git process
> terminates, it will send a kill signal to the filter in that stage.
>
> If a `filter.<driver>.clean` or `filter.<driver>.smudge` command
> is configured then these commands always take precedence over
> a configured `filter.<driver>.process` command.

okay. I think you can omit most of the commit message as it is a duplicate
of the documentation?

Instead the commit message can answer questions that are not part of
the documentation. (See the questions above which can be summarized
as "Why do we do it this way and not differently?")


> +       if (err || errno == EPIPE) {
> +               if (!strcmp(filter_status.buf, "error")) {
> +                       /*
> +                    * The filter signaled a problem with the file.
> +                    */

/* This could go into a single line comment. */

> +               } else if (!strcmp(filter_status.buf, "error-all")) {
> +                       /*
> +                        * The filter signaled a permanent problem. Don't try to filter
> +                        * files with the same command for the lifetime of the current
> +                        * Git process.
> +                        */
> +                        entry->supported_capabilities &= ~wanted_capability;
> +               } else {
> +                       /*
> +                        * Something went wrong with the protocol filter.
> +                        * Force shutdown and restart if another blob requires filtering!
> +                        */
> +                       error("external filter '%s' failed", cmd);

failed .. Can you give more information to the user such that they can easier
debug? (blob/path or state / expected state)


> +
>  static int read_convert_config(const char *var, const char *value, void *cb)
>  {
>         const char *key, *name;
> @@ -526,6 +818,10 @@ static int read_convert_config(const char *var, const char *value, void *cb)
>         if (!strcmp("clean", key))
>                 return git_config_string(&drv->clean, var, value);
>
> +       if (!strcmp("process", key)) {
> +               return git_config_string(&drv->process, var, value);
> +       }

optional nit: braces unnecessary

Thanks,
Stefan
