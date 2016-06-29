Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D4182018A
	for <e@80x24.org>; Wed, 29 Jun 2016 04:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbcF2EHR (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 00:07:17 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36450 "EHLO
	mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbcF2EHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 00:07:16 -0400
Received: by mail-it0-f68.google.com with SMTP id h190so4098395ith.3
        for <git@vger.kernel.org>; Tue, 28 Jun 2016 21:07:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=k09a/6H45h1QdEzkaBvD7aUTBdjL8Y7f7cXxJv5Ew7E=;
        b=UqmXtZQefz/Zwb48JFwugLEoSP5Qox5Vr9gJvWJNvlmgCyfgNBEYU7t9xAqJRMg7us
         4UtEpZoRn/OdLBipStootlPaJfVBJFHoXHhGQD09rn+okt7srAspbcZjPi3tdonoVv0v
         FIW276LGd8kMl17oxDBkdONjc9fXdG/eis8Ze6q5R8VT1AaCHrW/JW0UEN4bW39xdE8H
         S0Ame1rMIeMuBrY7DP7bsAm4wlXPOzAHNDbDoYdNLwHku0aOU2/q5RQM7d3gl0Le0r/x
         3Xjkel+/aFEvJzMgeGbVIjaXICZnjsO9OcIERXyH2lZCxb/xJ0R3SgaIJkJvQSB7+CQ9
         kpWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=k09a/6H45h1QdEzkaBvD7aUTBdjL8Y7f7cXxJv5Ew7E=;
        b=dysHZL1xe54xTtjRmDJCelu/aWdMKa4oViqacLA35z4NG+n/DZ2P6y6VWD9USxEPn3
         vUOqYrlx8wt/4kYNiz45pHoyWIITMsA3p7OPXybq//7Dt99XbpcAo6KgXGWK1QL3Nc9S
         Bs0eW4ccZ2PiFo/RHoq+w4xKQ3bLTFx3iNWFxsUMw2cAH48wef6tnPespDQRzqrXWY1i
         60PIsLwIMPlBkivaVHB+LJgfGekapFqo5bV279S+K4NZAi+SAzb530w8WAMg3RhbSyny
         wk8Qqm1doOIEizfGrk8OtpSVFi2+rP8O//HTjNEL4cd9lqqZ5Yj4CiyRe5S1LkYK8J/0
         261A==
X-Gm-Message-State: ALyK8tLihMEty/VpgQPdtys6uSz8cacqdd0lzX4WTrM7EmF/0VHqesP2PZgedsekziAtkDk6lb/st1W6AFQH8Q==
X-Received: by 10.36.84.79 with SMTP id t76mr19034684ita.63.1467173233907;
 Tue, 28 Jun 2016 21:07:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Tue, 28 Jun 2016 21:06:44 -0700 (PDT)
In-Reply-To: <20160628204959.GB21002@sigill.intra.peff.net>
References: <20160626070617.30211-1-pclouds@gmail.com> <20160628172641.26381-1-pclouds@gmail.com>
 <20160628172641.26381-3-pclouds@gmail.com> <20160628204959.GB21002@sigill.intra.peff.net>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Wed, 29 Jun 2016 06:06:44 +0200
Message-ID: <CACsJy8BQu6vcxdt0tESjBJVnbmvmW8oRNkLfMA157s1bE-S_eA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] config: add conditional include
To:	Jeff King <peff@peff.net>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jun 28, 2016 at 10:49 PM, Jeff King <peff@peff.net> wrote:
>> +static int prepare_include_condition_pattern(struct strbuf *pat)
>> +{
>> +     struct strbuf path = STRBUF_INIT;
>> +     int prefix = 0;
>> +
>> +     /* TODO: maybe support ~user/ too */
>> +     if (pat->buf[0] == '~' && is_dir_sep(pat->buf[1])) {
>> +             const char *home = getenv("HOME");
>> +
>> +             if (!home)
>> +                     return error(_("$HOME is not defined"));
>> +
>> +             strbuf_add_absolute_path(&path, home);
>> +             strbuf_splice(pat, 0, 1, path.buf, path.len);
>> +             prefix = path.len + 1 /*slash*/;
>
> Why did you drop expand_user_path() here?
>
> I guess it's to do with knowing the length of the prefix portion? I'm
> not sure I understand why the prefix is necessary. I thought the goal
> was to construct a wildmatch pattern that could be used against
> get_git_dir().

We need to make sure any '*', '?' and '[' in the $HOME (or `pwd`)
portion are not automatically promoted to wildcards. One option is
split the pattern in two parts, the prefix part is matched literally
then the rest passed to wildmatch(). The other option is escape
$HOME/`pwd`, but I think that's more complicated (or at least slower).
-- 
Duy
