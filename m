Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D1FE2013E
	for <e@80x24.org>; Fri,  3 Mar 2017 02:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751506AbdCCCmQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 21:42:16 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35831 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751465AbdCCCmP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 21:42:15 -0500
Received: by mail-qk0-f176.google.com with SMTP id h9so1612658qke.2
        for <git@vger.kernel.org>; Thu, 02 Mar 2017 18:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Mzpr41K7l6U/qpIMoQaRCLzfucM+SOKPKB5kvaN3chg=;
        b=M3NqhAPD3Ryp3wrNCekf8nvBXdCD+7E6djnZ3BDWc7wACNOgFYiv2ENWCFfWf/JMrJ
         iEJWjf4Qqg4kIuQcWX2F20Qv+vQ9mn/P2gjvkT8vJ32XX6TH1vyFa64MLGC23C1sv+py
         5QaqYph35st+uNkQcf6PKqAPC2FVGQ4fqrHCKA861fzbIpCON77IWNDhG5MbxhKsHGyw
         Zke4kcfr7GvJbA5jEzSyOJymGBTCT7+SoYfGYVSa4j7iDNde8vTgUSwh/XtsI51c4dmj
         IizeKDbwSiiRo5L9oN3nDUJ0dis9OUKbRKCg9a75ukOtMkBs3aJ4j8Vla+YWhiS3La1H
         5nhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Mzpr41K7l6U/qpIMoQaRCLzfucM+SOKPKB5kvaN3chg=;
        b=dB9j6DKA9ucJQfA2czG3j00ThV9sRfkwneznvRR+eCsHCw5fJy6v0nAvRshD/L+dZI
         DvXACXwcow+9imPbWbf4PVjl7ylbEH32FhexncKBTMCzIZdzRAQruOBWbEryufr8KKF7
         tUD6INHFKR/ntNJrzSLbyOHzcv2UQVCLZ1LPjZznsOR9zlLLFcitAhYXFYIdJc/s5tbB
         VIhDXsdpjoslfRD3s/TflPnUWagFtZiloTloZcBKWivLi8d/oPuG2jzv/bOjJsh5SNsm
         x+7TFirRS6XrjBeiD3NXE5g0cn+vGINkblEvClyDdg6isZf2ngAV1KtWYCCQLHJI/990
         bZaA==
X-Gm-Message-State: AMke39l4B8zLoujW75wyuMOPH9FwzMJk5V7+X4NBZ73MHP2RqHGWLJTq/t74uFgEVrgnac2vzy9oFXyJ+XnesQ==
X-Received: by 10.55.69.68 with SMTP id s65mr223357qka.43.1488504998109; Thu,
 02 Mar 2017 17:36:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.178.20 with HTTP; Thu, 2 Mar 2017 17:36:17 -0800 (PST)
In-Reply-To: <7a0992eb-adb9-a7a1-cfaa-3384bc4d3e5c@virtuell-zuhause.de>
References: <7a0992eb-adb9-a7a1-cfaa-3384bc4d3e5c@virtuell-zuhause.de>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Thu, 2 Mar 2017 17:36:17 -0800
X-Google-Sender-Auth: stO_bEd-YI7QD0f3Y1cUExJBwbI
Message-ID: <CAPc5daVSY5Z_+cpT1dHY-cM-TzNeu+Vzv+zouoOHW08PTFRQ7A@mail.gmail.com>
Subject: Re: log -S/-G (aka pickaxe) searches binary files by default
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 2, 2017 at 4:52 PM, Thomas Braun
<thomas.braun@virtuell-zuhause.de> wrote:
>
> I happen to have quite large binary files in my repos.
>
> Today I realized that a line like
> git log -G a
> searches also files found to be binary (or explicitly marked as binary).
>
> Is that on purpose?

No, it's a mere oversight (as I do not think I never even thought
about special casing binary
files from day one, it is unlikely that you would find _any_ old
version of Git that behaves
differently).
