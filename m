From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 0/8] Sequencer Foundations
Date: Mon, 16 May 2011 06:14:47 +0200
Message-ID: <201105160614.48215.chriscool@tuxfamily.org>
References: <1305100822-20470-1-git-send-email-artagnon@gmail.com> <BANLkTi=8BrFXfoDwL_fXG2bXarP7d0xioA@mail.gmail.com> <20110513103756.GC30618@elie>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 16 06:17:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLpFm-0004Bs-Bo
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 06:17:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906Ab1EPEO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 00:14:58 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:57536 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750856Ab1EPEO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 00:14:57 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id A044DA622B;
	Mon, 16 May 2011 06:14:49 +0200 (CEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic; KDE/4.6.2; x86_64; ; )
In-Reply-To: <20110513103756.GC30618@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173701>

On Friday 13 May 2011 12:37:56 Jonathan Nieder wrote:
> Christian Couder wrote:
> > About writing files before each cherry-pick, I am not against it, if
> > it is really needed to be safe. I even suggested it in my patch series
> > back in November
> > (http://article.gmane.org/gmane.comp.version-control.git/162183).
> > But it will make cherry-pick less efficient, so it is a kind of
> > performance regression that we can perhaps avoid by changing some
> > die() into error().
> 
> Yes, that's a good point.  Maybe in the long term the extra safety
> could become optional.  And I am happy about the die() elimination;
> the only part I was not as thrilled about is relying on it.
> 
> Some die() calls, like the one in xmalloc, would be very difficult to
> eliminate.

Yeah, but to address this problem, maybe we can use a special die routine like 
you already suggested. I think if we use both error() and a special die 
routine we should be pretty safe.

Anyway I looked at the patch series and I found nothing that your very good 
review had not already spotted. My only nit is that maybe as the error 
handling patch is growing bigger, it could be splitted in 2 or 3 patchs.

Thanks to you and Ram,
Christian.
