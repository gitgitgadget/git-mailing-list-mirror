From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: stash refuses to pop
Date: Thu, 12 Apr 2012 07:50:05 +0200
Message-ID: <4F866D0D.7070904@viscovery.net>
References: <4F847350.3000409@ubuntu.com> <7vpqbfpim2.fsf@alter.siamese.dyndns.org> <4F84827B.80104@ubuntu.com> <4F851D8A.4000501@viscovery.net> <4F859353.4070700@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 07:50:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SICvE-0008Jl-W9
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 07:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756689Ab2DLFuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 01:50:13 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:38756 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756616Ab2DLFuL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 01:50:11 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SICvE-0004OM-GO; Thu, 12 Apr 2012 07:50:20 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 008581660F;
	Thu, 12 Apr 2012 07:50:05 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <4F859353.4070700@ubuntu.com>
X-Enigmail-Version: 1.4
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195297>

Am 4/11/2012 16:21, schrieb Phillip Susi:
> On 4/11/2012 1:58 AM, Johannes Sixt wrote:
>> You are trying to abuse git-stash, but it does not cooperate because it
>> was not designed to be abused ;-) git-stash is not intended as a generic
>> push-and-pop-my-changes work horse.
> 
> In what way is using the documented -p switch abuse?

It isn't.

>> The purpose of git-stash is that you can "move away"
> 
> Yes, and then move back.

This is abuse, if you haven't cleaned your worktree.

>> That is, before you can think of applying a stash, you are expected to
>> have cleaned out your worktree.
> 
> It is obvious that is the assumption that stash was originally made with,
> and it might make some sense if it always left the tree in a clean state,
> but it no longer makes sense given -p and how it can leave the tree in a
> not clean state.

You are misunderstanding. The intended workflow is:

  stash -p
  # ... test the remaining changes in isolation ...
  commit -a
  # now the worktree is clean
  stash pop

-- Hannes
