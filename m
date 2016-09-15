Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C5802070F
	for <e@80x24.org>; Thu, 15 Sep 2016 20:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754485AbcIOUTX (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 16:19:23 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37836 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbcIOUTV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 16:19:21 -0400
Received: by mail-wm0-f44.google.com with SMTP id k186so4306264wmd.0
        for <git@vger.kernel.org>; Thu, 15 Sep 2016 13:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5QqJqNfJBHNR6Pshg392ms2/8EEs+4oUFYOl70KA0RY=;
        b=Bq2Ou/gK0wHqVEBvkm93YNK66NjV2hUqJbHNfO2rD4/ngfhkJoTdVDIlIvW6YNFHXd
         x+GF60pFkHBREL0tzoWCpK+NI6868OtXvSG3OksguoBAcqdcqJFYOoV9gN6VnG/ptSXG
         KUmJAtriFIplzAwdPwqXlGqW+UBLzy+pN77CmzBFgHinyJuFSeOj1erncOkmaloxBQEm
         FRu7DO0ppsmjXc3qSBJiPow7ENGrz1HHy8nJYZJAzpB6H/E1bGnKRwKWd4ZGN3EJ4G3W
         C8Rk/SYmHk3Yt6KAdcmYmDdnw0vKZ7pdqLtiBnSrUd9GNdl57g2480pNzKoNo+vW6X4k
         M4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5QqJqNfJBHNR6Pshg392ms2/8EEs+4oUFYOl70KA0RY=;
        b=JOY6KMWXmpf96UCD3VGgrQbtG9rWOg17KolctDDpswPphVzoRSlNOKV+dkq1a2D5bL
         lJOgWa6w7Xh1vw+vI54tdtSAz8PuYzkjwgAccT+HKBDlddY2T8Cf0h53tx2MfP5kjp99
         CCB9daVcya/T8Mbe9tW0rYflng0rTkCCXRNxLNXv1AvbHSQQdQjOWon895hyBSLO809W
         UwHT+WZ7dCu86bZFXsNilvFW8Iv4e83TjcXEep0bs5RybAPnE3lnDX2tSvS6yOPS45RQ
         H51t74AMqP1+pcl4wqXO/PXylKhm0WvCtgJn1BUboGQo5BfGRPIPV/otEnsUC158QGWr
         2ypA==
X-Gm-Message-State: AE9vXwP0geZsJXffYiDDRIKnlmIhQD+XAnWd1MlY/jl88Tes5xhp8lW0ldWUe1eKjzzmzA==
X-Received: by 10.28.135.129 with SMTP id j123mr4751215wmd.110.1473970760035;
        Thu, 15 Sep 2016 13:19:20 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB61FE.dip0.t-ipconnect.de. [93.219.97.254])
        by smtp.gmail.com with ESMTPSA id i195sm3981617wmg.14.2016.09.15.13.19.18
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Sep 2016 13:19:19 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v7 04/10] pkt-line: add packet_flush_gently()
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20160915194443.x7zvkkryvworqcxt@sigill.intra.peff.net>
Date:   Thu, 15 Sep 2016 22:19:19 +0200
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com,
        tboegi@web.de, jacob.keller@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <744FA3D5-888A-4032-90C4-6BFC7D5D4010@gmail.com>
References: <20160908182132.50788-1-larsxschneider@gmail.com> <20160908182132.50788-5-larsxschneider@gmail.com> <xmqqinu0y9v1.fsf@gitster.mtv.corp.google.com> <B138B703-08A6-45C4-9D54-80F87C75356B@gmail.com> <xmqq37l3v2rk.fsf@gitster.mtv.corp.google.com> <385016D3-8298-4273-81E7-876CB25B2789@gmail.com> <20160915194443.x7zvkkryvworqcxt@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 15 Sep 2016, at 21:44, Jeff King <peff@peff.net> wrote:
> 
> On Thu, Sep 15, 2016 at 05:42:58PM +0100, Lars Schneider wrote:
> 
>>>>>> +int packet_flush_gently(int fd)
>>>>>> +{
>>>>>> +	packet_trace("0000", 4, 1);
>>>>>> +	if (write_in_full(fd, "0000", 4) == 4)
>>>>>> +		return 0;
>>>>>> +	error("flush packet write failed");
>>>>>> +	return -1;
>> [...]
>>>>> I suspect that it is a strong sign that the caller wants to be in
>>>>> control of when and what error message is produced; otherwise it
>>>>> wouldn't be calling the _gently() variant, no?
>>>> 
>>>> Agreed!
>>> 
>>> I am also OK with the current form, too.  Those who need to enhance
>>> it to packet_flush_gently(int fd, int quiet) can come later.
>> 
>> "caller wants to be in control [...] otherwise it wouldn't be calling 
>> the _gently() variant" convinced me. I would like to change it like
>> this:
>> 
>> 	trace_printf_key(&trace_packet, "flush packet write failed");
>> 	return -1;
>> 
>> Objections?
> 
> I'm not sure that a trace makes sense, because it means that 99% of the
> time we are silent. AFAICT, the question is not "sometimes the user
> needs to see an error and sometimes not, and they should decide before
> starting the program". It is "sometimes the caller will report the error
> to the user as appropriate, and sometimes we need to do so". And only
> the calling code knows which is which.
> 
> So the "right" pattern is either:
> 
>  1. Return -1 and the caller is responsible for telling the user.
> 
> or
> 
>  2. Return -1 and stuff the error into an error strbuf, so it can be
>     passed up the call chain easily (and callers do not have to come up
>     with their own wording).
> 
> But if all current callers would just call error() themselves anyway,
> then it's OK to punt on this and let somebody else handle it later if
> they add a new caller who wants different behavior (and that is what
> Junio was saying above, I think).

OK. I'll go with 1. then.

Thanks,
Lars
