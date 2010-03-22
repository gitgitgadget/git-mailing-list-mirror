From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: cc/cherry-pick-ff (Re: What's cooking in git.git (Mar 2010, #04; Tue, 16))
Date: Mon, 22 Mar 2010 04:03:54 +0100
Message-ID: <201003220403.54770.chriscool@tuxfamily.org>
References: <7vhbof4fof.fsf@alter.siamese.dyndns.org> <201003180138.56529.chriscool@tuxfamily.org> <7v1vffqdm4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 04:04:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtXw6-0002Kf-Oh
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 04:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753784Ab0CVDEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 23:04:09 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:42381 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753711Ab0CVDEG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 23:04:06 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id C1EF0818023;
	Mon, 22 Mar 2010 04:03:59 +0100 (CET)
Received: from style.localnet (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 6EB97818052;
	Mon, 22 Mar 2010 04:03:56 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31-19-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <7v1vffqdm4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142887>

On Saturday 20 March 2010 15:20:03 Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> > ... if we implement "git cherry-pick A..B", and if many people
> > start to use it, then perhaps it will make sense for --ff to become the
> > default.
> 
> That doesn't make any sense to me.
> 
> Think why you are saying A..B, with an explicit "A".
> 
> It is because you know it is different from HEAD; otherwise you would have
> done "git merge B"---slurp all changes between HEAD..B, which would be
> equivalent to "cherry-pick --ff HEAD..B".

I think that some people might avoid "git merge" altogether just because they 
may not be confident with merges and prefer linear histories.

They may also prefer "git cherry-pick A..B" over "git rebase" or "git rebase -
i" because it may be simpler for them to understand.

> As an ingredient for use of scripts that do not want to check (even if
> they could) if it is dealing with a corner case in which the commit a
> change is being applied to happens to be the commit the change in question
> is based on, being able to say --ff would make sense (as your patch series
> showed, it helped to lose several lines from the rebase-i implementation).
> The end user may not bother to count commits, and being able to ff earlier
> parts of "rebase -i HEAD~20" when the first "edit" appears after many
> "pick" would help (and that was why "rebase -i" internally had ff logic).
> 
> But running cherry-pick as the top-level operation is a conscious act of
> "I want to replay the change done by that one", and it would be utterly
> confusing if it fast-forwarded by default.  I agree with Jonathan that it
> will never be default.

Well, I think it is difficult to predict how and how much people will use "git 
cherry-pick A..B", and if after using it they will want fast forwarding by 
default to be consistent between "git cherry-pick" and "git merge" or if they 
won't care.

Best regards,
Christian.
