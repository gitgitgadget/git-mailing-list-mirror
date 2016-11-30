Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F08D31FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 19:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932336AbcK3ToU (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 14:44:20 -0500
Received: from mail-yw0-f175.google.com ([209.85.161.175]:34850 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754476AbcK3Tm7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 14:42:59 -0500
Received: by mail-yw0-f175.google.com with SMTP id i145so164150957ywg.2
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 11:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=barzilay-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=f9wLKTnKxBoz0277Y3fKYd7fOIB3jjbTm4/SqjaRESI=;
        b=lV+h5Ot33b6ghEFyocFAZsmJ7iopQ8IBAnK+TQ1bCxn3qXSAGQLz+Chs9xYPfCylKN
         JnyL0cs4cWBc3cHrcjKL84qpVTEO8eNONXV+ETR9AdmywphaGKGiO7I9zLaRNAQByYKA
         2nt9+IMYXvijqiqvOqg7rbOwzwGb20QKoGoC2Ua3c3qTC4qhCALlSVkeo1hakt0PtMem
         55fx76TIm+oZWE+DpycYY0Fi+uNLvPGX4ToYIg0S1enlz3NZvEi8S8syC+hd/JbJuyB3
         bH5CazB6joR2Pl09Wprk2Ipp+wnN5LdRQngnof/xMcEJsv44a8Kwk/MrBvCZHmNjxyve
         Qeqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f9wLKTnKxBoz0277Y3fKYd7fOIB3jjbTm4/SqjaRESI=;
        b=kxYLwUp2jBIzI8vZ2aBqWHRq9esMKBSiQR0b4AC7Q4O9JHyoC+qQJGcognxlhYrALJ
         EAvMRy+TaOQtGb3C5+/NmKneXcO0VTvNyG9WuBZVUuT1OIrEvaiQcGUN047vpUNpOubn
         qJF3oo99o0YgDeIGFJYDHRFRgJqlnBdQDmr+dq3OEEzo2dMCSvqP+e0sqiGo3faWrDt+
         6gV43qvub5O6dpIe3UcwOs22yHebG70ywrok1AF+TCzBwt3CaDkLU1UPiR+e2w/bdFMd
         9x7Bt75xM7WZLnZIAZA8xjJ26EpkHiW4ZqDSZKLJ/CCAlxRUlSigvjNexO6aP/yS77tH
         ztxA==
X-Gm-Message-State: AKaTC00WW0qS760yBw7Cv/tYGZsc6mNFVAFE2591m+DCygdKcIFshSy2P0tpRZr2ajNqcSdzrroZagpp98WLeQ==
X-Received: by 10.129.113.84 with SMTP id m81mr41477912ywc.223.1480534978690;
 Wed, 30 Nov 2016 11:42:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.98.77 with HTTP; Wed, 30 Nov 2016 11:42:58 -0800 (PST)
In-Reply-To: <20161130190653.kk5pboas54yen2it@sigill.intra.peff.net>
References: <CALO-gutW80d6RLdXAtYA2m2GWOchAjNNPy3YCsr31_fCss512g@mail.gmail.com>
 <xmqq7f7mf4rs.fsf@gitster.mtv.corp.google.com> <CALO-gutJbM=LA3q8vdmbQJLoeCFAJWfPHFo8f1vz-5KJHVxJ6g@mail.gmail.com>
 <20161129214604.c5xcw3d2a5ydpx42@sigill.intra.peff.net> <xmqqeg1udkg4.fsf@gitster.mtv.corp.google.com>
 <CALO-gusHzTaLg=7X=KqYB==Yz_6yH6qkh8GDK54Lacu5ofD2pw@mail.gmail.com> <20161130190653.kk5pboas54yen2it@sigill.intra.peff.net>
From:   Eli Barzilay <eli@barzilay.org>
Date:   Wed, 30 Nov 2016 14:42:58 -0500
Message-ID: <CALO-guvsVgHp41ubvuKzmH3c4rE+3io3GaYie3=Q-4jdG91CDQ@mail.gmail.com>
Subject: Re: gitconfig includes
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 30, 2016 at 2:06 PM, Jeff King <peff@peff.net> wrote:
>
> I'm not sure what your script does exactly, but in general I think the
> right thing for most scripts is _not_ to use a specific-file option
> like --global.
>
> If the script is looking up a config value on behalf of a user, it
> probably makes sense for it to use the normal config lookup procedure
> (system, global, repo, command-line), which also enables includes by
> default. That would make it consistent with internal git config
> lookups (e.g., user.name probably only ever appears in global config,
> but you _can_ override it at the repo level if you want to).

This is intended for git newbies (and big company => infinite supply of
them), and also allows them to conveniently nuke the repo and start from
a fresh copy, so it makes sense to make the script inspect/tweak the
global settings.  If knowing git "well enough" was an assumed
requirement, I'd definitely do the normal thing.


> I know that's mostly orthogonal to what we're discussing, but I'd feel
> more convinced that enabling "--includes" with "--global" is useful if
> I thought that "--global" was useful in the first place outside of a
> few narrow debugging cases.

Ok.  Perhaps I overestimated the utility of --global anyway, given the
above...

-- 
                   ((x=>x(x))(x=>x(x)))                  Eli Barzilay:
                   http://barzilay.org/                  Maze is Life!
