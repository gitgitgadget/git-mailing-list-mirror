From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [GSoC 2011] Git Sequencer
Date: Tue, 5 Apr 2011 08:23:28 +0200
Message-ID: <201104050823.29762.chriscool@tuxfamily.org>
References: <20110403172054.GA10220@kytes> <201104040643.35583.chriscool@tuxfamily.org> <7vy63qa8z1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Stephen Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 08:23:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6zg1-0000QN-Ig
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 08:23:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443Ab1DEGXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 02:23:40 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:53016 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223Ab1DEGXk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 02:23:40 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 43992A63E4;
	Tue,  5 Apr 2011 08:23:32 +0200 (CEST)
User-Agent: KMail/1.13.5 (Linux/2.6.35-22-generic; KDE/4.5.1; x86_64; ; )
In-Reply-To: <7vy63qa8z1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170870>

On Monday 04 April 2011 07:20:18 Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> > Yeah, the first step should be 'cherry-pick' with '--continue',
> > '--abort', and '--skip' merged.
> 
> I haven't looked at rebase-i machinery recently, but I wonder if it would
> just be a matter of making a multi-commit cherry-pick just prepare a bunch
> of "pick XXX" lines into .git/rebase-merge/rebase-todo file, make other
> trivial setups (like detaching HEAD, writing head-name and head files) and
> then execing "git rebase --continue"?

It is probably quite easy to do that, but it would result in cherry-pick in C 
calling rebase-i in shell that itself calls cherry-pick in C (to pick 
individual commit). Instead with this GSoC I think we have the opportunity to 
have everything we needed in C.

Best regards,
Christian.
