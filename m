Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAA581F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 04:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbdBCETb (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 23:19:31 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:53729 "EHLO
        hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751512AbdBCETa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 23:19:30 -0500
Received: from homiemail-a14.g.dreamhost.com (homie.mail.dreamhost.com [208.97.132.208])
        by hapkido.dreamhost.com (Postfix) with ESMTP id EB2E4A796F
        for <git@vger.kernel.org>; Thu,  2 Feb 2017 20:19:29 -0800 (PST)
Received: from homiemail-a14.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a14.g.dreamhost.com (Postfix) with ESMTP id 1586339207E
        for <git@vger.kernel.org>; Thu,  2 Feb 2017 20:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=bit-booster.com; h=
        mime-version:in-reply-to:references:from:date:message-id:subject
        :to:cc:content-type:content-transfer-encoding; s=bit-booster.com
        ; bh=mCY48XxEn0b0f1lzQtVN6crJSzo=; b=IBfQBQGkW2CnlU+qMHaXqAm3lsD
        EoafGsxk78ZS8uTwVl/A2pgXs0lcJE6KyeB0mpMKFt2OhLk2OhDHQLD6GTvqBWTO
        An0jrBDpNo3fkVF5NfwU12kAFwOs8bvZLOi0p4n0WfnW2g4qGEAUgbDr7ldliDG7
        Q7rfocKBAWy9rA1A=
Received: from mail-yw0-f174.google.com (mail-yw0-f174.google.com [209.85.161.174])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sylvie@bit-booster.com)
        by homiemail-a14.g.dreamhost.com (Postfix) with ESMTPSA id 05DA2392078
        for <git@vger.kernel.org>; Thu,  2 Feb 2017 20:19:28 -0800 (PST)
Received: by mail-yw0-f174.google.com with SMTP id l19so4904359ywc.2
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 20:19:28 -0800 (PST)
X-Gm-Message-State: AIkVDXJA2xrJCHlP449ntq803Bbdc/mrasu7QVOEomWUAWQpJ0ztKfa119O+th9OQTsvGmtMOl61RzHYi9LcPw==
X-Received: by 10.13.255.69 with SMTP id p66mr9859452ywf.122.1486095568350;
 Thu, 02 Feb 2017 20:19:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.56.201 with HTTP; Thu, 2 Feb 2017 20:19:28 -0800 (PST)
In-Reply-To: <CAE1pOi0-8JnnZbdm9vu1RwTU1mXr7dboLC3ito3LcvK9gkNi_A@mail.gmail.com>
References: <CAE1pOi0-8JnnZbdm9vu1RwTU1mXr7dboLC3ito3LcvK9gkNi_A@mail.gmail.com>
From:   "G. Sylvie Davies" <sylvie@bit-booster.com>
Date:   Thu, 2 Feb 2017 20:19:28 -0800
X-Gmail-Original-Message-ID: <CAAj3zPz8wFc_5dRmM=-jMnqp6a7fGtc4XSyU5meF6mO5me47Dw@mail.gmail.com>
Message-ID: <CAAj3zPz8wFc_5dRmM=-jMnqp6a7fGtc4XSyU5meF6mO5me47Dw@mail.gmail.com>
Subject: Re: How to use git show's "%<(<N>[,trunc|ltrunc|mtrunc])"?
To:     Hilco Wijbenga <hilco.wijbenga@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 2, 2017 at 9:51 AM, Hilco Wijbenga <hilco.wijbenga@gmail.com> w=
rote:
> Hi all,
>
> I'm trying to get the committer date printed in a custom fashion.
> Using "%cI" gets me close:
>
> $ git show --format=3D"%cI | %an" master | head -n 1
> 2017-01-31T17:02:13-08:00 | Hilco Wijbenga
>
> I would like to get rid of the "-08:00" bit at the end of the
> timestamp. According to the "git show" manual I should be able to use
> "%<(<N>[,trunc|ltrunc|mtrunc])" to drop that last part.
>
> $ git show --format=3D"%<(19,trunc)cI | %an" master | head -n 1
> cI | Hilco Wijbenga
>
> Mmm, it seems to be recognized as a valid "something" but it's not
> working as I had expected. :-) I tried several other versions of this
> but no luck. Clearly, I'm misunderstanding the format description. How
> do I get "2017-01-31T17:02:13 | Hilco Wijbenga" to be output?
>

Will this work for you?

$ git show -s --pretty=3D'%cd | %an' --date=3Dformat:%FT%R:%S
2017-02-02T10:01:36 | G. Sylvie Davies


I have no idea how portable this might be.  As "git help log" says:

         --date=3Dformat:...  feeds the format ...  to your system
strftime. Use --date=3Dformat:%c to show the date in your system
locale=E2=80=99s preferred format. See the strftime manual for a complete l=
ist
of format placeholders.



- Sylvie
