From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/2] fsck: HEAD is part of refs
Date: Fri, 30 Jan 2009 10:27:22 +0100
Message-ID: <4982C7FA.20107@viscovery.net>
References: <49814BA4.6030705@zytor.com> <7vfxj1eqh6.fsf@gitster.siamese.dyndns.org> <49822944.8000103@zytor.com> <20090129223529.GB1465@elte.hu> <20090129224357.GA18471@elte.hu> <498231EA.3030801@zytor.com> <7vvdrxd8jz.fsf@gitster.siamese.dyndns.org> <alpine.LFD.2.00.0901291512260.3054@localhost.localdomain> <7veiylb1in.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 10:28:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSpgI-0002JX-8V
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 10:28:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149AbZA3J1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 04:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752092AbZA3J1c
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 04:27:32 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:43858 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbZA3J1c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 04:27:32 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LSpel-00061a-4V; Fri, 30 Jan 2009 10:27:23 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id D77C069F; Fri, 30 Jan 2009 10:27:22 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <7veiylb1in.fsf_-_@gitster.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107783>

Junio C Hamano schrieb:
> By default we looked at all refs but not HEAD.  The only thing that
> made fsck not lose sight of comments that are only reachable from a
> detached HEAD was the reflog for the HEAD.
> 
> This fixes it, with a new test.
[...]
> +test_expect_success setup '
> +	test_commit A &&
> +	git checkout HEAD^0 &&
> +	test_commit B &&
> +	git reflog expire --expire=now --all
> +'
> +
> +test_expect_success 'HEAD is part of refs' '
> +	test 0 = $(git fsck | wc -l)

I'm scratching my head over this. This test succeeds even without the
change... (Tested with a34a9db.)

-- Hannes
