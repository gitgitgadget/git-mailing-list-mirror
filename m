Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A790C1F404
	for <e@80x24.org>; Mon,  5 Feb 2018 14:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752855AbeBEOAZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 09:00:25 -0500
Received: from mail-oi0-f45.google.com ([209.85.218.45]:33773 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752612AbeBEOAX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 09:00:23 -0500
Received: by mail-oi0-f45.google.com with SMTP id l8so21219614oig.0
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 06:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rCy4hgKxDFWqZK4tUhx39X+bnpXSfpHrvk6md2NIW64=;
        b=Sbhn79v4IvETLzBF1/WiMhFakuRaUjr8ugMp4q7rWPtijyNL/Gv3cFuKIMMAYdo4DE
         l55nx4sPCWOX2qGkK7Wfl/t5L+5FDV/cvZ+UG1HqXkO3ZHMvQNMRlleatrvi9EPhO/uB
         KPLywDl6p4fEoqVmf+Anqv4NgK7GD/qqewE1CA3N9RN57hx0hwnEWwcxKuX8zYxwAFEW
         QFTDGSOa9zhmXeUF9qTZ2oToYQoXHiXo3I3uSrtqXj+NNlbptP1nO+lrKz20MmdofULt
         a25k5IxnLm0z0fsOuy1Dnucx5SEmVvKVlXZ1Jv98lFUpfPMO/neh0AElCP6+huwsZ2bL
         ogng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rCy4hgKxDFWqZK4tUhx39X+bnpXSfpHrvk6md2NIW64=;
        b=IrVP9ILg7M2TqCM7wnlDgQ+o+zoPFpllZGyqbBYvd4Eziaq2yDLEa63FBPzGbrTDE6
         cmBpQW22iI89xaNQa45AD6hee+t9zwVNPPkJ5Tba//qGTw8RqzUsKimz8rW6JKNu67JD
         LQOPkXcJVeR4XVkAp0aE9AGS0Dmom8h8/2jHVt0pk8deSx0tvJPkxhDRVLuZ2HQ0sMki
         qDTrUVzXXI9w4jh5A9hz3jXIG+Dn3iLXZDuoWE4uPFRblp82aJO0vd0R40BWeTQMkSAa
         NNOFF+M/1qrc5iIckrmsgWFxFtmZ3ftaOZmVOGK93/5qyDtNzhXPF8FYueSH+qPO4Jo4
         nQ9w==
X-Gm-Message-State: AKwxytfTtQLyM/5D+RnMuSyFnB98USomnrvY34cg0t1C2wXHQdt/dNK9
        4SkrGMU9NfbtBAxZNwtkFtZTBzJ6oiUu5v5TPDM=
X-Google-Smtp-Source: AH8x224wdiMAhtp4XtANO7bM2TxyDf7EVXQOijWnTt0ZI3x1wsQnh4Vc/mjeQNuoIbYtvgsOlYiRqi4sSq5kHdk8yYs=
X-Received: by 10.202.66.10 with SMTP id p10mr9390384oia.297.1517839222991;
 Mon, 05 Feb 2018 06:00:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Mon, 5 Feb 2018 05:59:52 -0800 (PST)
In-Reply-To: <trinity-5e3c4029-b348-4bd5-9337-215808436a12-1517838482997@3c-app-gmx-bs16>
References: <trinity-cb66d9d6-9035-4c98-948e-6857a7bd4de2-1517838396145@3c-app-gmx-bs16>
 <trinity-5e3c4029-b348-4bd5-9337-215808436a12-1517838482997@3c-app-gmx-bs16>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 5 Feb 2018 20:59:52 +0700
Message-ID: <CACsJy8CGQ4ynYFT0mY1DfcGGdzwP36eonMvr-kEZazX_82ag2Q@mail.gmail.com>
Subject: Re: Bug? Error during commit
To:     Andreas Kalz <andreas-kalz@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 5, 2018 at 8:48 PM, Andreas Kalz <andreas-kalz@gmx.de> wrote:
> Hello,
>
> I am using git frequently and usually it is running great.
>
> I read to write to this eMail address regarding problems and possible bugs.
> I am using git version 2.16.1.windows.2 / 64 Bit and during commit the following error message comes up:
> e:\Internet>git commit -m 2018-01-27
> fatal: unable to generate diffstat for Thunderbird/andreas-kalz.de/Mail/pop.gmx.net/Inbox
> [master f74cf30] 2018-01-27
>
> I also tried this before with an older git version with same problem.
>
> Can you help me with this problem please? Thanks in advance.

I think if you add -q to that "git commit" command, diffstat is not
generated and you can get past that. If that particular commit can be
published in public, it'll help us find out why diffstat could not be
generated.
-- 
Duy
