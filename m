Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4410120248
	for <e@80x24.org>; Mon,  8 Apr 2019 01:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfDHBeK (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 21:34:10 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:44732 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfDHBeK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 21:34:10 -0400
Received: by mail-wr1-f50.google.com with SMTP id y7so14291469wrn.11
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 18:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Bn8KjpVuH7o7O/ogb9OTeguVgKJAoPSF+nuGEiBTKkc=;
        b=bX2O/8qsIElx1vE1QB+IhTL/M759cMXglWd/Jjjired0Cxi/3PlLOJDIGBXs9xXexb
         8b3Y2HeCXFLcSN3UeF2B+6Q9aGLR1h4vJj0iWg4InEIVn1GAbOK2ABgbAlA3s+OzCks8
         T+QfKjEJbv5/Ou3RKmoMc5nAwItQVFrDYRhJXymsssflWvZMs30f3MLNbT2lXLgKhLnt
         kolC5R5y1D5jg3T9PyXCrveOb0pmUdD6c4Kt9ldEUJ4UnPIVzzNqGnM0r89Z1K++5Q9a
         rsk4QRlQT7jZ56CNSwgRrIxPpwvErC3e62dQ7R8K13GKgk+HBVmX5ieldGckAwSD0M/l
         bq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Bn8KjpVuH7o7O/ogb9OTeguVgKJAoPSF+nuGEiBTKkc=;
        b=L5vDB5JXytvx7WPIQyMv1LVB0/KspbFRq0uhI63Mt+zSgUgfETON+KH76flgMtIm8B
         ZakrFaOrXBAKkOtCD2lqCn9pqj1jxNlStlhWAzmo9tbuZ/597Bjh9AQN5Bb+pG63NQFT
         HvO5nB5BC+wxl5awWiXG4VgqgglhrcW59ctgfly2clBuv9rI838qfUxadzy1GOMl2IZs
         k03OCsptLpZgSAk/tBLBumEpGLyEKO9oIsPIOE0RFb9KoMEH23DoVpb2y7Gee+bMbf1R
         gSSOBDbOg11v0mf8T+U5H3TOHZUor2d/Wp+zOCZExyUCkp4Qvvz0IkAywvMshMeMv2ye
         Zi1w==
X-Gm-Message-State: APjAAAVaxBm4cMxLLqFiDxBvACOyXJJoJABn5OZKT9BjQce8Bbcqvufj
        8rX26tJ/sERjLhNLcfxgLAa5toANjk4=
X-Google-Smtp-Source: APXvYqwx4h5KrDquqt1A50LwcL65GkXpJXiiLjh+mywyG1SPj56t8DLyEqtCvA92cQ2yw6zMqt5R4Q==
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr16218681wro.232.1554687248783;
        Sun, 07 Apr 2019 18:34:08 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id y1sm84276999wrd.34.2019.04.07.18.34.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 18:34:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Damien Robert <damien.olivier.robert@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Pull without fetch
References: <20190406131200.xcd7gtf7dlc567uh@doriath>
Date:   Mon, 08 Apr 2019 10:34:07 +0900
In-Reply-To: <20190406131200.xcd7gtf7dlc567uh@doriath> (Damien Robert's
        message of "Sat, 6 Apr 2019 15:12:00 +0200")
Message-ID: <xmqq4l79cmb4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Damien Robert <damien.olivier.robert@gmail.com> writes:

> is there a way to do a git pull without it running git fetch?
> Looking at the source in builtin/pull.c does not seem to indicate so.

The reason behind that is because it does not make any sense for
"pull", which is meant as a quick short-cut to say "fetch && merge",
not to run fetch, especially back then when 'git pull' was designed,
the world was much simpler.  There was no "fetch && rebase", our
branches did not know what their @{upstream}s were.  In that simpler
world, what you are trying to do would have been:

	git fetch
	# did I get anything worth integrating?
	git merge FETCH_HEAD

That obviously would not work for those with "pull.rebase", and I do
not think it makes much sense to teach "git rebase" the same trick
to read FETCH_HEAD as "git merge" does in the above sequence.

Others may have a better idea, but I do not immediately see any
solution better than inventing a new option to "git pull".

Another and better option that may be harder to arrange is to make
sure that a no-op "git fetch" incurs very low cost.  If you did so,
"git fetch && git pull" would perform just like your "git fetch &&
git pull --no-fetch", and we won't need a new option at all.
