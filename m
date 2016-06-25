Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82B0F1FEAA
	for <e@80x24.org>; Sat, 25 Jun 2016 14:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbcFYOQE (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 10:16:04 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:32800 "EHLO
	mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbcFYOQD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Jun 2016 10:16:03 -0400
Received: by mail-it0-f66.google.com with SMTP id y93so5639269ita.0
        for <git@vger.kernel.org>; Sat, 25 Jun 2016 07:16:02 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=apClHiVG2QllXUfqfyvtRoolLh7tPo2ESBvd4e36ATc=;
        b=IUsrjOCX7XE+3zwJK3s0uf5dv11P8qlp0zSNqOIIMNlJrf6BC1VZlHbg6Q6E8tCIK4
         Wwe6JfUzIk5E8tciMuw1j4Bz/ouHJsKq2Eujd8cfzMdIVkfnF0gRIuFwpvooqMbsTdBx
         tI0dazPsyWRl0HeHdHB8d4PV/t41sH/A9tPfmx3JrT3vBI4XHQdDkl7QzHB1o2wGpHey
         UUjRXmQtCyDAaXaKIJ263TmJRSyzb0D1qc1DJgpvKPulOaVX/im7X2CbywcUEBQTm1Zg
         FhykpDAUuO1vQLE6A0AxkROkRjmtm4uVXVq7yPrsZ26Uns8TKLy3dx9UpirUs5l4WBzp
         TQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=apClHiVG2QllXUfqfyvtRoolLh7tPo2ESBvd4e36ATc=;
        b=IP/Ttxzo9HbwoQ3Dmi8eUu+8YUjuzDRNa+tnRXiuDn5G3j45rILcE6ock+6YzKjJpx
         YhnnfJiJLgjYrOqOgZAN97Hb2t7v/BgTtQ7qvOMMcQwnUauUYIjVgfs7lG8LJ4R3ENf4
         Br1Eaom4QOn2TRIZuFwy2z4kf870HV/i9o1N50sFJ20EJnVMfFTw2HAh3GoeBq5OClfD
         85eyk5V+p4FO1Gv3Hoq9upsr7whnKX/xE4zTPYWgT0dDxax9qkdru7xngyY1bvZ/toXG
         z6W/TelzQGBaVTouhUnCWumqt70bZH2lzc8ljn9YuuVYclS34pckRBD4qxVd7y4wtht9
         9stA==
X-Gm-Message-State: ALyK8tKwEm5Glt4VcGRrAeHPz0wEr3iPK3LFhiPhdPZ/HmmNLvIeEMnMgxCiEK7BieorbKZacIo8ro44Zi9rYw==
X-Received: by 10.36.43.5 with SMTP id h5mr2483252ita.57.1466864162260; Sat,
 25 Jun 2016 07:16:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Sat, 25 Jun 2016 07:15:32 -0700 (PDT)
In-Reply-To: <CAP8UFD0RAgUmKr4tG7xHcz75vpXAeuWi9t1+9mvbGOVzOcHcFA@mail.gmail.com>
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
 <1463694357-6503-5-git-send-email-dturner@twopensource.com> <CAP8UFD0RAgUmKr4tG7xHcz75vpXAeuWi9t1+9mvbGOVzOcHcFA@mail.gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sat, 25 Jun 2016 16:15:32 +0200
Message-ID: <CACsJy8A6C8i_XbXRRBBmT5iqq=mSovVGhFqe0d9WroyMVKf5RA@mail.gmail.com>
Subject: Re: [PATCH v12 04/20] index-helper: new daemon for caching index and
 related stuff
To:	Christian Couder <christian.couder@gmail.com>
Cc:	git <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jun 17, 2016 at 6:43 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Thu, May 19, 2016 at 11:45 PM, David Turner <dturner@twopensource.com> wrote:
>> From: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
>>
>> +static void loop(int fd, int idle_in_seconds)
>> +{
>> +       assert(idle_in_seconds < INT_MAX / 1000);
>
> This assert may not be very nice to users setting the value using --exit-after.

Yeah. We could catch this after parsing --exit-after (and before
forking to background, losing stderr) for invalid values and forget
about this assert.
-- 
Duy
