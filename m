Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FF2920706
	for <e@80x24.org>; Tue,  5 Jul 2016 15:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755341AbcGEP7o (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 11:59:44 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:36237 "EHLO
	mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754770AbcGEP7o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 11:59:44 -0400
Received: by mail-it0-f51.google.com with SMTP id g4so44838224ith.1
        for <git@vger.kernel.org>; Tue, 05 Jul 2016 08:59:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HZMyl+NjgNwjziNT9CrMEFSJZqSNIJP4+1N7G7S/9dI=;
        b=oGSlMFjC2gkNyYjwKVny0p+ohyjmP4yNoNvb/tqquiZ9EnnmvY0ZWPlNDcV6GcQkon
         dcBiJtSUbVat2RHbamy69QY0nQIzzt7cN8ZUqCUzacRQ0HJmJBSILHRuxb9FP2uz9hHo
         OcjLmmQXTHIbZlUXa/CRbY5LS5r1JGiAeavZGAEISs53W/Cr/tMOVc4I+h1etSO1ckm6
         hWX6bDtcubsp1S2OKeBS4ZH52Z1IkBHBr+8ACiLuy/T0ZFqYTQX1av7PO9rZNv868atK
         5usXA8QGrZcrVR6P1zmXFP2fYmzl5OZotqXqSMgqrrbIjJQdqg3N8e1BeEnnWW7dvDA7
         XcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HZMyl+NjgNwjziNT9CrMEFSJZqSNIJP4+1N7G7S/9dI=;
        b=VFKXbA5z3RDrjwnwBfqjoTv5We2AaToyxkttOAVfew3DAcqaM4ECcwnCLtNDefiM/4
         ZTa/9H8XPcuIN3sUhb3RJu0l7BWNvLMfUDgJwxvIBWe0zemrK1OH1vI6Z1YAqilE4sAj
         uTKHXffzrJ/5asbg4AExxdtr4TRgwsnl3HxPtbFO+QTBNvAyrk35+2nX26E4y49N4ZoO
         wol8UIcdt1LgizC1kvXN90FwOgMtJtZw0grBT/Dq7KCVx4In1d3rIxA9oyGWAlAO6GPe
         W4xkGUl0r5A7Ho8Xizka14Iw+x11V7R8FmZP/JjfodqbIJqK704xsTRu/lyA9xA4hmyI
         y4hw==
X-Gm-Message-State: ALyK8tJKNB4dzFfLEnGa9CZB9pXzV6M2DCIXeHathkU6Iuuynz0ER/bMTiRfq+vsQzAZxB+MiITnwE3p95hC6w==
X-Received: by 10.36.123.199 with SMTP id q190mr14843779itc.42.1467734382270;
 Tue, 05 Jul 2016 08:59:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Tue, 5 Jul 2016 08:59:11 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1607051704490.8378@virtualbox>
References: <alpine.DEB.2.20.1607051704490.8378@virtualbox>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Tue, 5 Jul 2016 17:59:11 +0200
Message-ID: <CACsJy8A=_0RfMsDkqyeyro3Xw3NbS4qU0bkVAkapky52jphH7w@mail.gmail.com>
Subject: Re: reflogs and worktrees?
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 5, 2016 at 5:07 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Duy,
>
> ever since I started working extensively with worktrees, I end up with
> these funny gc problems, like broken links and stale reflogs.

Yeah we have problem with gc not traversing all worktree refs. I had
something that could fix it temporarily [1] but the decision was to
wait for refs code to support new "worktree storage" so that we can
walk worktree refs properly, then fix gc [2]. We should get pretty
close to that point after [3] lands.

[1] http://thread.gmane.org/gmane.comp.version-control.git/295961/focus=296076
[2] http://thread.gmane.org/gmane.comp.version-control.git/295961/focus=296219
[3] http://thread.gmane.org/gmane.comp.version-control.git/296409

> Is it maybe possible that the reflogs (which are per-worktree now) are not
> traversed completely when gc'ing (which is *not* per-worktree)?
-- 
Duy
