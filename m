Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38B541F859
	for <e@80x24.org>; Sat,  6 Aug 2016 20:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034AbcHFU3h (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 16:29:37 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36669 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223AbcHFU3f (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2016 16:29:35 -0400
Received: by mail-wm0-f68.google.com with SMTP id x83so8733116wma.3
        for <git@vger.kernel.org>; Sat, 06 Aug 2016 13:29:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=G3Dg8Kg+L5dG1c8Nj/uhN9eRykRUvUj5W5HcM8+VA8k=;
        b=NgbaPpCJWGleSEtGOYDuppPMlB2deEVwaxYIX/Ef+Q0TnmPpKSsDhBTYeHgf47JEAF
         k28zi96q8iIw/mY5OoZ7qr4yQglU9Y+gAUc51iMMPcB62tH8E9nrFlRC/PsoPTvQ0fai
         5I+4JVUsnc/b7f6uH25JtZhNHU8QFdHU4GhHoC8JpAzrlkAn3TjcOi4Y/JgJAabyHb8+
         pa/vuT7Zq3Y+1P8Mw6fplWT4jyR57k0xS1XMUIfaci0FMIPMsIjxurOJAZFFblKPsxwn
         4q1xOFrxeVZIZAUEFxbyYwKvVR3TsLvzwAR141xQ8tjtkyi2nuK3PR2PRLO7A+FLnJ+U
         onRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=G3Dg8Kg+L5dG1c8Nj/uhN9eRykRUvUj5W5HcM8+VA8k=;
        b=TgFwcv2+EX4MUOjsTHDJHH6g61p4SFUY/WcoICxzHRlNFz6vDlDfsQh5Ys7kFv1wmG
         UTaXFPBWHxruu+bH0ooXufwY0TH7WInBZX+nh9t1mMb6IGgJ0Q1bfIrnI026D8k7Tc+2
         CDlGhthkoXpSBKqZGa3tsnISlAUaQGjAVZhLgHd6WoxV7gm7u9kpPnm440MnREl7CSXU
         BhnRKQvKDP5okcN/fEPpxjN4h/ONe8Vsr7cdU8qKFc4lO+CbpCHm9jSRvc6tslubwifx
         BFiTVak8KzyH1WoRFALnRTO4d6Lr80nQgQxTJddZfJlE28DOTpWR5XZeshFSdimsEivt
         zgvA==
X-Gm-Message-State: AEkoouumfBsdi0I+Pvo2NZQjdGyWo37NVzA8+YxwSQtyCuWqzJ3VEdsIZsO9SDXURI4xhw==
X-Received: by 10.28.152.5 with SMTP id a5mr8911395wme.76.1470507570466;
        Sat, 06 Aug 2016 11:19:30 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB5C12.dip0.t-ipconnect.de. [93.219.92.18])
        by smtp.gmail.com with ESMTPSA id k3sm24007826wjf.7.2016.08.06.11.19.29
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Aug 2016 11:19:29 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v4 11/12] convert: add filter.<driver>.process option
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20160806121421.bs7n4lhed7phdshb@sigill.intra.peff.net>
Date:	Sat, 6 Aug 2016 20:19:28 +0200
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	mlbright@gmail.com, e@80x24.org
Content-Transfer-Encoding: 7bit
Message-Id: <A07BE78B-5A5D-41F1-A51B-5C71F3E86CCF@gmail.com>
References: <20160729233801.82844-1-larsxschneider@gmail.com> <20160803164225.46355-1-larsxschneider@gmail.com> <20160803164225.46355-12-larsxschneider@gmail.com> <2e13c31c-5ee2-890d-1268-98fb67aba1ea@web.de> <xmqqfuqivpjv.fsf@gitster.mtv.corp.google.com> <20160805222710.chefh5kiktyzketh@sigill.intra.peff.net> <87D4BF17-67BB-4AFA-9B27-40DBB44C0456@gmail.com> <20160806121421.bs7n4lhed7phdshb@sigill.intra.peff.net>
To:	Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 06 Aug 2016, at 14:14, Jeff King <peff@peff.net> wrote:
> 
> On Sat, Aug 06, 2016 at 01:55:23PM +0200, Lars Schneider wrote:
> 
>>> And I expect it makes the lives of the client
>>> easier to get a code up front, before it starts taking steps to handle
>>> what it _thinks_ is probably a valid response.
>> 
>> I am not sure I can follow you here. Which actor are you referring to when
>> you write "client" -- Git, right? If the response is rejected right away
>> then Git just needs to read a single flush. If the response experiences
>> an error only later, then the filter wouldn't know about the error when
>> it starts sending. Therefore I don't see how an error code up front could
>> make it easier for Git.
> 
> Yes, I mean git (I see it as the "client" side of the connection in that
> it is making requests of the filter, which will then provide responses).
> 
> What I mean is that the git code could look something like:
> 
>  status == send_filter_request();
>  if (status == OK) {
> 	prepare_storage();
> 	read_response_into_storage();
>  } else {
> 	complain();
>  }
> 
> But if there's no status up front, then you probably have:
> 
>  send_filter_request();
>  prepare_storage();
>  status = read_response_into_storage();
>  if (status != OK) {
> 	rollback_storage();
> 	complain();
>  }
> 
> In the first case, we could easily avoid preparing the storage if our
> request wasn't going to be filled, whereas in the second we have to do
> it unconditionally. That's not a big deal if preparing the storage is
> initializing a strbuf. It's more so if you're opening a temporary object
> file to stream into.
> 
> You _do_ still have to deal with rollback in the first one (for the case
> that the stream ends prematurely for whatever reason). So it's really a
> question of where and how often we expect the failures to come, and
> whether it is worth git knowing up front that the request is not going
> to be fulfilled.
> 
> I dunno. It's not _that_ big a deal to code around. I was just surprised
> not to see an up-front status when responding to a request. It seems
> like the normal thing in just about every protocol I've ever used.

Alright. The fact that it "surprised" you is a bad sign. 
How about this:

Happy answer:
------------------------
packet:          git< status=accept\n
packet:          git< SMUDGED_CONTENT
packet:          git< 0000
packet:          git< status=success\n
------------------------

Happy answer with no content:
------------------------
packet:          git< status=success\n
------------------------

Rejected content:
------------------------
packet:          git< status=reject\n
------------------------

Error during content response:
------------------------
packet:          git< status=accept\n
packet:          git< HALF_WRITTEN_ERRONEOUS_CONTENT
packet:          git< 0000
packet:          git< status=error\n
------------------------

Cheers,
Lars
