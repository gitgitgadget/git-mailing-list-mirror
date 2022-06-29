Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570B8C433EF
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 09:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbiF2JWp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 05:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiF2JWo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 05:22:44 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82626377F2
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 02:22:43 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id n8so7350018eda.0
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 02:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=i8zzMz6aftqYQmYYme7JLTY/x+aYR9ixwsRXSz0zTTo=;
        b=igGpWxbN9KFXeZ4d4aS+kXwq3JVY004BKAEt8140qLTr5qF5wuNgJXrU39Y8NKdTVk
         19aiKX/EGZ5DYcpCdywwGEpZdJu5OsBfLJje0vOhqXi71JKg0E9SEoeCKpFx9xAfjMFi
         hLHS4+ECoeRCCJ86ErOnDmPrvzLNbTtsD2bHu8JqTAX42cK3gaO64MpWvHVTsiO65Rn4
         eoL4cTG30EPrvT7FDsPiw8CFerSPxf5qvPkisLcKF8ToXWhAYEt1Fhvo843o9i5TvaBW
         FZcQEk0+gDp57l9q57KgxXfNu49ZoYQjre1byKujin+FzVH03uarKjgJZvTZC8WHk94m
         VoDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=i8zzMz6aftqYQmYYme7JLTY/x+aYR9ixwsRXSz0zTTo=;
        b=boo3upsUvf8fodzhdWXSmVmcRuc+Lv8JfwzGwqlCMFVwTPKWErj19xa3cPAyDc3LTF
         ZSl+zF4+7lkh09hdHRSFw+9VV63iqXhBO9hGzORZA3P5RgChjvRcrnywbGWvSSsLSBao
         0uaMcqNbLw2v149Uep2OVn1Bgk7tmD6t0oUhAJhlbSRsBDu3SY+j9XJTNeTltBMxIsba
         laK+Ury0kqXuzwd+uMjat/s0Hvp1UPbbB/2lCCssevb47S7Mo5P170/2TejFfdQQRPcS
         I2a02poaaN3ySttjIBU0S6i7DOlzYNVNxiql1oQW2AWHcFwD08p7JI9gbhPs+6Z382yl
         FsbA==
X-Gm-Message-State: AJIora8y74ukhDCx5i8KDH2s4qdj6Qb5pfYpKHuGWvmRvJZL+UNPpB7g
        0pdW/e8QJkDk/f1M6g8jOywTgaCSLdw=
X-Google-Smtp-Source: AGRyM1vJ4wy89QbOJZIb5detR9tRQZMEzmIhJ51I4aYZNGCeAI7itaSuW3ZWbV4cf1oWT6c0wNIhxw==
X-Received: by 2002:a05:6402:360d:b0:435:710a:2531 with SMTP id el13-20020a056402360d00b00435710a2531mr2821411edb.377.1656494561922;
        Wed, 29 Jun 2022 02:22:41 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id p5-20020a17090653c500b00722e8c47cc9sm1880ejo.181.2022.06.29.02.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 02:22:41 -0700 (PDT)
Message-ID: <9fd566b5-ce85-2f48-9d96-7008dc5ddd2e@gmail.com>
Date:   Wed, 29 Jun 2022 10:22:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Oddities in gitignore matching
Content-Language: en-GB-large
To:     John Thorvald Wodder II <jwodder@gmail.com>,
        phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <DC3C4CED-3781-4380-95E6-97F5CBE1B13C@gmail.com>
 <72a1a225-5d84-56c3-2652-ec7c17c18cbd@gmail.com>
 <0871A57F-4AF4-4F45-AC56-10C1817761BB@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <0871A57F-4AF4-4F45-AC56-10C1817761BB@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/06/2022 14:48, John Thorvald Wodder II wrote:
> On 2022 Jun 28, at 05:13, Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> Hi John
>>
>> On 26/06/2022 20:34, John Thorvald Wodder II wrote:
>>> First: I've found that the pattern "foo**/bar" causes the path "foo/glarch/bar" (as well as "foobie/glarch/bar") to be ignored.  However, the gitignore(5) documentation states that "**/" only has special meaning when it's "leading"; in other circumstances, the double star should be treated the same as a single star (and "foo*/bar" does not match "foo/glarch/bar").  Is this behavior of non-leading "**/" deliberate or a bug?
>>
>> I've no idea if it is deliberate or not but it seems reasonable and I think it matches shells like fish, tcsh and zsh though not bash (I think our documented behavior matches bash).
> 
> OK, but it turns out that "foo**/bar" also matches just "foobar", no slash, which definitely seems wrong.

Yes that definitely sounds like a bug, I've cc'd Ævar who I think is 
more familiar with the pattern matching code than I am

Best Wishes

Phillip

>>> Interestingly, checking the pattern with the wildmatch test-tool (`t/helper/test-tool wildmatch wildmatch foo/glarch/bar 'foo**/bar'`) shows that the pattern should not match the path.
>>> Second: The pattern "[[:space:]]" does not match 0x0B (\v, vertical tab) or 0x0C (\f, form feed) despite the fact that the C isspace() function accepts these characters, and I cannot figure out the cause for this discrepancy.  (The pattern does match the other characters that isspace() accepts, though — tab, line feed, carriage return, and space character.)  The wildmatch test-tool agrees with this behavior, though.
>>
>> This is because git defines its own isspace() that does not treat '\v' or '\f' as whitespace (see git-compat-util.h and ctype.c). I'm not sure why we exclude those characters, I think the reason for defining our own isspace() is to avoid the locale dependent behaviour of the standard version.
> 
> Thank you for the explanation.
> 
> ---
> 
> Through further experimentation, I've discovered a fourth oddity with gitignore: If "foo//" (with two or more trailing slashes) is added to .gitignore and `mkdir -p foo/bar` is run, then `git status --ignored=matching --porcelain` won't show "foo/" or "foo/bar/" at all, which is something I'd previously only encountered for completely empty top-level directories.  This holds true no matter how deep or wide you make the directory tree at "foo/", as long as it's all-directories; once a file gets added somewhere under "foo/", the "git status" command shows "foo/" as ignored.
> 
> -- John Wodder
