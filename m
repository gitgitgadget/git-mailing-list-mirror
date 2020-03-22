Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E40C4332B
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 19:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8353720719
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 19:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgCVTEZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 15:04:25 -0400
Received: from ciao.gmane.io ([159.69.161.202]:35304 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbgCVTEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 15:04:25 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Mar 2020 15:04:25 EDT
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcvg-git-3@m.gmane-mx.org>)
        id 1jG5oh-000Qw9-1V
        for git@vger.kernel.org; Sun, 22 Mar 2020 19:59:23 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Achim Gratz <Stromeko@nexgo.de>
Subject: Re: GIT_ASKPASS absolute path detection bug on Windows
Date:   Sun, 22 Mar 2020 19:59:15 +0100
Organization: Linux Private Site
Message-ID: <87zhc8fc70.fsf@Rainer.invalid>
References: <CANPdQv+tCnfy_csM8EwuqAYBtgkJ3RhRvo+ALbzO=BcZA7qJtg@mail.gmail.com>
        <20200322073105.zh2tqycu2fgydf3e@tb-raspi4>
        <CANPdQvK4LRZ2b_K0QuWErxNcc2wpW0W4zvmj3HzKDnOvgBNHfw@mail.gmail.com>
        <20200322165915.GA6499@camp.crustytoothpaste.net>
        <20200322180730.57pe4awhglmmlxpm@tb-raspi4>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Cancel-Lock: sha1:XkD89X2FVvkP6seddLPvDs2DxaA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten Bögershausen writes:
> C:/MyTool.BAT is a valid Windows file name even under Windows.

Not all Windows programs handle that correctly, though.

> Cygwin preferres /cygdrive/cMyTool.BAT

The /cygdrive prefix can be changed, however.  If you want to be
independent of such vagaries, use /proc/cygdrive instead (use cygpath -U
instead of cygpath -u).

> Git under Cygwin should handle C:/MyTool.BAT correctly, and to my
> understanding it does.

Yes, but there is always the possiblity of some shell script somewhere
missing that boat.  You are best off normalizing to POSIX conventions as
early as possible and keep it that way until you hand off to a Windows
program.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Wavetables for the Waldorf Blofeld:
http://Synth.Stromeko.net/Downloads.html#BlofeldUserWavetables

