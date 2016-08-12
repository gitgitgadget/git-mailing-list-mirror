Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 450861F859
	for <e@80x24.org>; Fri, 12 Aug 2016 16:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848AbcHLQ7a convert rfc822-to-8bit (ORCPT
	<rfc822;e@80x24.org>); Fri, 12 Aug 2016 12:59:30 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37453 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711AbcHLQ73 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 12:59:29 -0400
Received: by mail-wm0-f46.google.com with SMTP id i5so46292761wmg.0
        for <git@vger.kernel.org>; Fri, 12 Aug 2016 09:59:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=pn3TtR4Nw513SRB65nj7EPFP2kwr0Ks1aEhszxd29PY=;
        b=jijG5ZQ6+F1Ilm+HVzmGvfCOGibyDSxBBqmbngk1E7pO1GfWpj8MRbFcRSDOHukOFx
         yBozQyhADB7GghJWyKjG1zenLhWbEXXN5wP9zX9fAKmyEsi6N15rhF6ES+yUh5FU2QnV
         36smJXcBvv0j6zwFEvLB/7hQi9LhIIY/95k6l2q1F4Etdp2CpLGRT/Gni+ib40chW01H
         w/eI8fKtFlkg2lGbsZWaP86HlBOUfcdamF63fmWnuWTmw5RL9wl0WR8SIhDDns6v+3/Y
         Z48qR0kOjP9UvO2+1g3plaJ7T2j12qYMdwdS/O/vhP7rK066qvnmGmp9zjvneVz55I2D
         WkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=pn3TtR4Nw513SRB65nj7EPFP2kwr0Ks1aEhszxd29PY=;
        b=BFpN2j3yQjDNTCsdZsMZFgmu42E03RdqV6uejHOeJmY7Seza36VOcNvCJk0aWXYTra
         1f8z+RX1lPD6DnZLUA9SGZSM5MPeL9i0aZbghtdgyAO15zCqSRdkn1fj0GoVWEb1woEN
         KXtJP+DvCqxPhbvwlZP1z7I1CrLcb3qhCUaN8nD9wbSyqllQbC/fB0qeMhNXFmJtqV6U
         yQSYw6Jt634lgSPXVO73EyfWjk1fsQklBUOHICIP8UfeGgcPKbYNfSSOOiId+d5bbzmL
         B5/Fb8zZMDIH0Me2x1fQLJ16nUQJ7uKKU+vDV0i65Nz71FyOLw1tGiNtcX39urFZT49K
         DMXw==
X-Gm-Message-State: AEkoouvRMpwm9e4Ta+X/RN3b/gB34FDzaTTzHVOBqAtWxLEJ1oAzlKSHUJEiVG4QUln95g==
X-Received: by 10.28.43.129 with SMTP id r123mr4603063wmr.1.1471021162726;
        Fri, 12 Aug 2016 09:59:22 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id s184sm3357266wmb.11.2016.08.12.09.59.19
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Aug 2016 09:59:19 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 14/15] convert: add filter.<driver>.process option
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAGZ79kboxgBRHSa2s7CKZ1Uo=13WT=rT8VHCNJNj_Q9jQzZAYw@mail.gmail.com>
Date:	Fri, 12 Aug 2016 18:59:18 +0200
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Martin-Louis Bright <mlbright@gmail.com>,
	Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, ben@wijen.net
