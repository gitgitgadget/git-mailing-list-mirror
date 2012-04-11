From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: stash refuses to pop
Date: Wed, 11 Apr 2012 07:58:34 +0200
Message-ID: <4F851D8A.4000501@viscovery.net>
References: <4F847350.3000409@ubuntu.com> <7vpqbfpim2.fsf@alter.siamese.dyndns.org> <4F84827B.80104@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 07:58:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHqZu-0008I5-Fv
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 07:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974Ab2DKF6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 01:58:42 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:21717 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752956Ab2DKF6l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 01:58:41 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SHqZf-0001G8-Mi; Wed, 11 Apr 2012 07:58:35 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 67EF71660F;
	Wed, 11 Apr 2012 07:58:35 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <4F84827B.80104@ubuntu.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195150>

Am 4/10/2012 20:56, schrieb Phillip Susi:
> On 4/10/2012 2:05 PM, Junio C Hamano wrote:
>> Phillip Susi<psusi@ubuntu.com>  writes:
>>
>>> git stash refuses to apply a stash if it touches files that are
>>> modified.  Using stash -p to selectively stash some hunks of a file
>>> and then immediately trying to pop that stash causes this failure
>>> every time.
>>
>> I think that is by design.
> 
> Being able to push something that you can not pop seems to be broken
> design...

You are trying to abuse git-stash, but it does not cooperate because it
was not designed to be abused ;-) git-stash is not intended as a generic
push-and-pop-my-changes work horse.

The purpose of git-stash is that you can "move away"

- all of your changes to have a clean worktree or
- part of your changes to _create a clean worktree from the remaining
changes_.

That is, before you can think of applying a stash, you are expected to
have cleaned out your worktree.

-- Hannes
