Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C216520193
	for <e@80x24.org>; Tue,  9 Aug 2016 18:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbcHISUN (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 14:20:13 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:36368 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932331AbcHISUL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 14:20:11 -0400
Received: by mail-io0-f169.google.com with SMTP id b62so19429421iod.3
        for <git@vger.kernel.org>; Tue, 09 Aug 2016 11:20:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DPHUcqqB6MLlJqZievd6grmlIWEX0IDN+SZMWoOTqoM=;
        b=n/MAjbANAucroaroIe4OpPG6t2hEs8/gwu+ISblCuF00YBtaitzj1WGH/vCnJoOPY5
         SaDMpedmVuyc41jwMGCgZJBY9x5dynDXHUCNs/uNYNWthSk3F5TAVbVWncedLn6DPaBu
         2OOsOlTaiBkUraQQ5mzulMAQzuyBM3CcJktK5czoRYi9xvzxbWbr9J1+vbuuYSzx0Jjv
         Iu7eL91/E2g0xCRw8yGd7+0ErnhgbYdN5bGSDr8earDnnDPEEOg2wIwlyFe7UpgMZCTp
         vS5oUEpj6f3mbpDU10ONoyoYYkrPrHONoh5jLO2wRkYCPGR4EmGojsiZVV7DEMcyzlJR
         t+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DPHUcqqB6MLlJqZievd6grmlIWEX0IDN+SZMWoOTqoM=;
        b=ktrAzU81a6AaBv6+DOcImCxkM7C2wkLnh2IRzlXeRYQONO3MenZeC46vKVZ9aPpa1d
         mYq3abByLWyC4MkL43WDYOYJf1COHhjLEWMb/fLSCp9BcdaSN1k7gMm+0cfcIHfATCEY
         4EkFIV6Ccu5/mDGMVPMHG0pAuO8efD1O8eNfIa3ySo0jD8ho4taeeAq30wapoc37awbs
         tfd+FplnGX+TIGqjCCgOpxDsSJakw1KJ1y/wVK3VvbPwcQF1KSTcqFuUicyULL1N96kW
         x+tUAumAuPQMK/TBvU3dCojpfMVujqpzHDL6Jgrxhtni0LMjilqQFHo3w3wVugeJ70YV
         W39A==
X-Gm-Message-State: AEkoousAXJjEMOohQ8ECdFevGYaZcSTfj8DED9jc2qQ8AD1lNwnAcHdmjuNdnC0PvcW2TE2y9GwiT4a+p3qyyYih
X-Received: by 10.107.178.129 with SMTP id b123mr487368iof.83.1470766804979;
 Tue, 09 Aug 2016 11:20:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Tue, 9 Aug 2016 11:20:04 -0700 (PDT)
In-Reply-To: <xmqq4m6tbzfd.fsf@gitster.mtv.corp.google.com>
References: <20160809040811.21408-1-sbeller@google.com> <20160809040811.21408-8-sbeller@google.com>
 <xmqq7fbpdhkw.fsf@gitster.mtv.corp.google.com> <xmqq4m6tbzfd.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Tue, 9 Aug 2016 11:20:04 -0700
Message-ID: <CAGZ79kbS1_DULjf8gPram+zNLe-xRShETotq+at+r7bmWrUyxA@mail.gmail.com>
Subject: Re: [PATCHv3 6/9] clone: implement optional references
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 9, 2016 at 10:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> If I am reading the implementation of real_path_internal()
>> correctly, the most relevant reason that an "if-able" repository
>> cannot be used causes real_path_if_valid() to return NULL.
>
> Oops, too many proofreading and rephrasing.  Please insert "I do not
> think that" before "the most relevant".

Side note:
  It took me a while to mentally process and reread this.
  It would have been easier with just
  s/the most relevant reason/I do not think that the most relevant reason/
  but that is just me being used to s/ expressions by now.

I think our emails nearly crossed. In the other thread I wondered if
you had different expectations on the -if-able part than I do.

For the expected use case I do expect that the missing path is the
most relevant thing (the submodule is not checked out).

Of course the submodule may be cloned shallow as it was recommended
in the .gitmodules file, so we should also care about that use case.


> Let's say your superproject borrows from ~/w/super, whose submodule
> repositories (if cloned) are directly in "~/w/super/.git/modules/".
> When you clone a submodule X for your superproject, you allow it to
> borrow from "~/w/super/.git/modules/X" if there is one available.

which is why we need to pass in ..../X/ with an ending slash.
See the comment in 8/9.

+               /*
+                * We need to end the new path with '/' to mark it as a dir,
+                * otherwise a submodule name containing '/' will be broken
+                * as the last part of a missing submodule reference would
+                * be taken as a file name.
+                */
+               strbuf_addf(&sb, "modules/%s/", sas->submodule_name);

Thinking about that we may want to not rely on such a hack,
but make it clearer.

Thanks,
Stefan