Content-Transfer-Encoding: 8BIT
Message-Id: <509A907F-B1B5-4244-B1C7-F1190296208D@gmail.com>
References: <20160803164225.46355-1-larsxschneider@gmail.com/> <20160810130411.12419-1-larsxschneider@gmail.com> <20160810130411.12419-15-larsxschneider@gmail.com> <CAGZ79kboxgBRHSa2s7CKZ1Uo=13WT=rT8VHCNJNj_Q9jQzZAYw@mail.gmail.com>
To:	Stefan Beller <sbeller@google.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 12 Aug 2016, at 18:33, Stefan Beller <sbeller@google.com> wrote:
> 
> On Wed, Aug 10, 2016 at 6:04 AM,  <larsxschneider@gmail.com> wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> Git's clean/smudge mechanism invokes an external filter process for every
>> single blob that is affected by a filter. If Git filters a lot of blobs
>> then the startup time of the external filter processes can become a
>> significant part of the overall Git execution time.
>> 
>> In a preliminary performance test this developer used a clean/smudge filter
>> written in golang to filter 12,000 files. This process took 364s with the
>> existing filter mechanism and 5s with the new mechanism. See details here:
>> https://github.com/github/git-lfs/pull/1382
>> 
>> This patch adds the `filter.<driver>.process` string option which, if used,
>> keeps the external filter process running and processes all blobs with
>> the packet format (pkt-line) based protocol over standard input and standard
>> output described below.
>> 
>> Git starts the filter when it encounters the first file
>> that needs to be cleaned or smudged. After the filter started
>> Git sends a welcome message, a list of supported protocol
>> version numbers, and a flush packet. Git expects to read the
>> welcome message and one protocol version number from the
>> previously sent list. Afterwards Git sends a list of supported
>> capabilities and a flush packet. Git expects to read a list of
>> desired capabilities, which must be a subset of the supported
>> capabilities list, and a flush packet as response:
>> ------------------------
>> packet:          git> git-filter-client
>> packet:          git> version=2
>> packet:          git> version=42
>> packet:          git> 0000
>> packet:          git< git-filter-server
>> packet:          git< version=2
> 
> what follows is specific to version=2?
> version 42 may deem capabilities a bad idea?

"version=42" is just an example to show how the initialization could look
like in a distant future when we support even another protocol version.

You are correct, what follows is specific to version=2. I will state
that more clearly in the documentation.

Can you try to rephrase "version 42 may deem capabilities a bad idea?"
I am not sure I understand what you mean.


> 
>> packet:          git> clean=true
>> packet:          git> smudge=true
>> packet:          git> not-yet-invented=true
>> packet:          git> 0000
>> packet:          git< clean=true
>> packet:          git< smudge=true
>> packet:          git< 0000
>> ------------------------
>> Supported filter capabilities in version 2 are "clean" and
>> "smudge".
> 
> I assume version 2 is an example here and we actually start with v1?

No, it is actually called version 2 because I consider the current
clean/smudge protocol version 1.


> Can you clarify why we need welcome messages?
> (Is there a technical reason, or better debuggability for humans?)

The welcome message is necessary to distinguish the long running
filter protocol (v2) from the current one-shot filter protocol (v1).
This is becomes important if a users tries to use a v1 clean/smudge
filter with the v2 git config settings.


>> Afterwards Git sends a list of "key=value" pairs terminated with
>> a flush packet. The list will contain at least the filter command
>> (based on the supported capabilities) and the pathname of the file
>> to filter relative to the repository root. Right after these packets
>> Git sends the content split in zero or more pkt-line packets and a
>> flush packet to terminate content.
>> ------------------------
>> packet:          git> command=smudge\n
>> packet:          git> pathname=path/testfile.dat\n
>> packet:          git> 0000
>> packet:          git> CONTENT
>> packet:          git> 0000
>> ------------------------
>> 
>> The filter is expected to respond with a list of "key=value" pairs
>> terminated with a flush packet. If the filter does not experience
>> problems then the list must contain a "success" status. Right after
>> these packets the filter is expected to send the content in zero
>> or more pkt-line packets and a flush packet at the end. Finally, a
>> second list of "key=value" pairs terminated with a flush packet
>> is expected. The filter can change the status in the second list.
>> ------------------------
>> packet:          git< status=success\n
>> packet:          git< 0000
>> packet:          git< SMUDGED_CONTENT
>> packet:          git< 0000
>> packet:          git< 0000  # empty list!
>> ------------------------
>> 
>> If the result content is empty then the filter is expected to respond
>> with a success status and an empty list.
>> ------------------------
>> packet:          git< status=success\n
>> packet:          git< 0000
>> packet:          git< 0000  # empty content!
>> packet:          git< 0000  # empty list!
>> ------------------------
> 
> Why do we need the last flush packet? We'd expect as many successes
> as we send out contents? Do we plan on interleaving operation, i.e.
> Git sends out 10 files but the filter process is not as fast as Git sending
> out and the answers trickle in slowly?

