Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4E43207F8
	for <e@80x24.org>; Thu,  4 May 2017 02:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753930AbdEDCTe (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 22:19:34 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36693 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753911AbdEDCTd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 22:19:33 -0400
Received: by mail-lf0-f67.google.com with SMTP id h4so57792lfj.3
        for <git@vger.kernel.org>; Wed, 03 May 2017 19:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OuN3XLbVFkQUZINKoKlH2juspw5Y+1mu2S/kDAYtr1o=;
        b=iMYUdOhxz+GAc7cDcLqnRFyZ6wqoyHmaKZ09KC3WXGiJrpbxs/UAsE+y/UgT0Ujv5S
         i72d3ECy9BfsPkyM832DVHuqvTmbomB8d9iPBjHcaia2K/DW+0OAikig85PGft2Jn/FT
         cMOeRLcXqUSjWV0ZVM2rLTnLufmZZby38cqxT347IXxrnJCRdvUlXBU05ez75s4GKjwk
         64ftpGMFz1trnLYY72i7qmOQtrEQmi8Adv+RB4bHrkiyvgT6FMPIlFGyvJb0xvg0wm4K
         zZ9GY4cxKRumW30YuWA928aQzTkAC37DZm2YEzo6lx6/olfRPgF7ouM2910MVm5j9PYY
         y55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OuN3XLbVFkQUZINKoKlH2juspw5Y+1mu2S/kDAYtr1o=;
        b=U74uez3zecPJwR5bLzkk0mEr2xc0Nmt3uQt44Prz+E40O3jxe95eZ6zDYWh5pspA9Y
         wO7FEGw1UAsIZiH5Qybhl+zTFyHJwX72LydBDsgCgmbrnxB1mON/s3sOSvhhAjENkAQg
         +P7MxqFyrf7jcOmOqHf9X8Qk8eocFR9GXPpWs18gmQgUxmCtUzXDGM2fNSLfaaXaURr2
         g9KWHTfdYAxZ6MB6+yLfx1R53fCjJ6CD18UgreD6KTnDz8jmJYNvDm/pyg1tQNpH4ETr
         F81EaZxBx9WG2apDN8CFVtGfJJ4r36ZtLTkk6tXf7kEqvBJ3XOpGGq2Kgw3LZDno/HFG
         igpw==
X-Gm-Message-State: AN3rC/57YIjU+OO8GuDxHBCri9rVZFh1f9itfqBc2tXjwzq7+na3btSf
        ObFwb64g11Kbg5rNigMzswg6fAk6lw==
X-Received: by 10.25.67.13 with SMTP id q13mr12705156lfa.36.1493864371771;
 Wed, 03 May 2017 19:19:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.43.75 with HTTP; Wed, 3 May 2017 19:18:50 -0700 (PDT)
In-Reply-To: <xmqqk25xct1w.fsf@gitster.mtv.corp.google.com>
References: <20170429122632.7122-1-zxq_yx_007@163.com> <xmqqo9vdiboz.fsf@gitster.mtv.corp.google.com>
 <743D62FA-65B9-4DCC-978E-DAF442AE0B0D@163.com> <CACBZZX6fursxEaBGr9raz+x8qBm0WZrmHCkMbtpajRzOM3B6qA@mail.gmail.com>
 <xmqqk25xct1w.fsf@gitster.mtv.corp.google.com>
From:   Ramkumar Ramachandra <artagnon@gmail.com>
Date:   Wed, 3 May 2017 22:18:50 -0400
Message-ID: <CALkWK0kceHMyjuKvTa=CQZsGnXKaUuG6=G-HxEFSHaN+dqe6nw@mail.gmail.com>
Subject: Re: [PATCH] send-email: new option to walkaround email server limits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?B?6LW15bCP5by6?= <zxq_yx_007@163.com>,
        Git Mailing List <git@vger.kernel.org>,
        viktorin@rehivetech.com, mst@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, mina86@mina86.com
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For the list, in plain text:

IIUC, they use the date received to sort. I think this might stem from
a historical cruft: emails sometimes took non-trivial amounts of time
to transit, back in the old days. MUAs (especially web-based ones)
probably did not want to violate user expectation by placing a new
email under several already-read emails. I would argue that this was
reasonable behavior. Further, since email is near-instantaneous today,
it really makes no difference which way the MUA sorts. Except for git
send-email.

It might be acceptable to put in a "practical hack" to help out MUAs
in the context of "near instant forwarding". I would argue against it
on grounds of it being an ugly hack, for very little benefit. The
patch that began this thread is also ugly, but has the important
consequence of enabling some people to use git send-email at all.

p.s- We should probably allow emails from mobile devices on the list.
It usually contains a HTML subpart.
