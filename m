Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10547C433E4
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 17:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5846206D8
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 17:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="AnXV+s18"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgGZRlT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 13:41:19 -0400
Received: from mout.web.de ([212.227.15.4]:43155 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbgGZRlT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jul 2020 13:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1595785265;
        bh=yTtMwp73pLWOt9TfeSNd71nkwsxKg9BtA6nj6TrCrsg=;
        h=X-UI-Sender-Class:From:Subject:To:Cc:References:Date:In-Reply-To;
        b=AnXV+s18bE6590hLn2HwjnBSKcRSz+vZnrtpadDqV+aNhuTfd2QgKF0AOmDuGIOMj
         8aynWfm/SFA4DHGEfGf4ONZC7UsszFBr2fy1zWGNMwMAnvzp86JQ0oeC/wif7jlXT4
         9KaCUY0C4QHGQRR9uIGptvMiJ9ZWX0LbgKI5kvXo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MSry9-1kOkJ23BLx-00RnRP; Sun, 26
 Jul 2020 19:41:05 +0200
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: Verbose commit message diff not showing changes from pre-commit
 hook
To:     Junio C Hamano <gitster@pobox.com>, Maxime Louet <maxime@saumon.io>
Cc:     git@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
References: <CADv3qkGq3jA8iXsjhrqfsUX=gW+KOuLyeVgDzmku1tUpsMdvtw@mail.gmail.com>
 <xmqqr1sziqrm.fsf@gitster.c.googlers.com>
 <xmqqk0yripca.fsf@gitster.c.googlers.com>
Message-ID: <a8c19b13-3f8c-6602-24dd-ef58af70d702@web.de>
Date:   Sun, 26 Jul 2020 19:41:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <xmqqk0yripca.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p9GYKqbHYvr4VAfGRc6UtFTZO4clowJ9KewAS0nkqtJVKryWWaf
 k7VNhTDOUPFKYdCALn/Oo/a+p7mNmZB8o9u8d6v0wOrsw9sij+7iimjVdZyr2uL3CG7Wpaq
 IPWzfVerJJ49kYKmpAxof3sWUTG4fkh+4Bw8COUag708CnGtqCZON6gTGVyrGGrGhMaVtgw
 e6Au79BoFV/eAuRHsmXxw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8rRPh3Z7ZO0=:kKY6Y0jWcQenzaOAeohz4u
 fQqOSU6sr0C9iTFmS1GB3SO7v3LgeAYlnK2UPBTzGMv9L2G2/yJVQjiaa/QrvTnCIoSou9b+4
 48hLzlrP0afXhTQnNogeSRm70EYzV2DJGVh4vpP38q3ZHhWCkwlyOTqZ/CfkwjRzZyRStIcfR
 c20ooK+r03a5cwMdWvdN9ZmqLSIQPmZ3AMy9meHoxuyphljfVg6zc251ofeaDDYI3tIUGI85h
 f+8OVN8VDpCEbtvD5YilrNhqDRr299XYyXeW1yvfF9GqbkEajKS2XrlLY+PsFOeacfauh4aLX
 AIJAbTLdD2VPFLyqVCFf1IMZNW+eQ0pdO7XF8GTq8F4tdb7zvN1V7y1Y5YQHWX203nYHSC+kE
 48dZrRy8MDwtMHKN/qxXPIWQjWXf3D2aicnpSV0235vRGWO3JZCWpDsQ/coUexJ2a8kpO7zdl
 B4qf3goZ+Yxw8ZSiwLDRBJL1RjLQ2zcuJtEH8324DeuyfaDXSvdYxGsr5PJeo1CbTLpmpotSO
 dM9SfnPFQ3/1EIal5yYBxfk+zK1y+vxqPrz8zCLYnNQuC1VuxwqpENuuUqmAY1lsbw2dReHwL
 VXpiwFW4LUTXtZKOHn1TOKjybH7aSD6NX/64QfpGX+luksRil8gWwuRirgUGQzujGReWb9pTc
 ccg0BYZy2Xj/kKLMD35FsjGW2qyY74lL2zP6z/tZHV2LB/a22yyRWm5ZifdREGNJGNdtbPiyC
 0sfShFsr1OG4XtW1CGKARC0kd2V4QlPA8v+VKbzlJZ7HLNaYW9TcvonqfFi591AI6RPZtvMKW
 CDMtolGHuqw58o2EuGWfBkeBcvxAq9Za9scV3PNuE2GzwjuIb5tuPkp2nrjdUT4yq1WJkHBOu
 On5ocbDw6QHqetpSyYd5Tiw9xlgUxKM/XHms0AgoTkAYf1GodWhGi5kX1Gr+IAoF4je3Eivk+
 VUgYkfukelPHmLmeDIor0fB3WGG8RwLWRZ5PM0PwitYjA3ZdeDLljl1rLVuc1ZNnGCyO62+cb
 Ek9GLK9na0A7qGjmjP7cxZL3AnBymN7oZUApac90QrrUN7hbb4/SUBSUix0dWPhJQsc56baFv
 nEaIB/vbpj3LQ4UDNeBktUQtb3T6j/IrQqTuuwVri7isgwWjkq6xbZppDUgvNMx8iCVpJqAnS
 zk4upUJUfTcMjbjj8gXUDZtStpv6ovIFgZLdLFSSNlWUDeM8rycEgLvB6/sb0AflIa/wMegxb
 gYk9f3OEB4bEpQO/b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.07.20 um 17:31 schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Maxime Louet <maxime@saumon.io> writes:
>>
>>> Is this expected behaviour? I find it somehow confusing that the diff
>>> in the commit message isn't the actual commit diff.

> Even before ec84bd00 (git-commit: Refactor creation of log message.,
> 2008-02-05), the code anticipated that pre-commit may touch the index
> and tried to cope with it.
>
> However, ec84bd00 moved the place where we re-read the on-disk index
> in the sequence, and updated a message that used to read:
>
> -	/*
> -	 * Re-read the index as pre-commit hook could have updated it,
> -	 * and write it out as a tree.
> -	 */
>
> to:
>
> +	/*
> +	 * Re-read the index as pre-commit hook could have updated it,
> +	 * and write it out as a tree.  We must do this before we invoke
> +	 * the editor and after we invoke run_status above.
> +	 */

When I read "refactor" in the title, I assume that the patch in
question doesn't change user-visible behavior.

> Unfortunately there is no mention of the reason why we "must" here.

@Paolo: Do you perhaps remember the reason?

> I think the "run_status above" is what prepared the patch in the log
> message template, so it is quite likely that we deliberately did so
> to exclude whatever munging pre-commit does to the index from
> appearing in the patch in the verbose mode.  If I have to guess, I
> think the reason is because pre-commit automation is expected to be
> some sort of mechanical change and not part of the actual work that
> the end-user produced, it would become easier to perform the "final
> review" of "what have I done so far---does everything make sense?"
> if such "extra" changes are excluded.

Committers review and sign off changes.  Hiding machine-made extra
changes from them, that they then implicitly also accept responsibility
for sounds questionable to me.  The prepare-commit-msg hook might be
a place for such filtering.  But git commit showing the full extent of
changes (incl. those made by the pre-commit hook) would be a better
default, wouldn't it?

Ren=C3=A9
