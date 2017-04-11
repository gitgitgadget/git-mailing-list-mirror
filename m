Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDACB20970
	for <e@80x24.org>; Tue, 11 Apr 2017 15:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752395AbdDKPNj (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 11:13:39 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:34860 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751875AbdDKPNi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 11:13:38 -0400
Received: by mail-oi0-f46.google.com with SMTP id f22so143808oib.2
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 08:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=picussecurity.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5eXyu0sEeNDN2c9PRGHbUNXh+QDtaeSIvMsutcjQ4g0=;
        b=abppvYp9cCATxVJ284OS6pdDrzIywnEczwxsu78RJKtsUl8dUIHWc1pVVfD9w9S1RR
         Um5/7S8nI55WJTMM838iQ8viy/DND1e+VgFR1WM4CMn2IR8KVgI1WJfT3YkRt91hGm+f
         wJFDTppvMz6snjumWGQOvgjCsxrtRRzy2oWhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5eXyu0sEeNDN2c9PRGHbUNXh+QDtaeSIvMsutcjQ4g0=;
        b=VtifjZZz63lRcZacbSBqHiNGZBdDxSfj+LjjiVx+TtsWlno+Mv5XFkuTcfUsVsgFlk
         eWM74jdEfNyxf+9qWx+lAldaFff8RkERic7K419bgf09puNEXnsqeQhjSReXsWXUeuxR
         bxD99yVgPj1BPrTUg3ZL/oX8arp9e4rsloOMZGChvOTsWL65FCcadGtMyHQRfJZFom+7
         o+KFLYJNmGL0XLEws+nAnmWGubim8RaoV+1jQKOW9VZ3NduJJpNreAMRsQloHRMqONXh
         /9MT0UAaJNO6ll9w65DMOs2qwHpSQ/2ZfDgt7uUf73NRNRMmiu62gD+MXTbjGRxEZxFA
         Am7A==
X-Gm-Message-State: AN3rC/6YePPoaHuTSo7pBfVlyBHMu5577Rysh/hVYyUBCnrrihCYv3qL4hJ9pzhGMVXiBhvJTspp+ITlQ9VDCw==
X-Received: by 10.157.83.45 with SMTP id g45mr5878611oth.244.1491923617481;
 Tue, 11 Apr 2017 08:13:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.145.1 with HTTP; Tue, 11 Apr 2017 08:13:37 -0700 (PDT)
In-Reply-To: <88df8638-9b7b-42c4-bb34-4e1a49d4c22d@grubix.eu>
References: <CAMLReHYBVmuu5H015N1ShCD0iLNau9oLOabJhQ7xc=58rXQi+Q@mail.gmail.com>
 <88df8638-9b7b-42c4-bb34-4e1a49d4c22d@grubix.eu>
From:   =?UTF-8?Q?Enis_Bayramo=C4=9Flu?= <enis@picussecurity.com>
Date:   Tue, 11 Apr 2017 18:13:37 +0300
Message-ID: <CAMLReHYbuHmGTtBSUQq3bO=6ghz=rfP-=Eg=PvP0tkwZbM2Q1Q@mail.gmail.com>
Subject: Re: `git status` output is very misleading after a merge on a
 "detached HEAD"
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Well, what do you suggest as an alternative?
>
> Git tells you that you are in detached state and where you came from
> (detached from).

I think it'd be best if git status somehow indicated that you're no
longer at the same commit. Maybe something like:

$ git status
HEAD detached from origin/master, no longer at the same commit
nothing to commit, working directory clean

or, to be more informative

HEAD detached from origin/master 1 commit ago,

On Tue, Apr 11, 2017 at 5:55 PM, Michael J Gruber <git@grubix.eu> wrote:
> Enis Bayramo=C4=9Flu venit, vidit, dixit 11.04.2017 10:57:
>> I've encountered a very misleading output from `git status`. Here's a
>> sequence of events that demonstrates the issue:
>>
>> $ git --version
>> git version 2.12.0
>>
>> $ git checkout origin/master
>>
>> $ git status
>> HEAD detached from origin/master
>> nothing to commit, working directory clean
>
> Hmm. My Git would display "detached at" here as long as you are on the
> commit that you detached from.
>
>> $ git merge --ff f3515b749be861b57fc70c2341c1234eeb0d5b87
>>
>> $ git status
>> HEAD detached from origin/master
>> nothing to commit, working directory clean
>>
>> $ git rev-parse origin/master
>> e1dc1baaadee0f1aef2d5c45d068306025d11f67
>>
>> $ git rev-parse HEAD
>> 786cb6dd09897e0950a2bdc971f0665a059efd33
>>
>> I think it's extremely misleading that `git status` simply reports
>> "HEAD detached from origin/master" while this simply happens to be a
>> mildly relevant fact about some past state.
>>
>> Thanks and regards
>>
>
> Well, what do you suggest as an alternative?
>
> Git tells you that you are in detached state and where you came from
> (detached from).
>
> Michael
