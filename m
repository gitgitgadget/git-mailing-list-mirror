From: worley@alum.mit.edu (Dale R. Worley)
Subject: Re: Apparent bug in git-gc
Date: Tue, 16 Sep 2014 14:09:13 -0400
Message-ID: <201409161809.s8GI9Dd4002425@hobgoblin.ariadne.com>
References: <201409152334.s8FNY33M032615@hobgoblin.ariadne.com> <20140916003046.GE5019@peff.net>
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 16 20:09:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTxBo-0001PQ-LJ
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 20:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754581AbaIPSJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 14:09:17 -0400
Received: from qmta09.westchester.pa.mail.comcast.net ([76.96.62.96]:34743
	"EHLO qmta09.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754345AbaIPSJQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2014 14:09:16 -0400
Received: from omta01.westchester.pa.mail.comcast.net ([76.96.62.11])
	by qmta09.westchester.pa.mail.comcast.net with comcast
	id rtxZ1o0040EZKEL59u9FSL; Tue, 16 Sep 2014 18:09:15 +0000
Received: from hobgoblin.ariadne.com ([24.34.72.61])
	by omta01.westchester.pa.mail.comcast.net with comcast
	id ru9F1o0091KKtkw3Mu9F7U; Tue, 16 Sep 2014 18:09:15 +0000
Received: from hobgoblin.ariadne.com (hobgoblin.ariadne.com [127.0.0.1])
	by hobgoblin.ariadne.com (8.14.7/8.14.7) with ESMTP id s8GI9EJS002426;
	Tue, 16 Sep 2014 14:09:14 -0400
Received: (from worley@localhost)
	by hobgoblin.ariadne.com (8.14.7/8.14.7/Submit) id s8GI9Dd4002425;
	Tue, 16 Sep 2014 14:09:13 -0400
In-reply-to: <20140916003046.GE5019@peff.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1410890955;
	bh=/Ae97lgxF3FGKo6HE8eX0si6KWBW+q4xfeAIvVvtJ6U=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=HoMK9uC6Nk78V0xB9AA+0CLZOBNeqs995vAwpPZCdEcoa93yMvSG9BrHfWuKvr7jd
	 4LxDLfhPwS1mWuY9xy0NMteVM7jOaiWjbl+WjZHoza4sCgi2p78HH6Bb/v2dIIt3h3
	 VHIZSk9XSWqfmkCO9MfIFUurWnkvYjM77rTmr9S0DE1cPyNRNMuSb0oYlnyGK3OcWA
	 NgssbgfBp35xDmIFxXnmxo41fb42l2wAiaeBd0y4I1J9o774qyV0AyVRGsgCIofCt/
	 so/xjg3/IHPN6d3S1YXufIDw3L+DlFx7RUyRwER/Es5vKxcZtqoUnjM/B9shKB1qsL
	 65wtM3W7SaTXg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257134>

> From: Jeff King <peff@peff.net>
> 
> > I have an 11 GB repository.  It passes git-fsck (though with a number
> > of dangling objects).  But when I run git-gc on it, the file
> > refs/heads/master disappears.
> 
> That's the expected behavior. Gc runs "git pack-refs", which puts an
> entry into packed-refs and prunes the loose ref.

Arrrgh, damn!  I knew that but I forgot it.  Sorry about the trouble.

(At least I don't have to worry about fixing it now.)

Dale
