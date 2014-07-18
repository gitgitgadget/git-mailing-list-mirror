From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] checkout: indicate when a detached head is checked out
 for a branch
Date: Fri, 18 Jul 2014 17:58:02 +0700
Message-ID: <CACsJy8CG17tzWWO27Pv2c+CjDyYiYATzgBSFfMBaugYgQfZQ5g@mail.gmail.com>
References: <35dbe7e3f3e4566d775bea19d816adc44db8ed5c.1405676303.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jul 18 12:58:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X85s6-0003dT-11
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 12:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761114AbaGRK6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 06:58:34 -0400
Received: from mail-qa0-f50.google.com ([209.85.216.50]:36264 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155AbaGRK6d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 06:58:33 -0400
Received: by mail-qa0-f50.google.com with SMTP id s7so2850273qap.23
        for <git@vger.kernel.org>; Fri, 18 Jul 2014 03:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LpD5S8FLyJgVL/yFG/AN/vNwAsICwdSH9uqGc5//DgY=;
        b=W8vorg5cD1WpMFtczhPpxw9bxjEhKAMDztQ2fZih2/bUf7mhQe1iZtVCd15HUM3IYZ
         qFAFRvGyajas15ZOekfZm6G91poOAr2UzotjStCm3Q9BqhksDhuWZ0dZ2LVxhtY6SaHG
         aNanf8tkCStvdg7+/vc2YpAQ7eS1V+XxXSp519DedAB22/76Lwe+3kAfxb/0D49Xi6V+
         xBFHxCHsHwq8MnNIgfJdf6HplgUBe2k2QkajyPAuH5I00APCcgEzAEtG/5bVLKa1wQ4j
         i3pHDrcQdqlaGJCgylCNIX0nseOkNSu/K+eGkbQacGlh7HYb6xorgfLb33CTui+BuHdC
         bOow==
X-Received: by 10.224.122.83 with SMTP id k19mr6964524qar.78.1405681112427;
 Fri, 18 Jul 2014 03:58:32 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Fri, 18 Jul 2014 03:58:02 -0700 (PDT)
In-Reply-To: <35dbe7e3f3e4566d775bea19d816adc44db8ed5c.1405676303.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253811>

On Fri, Jul 18, 2014 at 4:50 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> I really like the new --to feature and will convert all my "new workdir"
> checkouts to that. But that detached checkout is so easy to miss - in fact
> I noticed it only when I compared "new-workdir" to "checkout --to" for a
> test repo with one branch, to see what a converter would need to do.
>
> I'm even wondering whether we should do this DWIMmery at all,

This is what this series needs, user's opinions (bad or good). The
other option is abort the checkout immediately. I think I made detach
behavior default is because it's more work (and needs to be proven
feasible). How about a config key that lets user decide what to do
here, abort or detach. We may change the default behavior too if
people think the current one is not good.

> given how "dangerous" a detached head is for those who are not aware of it
> before gc kicks in.

Wait, what danger are we talking about? I thought gc pays attention to
detached heads as well..
-- 
Duy
