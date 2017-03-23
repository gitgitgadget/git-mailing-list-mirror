Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEA6120958
	for <e@80x24.org>; Thu, 23 Mar 2017 22:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935240AbdCWWyr (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 18:54:47 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:35278 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932530AbdCWWyq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 18:54:46 -0400
Received: by mail-wr0-f181.google.com with SMTP id u1so22964569wra.2
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 15:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=tbwWDRG9uN/Bd5BQ+ePVDHCG+iV2Dz55kXleKhHuyDA=;
        b=SrKeP9xZakaXHJjaNoQb8C/DvARmklBLivyoG3Pvh7n+nMVVlqH+8LHzGObj3h7Mfd
         qPlfzrfDKg2BNemE6G138Qu4FZSh5Oh/X4Q686zLiBUBcxJo8drGCGAE5AqHNzpgbw8e
         Ttuqkqi7LaUNkVLeGStWkMoTlnSPTVh+L7JzYZhlG2ma75ouwjF3Dd4jeBueGmYAkIrk
         mXV2O4G40QkqCDG4fHogk4SGrfeZL5DiVtzDCm5wwe16FYg0fPgqo3lVDi+EFFGq4GWP
         XtJ5ICyCf17BafOiuAoSGsvl6u2A76bqM0TlpUUgfSOcjRRH2T63U7bvRCPW4s93XqUS
         l7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=tbwWDRG9uN/Bd5BQ+ePVDHCG+iV2Dz55kXleKhHuyDA=;
        b=fif0/AbGi8WiOtk/icAxt/XeAb9UUoCsH8l59ht2JONRpsw87VIfQJa76omTMYm9Ae
         j5rHU7unXWGGfDQF7vB/OFL7wikGmnEO8fSULBSjRnqcMGGUZx1d4sPVCCAyCGMLXANS
         64Ap6WFcrEGd0qC5dT6ECZjdkZNlopwgmmg04/qGvKtulr+x6g+J0939fgeSjuO6Pyvi
         2Ah9V+1ueW3t0ETDuoI6msEfGajcY0PCoYFRDog1elHSQmhpEy9fM3dpFlYH5aJZnPVd
         c8is16dpT3qKM+YILzDmv7uV5Yj7rQzg26Qff4/MdEdEIRJpoqMdjU2xJxzfhVktdEyC
         zs5w==
X-Gm-Message-State: AFeK/H04uJeZeUvQ8UL03zIdh22k67hkt3JNBqrU3C2KeR3FiKJJaRlP2EbeZVwjn86usw==
X-Received: by 10.223.134.231 with SMTP id 36mr5304379wry.46.1490309684220;
        Thu, 23 Mar 2017 15:54:44 -0700 (PDT)
Received: from [192.168.5.102] ([87.116.181.0])
        by smtp.gmail.com with ESMTPSA id c17sm512497wre.30.2017.03.23.15.54.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Mar 2017 15:54:43 -0700 (PDT)
Subject: Re: [git-gui] Amending doesn't preserve timestamp
To:     =?UTF-8?B?SnVyYWogT3LFoXVsacSH?= <juraj.orsulic@fer.hr>
References: <CAEPqvoxM9_Ku-1YgwNiqearUBaaYbAJcehuSwZYNNfJLQNH1_g@mail.gmail.com>
 <8a1179dfbb7743b6b8c23570306120b7@MAIL.fer.hr>
 <CAEPqvozCvFqOTNPw0c1ErKoOd+Mn1WCyJr9hj6CXiWWtL93Tqw@mail.gmail.com>
 <70bd7cfd05ae459dac94625bb78c26c3@MAIL.fer.hr>
 <CAEPqvoz8s=CVLABuXx-zOzryrXwr_cb39G2TYJvvFXRYzpCBFQ@mail.gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <851ca2c5-2224-2463-2b50-781861c95683@gmail.com>
Date:   Thu, 23 Mar 2017 23:54:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAEPqvoz8s=CVLABuXx-zOzryrXwr_cb39G2TYJvvFXRYzpCBFQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Juraj,

On 23/03/2017 15:26, Juraj Oršulić wrote:
> Hello Igor (and others), I have something else to report about the
> commit amend functionality in git-gui, and I think it could be
> related to my original question. It seems that git-gui messes up
> international signs on amending.
> 
> E.g. I use git gui to make a commit, and all is OK:
> 
> commit ef24b133dda6c18b8ef01b1a38f9e049d87f2021
> Author: Juraj Oršulić <juraj.orsulic@fer.hr>
> 
> I open git gui again, click "Amend Last Commit", press "Commit", and I
> get this in git log:
> 
> commit 6e09ff9edcef863d92f02cf86e0307c27171aec0
> Author: Juraj OrÅ¡uliÄ<U+0087> <juraj.orsulic@fer.hr>
> 
> 
> Does anyone have any idea what could be the cause?
> 
> I tested this on Ubuntu 16.04 and HEAD vearsion of git-gui on
> http://repo.or.cz/git-gui.git, currently 0.21.0.5.g5ab72.

Yes, I can confirm this.

git version 2.12.1.windows.1
git-gui version 0.21.GITGUI
Tcl/Tk version 8.6.6

That said, it seems there are quite some topics about it, like [1], 
[2], [3] and [4], but the most interesting one could be [5], having 
some kind of a "workaround" at the end as well.

I`ve tried replacing the "commit.tcl" file as proposed, and it seems 
to work correctly -- just please do note that it actually reverts the 
file in question to an older version, maybe (re)introducing other 
bugs while fixing this specific one, so it could be something you may 
want to investigate into a bit more before actually using it for good.

P.S. It might be a good idea to start a new topic in situations like 
this (send out a new e-mail instead of a reply), keeping unrelated 
discussions separated and helping interested parties spotting the new 
topic more easily.

Regards,
Buga

[1] https://public-inbox.org/git/588ac268-0a1b-6787-e6a1-4164e7e9a784@b-i-t.de/T/#ea05ebbde162f9c230a2cc4f7099363aed68768f6
[2] https://public-inbox.org/git/52E1627956F20E458D872C5961027EDC654FE17C@SGDS00759.zf-lenksysteme.net/T/#m0baea8c76e79f25bf92ca0deabe38efec2ee168d
[3] https://public-inbox.org/git/50913C58.2000200@drmicha.warpmail.net/T/#m72664106ad3070235ea2628b61fc6203fbb5563e
[4] https://public-inbox.org/git/20071212091744.GA5377@pvv.org/T/#m8490dd348389b4eea82eb1bdaab69227c946de19
[5] https://github.com/git-for-windows/git/issues/761
