Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51E521F576
	for <e@80x24.org>; Thu, 15 Feb 2018 10:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755382AbeBOKLn (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 05:11:43 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:33040 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbeBOKLm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 05:11:42 -0500
Received: by mail-ot0-f194.google.com with SMTP id q9so22947021oti.0
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 02:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Msm4vL2mTgHinkmKuHlb0YEtb7mZzmnQN2XQwpM8PeU=;
        b=OM2sWLu7VdQD5MROx1rJLMM1L3PAzpShCEFpnCD7CDMC8qoF5xp/8ZHpEGXORHZ8EA
         5DgBzL/H2a7IPN4eI5AlQyJyjzFfcV26ZHlywVRqVSWcowVnzXCLALRhu2YGxqyVATzY
         8+L7anJWIidlWjCHLnQKDSEl0N1Y2pvI3okcs40ep0ypj09S4U2SeQ7S4tOwCMwWXHYT
         8v3iziiaRfBTq5bX02yG+EZGVqAgzVb9W2DG4l5ejBXgrIv3Na13ThXyGNvbIWoMs71b
         ccZIwRLLr2r0eGic7ZZ3YhctKU2LCxZt4ftuYIqWnBre37EOLNpjgKQsmoX8cTU4hpJS
         517A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Msm4vL2mTgHinkmKuHlb0YEtb7mZzmnQN2XQwpM8PeU=;
        b=f5pXbu1CNmq40uvzV3IfxaLUzT12g7J9rfAA/Rn3yWHvnddCf98A7Fw7FMqhNwhc39
         QGaiMYjl8YiFNgUbkqbTH/nDJt7ZLFoPFWbW68ZBQ012siidRg6GT6Ntenya155Y9UpB
         p1RX/dcRD/OXnbLqo0LQt7Rv3N6xZ95r+Smb0Xk/zm3YsbtwXaofaQK4fi6uIbPd4mWu
         59pKxlkBqKlD3+7pcMm39CPhWBm2sUFF4A72GOLpoPdOkr4C3kBNMNQ3MYV7VdjkSS4v
         0y6n5nyzA3tT7hTJjLSFceLUYNpiJ3zBQj9lBuIZ87TDr97XHocGNhF3xs4/yrZFNP9O
         ZqYQ==
X-Gm-Message-State: APf1xPCVOnsuIQp6Ey+DuJsu7PiRp/9igI/ZdzFCCqX1gqwO7zwtSdrQ
        M/OAVZ/1tSTlwMAOfKlK6VUM4MafaDOeO+nDp+o=
X-Google-Smtp-Source: AH8x224Oy/rPRcoZ7HyfLdPVoFkdJE7LcYcEjRmIV6Lls94NcVSoYOqo6/IOXuugw8lOmdTPaT+C2Qqf7ZmJ61DESUc=
X-Received: by 10.157.46.50 with SMTP id q47mr1466828otb.109.1518689501616;
 Thu, 15 Feb 2018 02:11:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.0.2 with HTTP; Thu, 15 Feb 2018 02:11:41 -0800 (PST)
In-Reply-To: <CAGZ79kZf1UKsBEJXuwAH+EWr+ZKj-FE8DuBvcM2nJeNhLEA4CQ@mail.gmail.com>
References: <CAEWZXo7KiRWK7ddyZgQKs=F+sHY7TtFsXTMXyE-57=FRr6kf6w@mail.gmail.com>
 <CAGZ79kZf1UKsBEJXuwAH+EWr+ZKj-FE8DuBvcM2nJeNhLEA4CQ@mail.gmail.com>
From:   Paul Tan <pyokagan@gmail.com>
Date:   Thu, 15 Feb 2018 18:11:41 +0800
Message-ID: <CACRoPnROrHbdOf_dCbYhGXSnqM4gowj_s50RcH+8vWgU+deCdw@mail.gmail.com>
Subject: Re: git-rebase --undo-skip proposal
To:     Psidium Guajava <psiidium@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>, jacob.keller@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Gabriel,

On Wed, Feb 14, 2018 at 4:42 AM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Feb 13, 2018 at 12:22 PM, Psidium Guajava <psiidium@gmail.com> wrote:
>>
>> Also, a little unrelated with this issue:
>> 5. What happened to the rewrite of rebase in C [2]? I couldn't find
>> any information after 2016.
>>
>> [1] https://public-inbox.org/git/201311011522.44631.thomas@koch.ro/
>> [2] https://public-inbox.org/git/1457779597-6918-1-git-send-email-pyokagan@gmail.com/
>
> cc'd Paul Tan, maybe he recalls the situation.

It was discarded in favor of Johannes' rebase-helper approach, and I
think parts of it are already in master. There's probably room for
help there.

I haven't had time to keep track of Git development, hence my
inactivity. Sorry about that.

Regards,
Paul
