Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9BA02018E
	for <e@80x24.org>; Tue,  9 Aug 2016 05:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752445AbcHIFYH (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 01:24:07 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:34157 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436AbcHIFYG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 01:24:06 -0400
Received: by mail-yw0-f172.google.com with SMTP id z8so1365776ywa.1
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 22:24:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CAOfxF4dNLZZrH/EARhLf6O7Yy7TH1PLc2jpy+Cx7Rg=;
        b=LWNqJZlkvXQu8xKyTHNSc1wyaWUg2SyF8rpEDWlM1mhtYRfnZafWrI2LfoK6zG6OlF
         j/Uiz8ET/W+7HdVk3137WEvS2NXrFcvyinpTXNX/19rtOOviU/GuZc+vom2tpVmryoIf
         0BSGwuFc/yusmnOEpaKOCFsia64Q/Vgxz2DoroHexqrGC/oOcdH8CzN7On/TnAMZfuWh
         gZDqWcs1TQPJzm2S7JLnc7Ymfjcb7PfoWsA6iC8uh+PipSdTjBD1Dpw/IWwB/se91lOB
         nczun5+vi6cWxByzYANZO2SS4r7aqjZFdawvGAb8gka51IETJ5/3aw0Ouc6x+gRih10h
         y6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CAOfxF4dNLZZrH/EARhLf6O7Yy7TH1PLc2jpy+Cx7Rg=;
        b=XFCeLEORpbu64LYy+kVwPTdClBpMvM+MS/g15bgDhU5G06gwcz+oVW9TwL+Z223lw3
         pcxORkSWNCTatx7xZocx6KkU9l6eKYu8RycVslk0E5Rp7oSs4PatbDdKa2mIq9SDwp4B
         iVWNyaZXNeivfTYkeBffn2CnmUxKmSOuHMYPXJbwY8/aCtbMUHOkzaE4A20Eym8wjnC9
         GL7qmff6mazZRDV9qVjeLrm4aQ+0f5TaornjmaaZ0HjmMk0WtHFMrsliybPlJgAATTlf
         6gQh6yqfgPigbnYujSxjMjvDrVVh2VI7lV+SrOlbAb1HhzAMnvhGo/vO+9ofNQgV7ta5
         8WNg==
X-Gm-Message-State: AEkoout+FEczcsrFSsQVcsDB9eaDnN8jp0BLdhLmtgUHnUql7dZiUpLwa/vG13zuqeJpckHN+iSwFBHIegDxDg==
X-Received: by 10.129.135.2 with SMTP id x2mr43674542ywf.310.1470720245237;
 Mon, 08 Aug 2016 22:24:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.196 with HTTP; Mon, 8 Aug 2016 22:23:44 -0700 (PDT)
In-Reply-To: <20160809040811.21408-1-sbeller@google.com>
References: <20160809040811.21408-1-sbeller@google.com>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Mon, 8 Aug 2016 22:23:44 -0700
Message-ID: <CA+P7+xpHBkAHU7bAGHN4Hy1SnNS16zAg8XnFjzPY1CBKZV1s1Q@mail.gmail.com>
Subject: Re: [PATCHv2 0/6] git clone: Marry --recursive and --reference
To:	Stefan Beller <sbeller@google.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, mst@redhat.com
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 8, 2016 at 9:08 PM, Stefan Beller <sbeller@google.com> wrote:
>
> v3:
>
> Thanks to Junios critial questions regarding the design, I took a step back
> to look at the bigger picture.
>
> --super-reference sounds confusing. (what is the super referring to?)
> So drop that approach.
>
> Instead we'll compute where the reference might be in the superproject scope
> and ask the submodule clone operation to consider an optional reference.
> If the referenced alternate is not there, we'll just warn about it and
> carry on.
>

This makes a lot more sense to me, and being able to use
"reference-if-able" for regular clones may be a useful addition as
well.

I looked over the other patches and didn't see anything obviously
wrong, but take that with a grain of salt as I didn't spend a lot of
time at it.

Thanks,
Jake
