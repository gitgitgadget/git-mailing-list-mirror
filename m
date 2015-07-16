From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: A few "linked checkout" niggles
Date: Fri, 17 Jul 2015 06:13:48 +0700
Message-ID: <CACsJy8CC_fju1Vy-hN69rKdpZ=XDUdZ_H_pmUb0bJdt-LdiPew@mail.gmail.com>
References: <xmqqoajdui8w.fsf@gitster.dls.corp.google.com> <xmqqd1zr4z28.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 01:14:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFsMB-0003ym-AP
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 01:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbbGPXOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 19:14:18 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:36193 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbbGPXOS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 19:14:18 -0400
Received: by igbij6 with SMTP id ij6so25739380igb.1
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 16:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nRdkRWaGPTr/U6cTGGZQRnz56jHrJuDlhuOLj+ddt8A=;
        b=qbSW6jdJGVw3kgP10CQvF1geB7EjTQg07epTlme1ipizD73x0a/tdCv5ZXdj0sYVC6
         f1sYDn7in86aSC8tLbERDloWw5Y2t6aIKmT2CP/th4aZhs0G0wtqI84w7mi2Rk/6ftgI
         JkGopJsoBCJmIcHCrRhr8eHzN0NWCEdrcpp29Q/OJ2jxr1xD/O4eWDFtm2rxDO8zFnRZ
         2JxhOPVUgJe9c6Y7WuFuleFC4bySWYPwiY8wYo6HLn8gQCV6IVdROv+133VzcXmsoAYt
         LL1+5Wg2qMj4xIbIg1r7gKKscp385bl7PUkqsyoEN6f0oOhnGFMAlpwZXtvMeVaRH3Am
         Nw/Q==
X-Received: by 10.50.28.78 with SMTP id z14mr6754990igg.61.1437088457445; Thu,
 16 Jul 2015 16:14:17 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Thu, 16 Jul 2015 16:13:48 -0700 (PDT)
In-Reply-To: <xmqqd1zr4z28.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274050>

On Fri, Jul 17, 2015 at 3:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Also in a linked checkout of git.git itself, t5601.21 seems to fail
> with:
>
> fatal: Not a git repository: /home/gitster/w/src/.git/worktrees/rerere
> not ok 21 - clone respects global branch.autosetuprebase
> #
> #               (
> #                       test_config="$HOME/.gitconfig" &&
> #                       git config -f "$test_config" branch.autosetuprebase remote &&
> #                       rm -fr dst &&
> #                       git clone src dst &&
> #                       cd dst &&
> #                       actual="z$(git config branch.master.rebase)" &&
> #                       test ztrue = $actual
> #               )
> #
>
> This test is running in /home/gitster/w/rerere, whose .git points at
> that directory the fatail: message complains about.

I can't reproduce with either master, next or pu. Seems strange that
git.git info is leaking into this test..
-- 
Duy
