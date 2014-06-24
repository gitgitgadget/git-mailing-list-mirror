From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 06/10] setup_git_env: use git_pathdup instead of
 xmalloc + sprintf
Date: Tue, 24 Jun 2014 20:02:21 +0700
Message-ID: <CACsJy8ACXPq+-py+vwDFg9nfB6eaC5jy+nXpHn8y6QEe88FuLg@mail.gmail.com>
References: <20140619211659.GA32412@sigill.intra.peff.net> <20140619212800.GF28474@sigill.intra.peff.net>
 <CAPig+cTyZxH6Ka3JVpYBP7=i=HAWoSYBt9MScwfVaTcKKmi1UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 15:02:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzQNE-0008Ls-Nv
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 15:02:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874AbaFXNCx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 09:02:53 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:55422 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbaFXNCw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2014 09:02:52 -0400
Received: by mail-qc0-f174.google.com with SMTP id x13so218401qcv.33
        for <git@vger.kernel.org>; Tue, 24 Jun 2014 06:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=iWNJPprAbmm765kHyS/qLIrWqqvXeMyG+vaRA0kiv9o=;
        b=I1us6Mj14SbNhNCN4IGYeJvillpOtqbYmz7X3gbRCOBJTd9fjdfKFVmlKjkPwiGTZw
         NgPxmZVvt6Ql60uTJAmNg9iu5JmLr7mXVuc9oVGmdPjCHKS+DL00BeVttSHeWkbo/a+U
         vrRNZCBRxil6n/pMrbHC2dRCawtGLtuzimj+P4ucRc1g+vlRBAYlr1keSHkGLxmT6a3h
         0Rz0XpwcqStsmHZMx8MIQcXGaZ8U5io1rljD0pPxCL81ez9O7Ryi+5Pk9rdZpZqxZ/qj
         djVVPU8ww1TZKAohwa1g8EM4UqlEADkUaviEJf4Cp0ShD3TmcYCFwiNjBlWw0tX/Ev2f
         jzwA==
X-Received: by 10.140.109.118 with SMTP id k109mr1325138qgf.98.1403614971613;
 Tue, 24 Jun 2014 06:02:51 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Tue, 24 Jun 2014 06:02:21 -0700 (PDT)
In-Reply-To: <CAPig+cTyZxH6Ka3JVpYBP7=i=HAWoSYBt9MScwfVaTcKKmi1UA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252406>

On Mon, Jun 23, 2014 at 5:21 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, Jun 19, 2014 at 5:28 PM, Jeff King <peff@peff.net> wrote:
>> This is shorter, harder to get wrong, and more clearly
>> captures the intent.
>>
>> Signed-off-by: Jeff King <peff@peff.net>
>> ---
>> I wondered if there was a reason to avoid this (because we are in
>> setup_git_env, which can potentially be called by git_pathdup). But the
>> git_graft_file initialization below already uses it, and I
>> double-checked that it is safe once git_dir is set.
>
> This patch will conflict textually with patch 6/28 of Duy's
> nd/multiple-work-trees series [1].

I'll just steal the conflicted bit about git_object_dir and put in the
re-roll. It's a better way anyway. If git_index_file change still
results in conflicts, Junio can resolve it easily (I don't touch it in
nd/multiple-work-trees).
-- 
Duy
