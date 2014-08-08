From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH v2 23/23] rebase -i: enable options --signoff, --reset-author for pick, reword
Date: Fri, 08 Aug 2014 21:10:26 +0200
Message-ID: <87sil6ajbx.fsf@thomasrast.ch>
References: <53A258D2.7080806@gmail.com>
	<cover.1407368621.git.bafain@gmail.com>
	<ed19a079924e11edac0163837500c2e8caa2a555.1407368621.git.bafain@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 21:10:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFpYh-0003YT-Oj
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 21:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbaHHTKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 15:10:30 -0400
Received: from ip1.thgersdorf.net ([148.251.9.194]:57837 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751157AbaHHTK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 15:10:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id CC97B4D6572;
	Fri,  8 Aug 2014 21:10:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id DeC9maNnl39I; Fri,  8 Aug 2014 21:10:26 +0200 (CEST)
Received: from linux-1gf2.thomasrast.ch (173-161-212-225-Philadelphia.hfc.comcastbusiness.net [173.161.212.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 740424D6664;
	Fri,  8 Aug 2014 21:10:25 +0200 (CEST)
In-Reply-To: <ed19a079924e11edac0163837500c2e8caa2a555.1407368621.git.bafain@gmail.com>
	(Fabian Ruch's message of "Thu, 7 Aug 2014 01:59:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255066>

Fabian Ruch <bafain@gmail.com> writes:

> @@ -634,21 +644,24 @@ do_replay () {
>  		comment_for_reflog pick
>  
>  		mark_action_done
> -		do_pick $sha1 || die_with_patch $sha1 "Could not apply $sha1... $rest"
> +		eval do_pick $opts $sha1 \
> +			|| die_with_patch $sha1 "Could not apply $sha1... $rest"

You had me a little puzzled at the switch to 'eval' here.  That is
necessary to match the quoting added in 20/23, not for any change in
this commit.  This commit is simply the first one to trigger this.
Also, are you sure $sha1 does not require quoting through an eval?


Please add tests to this patch.

-- 
Thomas Rast
tr@thomasrast.ch
