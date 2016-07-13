Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D66220196
	for <e@80x24.org>; Wed, 13 Jul 2016 17:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698AbcGMRzx (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 13:55:53 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:33403 "EHLO
	mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752396AbcGMRzs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 13:55:48 -0400
Received: by mail-yw0-f181.google.com with SMTP id j17so51012650ywg.0
        for <git@vger.kernel.org>; Wed, 13 Jul 2016 10:55:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ws8zNaufXxgZjhQhcJ6jnknJ0/ddOL3H8cOwy4ZGlIk=;
        b=If8IlfE8IBUPQ/mHxSn4sCj2V7BNlQd5AqkB6SwfxWyfeolVuVstymuYZ/+NT+Ar2g
         zJqTiYXkThf1MLLJQWMV/G3LGn3556FkwkVz2M/p3/647LctevO62GkkWSNFKcSSEiEe
         VrUkztTTszj+4ik3A4WKfpKVHALyoKW8b9suRP2SKHivlZv08By9BlxRxHMlgHJPcJ1c
         3TeLiCozlhF9gm72sd2Tfdmw28BczHujtPcNJH02ywwIRDtpZ1hHDPpCLIIfni+l1lOq
         da29t9fw8kH/cGQBMqPnm+ywLW98+4MiW8oFgLWheWR/BLZyxvlSgae5nyOVZInKZImw
         WBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ws8zNaufXxgZjhQhcJ6jnknJ0/ddOL3H8cOwy4ZGlIk=;
        b=KuRsJOyyKdJIXnYmVs9F4Bp5u0eEgSpyPxJeJJTlQsK+K0a8Pb2pflxr8QnB32Ntpu
         TFMXKdTxcKKIhOcxQB2qhd3X06h3PpRYsJDWMltOZSQeRxOkDvoC3eac6Lla6NfCuoPZ
         zU5sJduTXW88taW/07ApQ6ZjrgD0GLIcgvfqv65aw9sicr9pfDm//6KmFVq5FlsGw04B
         1sZasWFmV63MBojRvwKngz8Z74PRgjE522WnngP4rhElG+xRkhLSLCNbLTTra6LHftHj
         qTHGF6bs9SnoJleB4MstHm1mrcqPOSJA8vc6IS7t6qiBLXlflSqpqhrC783Q7MLuU+Wa
         Y/9A==
X-Gm-Message-State: ALyK8tKsq8RRvxCge/UlmWnkqO8iE4x+3A3rlNUpupHSdUkUakoO3bUR7O6mjX05wA429zaV7tPpdBHxXdrZug==
X-Received: by 10.129.94.133 with SMTP id s127mr7117470ywb.69.1468432542479;
 Wed, 13 Jul 2016 10:55:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.240.66 with HTTP; Wed, 13 Jul 2016 10:55:23 -0700 (PDT)
In-Reply-To: <CAGZ79kYUMX7wewo2QEWQGU9sGR76XjrKJ3uJxpLnyWoZeZ6WXA@mail.gmail.com>
References: <xmqqy4551nph.fsf@gitster.mtv.corp.google.com> <CAGZ79kY7pWUG7Q0fDhieHCBCpR5RCongzHth6DWOJaEkcGqMEA@mail.gmail.com>
 <xmqqpoqh1m0o.fsf@gitster.mtv.corp.google.com> <CAGZ79kYUMX7wewo2QEWQGU9sGR76XjrKJ3uJxpLnyWoZeZ6WXA@mail.gmail.com>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Wed, 13 Jul 2016 10:55:23 -0700
X-Google-Sender-Auth: mP4dzNVAQQECcHTcgZChdM52gGk
Message-ID: <CAPc5daU1eD5DVqO0A9LZ=UyZMOoO2RfHk8Lm48Oy0-26q+1Lhg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2016, #05; Wed, 13)
To:	Stefan Beller <sbeller@google.com>
Cc:	Shawn Pearce <sop@google.com>, Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 13, 2016 at 10:52 AM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Jul 13, 2016 at 10:32 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>>> * sb/push-options (2016-07-12) 5 commits
>>>>  - add a test for push options
>>>>  - push: accept push options
>>>>  - SQUASH???
>>>
>>> Squash? I do not find a squashable commit in what you pushed,
>>> do you intend to squash the first 2 patches instead?
>
> Oh I pulled a few minutes before you sent this email, and forgot
> that you likely have pushed again when sending this email. :/

There were no multiple pushes involved.

I prepare what is to be pushed out, update the what's cooking report,
push and then send out the what's cooking report (which also is on
the 'todo' branch).

But there is this thing called propagation delay ;-)
