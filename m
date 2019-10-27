Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E84551F4C0
	for <e@80x24.org>; Sun, 27 Oct 2019 10:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfJ0K1Q (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Oct 2019 06:27:16 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38827 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfJ0K1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Oct 2019 06:27:16 -0400
Received: by mail-lj1-f196.google.com with SMTP id q78so8277119lje.5
        for <git@vger.kernel.org>; Sun, 27 Oct 2019 03:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=W9ZSsHHZtwlhcKaIv9geKVWbxqgVhIZs4n0dCu13dls=;
        b=Rdz1/NPGUMK0y3WXA+D3gts9HVsMF5Xat/y8KPGUMrqpsTpQrBAqIhm7txBRmCfPzL
         YgLfPPz9YRDIaMNxyMiwF8+8dQCWN+DpzzGH79XMtsq4teYYpc0TklW0ToZqK1UcDsAR
         dXNWESKsX6rCzNlrSWKgnQ48DetW+4BRuY9EsvT+1eSalUB83CE7uHGBsXUo8tBgswk7
         t8EH6mO4RTFi5HUVmQRgWyJlQ6nlny0vJQ/sKDQp+pbNcWnraesmQ1ROyov0P2cBkd49
         pPOu6MmcFZIODKbkuv6Lt9IF49Sf5ADXzq3eb5Hi6+ZMjwKCscW551799jEytpXM2qhJ
         54Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=W9ZSsHHZtwlhcKaIv9geKVWbxqgVhIZs4n0dCu13dls=;
        b=Oc4r8GXO02EITXZ7eyarEt5n94OsB1yZCUqyWry6XTZRI1RKLXSbQ3NNkI/5b9vre2
         ZBj8JPpf8NXPgc0hy4SqRmv80k1qHaHF4JQStG2lLb6a7hcAxR0CdNvu04A3/DGf0KIe
         ZcU5TOyR7f5LqIKQw8nH8ziQsYRAxW2WIOler8Xd3LqSclIxlUTB4+ivHgZ5ksbdPXnV
         VzReDqjqwpFX5qlx9Mt1K8/9KcQ+lbRi5loSHBH7wwteCew+NyOSbweFaKtOD1aoDqN8
         sJpJExKm2xn3aqDhpxqHJlTRirky/KXDBGNHmf2nISekwnjz8QHjqjPUfN1zly1i/d1C
         Q+nw==
X-Gm-Message-State: APjAAAVkH+O73Udx90HNMLPrsmk5BfTgKMwSHjSBDbsjuYgXDnbE+cyW
        poo1dC8BasmNtHYVl9RlUjgupFZKDk4=
X-Google-Smtp-Source: APXvYqyCd/tsfBrfzmbbk6+fEMNJO45NsigiW6JknmTjzInM27IMkgtz7PMIf9oV5JuF+dkuDN+g4Q==
X-Received: by 2002:a2e:819a:: with SMTP id e26mr3651563ljg.26.1572172032256;
        Sun, 27 Oct 2019 03:27:12 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id r29sm2916303ljr.66.2019.10.27.03.27.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Oct 2019 03:27:11 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Robert Luberda <robert@debian.org>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] gitweb: correctly store previous rev in javascript-actions mode
References: <53CECC87.7030209@debian.org> <20181216232429.GJ75890@google.com>
        <8073f537-4380-4571-6997-546a9ca919f4@debian.org>
Date:   Sun, 27 Oct 2019 11:27:08 +0100
In-Reply-To: <8073f537-4380-4571-6997-546a9ca919f4@debian.org> (Robert
        Luberda's message of "Sun, 27 Oct 2019 10:14:26 +0100")
Message-ID: <86eeyybi0z.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Luberda <robert@debian.org> writes:

> From: Robert Luberda <robert@debian.org>
> Date: Sun, 16 Mar 2014 22:57:19 +0100
>
> Without this change, the setting
>
>  $feature{'javascript-actions'}{'default'} =3D [1];
>
> in gitweb.conf breaks gitweb's blame page: clicking on line numbers
> displayed in the second column on the page has no effect.
>
> For comparison, with javascript-actions disabled, clicking on line
> numbers loads the previous version of the line.
>
> Addresses https://bugs.debian.org/741883.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Robert Luberda <robert@debian.org>

For what it is worth it (because I am not active in gitweb development):

Acked-by: Jakub Nar=C4=99bski <jnareb@gmail.com>

> ---
>> Hi Robert,
>
>> Years ago, you sent this obviously correct patch to the link mentioned
>> above, but it got lost in the noise.  Sorry about that.  Hopefully
>> late is better than never.
>
> Hi,
>
> Somehow I missed your e-mail and just have found it today by a chance :(
>
>> May we forge your sign-off?  See
>> https://www.kernel.org/pub/software/scm/git/docs/SubmittingPatches.html#=
sign-off
>> for more details about what this means.
>
> Done, I've added the Signed-off-line above.

Thanks for following this up.

>> Jakub et al, any thoughts?  I don't see any unit tests in gitweb/static
>> that could avoid this regressing --- am I missing some, or if not any
>> hints for someone who would want to add a test framework?

We currently have no tests for the JavaScript in gitweb code; I am not
sure how one would go to add such tests (and whether it would be
possible while gitweb is part of git - if they need externel
dependencies like Node.js or Selenium they would need to be able to be
disabled or enabled with builld option).

>  gitweb/static/js/blame_incremental.js | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/gitweb/static/js/blame_incremental.js
> b/gitweb/static/js/blame_incremental.js
> index db6eb50584..e100d8206b 100644
> --- a/gitweb/static/js/blame_incremental.js
> +++ b/gitweb/static/js/blame_incremental.js
> @@ -484,7 +484,7 @@ function processBlameLines(lines) {
>  			case 'previous':
>  				curCommit.nprevious++;
>  				// store only first 'previous' header
> -				if (!'previous' in curCommit) {
> +				if (!('previous' in curCommit)) {
>  					var parts =3D data.split(' ', 2);
>  					curCommit.previous    =3D parts[0];
>  					curCommit.file_parent =3D unquote(parts[1]);

Thanks,
--=20
Jakub Nar=C4=99bski
