From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/2] rebase -i: use some kind of config file to save author information
Date: Wed, 24 Jun 2009 06:29:39 +0200
Message-ID: <200906240629.40138.chriscool@tuxfamily.org>
References: <20090620023413.3995.3630.chriscool@tuxfamily.org> <200906230657.48627.chriscool@tuxfamily.org> <7vljnja5dv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 06:30:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJK7W-0001On-Br
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 06:30:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbZFXE32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 00:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbZFXE31
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 00:29:27 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:38869 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751131AbZFXE30 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 00:29:26 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 867EB818076;
	Wed, 24 Jun 2009 06:29:20 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 7C92C8180F5;
	Wed, 24 Jun 2009 06:29:18 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vljnja5dv.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday 23 June 2009, Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> > This patch would use the message from HEAD instead of
> > "$DOTEST"/message, but it looks like we are changing "$DOTEST"/message
> > sometimes with the "make_squash_message" function.
>
> Heh, that is why it was "something along this line" patch ;-)
>
> Regarding the C rewrite vs rebase--i.sh update, I tend to agree with
> Dscho that changing the scripted Porcelain is not worth it if we are
> rewriting the whole thing in C soon.  But perhaps we can allow
> combinations of the two options ("-[cC] commit" and "-F file") given to
> "git commit"?

I agree that it would be nice.

> The intent of the caller in such a case is quite 
> clear---use the authorship but do use the message from the other source
> (if we do this, it would probably make sense to do that also for "-m
> message").  The version entirely written in C obviously does not even
> need such an option (it can read authorship from HEAD and use its own
> message), but the point is if going that route would eliminate the need
> to store "which commit were we dealing with when we gave the control
> back" information on disk.  I suspect that the sequencing information is
> already on disk (i.e. $TODO file) and author-script may be redundant
> information.

Yeah, perhaps we could ge this route, but I'd rather just port what I can 
step by step first and then polish and/or rewrite some parts than the other 
way around.

Thanks,
Christian.
