Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0489C433E5
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 16:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9858523118
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 16:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="IboJPnk/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgHXQgt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 12:36:49 -0400
Received: from out0.migadu.com ([94.23.1.103]:20578 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728290AbgHXQgb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 12:36:31 -0400
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1598286972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=CTDANAYF6lbZ9E2KrbZP12Kto3XtxsvFtO6oUVizR70=;
        b=IboJPnk/d0nPjLGUivkTrJoNloApG96T2Dpxn44prpXrfnDHHk9/u25VTW4N0PIWgXEimE
        +fWW2dDOr1KJW9GtkiQ5c/b9NJITNhFcAJcpErVBhBlPu5aXu2Wr5knkhEWJEv4B5tiJxP
        GoZUKW0yoE7ysUHRg+YFVcvCTKrA1kE=
Content-Type: text/plain; charset=UTF-8
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     <phillip.wood@dunelm.org.uk>, "Junio C Hamano" <gitster@pobox.com>
Cc:     "Thomas Sullivan" <tom@msbit.com.au>, <git@vger.kernel.org>
Subject: Re: git add intent-to-add then git add patch no longer allows edit
Date:   Mon, 24 Aug 2020 12:23:15 -0400
Message-Id: <C55D662I6OBC.4J2O3KP58DJ2@ziyou.local>
In-Reply-To: <4607f4b5-a5d6-7965-553f-19a52656fb13@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun Aug 23, 2020 at 12:03 PM EDT, Phillip Wood wrote:
> I think I was talking about edit rather than split. I'd forgotten that
> it used to work with i-t-a additions. I just checked seen and it seems
> to be working again since dscho's patch although the user is presented
> with the full diff header rather than just a hunk header in the editor.
> As you say once the user has staged some part of the diff the rest falls
> out naturally.

Which topic is this? I can't find one where it works (it's always
"Sorry, cannot edit this hunk" on seen 2.28.0.508.g7d1bebc7fe).

Yeah, it's split that would be a problem, edit just stages and moves on.
Split would be nice, but I don't actually recall it ever working before
- it doesn't work now on diffs from actual blank files. Getting edit
back (if there's a topic that does this already) makes it work for my
usage.
