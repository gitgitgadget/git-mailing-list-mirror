From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: git reset --keep (Re: What's cooking in git.git (Mar 2010, #01; Wed, 03))
Date: Fri, 5 Mar 2010 22:08:15 +0100
Message-ID: <201003052208.15837.chriscool@tuxfamily.org>
References: <7v7hptt0mr.fsf@alter.siamese.dyndns.org> <7vk4trlhim.fsf@alter.siamese.dyndns.org> <20100305162521.GA25120@progeny.tock>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 05 22:08:34 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nnel4-0000yB-Oo
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 22:08:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752971Ab0CEVIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Mar 2010 16:08:25 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:52053 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751800Ab0CEVIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Mar 2010 16:08:25 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id EB6F28181B5;
	Fri,  5 Mar 2010 22:08:18 +0100 (CET)
Received: from style.localnet (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 192A98181B7;
	Fri,  5 Mar 2010 22:08:16 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31-19-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <20100305162521.GA25120@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141596>

On Friday 05 March 2010 17:25:21 Jonathan Nieder wrote:
>
> 1. Helping people new to git.
> 
> A person not very familiar with git comes to me asking how to undo
> the last couple of commits.  After a quick conversation, it becomes
> clear that the commits in question were not pushed out to any public
> repository and that this person does not feel it would be useful to
> publish the problem commits.
> 
> Currently, I would have to advise such a person to use
> 
> 	git reset --hard HEAD^^
> 
> I would prefer to recommend
> 
> 	git reset --keep HEAD^^
> 
> because if there are uncommitted changes then it will give a "needs
> update" message (right?) and I can help the person to deal with it.

If the uncommited changes are in files that are not touched by the discarded 
commits then it will silently work and will keep your uncommited changes.
If the uncommited changes are in files touched by the discarded commits then it 
will fail with an error message like this:

error: Entry 'foo' not uptodate. Cannot merge.
fatal: Could not reset index file to revision 'HEAD^^'.

Best regards,
Christian.
