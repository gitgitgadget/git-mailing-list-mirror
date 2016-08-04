Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DC5020193
	for <e@80x24.org>; Thu,  4 Aug 2016 18:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934261AbcHDSyz (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 14:54:55 -0400
Received: from mail-vk0-f44.google.com ([209.85.213.44]:33052 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934092AbcHDSyy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 14:54:54 -0400
Received: by mail-vk0-f44.google.com with SMTP id x130so175144870vkc.0
        for <git@vger.kernel.org>; Thu, 04 Aug 2016 11:54:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=2cj0GACtsd6PVI4q3aJviDlUCw2DAL7Q51/PECM0zk8=;
        b=WY2EuvKh+IMe+v6QbhCsroe7nHrIpB6KcBQMnH41g+qT8wI6l6k12siw1HjnAjq3Cl
         CYGJdTU9BJU71oH2ahCNx5Yz9w5RM8HkFvjR7Pg+co9tM0OYzd+DmWh17GoQqm5dhk85
         IWmU9iYq3QNcslb63a0UX21PB31Rsos1ExPY4HRU5/i8+/0ulkCZrv/wdrsXy+4MZOhD
         MXKFzD0Ytwnvxgu2i1HnlING+Sn5nLGdZJVV0Z/80FQwRzbbeU5gEpf84+6QQnl1T1dj
         PfUsKubOmqKJLx8yZBoDBwVUP0qpRoe/jgRZ1uhxe9acSpX4C4Zssgp/8vHKaAzGj9Mb
         bupA==
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=2cj0GACtsd6PVI4q3aJviDlUCw2DAL7Q51/PECM0zk8=;
        b=bg+9v8lHgnGRJYhbGLZ3R3dxqaYeK7eZp5YJB21J4vAeXxF9Pqx0m+FUTFFRFpSvO0
         QV+9EUuAs7HYAxp5508/3mT9pXTc6Q+8nU/czFHWJ5vQyIH35fL7Jf3bkLmpEIONd07h
         X83Rt5jW3JL39qaLjpi32OR5iQJBsNjhono30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=2cj0GACtsd6PVI4q3aJviDlUCw2DAL7Q51/PECM0zk8=;
        b=ddm3WN/v5vYPwXI/VW0ywVweg2cNtjfvPwJTwiEriBtld0hniU2j6Y56Kg+7glcpEN
         vAoDgk3IJ0nSjIB5ebcoQ5xhwapA1798QHGIAszDV9u1HHJKvn1z4WSWu7E4xhqLvvDW
         wyruO4z0Gk7oJ5k7mlJPJikldREVY75c4181uU0uO21lURaxyyMUnu74zmJRMTS+KbwL
         6P9YxNNGRB11Vby9eNn10SDDbs8SCs42QylKl2OiFnLPTiAivPm6r4Dio6AlK0TBHAnR
         Ckyi39YEqEUXAxF2HkyNqdyZsnG8v4FppJs6k71zibLmFPRXiW9uMckk5Wu5k27db9jQ
         oKSw==
X-Gm-Message-State: AEkoouvn9lqN0DpL7bA6tXApY0MJML2EKzY8x/qIhP2bD57r9rB/8XBVvINyeAgEt33tH1JSDMUQkRVBGV4YCnR4
X-Received: by 10.31.188.203 with SMTP id m194mr38736995vkf.120.1470336893126;
 Thu, 04 Aug 2016 11:54:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.34.167 with HTTP; Thu, 4 Aug 2016 11:54:32 -0700 (PDT)
In-Reply-To: <xmqqr3a8goka.fsf@gitster.mtv.corp.google.com>
References: <CACi5S_0QGEgnijGyaBeZxOSobdwfA+d-wa-jrHs64Va097mnRQ@mail.gmail.com>
 <xmqqr3a8goka.fsf@gitster.mtv.corp.google.com>
From:	Michael Giuffrida <michaelpg@chromium.org>
Date:	Thu, 4 Aug 2016 11:54:32 -0700
X-Google-Sender-Auth: q5ysZM6DdLyxn8KVAVS1gp1XXEA
Message-ID: <CACi5S_2j+PXFwE755CSiE01=sYALx-17Hk1k8zJOR9_Fj7y9Pg@mail.gmail.com>
Subject: Re: git grep -P is multiline for negative lookahead/behind
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Michael Giuffrida <michaelpg@chromium.org>, git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 1, 2016 at 2:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Giuffrida <michaelpg@chromium.org> writes:
>
>> Is this expected behavior, and if so, why/where is this documented?
>
> I do not think "git grep" was designed to do multi-line anything,
> with or without lookahead.  If you imagine that the implementation
> attempts its matches line-by-line, does that explain the observed
> symptom?

No. If it worked line-by-line, it would produce more results. It is
not producing the expected matches because it *is* considering the
previous line in negative lookbehind, when I don't want or expect it
to. Thus it throws out results that should match.
