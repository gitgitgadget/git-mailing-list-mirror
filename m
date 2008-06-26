From: Nikolaj Schumacher <n_schumacher@web.de>
Subject: Re: [PATCH] git.el: Don't reset HEAD in git-amend-file.
Date: Thu, 26 Jun 2008 22:17:16 +0200
Message-ID: <m2y74symr7.fsf@nschum.de>
References: <m2myle77bb.fsf@nschum.de> <87tzfg7gd5.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Thu Jun 26 22:18:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBxvB-0000BD-4x
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 22:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756708AbYFZURV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 16:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756608AbYFZURU
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 16:17:20 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:59320 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756256AbYFZURT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 16:17:19 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id CB296E34AE8B;
	Thu, 26 Jun 2008 22:17:17 +0200 (CEST)
Received: from [77.135.68.198] (helo=thursday)
	by smtp05.web.de with asmtp (WEB.DE 4.109 #226)
	id 1KBxu9-00059U-00; Thu, 26 Jun 2008 22:17:17 +0200
In-Reply-To: <87tzfg7gd5.fsf@wine.dyndns.org> (Alexandre Julliard's message of "Thu\, 26 Jun 2008 10\:25\:10 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2.50 (darwin)
X-Sender: n_schumacher@web.de
X-Provags-ID: V01U2FsdGVkX1/6Lt3ohS3eIuvxVQ/yk2JXDBhX6vkPl5MWT97e
	Z+VvVN+ixhNVxnc3pdAG8k0VDrZvXw/fQPrcA6IbHkW8ACRhks
	1cV5NLkn6whBzc7HdrXw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86479>

Alexandre Julliard <julliard@winehq.org> wrote:

> Nikolaj Schumacher <n_schumacher@web.de> writes:
>
>> The current implementation of git-amend-file is a little dangerous.
>> While git --amend is atomic, git-amend-file is not.
>>
>> If the user calls it, but doesn't go through with the commit (due to
>> error or choice), git --reset HEAD^ has been called anyway.
>
> That's a feature, even if it's a little dangerous. You have to reset
> HEAD to be able to properly do diffs, refreshes, etc.  Maybe there should
> be an easier way to redo the commit if you change your mind, but the
> command would be much less useful without the reset.

You're right, it would be less powerful.  But I still think it maps
better to what "git commit --amend" does, i.e. do a few changes and
amend them.  No need for diffing against the old head, or even showing
it in the summary.  For doing something more complicated I would reset
head, too.  So, yes, the command should exist as well.  But I'm not
so sure about the name...

As an aside, the current method doesn't work on the initial commit.


regards,
Nikolaj Schumacher
