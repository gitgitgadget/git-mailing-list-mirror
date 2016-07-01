Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE0BC2018A
	for <e@80x24.org>; Fri,  1 Jul 2016 19:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbcGATb0 (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 15:31:26 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:35340 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbcGATbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 15:31:25 -0400
Received: by mail-io0-f172.google.com with SMTP id f30so108493600ioj.2
        for <git@vger.kernel.org>; Fri, 01 Jul 2016 12:31:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SJQ86yuCLIaA2aL8xLBLIkYgi21EiVDBfFQz7Jn3qsw=;
        b=UQavcZnWuDYkeXWSWsqxcDz8QzGaFUhKIR4Jzmu5LMRfe3+2Pea9qYByNKxjcJr1z4
         MZEdYhuYgcroLP5nqKqOOKYitF4qQs+VobWFDChnUZvRI0ls59Yl/wrz/49jsCilNfH4
         fPwaykq1IEnEk2zqnlnQe0ohCnjulgSD9jJHosgtifMc4wpC/sezr8ko30H9Howc9hyZ
         Y5QerEa5eLX4NJzcdvGcxHrMhI7idh5m0T+EtTMY4e65K+XG8yn+B8M0su4og0BTYoMI
         FrKBMu0A5LiQoYz5hCjd+u0yuKo3NF9/jrFJ/10DgCn0kHv0jEwpl6zxTSiLPudBsqIk
         f0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SJQ86yuCLIaA2aL8xLBLIkYgi21EiVDBfFQz7Jn3qsw=;
        b=GctpyXDo+X7yxsHT1yuo8XOEV0IOp+Glp5iosgZZ9snr14xva7bCa0+2IGYb80aAxB
         4rmwcPQLp/C/jj11gG1ODMYElPk+j7jkcuMrls4WRpwmFVo3ifxj/+5uXsWSfor096IH
         yqznV6jh59QFmOAT04Wp9EINsLd0aJN2xrNO/cDFkebmghO8JSvLTzzQzERIdVnMHItR
         ZEt/DTKsbAB4CRCb7kJnh5lfZoEqd6LxhNuozIr5MXUcI5NXIWzJ83KHF5HSb1sW9p0h
         mILsb06cU7r9bVG5ODSLOcrh5QSzbhSqo0qW6NlfHHCKOLpQUDPFIXbCrs/TB9Cdoxms
         Dcbw==
X-Gm-Message-State: ALyK8tItAMD7nmJyVln3Cb4K6Xj7R+fUU+bQ+ZkZOfuOsU9wfDTGDjQRJtfoy1nc6+vUO2n8WHJgbz80yafBHvDa
X-Received: by 10.107.144.86 with SMTP id s83mr20269592iod.165.1467401484108;
 Fri, 01 Jul 2016 12:31:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.16 with HTTP; Fri, 1 Jul 2016 12:31:23 -0700 (PDT)
In-Reply-To: <xmqqr3bdxirw.fsf@gitster.mtv.corp.google.com>
References: <20160630005951.7408-1-sbeller@google.com> <20160630005951.7408-2-sbeller@google.com>
 <20160701071410.GG5358@sigill.intra.peff.net> <CAGZ79kaDCLm3BBURJKfkYWKKvozkFTGCn0wGiQCtspUvtQBd+g@mail.gmail.com>
 <20160701175950.GB16235@sigill.intra.peff.net> <CAPc5daWjSW5KM4uUyEBbb+765t50+dUsewF52uPrCiT1HW=NAQ@mail.gmail.com>
 <20160701181102.GA16695@sigill.intra.peff.net> <xmqqr3bdxirw.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Fri, 1 Jul 2016 12:31:23 -0700
Message-ID: <CAGZ79kYB8jej6VMsBACvAG_B-PyWAbe+tBQLXmF2nL8P+zX1KA@mail.gmail.com>
Subject: Re: [PATCH 1/4] push options: {pre,post}-receive hook learns about
 push options
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Dan Wang <dwwang@google.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 1, 2016 at 12:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> Compare to:
>>
>>   if test "$GIT_PUSH_VAR_force" = true
>>      ...
>
> OK.  As this is a new feature, I guess it is not too bad if we tell
> users that they cannot have duplicate keys in their <key,val> data
> they ask Git to transport.  They can do the key1=val1 key2=val2
> numbering themselves if that is really needed.
>

The original use case for us was to send out email on your behalf, so
git push -o CC=user1@domain -o CC=user2@domain would not work well with
this backend approach as the client would already yell at us for duplicate
keys.

Instead that has to be `git push -o CC=user1@domain,user2@domain
and we do need to parse the email addresses apart ourselves.

So currently I'd favor the _COUNT thing and we deliver a reasonable
_COUNT -> key/value parser/translator in the example hook.
