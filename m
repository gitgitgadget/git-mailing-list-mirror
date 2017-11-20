Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D0DE202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 18:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752057AbdKTS5N (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 13:57:13 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:44581 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751637AbdKTS5M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 13:57:12 -0500
Received: by mail-qk0-f194.google.com with SMTP id n3so8746594qkn.11
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 10:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Dw/WFpA+VE2QqxKExfAScJfrO69TTZEjTpG0JoY2cVg=;
        b=nCOull2PspyRqYI1PzWL/79cdX96YUOxV4TMPe7uomZMJnVU+8Qwi3aFVXbyXECNJY
         GMJltM4bri5SwiPLFpVdYY3YfZLjbvbrWr9+qXNb55e2Gp7IRlhYxZ6GYu7D5Yt4bBN/
         z/MzVqKCuNzkff/C1edvRKVRKn/73Iij3FuqbsrqyqWU91xzqdRFTLEyKQxOaHfXHd7g
         DusdAgc9DbM+PT8K86jXC6pR1y6Azq3WKBBkK5bgkHtiwXZflAqRwgnvd3cKF+YCX9GP
         pqxHEL+JXzDce4PzTye4fG2AKjKjGH0BAA8gvRZPzgz1oTVRb0QeP2eGutPEgIO8dxsE
         gVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Dw/WFpA+VE2QqxKExfAScJfrO69TTZEjTpG0JoY2cVg=;
        b=NZGhyuXQs3w0yOdylWJDVdJ4ZgBAAGJZS8a8YgCTy8IW2mtesg1+FZYZ2N/9vt8lC3
         J8RXZDuMVqhZjfT5oPwcl7pyJ6sNh4CCrjqYJVM+rrTJy9idejgIBj9EG4tK68r/opJ+
         ShDMi6DsxK4I6+ItxW+pHxxIszHXtdhSvO+sG/ChAkxkQl0R6bpjD+skA4YN1fXGEJTX
         Ly6/0KFAjrEuYkLiBLJzfq9T2gji+SyuyD4FGDPRmRV1ytwUtIH/fCefdvs0oGb4OPqa
         phbzPISbgtuMr9xutVCwkk2GbK4+D/YWHYy6KcxTTxMHx49DmHg0+oFfes8attQ2Tcnd
         rbXQ==
X-Gm-Message-State: AJaThX5eTPKdpSZQgV0NWaOli7tAHTRnt2XhBzdgOJSHbhXJVZHQ/duU
        i00XUEbGgoABbsJOq5UhzPOzzXN85K+cMI/Vufk=
X-Google-Smtp-Source: AGs4zMaGKtGUMffJnevB2tySwI4b0jIWwFtJhchg6osP7aleI0f+xi/1BawuC9p86G3bkUSVtg3It7Hgj5c0HoGam/0=
X-Received: by 10.55.58.14 with SMTP id h14mr20828186qka.132.1511204231373;
 Mon, 20 Nov 2017 10:57:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Mon, 20 Nov 2017 10:57:10 -0800 (PST)
In-Reply-To: <CAPig+cSh0tVVkh0xF9FwCfM4gngAWMSN_FXd2zhzHcy2trYXfw@mail.gmail.com>
References: <20171116154814.23785-1-alex.bennee@linaro.org> <CAPig+cSh0tVVkh0xF9FwCfM4gngAWMSN_FXd2zhzHcy2trYXfw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 20 Nov 2017 13:57:10 -0500
X-Google-Sender-Auth: DHvudFOpw9epeEW5qxhgebU57gk
Message-ID: <CAPig+cSbRrGnyDkunMFiFXbWRMAsGyuAL-0FpP1QTtjSUSY2Hg@mail.gmail.com>
Subject: Re: [PATCH] git-send-email: fix get_maintainer.pl regression
To:     =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 18, 2017 at 9:54 PM, Eric Sunshine <sunshine@sunshineco.com> wr=
ote:
> On Thu, Nov 16, 2017 at 10:48 AM, Alex Benn=C3=A9e <alex.bennee@linaro.or=
g> wrote:
>> +test_expect_success $PREREQ 'cc trailer with get_maintainer output' '
>> +       [...]
>> +       git send-email -1 --to=3Drecipient@example.com \
>> +               --cc-cmd=3D"$(pwd)/expected-cc-script.sh" \
>> +       [...]
>> +'
>> OK I'm afraid I don't fully understand the test harness as this breaks a
>> bunch of other tests. If anyone can offer some pointers on how to fix
>> I'd be grateful.
>
> There are several problems:
> [...]
> * The directory in which the expected-cc-script.sh is created contains
> a space; this is intentional to catch bugs in tests and Git itself. In
> this case, your test is exposing what might be considered a bug in
> git-send-email itself, in which it invokes the --cc-cmd as "/path/with
> space/expected-cc-script.sh", which is interpreted as trying to invoke
> program "/path/with" with argument "space/expected-cc-script.sh". One
> fix (which you could submit as a preparatory patch, making this a
> 2-patch series) would be this:
>
> --- 8< ---
> diff --git a/git-send-email.perl b/git-send-email.perl
> @@ -1724,7 +1724,7 @@ sub recipients_cmd {
> -    open my $fh, "-|", "$cmd \Q$file\E"
> +   open my $fh, "-|", "\Q$cmd\E \Q$file\E"
> --- 8< ---
>
> However, it's possible that might break existing users who rely on
> --cc-cmd=3D"myscript --option arg" working. It's not clear which
> behavior is correct.

The more I think about this, the less I consider this a bug in
git-send-email. As noted, people might legitimately use a complex
command (--cc-cmd=3D"myscript--option arg"), so changing git-send-email
to treat cc-cmd as an atomic string seems like a bad idea.

Assuming no changes to git-send-email, to get your test working, you
could try to figure out how to quote the script's path you're
specifying with --cc-cmd, however, even easier would be to drop $(pwd)
altogether. That is, instead of:

    --cc-cmd=3D"$(pwd)/expected-cc-script.sh"

just use:

    --cc-cmd=3D./expected-cc-script.sh
