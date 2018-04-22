Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E48EC1F404
	for <e@80x24.org>; Sun, 22 Apr 2018 05:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750779AbeDVFhq (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 01:37:46 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:36520 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750758AbeDVFhp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 01:37:45 -0400
Received: by mail-qk0-f173.google.com with SMTP id a202so12865101qkg.3
        for <git@vger.kernel.org>; Sat, 21 Apr 2018 22:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=9BO0NZXRhkK04pJg9XzvqXKtAVGwtrZkpWqZb6pXvNA=;
        b=LlQnTRm5snORFfv8++V8PdV7GbYm0p/Mcb6cMa4gXwf+D5tVadnePdZCPADspeqt69
         DLsUs2YZb5HwGZvefb1CAYTMq7HKFXOxcmER2ojjj2Wdoig0czHGkpooGrKLemE1V0qF
         bGY7ALpUxaHKRMTivDUgciWFnYpg1oj+R8gU35f7f6wPxyYSMkJtn/i4JUIsnrWxMIF6
         FcrAn6RVno0IPzerEc+KCZeq/q7bvQRy4/SGWQuHVFtdHwBqnwocnxqSZEt6gmdpmmRa
         zDlU+KtNL9uquRd7Pe5JUfSIxcTv5ma6mq7dwOR7Sm78m0Ym61xfIV+YRfTaFGcUoSqu
         skRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=9BO0NZXRhkK04pJg9XzvqXKtAVGwtrZkpWqZb6pXvNA=;
        b=bjOI18q8fU4Te3Ddtevvv6LIL6S9szG1GBiwhEnkkLqUl0443jygBYHhtR4njbA8f0
         BZPuWqnJEdL+Xlnu6jL4Vmjx/wDaxDQYyL457slvNRAOcaxEVy9KsjT8sM8b2EbwcBKs
         Sag1BRK4mO85Uu8YTPrR025W9W1RCm4LM0ArTIKznEf7V8pQF8vLCNMU7jZTfoSGIh69
         FbtVL+XQo3SmGd+z4N6najO2SOSDpmOpMFkl9uh4fUts/Jz+jGgB48fYMXlJLOhpOYrj
         TedXlYuTjeMAA58b6FIG7USs57L7PpVSBK0PByJtdXIckTe5wrWncauZSdw/n1hpStTY
         NuvA==
X-Gm-Message-State: ALQs6tA+kYdrE3q5rhXvLO/d7XP/y5OHD1oWOecMwm44luPI6jyqOrFB
        3OkEyfilb1P1lo+WE99K8KKDnEcntuab8f3YN8E=
X-Google-Smtp-Source: AB8JxZo65R9Y/uEu52opgV0nmguCPEK3TSrUtbI1QjEQFsGYUB365zvYSMBDlR4RoJr/CuGPmNggdpgNFbBPyebryyI=
X-Received: by 10.55.190.134 with SMTP id o128mr15674761qkf.141.1524375464841;
 Sat, 21 Apr 2018 22:37:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sat, 21 Apr 2018 22:37:44 -0700 (PDT)
In-Reply-To: <CA+FnnTzkZS7HP61Ck3y5p0EC7J_h=ToR5tq5cvEpJ79vYuSxZw@mail.gmail.com>
References: <CA+FnnTxbg97A4P3AP7n5RT8+=W8PY0yx3644Ay2Zi9xgKD2aoA@mail.gmail.com>
 <CAPig+cR19LS2vfjBQ71c3j2g61vSHnYRj1iSX1-V_E3Fj=kwOA@mail.gmail.com>
 <CA+FnnTzfJMBuSMAD7PgUurRu8jOpirEgM6=+=i91zdGLWmfUpg@mail.gmail.com>
 <CAPig+cQOzKbM0R6vKTg_BU6meEbAAJWL1T0jZkaCOF0uJ=_Lmw@mail.gmail.com>
 <CA+FnnTzqaPrLgYv-8X9BDW0DR7331morN33B81w8T3vzOwn+Pw@mail.gmail.com>
 <CA+FnnTz-qdVK5482GJo06QrvMktGYhJAJ6g-Naq0BgT-uoRvEA@mail.gmail.com>
 <CAPig+cS+gf5gGM3fmnxk-6k7ezbtS=KQFqkkxVtcytHfcQApEQ@mail.gmail.com>
 <CA+FnnTwvnA90nDARKW9r7p5iraoOGTvfDJ26n6Udc68bDSUASw@mail.gmail.com>
 <CAPig+cRjYju4zEgiY_TuOOk0e7A8zNz+hu+40vQUEGDX6FGDxw@mail.gmail.com>
 <CA+FnnTzFomd91d1F6O-a28hXQ6PxOiBd44da4nSVW0MuDKgkmw@mail.gmail.com>
 <CAPig+cTw5GjB4VgFD2teDvMuyGPFFoNSCqbXbarEXCe3fVdLjQ@mail.gmail.com> <CA+FnnTzkZS7HP61Ck3y5p0EC7J_h=ToR5tq5cvEpJ79vYuSxZw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 22 Apr 2018 01:37:44 -0400
X-Google-Sender-Auth: I391rIFb9ptvjtMZO3UMMnt9ygA
Message-ID: <CAPig+cT0ogLmiviWhdZTLxDM7+VN3hk7wgkKnvX96Ym-yXR5bA@mail.gmail.com>
Subject: Re: Is support for 10.8 dropped?
To:     Igor Korot <ikorot01@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 22, 2018 at 1:15 AM, Igor Korot <ikorot01@gmail.com> wrote:
> MyMac:git-2.17.0 igorkorot$ cat config.mak
> NO_GETTEXT=Yes
> NO_OPENSSL=Yes
>
> MyMac:dbhandler igorkorot$ /Users/igorkorot/git-2.17.0/git pull
> fatal: unable to access
> 'https://github.com/oneeyeman1/dbhandler.git/': error:1407742E:SSL
> routines:SSL23_GET_SERVER_HELLO:tlsv1 alert protocol version
> MyMac:dbhandler igorkorot$

Try re-building with OpenSSL enabled (remove NO_OPENSSL from
config.make). You may need to build/install OpenSSL yourself to get
this to work.
