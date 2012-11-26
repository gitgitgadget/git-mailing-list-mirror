From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 00/11] alternative unify appending of sob
Date: Mon, 26 Nov 2012 14:56:49 +0700
Message-ID: <CACsJy8AfaETfikvB+zON4iiX2HBehJg-xX2GGmKYHueX8rv3qw@mail.gmail.com>
References: <1353894359-6733-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 08:57:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TctZV-0000uM-Do
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 08:57:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754411Ab2KZH5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 02:57:22 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:47236 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754401Ab2KZH5V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 02:57:21 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so4295525eek.19
        for <git@vger.kernel.org>; Sun, 25 Nov 2012 23:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1vktyLJJQwMZZx5A/U3K1K+n0i2U4eLQ1u7e7tch1QE=;
        b=zpU/KqmCV1WksGsyTyyD5oZec1Qb3RmdS2I8mCNynG0eCwH5eZldBswp8WbbCkyrrh
         moqJxfQQl+q1bM+3zPBQZ3Ru8UXh0O0K5zaLJjg0fOrzRSDdmBcK3ljc8gIORT9xEMOJ
         r7Tq7Sh6PxPuw0iUtvwf8eZur2hJbyJO/i08H6fL0qdZX8Bf3pcOK4i4VcnR2tk0RUEt
         ymicAxH1czrLAU1fOEEaeaUDSxP0ohHr46Df+BWCW/lKXTO0Ow7BL2/RIJVDBdazQjvz
         Q9iAxrp+oh0b9nXUazUT9tjMsAuk/f741MmhErijOs3B1BjtdnIdjYvwGcynvo3Tzsns
         WBRw==
Received: by 10.14.223.135 with SMTP id v7mr42761915eep.41.1353916640270; Sun,
 25 Nov 2012 23:57:20 -0800 (PST)
Received: by 10.14.199.194 with HTTP; Sun, 25 Nov 2012 23:56:49 -0800 (PST)
In-Reply-To: <1353894359-6733-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210423>

On Mon, Nov 26, 2012 at 8:45 AM, Brandon Casey <drafnel@gmail.com> wrote:
> From: Brandon Casey <bcasey@nvidia.com>
>
> I hate to have the battle of the patches, but I kinda prefer the
> append_signoff code in sequencer.c over the code in log-tree.c as a
> foundation to build on.
>
> So, this series is similar to Duy's "unification" series, but it goes in the
> opposite direction and builds on top of sequencer.c and additionally adds the
> elements from my original series to treat the "(cherry picked from..." line
> added by 'cherry-pick -x' in the same way that other footer elements are
> treated (after addressing Junio's comments about rfc2822 continuation lines
> and duplicate s-o-b's).
>
> I've integrated Duy's series with a few minor tweaks.  I added a couple
> of additional tests to t4014 and corrected one of the tests which had
> incorrect behavior.  I think his sign-off's should still be valid, so I
> kept them in.  Sorry that I've been slow, and now the two of us are stepping
> on each other's toes, but Duy please take a look and let me know if there's
> anything you dislike.

I'm still not sure whether format-patch should follow cherry-pick's
rule in appending sob. If it does, it probably makes more sense to fix
the sequencer.c code then delete log-tree.c (not fixes on log-tree.c
then delete it). I see that your changes pass all the new tests I
added in format-patch so sequencer.c is probably good enough,
log-tree.c changes are probably not needed. Feel free take over the
series :-)
-- 
Duy
