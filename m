From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC PATCH] repack: rewrite the shell script in C.
Date: Thu, 15 Aug 2013 11:15:06 +0700
Message-ID: <CACsJy8AZ+xLURszWni1wdZw7e6ZvE0je9_ELcj6gCzaEyNNLmQ@mail.gmail.com>
References: <520BAF9F.70105@googlemail.com> <1376497661-30714-1-git-send-email-stefanbeller@googlemail.com>
 <CALWbr2xuV+V7M354+XoA3HCvLr0Cpx4t3cLVeTCx4xeNmQQX1w@mail.gmail.com> <201308141125.59991.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Fredrik Gustafsson <iveqy@iveqy.com>,
	Junio C Hamano <gitster@pobox.com>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Thu Aug 15 06:16:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9oyg-0000jo-BC
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 06:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091Ab3HOEPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 00:15:37 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:49041 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899Ab3HOEPg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 00:15:36 -0400
Received: by mail-ob0-f173.google.com with SMTP id ta17so326319obb.4
        for <git@vger.kernel.org>; Wed, 14 Aug 2013 21:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=eAeRwm+CfkDv8ggpUMyia1GbdvNYJOAIXRHHuNSy3YM=;
        b=cZy0E0Yw93o08LoTyGKKuGNOBKp3+MiMCafGKt3j24uTOsGD80Ep/0roSFdCKY/ue8
         A5stbo3vp5f69YT1t6gNAtlLqwhIlWfbk+a+QzRNLZEJG+3FL+0E8wcXtv2SlgKoYpxo
         NuFYjMV5cRSCI2s/k/pvitYuWjcR60HDpLCJdN20Jrfp5Pf/1rKL5I44ureLgGoNp/pA
         NIzXeXyX7P+pmcaVoAJwTUv1i1lPxJwvPDkSI5Um64f5Sm9EVIdlXC9mr6Jpj24lOj7l
         qPzxus5LHAZiRpT4SgXizImW8HXH2Rk7R0uFD13/VaexRO24/n4yqUXIw3WTu8v0Si0R
         lXCw==
X-Received: by 10.182.186.102 with SMTP id fj6mr1375303obc.19.1376540136468;
 Wed, 14 Aug 2013 21:15:36 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Wed, 14 Aug 2013 21:15:06 -0700 (PDT)
In-Reply-To: <201308141125.59991.mfick@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232329>

On Thu, Aug 15, 2013 at 12:25 AM, Martin Fick <mfick@codeaurora.org> wrote:
> The script really is mostly a policy script, and with the
> discussions happening in other threads about how to improve
> git gc, I think it is helpful to potentially be able to
> quickly modify the policies in this script, it makes it
> easier to prototype things.  Shell portability issues aside,
> this script is not a low level type of tool that I feel will
> benefit from being in C, I feel it will in fact be worse off
> in C,

I think C is better for the modification you made in git-exproll.sh,
if it gets merged to git-repack.sh. Such calculations are not a strong
point of shell scripting. git-repack.sh is still around for
experimenting, although I think perl, ruby or python is better than
shell for prototyping.
-- 
Duy
