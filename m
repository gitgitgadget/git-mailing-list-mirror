Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFB0B20450
	for <e@80x24.org>; Fri,  3 Nov 2017 18:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933472AbdKCSCA (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 14:02:00 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:55041 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932321AbdKCSB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 14:01:59 -0400
Received: by mail-io0-f181.google.com with SMTP id e89so8008911ioi.11
        for <git@vger.kernel.org>; Fri, 03 Nov 2017 11:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2yICI8iIAqnMu/LLR7ePE7EIEceOthhbLMw2UgAOZfE=;
        b=VNilRNsF5Y0SUmM90AIVzCDBy1KFsotdlVn7ZewMxD6kK87/GXkUJCLOzq5qjFsjYD
         7GViGjtKJAFGxQb+iKRk0PsI4HmDrHxql9OXIjK5aYSW6J1YvDv2aORkqKnyc/KedGDa
         V9tIOpZeDmeLY6mqFsQQq8mjhf//yfzoTF0h2OT2ihPqKKNELCTsDulSPi2VpX0v2yX1
         wFATMJlsDFj0PpisQVUWEnVWLDvnSQOFzrSfOKI7WpxPeY13fiCoHr0TnjNy11uS6tCv
         RBtknFKcheAoali1HAoIzGNVu6jfb+lDcYzQ/yhXCPgkOaGMPiCKQ40FRfOWZUeUY26V
         yhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2yICI8iIAqnMu/LLR7ePE7EIEceOthhbLMw2UgAOZfE=;
        b=OpaOzM4j6RYtb4cQGCGf3QKunz/47xRpj4TSKNFIboxBPn07RCtYYme7KuLHym2tL3
         tHrPr+JWGmrlxVY9fmeElZbJESdxcsCgXXbMfF+cihAu4oEWVwiAF8KDG7zJKOjEanf7
         Ii8Eq8RyStBc79equp4f5yWFi476GavB1dS00a4qIyl/X7Ou36M1T/4MpVu7rIHapSG4
         ZpIW55DJaF34FMazJ+hBu2dSS/TAx2A+caeo/CqikoIfvnVb6RMELxzGdpAeZ+mfDC80
         A+vU5XYGzV2ixlByjB4zileizUQkFEV5zMTe7jZJCTcP8RDBMO66t0lG3UB5e42bYckw
         D+bQ==
X-Gm-Message-State: AJaThX41jQBEe1FQFnA4jlYX35kcbzuXwlWeVdWtp2PTSFQ7ltqA2RGF
        imoj0b8Uae76hotWRK70mks6Qx4slWRrbwmt4/On9pX7
X-Google-Smtp-Source: ABhQp+TSifEB2KkKLhNFkD4OWxH/gg+/uRy7auMdylLYxU5SCGlgEZelHN5SkgwPskArqWxCRmpOtYMeu/WNFAafGT8=
X-Received: by 10.36.86.142 with SMTP id o136mr918626itb.68.1509732118617;
 Fri, 03 Nov 2017 11:01:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.36.22.15 with HTTP; Fri, 3 Nov 2017 11:01:38 -0700 (PDT)
In-Reply-To: <CAOAxMp9H6M+t5RvYiem+kXrY920ZDYvyyYt4GZ7ZnkpXVA_c0g@mail.gmail.com>
References: <CAOAxMp-vAM7mCWuanj69coM09zF-Sxe=G=-XMd_RmaAne8qFvw@mail.gmail.com>
 <CAGZ79kaDB+nnTZVw-7msVa12RQa3sHn_zFKQ2-5i2eosuHutxQ@mail.gmail.com>
 <1509648929.1838.1.camel@kaarsemaker.net> <CAOAxMp9H6M+t5RvYiem+kXrY920ZDYvyyYt4GZ7ZnkpXVA_c0g@mail.gmail.com>
From:   Yaroslav Sapozhnyk <yaroslav.sapozhnik@gmail.com>
Date:   Fri, 3 Nov 2017 14:01:38 -0400
Message-ID: <CAOAxMp9fi3n=anfE_XCqDMtsr89pPANgCK1SL-RnOkwYjOM8hQ@mail.gmail.com>
Subject: Re: Git libsecret No Unlock Dialog Issue
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What version should include this fix? Cannot find a pr for it.

Thanks for providing the fix!

Regards,
Yaroslav

On Thu, Nov 2, 2017 at 3:48 PM, Yaroslav Sapozhnyk
<yaroslav.sapozhnik@gmail.com> wrote:
> I've tested the code change locally and seems like it fixes the issue.
>
> Yaroslav
>
> On Thu, Nov 2, 2017 at 2:55 PM, Dennis Kaarsemaker
> <dennis@kaarsemaker.net> wrote:
>> On Thu, 2017-11-02 at 11:35 -0700, Stefan Beller wrote:
>>> On Thu, Nov 2, 2017 at 9:00 AM, Yaroslav Sapozhnyk
>>> <yaroslav.sapozhnik@gmail.com> wrote:
>>> > When using Git on Fedora with locked password store
>>> > credential-libsecret asks for username/password instead of displaying
>>> > the unlock dialog.
>>>
>>> Git as packaged by Fedora or upstream Git (which version)?
>>
>> Looking at the code: current upstream git. Looking at the documentation
>> for libsecret, this should fix it. I've not been able to test it
>> though.
>>
>> diff --git a/contrib/credential/libsecret/git-credential-libsecret.c b/contrib/credential/libsecret/git-credential-libsecret.c
>> index 4c56979d8a..b4750c9ee8 100644
>> --- a/contrib/credential/libsecret/git-credential-libsecret.c
>> +++ b/contrib/credential/libsecret/git-credential-libsecret.c
>> @@ -104,7 +104,7 @@ static int keyring_get(struct credential *c)
>>         items = secret_service_search_sync(service,
>>                                            SECRET_SCHEMA_COMPAT_NETWORK,
>>                                            attributes,
>> -                                          SECRET_SEARCH_LOAD_SECRETS,
>> +                                          SECRET_SEARCH_LOAD_SECRETS | SECRET_SEARCH_UNLOCK,
>>                                            NULL,
>>                                            &error);
>>         g_hash_table_unref(attributes);
>
>
>
> --
> Regards,
> Yaroslav Sapozhnyk



-- 
Regards,
Yaroslav Sapozhnyk
