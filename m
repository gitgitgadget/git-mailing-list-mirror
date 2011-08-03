From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v14 5/8] bisect: introduce --no-checkout support into porcelain.
Date: Wed, 3 Aug 2011 07:28:42 +0200
Message-ID: <201108030728.42453.chriscool@tuxfamily.org>
References: <1312323362-20096-1-git-send-email-jon.seymour@gmail.com> <7voc07ct9z.fsf@alter.siamese.dyndns.org> <7vk4avcsk9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jon Seymour <jon.seymour@gmail.com>, git@vger.kernel.org,
	j6t@kdbg.org, jnareb@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 07:28:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoU0m-0002WP-0G
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 07:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754540Ab1HCF2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 01:28:52 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:47780 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753076Ab1HCF2v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 01:28:51 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id EE2C8A61F1;
	Wed,  3 Aug 2011 07:28:43 +0200 (CEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic; KDE/4.6.2; x86_64; ; )
In-Reply-To: <7vk4avcsk9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178543>

On Wednesday 03 August 2011 01:16:54 Junio C Hamano wrote:
> 
> Having said that, other than these minor nits, I think this round is
> almost ready. I didn't check how it behaves upon "bisect reset",
> though. It shouldn't touch the index, HEAD nor the working tree (it
> probably is just the matter of "update-ref -d BISECT_HEAD" and nothing
> else, but I haven't thought things through thoroughly).
> 
> Further polishing we may want to do while it is still in pu/next I can
> think of off the top of my head are:
> 
>  - In this mode, I can bisect the history even inside a bare repository,
>    as the whole point of --no-checkout is that the mode does not require a
>    working tree. I however suspect "git bisect" requires working tree. Is
>    this something we want to fix?
> 
>  - Further, perhaps should we default to this mode inside a bare
>    repository?

I agree that it would be nice if it worked in a bare repo. I did not look at 
that yet.

> Christian, do you think of anything else?

No, I agree that it looks almost ready.

The few improvements I would like are:

- squashing the last patch into the previous ones,
- using a bisect_mode() function when needed.

> Also do you see flaws in our
> reasoning that updating only BISECT_HEAD and doing nothing else is a good
> way to do this?

No, I agree that --no-checkout is a good idea and that using only BISECT_HEAD 
is good way to do this.

Thanks,
Christian.
