Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43D10200B9
	for <e@80x24.org>; Sat,  5 May 2018 15:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751327AbeEEPx0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 11:53:26 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:52751 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbeEEPxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 11:53:25 -0400
Received: by mail-it0-f41.google.com with SMTP id y189-v6so798860itb.2
        for <git@vger.kernel.org>; Sat, 05 May 2018 08:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DbhkO5gwUMkJhEkUMoUgOfPJcifzzGXpr5MhrvjKUXI=;
        b=LZ/903wblAgw0O3n+JzlnobxS6D2Yny/jjclQRNQNGQwmVHAZQFPs7PF/lIHKEGrpQ
         7eRWNY7uROlzXuJCRWSgKJyFq+T7onBsdSPQLJ8SqpcYN81PoyP6tUaOGLYIEk9ayviQ
         btB2+57D4wJ6hrQbqtgb0bMFMEUwp1D6ejGGolTSZKpRQKfw8hQiPqRHJ7AT1wB9hlBL
         vSZW27aFxGJc85UIWAl2ZPfR3Fx7ijITR+yozchClpJQHadOdq2yv8kSZCDEFHntVgyh
         tv+rs3YMNVucih4Wm4mXHge27flKgIzu46ofQr408IL8oEiEbfqmyYhC76MN6e9KfvQH
         idnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DbhkO5gwUMkJhEkUMoUgOfPJcifzzGXpr5MhrvjKUXI=;
        b=giUYCxuGFNlHpH2SIAlahVM3ZSflJd5bWwllmLVlK95Mf4exIkA36b2MuILhMlKs2R
         Ju/BT2y+L59MmlCZcH+CgkyzbuCI+4va9mVZevO+kwJT1r+pv5VGyy/RxWLXj78krmdL
         30aWaj19M2xUyBViQ9OKYyVzxZz401BgEP2rCid8OQNZ2HDc2H3UNPBk9WrEzvVPLfNR
         JsK5PVn9Oacp1j5FikOXAINGxDAiqRvFB1n5tUVqIpwwdOWXBPK8Hlq5oZNZgb2B1Wq9
         VnHJ8VIQRPA8ln5yy/fAZbtZjy9DbhBXek41zbaigkpj4u3ktncXHkA1deSjcxqD+tzg
         nVLg==
X-Gm-Message-State: ALQs6tBgVdjXVTxuj5uWo18YUHfJmZQHPaOPLHUCh5TLzCvj/UpNVRZd
        IG3+2Gp+R+PSP12dYFcdTcBCgX9R2jmJqZEQ/Um12zER
X-Google-Smtp-Source: AB8JxZotJUyyrorXwbEBRAbGlD5fNWTkb1+plhJdN+W/Ccc3pHNltHWt/bdimCUuhr76FW2yDbruz/dbIK8CE9VM11s=
X-Received: by 2002:a24:dd94:: with SMTP id t142-v6mr5511254itf.81.1525535604689;
 Sat, 05 May 2018 08:53:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22db:0:0:0:0:0 with HTTP; Sat, 5 May 2018 08:53:24 -0700 (PDT)
In-Reply-To: <2107075651.273821698.1525534895640.JavaMail.root@zimbra39-e7>
References: <CAP8UFD3jc6Aops56pgQCw7cYKW9ujkUmtDgLfwo=VyBy-QNKAg@mail.gmail.com>
 <2107075651.273821698.1525534895640.JavaMail.root@zimbra39-e7>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 5 May 2018 17:53:24 +0200
Message-ID: <CAP8UFD1KqFS5j=ZPqEHXrh3jM3LeTbk8_KEy3FGmsVwa+krPAQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Fix support for merge options.
To:     Yann Dirson <ydirson@free.fr>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 5, 2018 at 5:41 PM,  <ydirson@free.fr> wrote:
> Christian wrote:
>>
>> It looks like git-reintegrate is not managed in Git but in this
>> repository :
>>
>> https://github.com/felipec/git-reintegrate
>>
>> So could be a bit confusing to send those patches to the Git mailing
>> list without telling that your patches are not to be integrated into
>> Git itself.
>
> Right, I stand corrected, thanks :)
>
>> Nice to see you again on the list anyway!

Also congratulations for Shadow's success! (https://shadow.tech/usen/)
