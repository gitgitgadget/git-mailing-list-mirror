Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D85ED206FB
	for <e@80x24.org>; Fri,  8 Jul 2016 22:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756279AbcGHWRR (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 18:17:17 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:35739 "EHLO
	mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755939AbcGHWRP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 18:17:15 -0400
Received: by mail-it0-f42.google.com with SMTP id u186so20055111ita.0
        for <git@vger.kernel.org>; Fri, 08 Jul 2016 15:17:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ROYYbQ3BYTd7njDFDWvQPGt5LQ2oIgm2WNuBLuja/Ns=;
        b=kvanpyouQdMQsY1SaxFPcvCfnCcWncuyrnpBd81ZZXSFwFsortH3fF5zRRAeyxOgd0
         +5gySXEs95Oorssv4mQaW9wTO9JEvXvocrwgh321//pcRtDcnU/YsIlqSDRj5vZ0UDFF
         JKlxLDacnH/mvn3hYD0uwf+7CTtURThQY96ATJ20HIxitph0UhfD30Svhj4qxztxnyB0
         7/xwnkrQ+539A5Dnz0z4rRawIV3HRh6mqbD7YbIfksJwhtyOuTxJThI4SPg7I8DkAxgc
         lqZxaJ7PhA/F/Z0jUZ4VUBa4NkpfhiA8NTBzIy5V64FA77Sz2PsCsi6T3Jbf3bZsXPNK
         0Mxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ROYYbQ3BYTd7njDFDWvQPGt5LQ2oIgm2WNuBLuja/Ns=;
        b=WVkSW3b/BP8JAfVXNeSsMgNrPIcLGGF3jRNT1tc/5Oq2lXlL6IWjW7mI9Rgk6wcno3
         FH1UH49ZcZ9FuEBHYGSx6+zNVHcrN2rRYH5Nxf1ZYcdBOICg/1fSzwGiW7y9dvmVwnJ+
         x0AUTkQUJdMY7pXEQrwMyMcqHtLsPp2dgo/yBGkNwZSXnaVvK3D4g/rNAoeTigN0jQ+D
         u4cWvVGh3q/vP2xe8miblzIQzpXCH3ULmgeUPgNk8Ud6uZ5ES3kUp/z1v8yiHrBYW4GX
         n8Lt5o79FzrURNqCHyRo+5PnL1xV6iTh1by0N7qdsbpNjCM3zzoGN4rKbl73BoSohRmp
         eMYA==
X-Gm-Message-State: ALyK8tIrSask1sDR3uX1l7fc1ZdYbI/AxvveUIo8sjTlzrA9Vbwlw4KkKRU9EqrVl/+xl+krv2wSQ2agfwsDvKla
X-Received: by 10.36.69.4 with SMTP id y4mr780519ita.49.1468016234496; Fri, 08
 Jul 2016 15:17:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.16 with HTTP; Fri, 8 Jul 2016 15:17:13 -0700 (PDT)
In-Reply-To: <20160708214637.GB9820@sigill.intra.peff.net>
References: <20160707011218.3690-1-sbeller@google.com> <20160707011218.3690-3-sbeller@google.com>
 <xmqqa8htp4kc.fsf@gitster.mtv.corp.google.com> <CAGZ79kbkv5P0wP2kKt9gzmZBe1DjLSB8JpZD66DT_Xd4NKqmKQ@mail.gmail.com>
 <xmqqh9c1nlvm.fsf@gitster.mtv.corp.google.com> <20160708175821.GA29326@google.com>
 <xmqqshvkkm86.fsf@gitster.mtv.corp.google.com> <CAGZ79ka8eHOx28Ja+S6DOGEOrV_ijUvi_NnjprhuzQ+3O9BAoQ@mail.gmail.com>
 <20160708214637.GB9820@sigill.intra.peff.net>
From:	Stefan Beller <sbeller@google.com>
Date:	Fri, 8 Jul 2016 15:17:13 -0700
Message-ID: <CAGZ79kZOdcJwd0ePMquhfJTv=xZGP_+w4BRV=GyTy3ejb79yrQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] receive-pack: implement advertising and receiving
 push options
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Eric Wong <e@80x24.org>, Dan Wang <dwwang@google.com>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 8, 2016 at 2:46 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Jul 08, 2016 at 11:57:20AM -0700, Stefan Beller wrote:
>
>> >> Sorry to butt into the conversation late, but: I am not yet convinced.
>> >>
>> >> Is the idea that if the push options were very large, this would save
>> >> the client from the cost of sending them?
>> >
>> > Not really.  I have no strong opinion on the benefit of limiting
>> > number/size.  Stefan limited the number/size at the receiving end
>> > and made receiving end die with its message.
>>
>> Jeff claimed we'd need some sort of DoS protection for this feature,
>> so I considered just die-ing enough for an initial implementation.
>
> I do not think we need to worry too much about niceties for these
> limits. The point is to protect servers from malicious nonsense, like
> somebody sending gigabytes of push options, or trying to overflow a
> buffer in a hook with a large value.

Agreed. This would speak for keeping the implementation as is.

>If people are seeing these in
> routine use, then the limits are set too low, and this should happen
> roughly as often as a BUG assertion, and IMHO should be treated roughly
> the same: don't bother with translation, and don't worry about
> optimizing wasted bandwidth for this case. It won't happen enough to
> matter.

Well the wasted band width is part of the server protection, no?
This would favor the idea Jonathan came up with:

    server: I advertise push options
    client: ok I want to use push options
    client: I'll send you 1000 push options with upper bound of 1000M
    server: It's a bit too much, eh?
    * server quits

So this case only occurs for the (malicious?) corner case, where I
do not bother a translation.

But having the size announcement not in
the capability advertisement, but in the actual push options phase makes
sense to me as we do not want to clutter the capabilities with data that can
come later. We would only waste a little bit of band width, (the
initial ls-remote
and command list of the client).


Speaking of this, I can craft a malicious client that sends the
following command list

0000000000000000000000000000000000000000
0000000000000000000000000000000000000000
refs/heads/loooooooooooooooooong-ref
0000000000000000000000000000000000000000
0000000000000000000000000000000000000000
refs/heads/loooooooooooooooooong-ref
0000000000000000000000000000000000000000
0000000000000000000000000000000000000000
refs/heads/loooooooooooooooooong-ref
0000000000000000000000000000000000000000
0000000000000000000000000000000000000000
refs/heads/loooooooooooooooooong-ref
0000000000000000000000000000000000000000
0000000000000000000000000000000000000000
refs/heads/loooooooooooooooooong-ref
<repeat the above a few times>
0000

IIUC in the receive-pack code we would queue that up and the error checking
(two times null sha1? update of the same ref more than once?), is
done just after we send out the flush packet, i.e. when all commands
are received.

This would also result in sending gigabytes of junk as well as a
memory issue on the server
side?

The new push options design is actually neat in the way that the
client exactly says what it wants
and the server can reject early, but not cluttering the capability
advertisement.

Thanks,
Stefan
