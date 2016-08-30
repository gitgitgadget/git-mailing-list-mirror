Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AFEF1FD99
	for <e@80x24.org>; Tue, 30 Aug 2016 06:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752320AbcH3GXz (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 02:23:55 -0400
Received: from mail-yb0-f176.google.com ([209.85.213.176]:32924 "EHLO
        mail-yb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751966AbcH3GXy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 02:23:54 -0400
Received: by mail-yb0-f176.google.com with SMTP id a7so3211711ybi.0
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 23:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=s3bv7wx1lz40HIEPP1HUsyNwQsLIj9m5LLGmIh6/Abo=;
        b=T2wER/UD2MO2xn9PCaaqaxzcDWUBU4YdRZsbL2mlvKPGGl4BX3y6anoo9GKULMRkWJ
         7kR9aAUldOJ5WJEaO7VUT05wBuVg828BlAOMnSykXiZV8PpTDYJjaGMgG39hjg25TfWL
         B8BHdQvTvfEQLSRhtoCMgw893W8LdurJ+hkGJ5ace+qi4LxkIxMLSuSWdgNh8dRTPn4J
         QcuhcUwWishxgReArEUXdRLHHckNL+tz/fCvSpUT4fwxk8/9txQisEZIGVsFjfHF4Wv6
         zYdNwZIBUiZeuOvTsiUp88SVmVwLVBq4BqgMsTcWd/Mu2WJE7DN2t9c5UR2SvZvaU2Cy
         SEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=s3bv7wx1lz40HIEPP1HUsyNwQsLIj9m5LLGmIh6/Abo=;
        b=Tv+cDgsaCrAdNJfK6frS237V94Xvlzs1YpNjI2/AKQsRFkZiyRDT8PaTr6aQA+/p19
         LQJoCKc2AfurFawvIVpz8F7mdpyMQvDKE5h41V1YXNDVgFfG1sz4oqmp3jH3Ctkw2rkf
         OIt8T++gwQY6xHEGFuI4nChxluAIRdtx2JX2MnYcAI5k5f7g37KxNtLjZ2S5Is44Ut+P
         dlixuZC+ucPjIVCKTsHMd/lq1WCRo7mkPVfCZm+AkejoUOPzNde830cxL0iQyacnXsrB
         ot5tL5kOH1AulRAuS0Shii2pHKX/J7IxfGg6G5MoJtCQcZVTWo5DN9x68/baA00wMrQB
         DOmA==
X-Gm-Message-State: AE9vXwPY/t0ikVJvak+g9Q0Tui383vkegARhVqYejNr6bm1ylCy7dBuD0Du4eZxBRcm6mZcxgEagsXRnXKiLSw==
X-Received: by 10.37.60.67 with SMTP id j64mr1627844yba.111.1472538233709;
 Mon, 29 Aug 2016 23:23:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Mon, 29 Aug 2016 23:23:33 -0700 (PDT)
In-Reply-To: <CA+P7+xohfRsoV9VXgUrRaXPb9HvCc5gs4-KSWp38X_d_6EfkTA@mail.gmail.com>
References: <CAN5XQftQH8B+hWVh4JQgZwAp+rkbz51P5NZDc_+Tfm0EB1zkew@mail.gmail.com>
 <xmqqlgzf9wch.fsf@gitster.mtv.corp.google.com> <CAN5XQft6S+LG0mBgRFPrMZiOxHSfRhjLmQdeMdBeHKoWQSRUEA@mail.gmail.com>
 <CAPc5daVhY6WdHkXGLYea48uOw0-rTzLLZ=7mNo=VPebZ9AG4jQ@mail.gmail.com>
 <CAN5XQfty6Fshzf6kN7eXhFekU9+=VPwbzEPN1a92yVB=9nm0Vg@mail.gmail.com>
 <CAN5XQfsg_sJbyjfdc=-e85jiCQNUqagwgh6TVOXN+NskZ7KkVw@mail.gmail.com>
 <xmqqbn0b6ua8.fsf@gitster.mtv.corp.google.com> <CA+P7+xosGg955msq-gyKz_HyCZf7fPFQJdKZ3P8U3+poBBfuWA@mail.gmail.com>
 <CAN5XQfsv+BEYDWR6Xjs4mCtYDVR12a2UzB1-_H4A_xfjUUOe2g@mail.gmail.com> <CA+P7+xohfRsoV9VXgUrRaXPb9HvCc5gs4-KSWp38X_d_6EfkTA@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 29 Aug 2016 23:23:33 -0700
Message-ID: <CA+P7+xpGnsKzBPLVgPNSmZ7K00vY7-eJp7kSHWMRHM+cOsL_XQ@mail.gmail.com>
Subject: Re: git submodules implementation question
To:     Uma Srinivasan <usrinivasan@twitter.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 29, 2016 at 11:09 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Mon, Aug 29, 2016 at 5:12 PM, Uma Srinivasan <usrinivasan@twitter.com> wrote:
>> This is great! Thanks Jake. If you happen to have the patch ID it
>> would be helpful.
>>
>> Uma
>>
>
> http://public-inbox.org/git/1472236108.28343.5.camel@intel.com/


Actually correct patch is
http://public-inbox.org/git/20160825233243.30700-6-jacob.e.keller@intel.com/

Thanks,
Jake
