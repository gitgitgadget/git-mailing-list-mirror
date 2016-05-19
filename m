From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv8 0/5] pathspec magic extension to search for attributes
Date: Thu, 19 May 2016 14:00:31 -0700
Message-ID: <CAGZ79kZvZQxPUkECupvqk0KRbq-pRK6y=GksOiYn_zz+TM=dBA@mail.gmail.com>
References: <20160519010935.27856-1-sbeller@google.com> <xmqqiny9j2sc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 19 23:00:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3V3e-00038u-QO
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 23:00:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933277AbcESVAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 17:00:34 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:38655 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932710AbcESVAd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 17:00:33 -0400
Received: by mail-ig0-f177.google.com with SMTP id vs11so12560273igb.1
        for <git@vger.kernel.org>; Thu, 19 May 2016 14:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oKhudoyGrItIpToOr0vHwTbWdLve1JYP4oEqX++rEJg=;
        b=g9rUkrplinGWl6DNulLW3bCzXGj26CA6u5jOrpRO3VP0fHJBzXHzDgvelreotUN23t
         Oc1pgcLMDbb/21Y06HJty9mxjZMeZO2mIy2zS2N2Cmm60GEA8B5Ul+iZ7TmyduyLBaGD
         54bXTacUre8fYYFuPHqCZvJhoRJJJXeVq6k4IGdGr/MN9AhGGWQx7MIUXR5HEJLZ8HHw
         7GvOn5UWD5x/cX2JepEvYObGh3nGzgDz2Eu2MNldE39D/mcE6jxKjeN7ACFJh4Jy7sNK
         hFXXpS/iFXTv9Alo5Ju70n1eXxL8ZzmXelufb6xEYBYXxrVvFZI7GH27JAhypuNib78z
         p7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oKhudoyGrItIpToOr0vHwTbWdLve1JYP4oEqX++rEJg=;
        b=eSAQCOskKMQK+yjlgiSHxI75Y7/D+ZlGkKjji9LhB+LsfJLwuVGX3VDrYyVDH0QUrd
         7b/6LbV0HmPWyGjhj0lHu2g/zGeR2p0Kuo3Ea+h1P3z0meR76CmIxjBR/1pb7Gj6+T0F
         ujUEjWtvTVfhZGfJ6s0scdg/fBUxr89+SrPfnFuGUBPKWGDSPlfZ1LEDjdrfsXBjrZFr
         PovLNb4JC1jsvhMRwrm/25KhrdgdXf1IoxtnThwLYZnGA6ox1k3CIsmC5H+Yxzn9Shll
         sJokuAxWCOkrk4+eJglt3f0SSy5C0FF1DWj7Ul8WscSRpCXPulE0/V0pi6vP0O/MCeLN
         46Ig==
X-Gm-Message-State: AOPr4FWp+PB5ZY3MuiwMv0Upes8GCRFK0k62/+UEeMtI9nfRrGmZC6EhBCToCWb5qVfGgLW+MGI92jdz7R74u+Kx
X-Received: by 10.50.29.45 with SMTP id g13mr4681537igh.93.1463691631526; Thu,
 19 May 2016 14:00:31 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 19 May 2016 14:00:31 -0700 (PDT)
In-Reply-To: <xmqqiny9j2sc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295100>

On Thu, May 19, 2016 at 11:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I think this round is 99% there.  The next step would be to answer
> "does the feature set we have here meet your needs that you wanted
> to fill with the submodule labels originally?" and I am hoping it is
> "yes".

But it's no. (...not quite / not yet)

I thought about this question since sending out the
series and I think we would want to improve submodules more.

In the original patch series "submodule groups" I tried to achieve two goals:
 (A) a grouping scheme for submodules
 (B) some sort of persistent configuration for such a group

(A) will be mostly solved now by the pathspec attrs. It may be a bit
confusing for users, as any other submodule related configuration is done
in .gitmodules. Also when moving a submodule (changing its path on the file
system, not the name in the config), any configuration still applies
except for the grouping scheme, which may not match any more.

(B) requires some thought though. Here is my vision:

    1) Allow pathspecs for sparse checkout.

      I wonder if we just add support for that in .git/info-sparse-checkout
      or if we add a new file that is for pathspecs only, or we have a config
      option whether sparse-checkout follows pathspecs or gitignore patterns

    2) Teach `git clone` a new option `--sparse-checkout <pathspec>`
      When that option is set the pathspec is written into the new file from
      (1) and core.sparsecheckout is set to true

    3) Advertise to do a `git clone --sparse-checkout
:(attr:default_submodules)`

Going this way we would help making submodules not different but integrate more
into other concepts of Git. As a downside this would require touching
sparse checkout which may be more time consuming than just adding a
`git clone --init-submodules-by-label` which stores the labels and only upddates
those submodules.

Or are there other ideas how to go from here?

Thanks,
Stefan



>
> Thanks.
