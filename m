Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 177981FA7B
	for <e@80x24.org>; Sun, 18 Jun 2017 09:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751081AbdFRJMb (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Jun 2017 05:12:31 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:36481 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751009AbdFRJMa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jun 2017 05:12:30 -0400
Received: by mail-it0-f45.google.com with SMTP id m47so52982524iti.1
        for <git@vger.kernel.org>; Sun, 18 Jun 2017 02:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AYaXATDxFt8Z/ZIMjt7jzcBddSb6ScBx4pZmrnMfnOs=;
        b=Z3mErzszbW5vwpPJCOqFYMjqY1hR9zzDmkyLD7VFLzZODHOsqI7J3YiDt4G4ZPTjhU
         USfim6gymtrkb1ao77WYAhldLdozFLE3g9pqho8Oj6McoicY8IXnrZ3ZhcNYJ6GPH57u
         DgdftC4d3LNhrWbfxsMgKXyupVfnnjmwjdGcGVzGdiugcnHQhEndbxYR7wz8vAzwS9q5
         8xgdWAdriHSuqV1jYZeAJC3WLnOwB+K0+NmgQ/BB7FJ0/7eJaK5192qUEbNRt4cKUpMy
         9YlxmVRvgYEK8BlvRaz95McNg4daV2Sh6suuCX3mzn4jhRKr2CLTDgh/AM71DfOHVlvF
         koqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AYaXATDxFt8Z/ZIMjt7jzcBddSb6ScBx4pZmrnMfnOs=;
        b=pdA+BOqPwKSqglwpr2ElTYynWKwxXqnuAj+6taeC3qpnTE4ADYErOwhJa9f3g+88BG
         gRjylHSTld51ynY+UUfYv3XF+wUTkI38KxMjl4uRZQThEvIus56iUMSF+7pV3eecOXsI
         4hJl26K+USd9DuAilcQ5dIcjhxOni0DbkB0ePrVQy4q4Stu18/KQrirdhQJvXj88c/J1
         77aigu3eTCQaUKAivaerYIX4joWkV8hCyk73rd5u08U/ogDUpKQpys/JyI/xW2yaApBS
         rXXq5Y7VO11IxmWGLvF5oUd6/t2yUTtdKJEQEbYeoUlmP3IkC5A5eDyXRjMgb8qIXE03
         Vq9w==
X-Gm-Message-State: AKS2vOwTZRbN+5tWbdABsyWhU84P3AkYvweK0PvPjgnY7k9XWQDfTUE5
        nYykEBXu393NXx/lPCIqFEVJLaes7Q==
X-Received: by 10.36.13.16 with SMTP id 16mr17877075itx.22.1497777149169; Sun,
 18 Jun 2017 02:12:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.72.66 with HTTP; Sun, 18 Jun 2017 02:11:48 -0700 (PDT)
In-Reply-To: <20170618074603.epf3vhsi4pevg6jn@gmail.com>
References: <20170617102454.2040-1-davvid@gmail.com> <CAJZjrdX=8DbRTsdJ+bH5BABJG0m=y2QpT8C4kFviUsxVqVLVLg@mail.gmail.com>
 <20170618074603.epf3vhsi4pevg6jn@gmail.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Sun, 18 Jun 2017 05:11:48 -0400
Message-ID: <CAJZjrdVU7h6RCd7K2hwFbZfo-6ifiKeh3dYdz7bdNzaPzCRXCg@mail.gmail.com>
Subject: Re: [PATCH] mergetools/meld: improve backwards-compatibiilty when
 using "--output"
To:     David Aguilar <davvid@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Matthew Groth <mgroth49@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 18, 2017 at 3:46 AM, David Aguilar <davvid@gmail.com> wrote:
> On Sat, Jun 17, 2017 at 10:11:36AM -0400, Samuel Lijin wrote:
>> On Sat, Jun 17, 2017 at 6:24 AM, David Aguilar <davvid@gmail.com> wrote:
>> > Meld 3.16.0 requires a "=" in the --output argument, as it uses
>> > a simple hand-rolled command-line parser.
>> >
>> > Newer versions of Meld (3.16.4, and possibly earlier) use
>> > optpaarse, which accepts either "--output <file>" or
>> > "--output=<file>".
>
> Junio, there's an optpaarse -> optparse typo in the commit message
> here in case you want to fix that up.
>
>>
>> Do older versions also support both?
>
> No.  When the "--output" option was first added (3.16.0, or possibly
> earlier) it used the simpler parser that does not undertand the
> "--output <filename>" form.
>
> Much older versions didn't support "--output" at all, so we don't have
> to worry about them since we already use the "--output" flag
> selectively based on whether or not it's supported.

It sounds like this patch would break versions of Meld that use the
hand-rolled parser, then.