Git filter processes run sequentially right now (unfortunately).

re flush: please see Peff's answer:
http://public-inbox.org/git/20160812163809.3wdkuqegxfjam2yn%40sigill.intra.peff.net/


>> In case the filter cannot or does not want to process the content,
>> it is expected to respond with an "error" status. Depending on the
>> `filter.<driver>.required` flag Git will interpret that as error
>> but it will not stop or restart the filter process.
>> ------------------------
>> packet:          git< status=error\n
>> packet:          git< 0000
>> ------------------------
>> 
>> In case the filter cannot or does not want to process the content
>> as well as any future content for the lifetime of the Git process,
>> it is expected to respond with an "error-all" status. Depending on
>> the `filter.<driver>.required` flag Git will interpret that as error
>> but it will not stop or restart the filter process.
>> ------------------------
>> packet:          git< status=error-all\n
>> packet:          git< 0000
>> ------------------------
>> 
>> If the filter experiences an error during processing, then it can
>> send the status "error". Depending on the `filter.<driver>.required`
>> flag Git will interpret that as error but it will not stop or restart
>> the filter process.
>> ------------------------
>> packet:          git< status=success\n
> 
> So the first success is meaningless essentially?
> Would it make sense to move the sucess behind the content sending
> in all cases?

Again, I refer to Peff's answer.


>> packet:          git< 0000
>> packet:          git< HALF_WRITTEN_ERRONEOUS_CONTENT
>> packet:          git< 0000
>> packet:          git< status=error\n
>> packet:          git< 0000
>> ------------------------
>> 
>> If the filter dies during the communication or does not adhere to
>> the protocol then Git will stop the filter process and restart it
>> with the next file that needs to be processed.
>> 
>> After the filter has processed a blob it is expected to wait for
>> the next "key=value" list containing a command. When the Git process
>> terminates, it will send a kill signal to the filter in that stage.
>> 
>> If a `filter.<driver>.clean` or `filter.<driver>.smudge` command
>> is configured then these commands always take precedence over
>> a configured `filter.<driver>.process` command.
> 
> okay. I think you can omit most of the commit message as it is a duplicate
> of the documentation?

Yes it duplicates the documentation. 


> Instead the commit message can answer questions that are not part of
> the documentation. (See the questions above which can be summarized
> as "Why do we do it this way and not differently?")

OK, point taken. I will write a new commit message for v6.


> 
>> +       if (err || errno == EPIPE) {
>> +               if (!strcmp(filter_status.buf, "error")) {
>> +                       /*
>> +                    * The filter signaled a problem with the file.
>> +                    */
> 
> /* This could go into a single line comment. */

OK, will change.


>> +               } else if (!strcmp(filter_status.buf, "error-all")) {
>> +                       /*
>> +                        * The filter signaled a permanent problem. Don't try to filter
>> +                        * files with the same command for the lifetime of the current
>> +                        * Git process.
>> +                        */
>> +                        entry->supported_capabilities &= ~wanted_capability;
>> +               } else {
>> +                       /*
>> +                        * Something went wrong with the protocol filter.
>> +                        * Force shutdown and restart if another blob requires filtering!
>> +                        */
>> +                       error("external filter '%s' failed", cmd);
> 
> failed .. Can you give more information to the user such that they can easier
> debug? (blob/path or state / expected state)

Agreed, will add!
However, we don't give this information with the current clean/smudge interface.


>> +
>> static int read_convert_config(const char *var, const char *value, void *cb)
>> {
>>        const char *key, *name;
>> @@ -526,6 +818,10 @@ static int read_convert_config(const char *var, const char *value, void *cb)
>>        if (!strcmp("clean", key))
>>                return git_config_string(&drv->clean, var, value);
>> 
>> +       if (!strcmp("process", key)) {
>> +               return git_config_string(&drv->process, var, value);
>> +       }
> 
> optional nit: braces unnecessary

Agreed, will remove!


Thanks a lot for the review,
Lars