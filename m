Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AA46201A8
	for <e@80x24.org>; Sun, 19 Feb 2017 19:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751208AbdBSTZj (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Feb 2017 14:25:39 -0500
Received: from mail-lf0-f42.google.com ([209.85.215.42]:36734 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751112AbdBSTZj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2017 14:25:39 -0500
Received: by mail-lf0-f42.google.com with SMTP id b80so4443702lfe.3
        for <git@vger.kernel.org>; Sun, 19 Feb 2017 11:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GtL0+6nEqQdosgtHlw5xjpan/2yxQJ6wvq92MaXuvbw=;
        b=ZJ4/VV8dKqTNp06Mc0TELdUP/dYuuC6GawTjMX5v1dXrvxUl4JMLmlOmYBRV/6zMNI
         m4xpXvol204XkiFQxAm/bcOfD29fY8vGaOJqJVRiggQREfk8PK1SKE/BJBCFq24i7Tqk
         MunG3FkCuhHEDvVwAMh1lqUXASZ8v3E5vEoTIMuyblEgMUT4x/Ef0R2WDzPpauezWx1n
         se65YM/Uqi2d2wBw0iwzR4PFQQMXHQEun4nzHu6tKZXwdgDk5Z+bEE9/QhzhI9CBq56n
         ab7/arDBj/idYQAGRv2IBjCJPo3fkJnyDw12f03RaC84tzKjkBcbMM0Un77bUzoJsFSD
         T11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GtL0+6nEqQdosgtHlw5xjpan/2yxQJ6wvq92MaXuvbw=;
        b=TNEO3xpRjhpiuzHOXTb0J5nLJVADY/2qtIHJoZWgMxbZUsX907af+ACewtAR8K+J1a
         0XvctPr3VS8NQbdiuiUHekthNZYqy39zxngjAnQqwYP+lRBskxaDu/z1b1JUQ6GLVzyz
         MJvBgcHBhfLPebQ+prajaYTt4zrLZI1x3G3Pv0KWiu9RukEKbvvbvkaPbIjhTImnBG25
         FxAh0U4sWF6IAvH39+4L7mZMqQkwNkmC/z2A5NcbMKxz0JZuwYltpgzQ/6nx739fZjDS
         j1aMNofm++u0qVTlJno16B3izFqLQgdgmqUUzZBGAB1cJxkKijK7sI/ijmFB2uP+pDwE
         9ncw==
X-Gm-Message-State: AMke39kRUOyhHNiFzrU23PG3+41CUGrwRePTUD80EeR3d2zoBDY8am2BvzJBFj6BC4pzXjZG4ZzcOO3ehJLKjw==
X-Received: by 10.25.24.218 with SMTP id 87mr8781lfy.12.1487532337219; Sun, 19
 Feb 2017 11:25:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Sun, 19 Feb 2017 11:25:14 -0800 (PST)
In-Reply-To: <CAMX8fZWRgeK5XjSrFYzZea8YgT9Mqm0XJBxQGt1eqdWZU+DEnA@mail.gmail.com>
References: <CAMX8fZWe2HO78ySonHX0adtPUxVPbj5_vo-NUGrjwpb7gPdGrQ@mail.gmail.com>
 <d4991e4b-cbc4-da14-381a-88704e457a19@gmx.net> <3ff5ce3c-285f-cb9a-d1d4-46323524dab7@kdbg.org>
 <CAMX8fZVkBU6M8fkUcRr69V97_NTSOGGmPB1U-ObhmVv3i6wQhg@mail.gmail.com>
 <477d3533-d453-9499-e06e-72f45488d421@kdbg.org> <CAMX8fZW2y+iPRfSbXVcHufbM+CsqgekS_0WnCEJ++=njy_TvKg@mail.gmail.com>
 <CAP8UFD3ngMvVy2XLzYNn9OFbS+zQpWTW=pravpHhA-0PcDVhfg@mail.gmail.com>
 <CAMX8fZVeAEJ5tfCO_4Pebnq=rysaJ2xDMjH-9pjmPeF4FziLFw@mail.gmail.com>
 <d7bb866d-4a50-f75e-ff4c-bcdd54f75459@kdbg.org> <CAMX8fZWRgeK5XjSrFYzZea8YgT9Mqm0XJBxQGt1eqdWZU+DEnA@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 19 Feb 2017 11:25:14 -0800
Message-ID: <CA+P7+xrch9WDo6OgU3vUEpXqAETZ07mkf76dC9nJctm0LTFQHQ@mail.gmail.com>
Subject: Re: Git bisect does not find commit introducing the bug
To:     Alex Hoffman <spec@gal.ro>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Christian Couder <christian.couder@gmail.com>,
        Stephan Beyer <s-beyer@gmx.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 19, 2017 at 11:05 AM, Alex Hoffman <spec@gal.ro> wrote:
>> Then you must adjust your definition of "good": All commits that do not have
>> the feature, yet, are "good": since they do not have the feature in the
>> first place, they cannot have the breakage that you found in the feature.
>>
>> That is exactly the situation in your original example! But you constructed
>> the condition of goodness in such a simplistic way (depending on the
>> presence of a string), that it was impossible to distinguish between "does
>> not have the feature at all" and "has the feature, but it is broken".
>
> Johannes, thank you for correctly identifying the error in my logic.
> Indeed I was using the term 'bad' also for the commit without the
> feature. In order to find the commit introducing the bug in my example
> a new state is needed, which would make 'git bisect' a bit more
> complicated than the user 'most of the time' probably needs. Or do you
> think, it would make sense to ask the user for this state (if e.g 'git
> bisect' would be started with a new parameter)?

If a commit doesn't have the feature, then it is by definition, not
containing a broken feature, and you can simply use the "good" state.
There is no need for a different state. If you can't test the commit
because it's broken in some other way, you can use "git bisect skip"
but that isn't what you want in this case.

Thanks,
Jake
