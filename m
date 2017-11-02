Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92AAB20281
	for <e@80x24.org>; Thu,  2 Nov 2017 14:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933318AbdKBOVR (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 10:21:17 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:45001 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932312AbdKBOVP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 10:21:15 -0400
Received: by mail-qt0-f182.google.com with SMTP id 8so6339879qtv.1
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 07:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=2i2VpEtZALgMZedKkkFF/qcOMvG7+pWfk3hAQfBz4yk=;
        b=goU5I9dZQ2mBndGhdTgY1BH2qMgXvEaSzsLN5W6HYQL133jTh/enIFczf7J8yUSXZ7
         AwBOhUuAbDs4inygGGNo6EcHgZ7Y4o3EPF2PqqSklGVyIg45xpMfX7AcS4iDOY1E9bzm
         TZZfpwNmkZLM9kjs9tSsckbsRtIoAj7j+cixR0tADcEI/O34+j8LBhg/o1DYEdbMqU2t
         I9maKA3vcyX8hQs9bAsjEZC2TMnWKCcz4id5roDm9IEVDFqvLantzsaRpSfzBVtnqqDN
         KwbcAqSDlK/OSK6YCZJD6XiwMXcxq6l+eBsxHVwx2baVZz+dgQ3h4iyODKJps21rMpDt
         NXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=2i2VpEtZALgMZedKkkFF/qcOMvG7+pWfk3hAQfBz4yk=;
        b=mebDt14xTRvfzKwPBJpNS22LyN+zz56Y4haBfrGBODz+kK/fw4elx1kLOwjdiBQx0j
         bvgg/2NKx034EdoSguCRBWKYEDWBjE2rHqptxYRuLaXqUWa2ADnOIcZofdxUpEnKE+G/
         WHCae2i6MWCGGjZ9RwklX5CaAVWQEDV3dUhBaGgBLzfYgoEupcQJ4Gh6BdFdCia1lRvk
         7FQwS+QKGSODQYsw2ybV57H6SeRVX8jhbonquznUyy1YUoy/zKzK/jszrPfIBrckeBXy
         70BaSZaXrcsNTHVK6yMflgFe2EoalSj/vlZzcV01huQFkDHspvoMcBciMgJ0cQSrfxhq
         NoIQ==
X-Gm-Message-State: AMCzsaUuUlM2uF/SO92BTHWz6s50jR3ZM3JshgXRnP2U842iwQWLVNlE
        HIvcAWTER9GW04sTwxQnr03HEmxOlHTEo4NyEoH7IA==
X-Google-Smtp-Source: ABhQp+SEpZwGhqfiaPIkOgqkwCjL6muy6j0a+bIjBj0icB0BBKpRj/U06gcqlD7Oi0+BZJAPnPFfmeTmZu1PZOZqAh0=
X-Received: by 10.200.53.12 with SMTP id y12mr5524415qtb.84.1509632474967;
 Thu, 02 Nov 2017 07:21:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.146.118 with HTTP; Thu, 2 Nov 2017 07:21:14 -0700 (PDT)
In-Reply-To: <20171102065407.25404-5-kaartic.sivaraam@gmail.com>
References: <20170925082024.2691-1-kaarticsivaraam91196@gmail.com>
 <20171102065407.25404-1-kaartic.sivaraam@gmail.com> <20171102065407.25404-5-kaartic.sivaraam@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 2 Nov 2017 10:21:14 -0400
X-Google-Sender-Auth: 5L7HW-kK2T1tEeBU-_eLudOMhR4
Message-ID: <CAPig+cRJDiHXoz-81EMtsbFfqaZz76eo1msUQW+eBP=wUsm6JA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 4/4] builtin/branch: give more useful error
 messages when renaming
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 2, 2017 at 2:54 AM, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> From: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
>
> When trying to rename an inexistent branch to with a name of a branch
> that already exists the rename failed specifying the new branch name
> exists rather than specifying that the branch trying to be renamed
> doesn't exist.
>
>     $ git branch -m tset master
>     fatal: A branch named 'master' already exists.
>
> It's conventional to report that 'tset' doesn't exist rather than
> reporting that 'master' exists, the same way the 'mv' command does.
>
>     (hypothetical)
>     $ git branch -m tset master
>     fatal: branch 'tset' doesn't exist.
>
> That has the problem that the error about an existing branch is shown
> only after the user corrects the error about inexistent branch.
>
>     $ git branch -m test master
>     fatal: A branch named 'master' already exists.
>
> This isn't useful either because the user would have corrected this error in
> a single go if he had been told this alongside the first error. So, give
> more useful error messages by giving errors about old branch name and new
> branch name at the same time. This is possible as the branch name validation
> functions now return the reason they were about to die, when requested.
>
>     $ git branch -m tset master
>     fatal: branch 'tset' doesn't exist, and branch 'master' already exists

Nicely explained; easily understood.

> Note: Thanks to the strbuf API that made it possible to easily construct
> the composite error message strings!

This may be a problem. See below...

> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> ---
> diff --git a/builtin/branch.c b/builtin/branch.c
> +static void get_error_msg(struct strbuf* error_msg, const char* oldname, unsigned old_branch_exists,
> +                         const char* newname, enum branch_validation_result res)
> +{
> +       const char* connector_string = _(", and ");
> +
> +       if (!old_branch_exists) {
> +               strbuf_addf(error_msg, _("branch '%s' doesn't exist"), oldname);
> +       }
> +
> +       switch (res) {
> +               case BRANCH_EXISTS_NO_FORCE:
> +                       strbuf_addf(error_msg, "%s", (!old_branch_exists) ? connector_string : "");
> +                       strbuf_addf(error_msg,_("branch '%s' already exists"), newname);
> +                       break;
> +               case CANNOT_FORCE_UPDATE_CURRENT_BRANCH:
> +                       strbuf_addf(error_msg, "%s", (!old_branch_exists) ? connector_string : "");
> +                       strbuf_addstr(error_msg, _("cannot force update the current branch"));
> +                       break;
> +               case INVALID_BRANCH_NAME:
> +                       strbuf_addf(error_msg, "%s", (!old_branch_exists) ? connector_string : "");
> +                       strbuf_addf(error_msg, _("branch name '%s' is invalid"), newname);
> +                       break;
> +               /* not necessary to handle success cases */
> +               case BRANCH_EXISTS:
> +               case BRANCH_DOESNT_EXIST:
> +                       break;
> +       }
> +}

Translators can correct me, but this smells like "sentence lego"[1],
which we'd like to avoid. Translators lack full context when presented
with bits and pieces of a sentence like this, thus the translation may
be of poor quality; it may even be entirely incorrect since they don't
necessarily know how you will be composing the various pieces.

You _might_ be able to able to resolve this by dropping "and" from:

    "foo is moo, and bar is boo"

to turn the error messages into independent clauses:

    "foo is moo; bar is boo"

but I'm no translator, and even that may fail the lego sniff test.

A sure-fire way to avoid lego construction would be simply to emit
each messages on its own line:

    fatal: branch 'tset' doesn't exist
    fatal: branch 'master' already exists

(though, you might consider that too ugly).

[1]: http://www.gnu.org/software/gettext/manual/gettext.html#Preparing-Strings
