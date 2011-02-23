From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH v2 00/31] refactor rebase
Date: Wed, 23 Feb 2011 06:26:33 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1102230613040.5290@debian>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com> <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com> <7vd3mz33xb.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.1102111811300.26684@debian>
 <alpine.DEB.2.00.1102132047500.4253@debian> <alpine.DEB.2.00.1102220847500.5290@debian> <7vd3mjdge1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 23 12:26:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsCrj-0008Ah-94
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 12:26:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798Ab1BWL0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 06:26:39 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:41381 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297Ab1BWL0i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 06:26:38 -0500
Received: by qwd7 with SMTP id 7so3636891qwd.19
        for <git@vger.kernel.org>; Wed, 23 Feb 2011 03:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=nQrc3Zo3jfnJ/JpvGCYHv8a2FVqJw3bO/5EYKdT6t2A=;
        b=sGMMHNyLsTmNVAUqkiW5uzcFPT+lsfwIho7Sup90+pYidkGKGszpGhL9IaJnBwX9mT
         AjKEPRoRnj619mwTvULDZY0NWPjQfaVTwQRtDaS3KYGeUp/chBNy8pKzkCT2scFreCle
         yPZJAmMFSP+xdyq1KVpCjux2WuPAkjgcRyuXw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=Nx7FOQN+OKXNowSz3ZeTR4HLsToCjS6UwzBlT8HeIc24imgycFi+qu99c2KKpbpqd4
         7vV1SM62+r/kcAcWK9QPpaD1LccawTKdyIMCK+089GA2gNzlS6LX65Uu8Q1NBY/8SLBS
         XIUXR1t9EYJJcJShgZ09AHEs12K4HMJwQ9tC4=
Received: by 10.229.246.196 with SMTP id lz4mr2950467qcb.39.1298460397329;
        Wed, 23 Feb 2011 03:26:37 -0800 (PST)
Received: from [192.168.1.101] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id y17sm5400570qci.9.2011.02.23.03.26.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 Feb 2011 03:26:36 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <7vd3mjdge1.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167689>

On Tue, 22 Feb 2011, Junio C Hamano wrote:

> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
> 
> > On Sun, 13 Feb 2011, Martin von Zweigbergk wrote:
> > ...
> >> This would apply on top of mz/rebase after dropping 95135b0 (rebase:
> >> stricter check of standalone sub command, 2011-02-06). If you agree
> >> with it, I will include it in a future re-roll.
> >
> > Any opinions about this, anyone? I have one example: I was rebasing
> > some things the other day where I thought there would be no conflicts.
> > After applying a number of patches, it turned out there were
> > conflicts. I think allowing 'git rebase --continue -sours' would have
> > been useful in that case. It's rare enough that I don't care much,
> > though.
> 
> Hmm, do you think applying -sours throughout to the rest of the series
> would have been a safe thing, or do you think you would rather wanted to
> see -sours applied only to that particular one?

In this particular case, I actually wanted it on the rest of the
series, but it was such a degenerate case that it doesn't really
matter (I just wanted the history graph for testing and didn't care
about the trees).

> > The reason I'm asking is that I have a patch that fixes the problems
> > with the command line parsing that Johannes Sixt pointed out in
> > another mail on this thread and would like to know if I should make it
> > apply on top of this patch or not.
> 
> It is a good idea to build a change you are more certain of first,
> excluding the ones you have doubts about.

True. Will do.

Let's leave this patch for now then and get back to it in a few years
when/if someone actually requests it ;-). I agree that it's not clear
at this point what the desired behavior is.
