From: Atsushi Nakagawa <atnak@chejz.com>
Subject: Re: Reset by checkout?
Date: Sat, 07 Jun 2014 13:54:42 +0900
Message-ID: <20140607135439.7893.B013761@chejz.com>
References: <20140601132624.821C.B013761@chejz.com> <538AE814.2010407@bracey.fi>
Reply-To: Atsushi Nakagawa <atnak@chejz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Sat Jun 07 06:54:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt8eZ-0001cS-Ac
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 06:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbaFGEyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2014 00:54:44 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:36446 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbaFGEyn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2014 00:54:43 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so3299472pbb.36
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 21:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chejz.com; s=google;
        h=date:from:to:subject:cc:reply-to:in-reply-to:references:message-id
         :mime-version:content-type:content-transfer-encoding;
        bh=TsNYzMWC/vBNbW09axyLd+6w5WGnghNTjovJrZfkh58=;
        b=owxAFCPIJJzKP3FVGDdI0u32blhKCUq9fKZriqYAIfVPIFLZRIvKcwifvyeslBX6Pk
         wos6q+Z/F6z4DC2Wo6eOBQmixiTUwXYr4WzHxewhsZch4FWvJcEYha8SNzhpOMNeCKSL
         gx+6og9pc6+gz9CizXy4qXDU+Nv5gNQ75qU7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:cc:reply-to:in-reply-to
         :references:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=TsNYzMWC/vBNbW09axyLd+6w5WGnghNTjovJrZfkh58=;
        b=VhXopJ+3XCSyXhbKcMCUWZEO00VHkPRb8gOZztRwVJlG2ZvNhRPFy9CL+9aCkU7Kqh
         hTwFF4TAh9Tq+rxWYmmQKiYF9CJ6BxR5vC2VuQyB3tUld+Auje72AOrn2l/3Ra7j4wJM
         mQllu4tN/ziQUN1ujAcL4Zz9voVJcvzfrpCugMCVG1+3Fn68EzYP7cT7HwrSrx2/v8Lq
         EACdh2Uoe3bOzr2r2CJPakuk6tct8LDKi3Exj5gggrh1heSGU7fwYB8hka/AWiHzYPA/
         MOZOYS6pXZbnglHjYNmmrSEz4uRjkRwDbbOsg4M2wTQ4d6J1Esct7fZ2ReVT4/9GN/AA
         TGrg==
X-Gm-Message-State: ALoCoQkr4esDBYNemAQSYI4kQqveYwg/WxYA44VI7QEIG8sHBf2ScX1hPB/uvwCPa8EZ3Ikg0Yiv
X-Received: by 10.68.197.195 with SMTP id iw3mr323725pbc.139.1402116882689;
        Fri, 06 Jun 2014 21:54:42 -0700 (PDT)
Received: from [127.0.0.1] (KD106168138162.ppp-bb.dion.ne.jp. [106.168.138.162])
        by mx.google.com with ESMTPSA id sm8sm43231110pbc.92.2014.06.06.21.54.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jun 2014 21:54:42 -0700 (PDT)
In-Reply-To: <538AE814.2010407@bracey.fi>
X-Mailer: Becky! ver. 2.65.07 [en]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251018>

Kevin Bracey <kevin@bracey.fi> wrote:
> On 01/06/2014 07:26, Atsushi Nakagawa wrote:
> > Kevin Bracey <kevin@bracey.fi> wrote:
> >> The original "git reset --hard" used to be a pretty top-level command.
> >> It was used for aborting merges in particular. But I think it now
> >> stands out as being one of the only really dangerous porcelain
> >> commands, and I can't think of any real workflow it's still useful
> >> for.
> > My thoughts exactly.  I think the 'reset --soft/--mixed/--hard' pattern
> > is so ingrained, that many people just don't realize there's a safer
> > alternative.  (I've heard work mates on more than one occasion
> > recommending 'reset --hard' as the go-to command for discarding commits.)
> >
> > I believe this is likely because many third party GUI tools just don't
> > support 'reset --keep', and these tools present a "Reset..." dialog with
> > the de facto Soft/Mixed/Hard options.  (Even 'gitk' does this.)
> True on the GUI - "hard" really needs demotion.
> 
> It would help if the documentation explained better straight off what
> the different reset modes are intended /for/ in a more practical way,
> rather than the technical jargon.

On one hand, I agree that improving man git-reset and making it easier
to understand would be of benefit.

However, one of the main culprits of confusion here seems to be the mere
existance of '--keep', which is somewhat of a conceptual black sheep.

The --soft/--mixed/--hard trio seems quite easy to explain, /if/ you
didn't need to also explain --keep...

To that end, I'm wondering if it's better to just deprecate 'reset
--keep' and shift the use-case over to 'checkout':

checkout [-u|--update] [<commit>|<branch>]

-u
--update
    Rather than checking out a branch to work on it, check out a commit
    and reset the current branch to that commit.

    This is functionally equivalent to 'checkout -B CURRENT_BRANCH <commit>'.

    (...Maybe a warning here about commits becoming unreachable...)


Then, as an added bonus, anything I've staged is kept intact.  *And*, I
can attempt 'checkout -u --merge' if I'm feeling particulary careless.

> --hard
>     All [] changes are dropped[] and the [working tree] and index are
>     forcibly reset to the [state of <commit>].  Note that this is
>     dangerous if used carelessly.  ALL uncommitted changes to ALL
>     tracked files will be lost[].
>
>     Older documentation often recommends "git reset --hard" to
>     undo commits; the newer "--keep" option is [safer and is now the
>     recommended] alternative [for use in this situation].

I like this explaination of '--hard' and prefer it over current, which
doesn't much explain the gravity of the command.  I've made some edits
above.

> --merge
>     Performs the operation of "git merge --abort", intended for use
>     during a merge resolution - see git-merge(1) for more information.
>     This form is not normally used directly.

Aha, so that's what that's for.  I couldn't really understand the
explanation in the current manpage, but your version at least tells me
that it's an option I don't need to worry about.

Cheers,


-- 
Atsushi Nakagawa
<atnak@chejz.com>
Changes are made when there is inconvenience.
