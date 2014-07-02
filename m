From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Show containing branches in log?
Date: Wed, 2 Jul 2014 11:52:43 -0500
Message-ID: <CAHd499Bk6ZG+DDjN1HuC-RFczwd+AGZaUSkXA6a8MsZjOL5H8A@mail.gmail.com>
References: <CAHd499A78BRVawWSHNnzJcD1Ca7RfFeEnJf0SB7py1MD5qwL0g@mail.gmail.com>
	<20140702163451.GB14404@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 02 18:52:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2Nm7-0001vl-Vv
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 18:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757524AbaGBQwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 12:52:46 -0400
Received: from mail-ve0-f175.google.com ([209.85.128.175]:45003 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756380AbaGBQwo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 12:52:44 -0400
Received: by mail-ve0-f175.google.com with SMTP id jx11so11489182veb.34
        for <git@vger.kernel.org>; Wed, 02 Jul 2014 09:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=upKin8gbaIikqAbogDk3Mj20Lk0GpFSVhGKt6DPgdJY=;
        b=lHyhyoA/GUJ+BdvVVU2BVP4tJTsnLXlbn8DzHIJNGaF/FjIfpKgSADNGHxgLqmYHOa
         rLFGMxatM1O/EvRYeni960TnnixtHIQM/AyM1H16DSbBND5TisDKXTML4r0JW8rkGyUC
         lUVrOWCppw4zxFKkMrrWnLoY6MbzFJhdTy8nXU2TCqljVI40h2p5CTXqmYOP6SB8JNH4
         qtM795BGBWVylko/CaU5srnOP27vfIEkbHSZiT8mfSWHU6dtXR7rRFU087udHziD1wyo
         gZqDB3tObsvucGfLvmTARJCO3B2t9rWQb0w/hsr17/mLJgM0wDGwvNstIEf3AfnH8rS9
         MIbw==
X-Received: by 10.58.196.231 with SMTP id ip7mr1153596vec.47.1404319963645;
 Wed, 02 Jul 2014 09:52:43 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.220.102.204 with HTTP; Wed, 2 Jul 2014 09:52:43 -0700 (PDT)
In-Reply-To: <20140702163451.GB14404@sigill.intra.peff.net>
X-Google-Sender-Auth: MNdoYq2ctMLjD565-HPzVMXxzgk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252795>

On Wed, Jul 2, 2014 at 11:34 AM, Jeff King <peff@peff.net> wrote:
> Have you tried "git describe --contains --all <commit>"?
>
> To some degree, I fear your question isn't something git can answer. If
> the branch containing the commit has been merged into other branches,
> then they all "contain" the commit. There is not really any reason to
> prefer one over the other ("describe --contains" will try to find the
> "closest" branch, but that is based on heuristics and is not necessarily
> well-defined).

I have not tried that command. Note I mentioned named refs, so
nameless branches I'm not worried about. Even if I merge branch A into
branch B, branch A is still closest in terms of number of steps to get
to the commit, because to get to the commit through B you have to
cross over a merge commit. Basically the priority should be directness
and distance. The more direct a branch is (i.e. the lesser number of
merge commits it goes through to get to the commit) the more relevant
it is. As a second condition, distance would be used in cases where
the directness of it is the same.

Sorting this in the log graph and seeing it visually (I could even use
--simplify-by-decoration) would help me understand the topography of
git's history relative to the commit(s) I specify.
