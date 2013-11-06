From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH] Add interpret-trailers builtin
Date: Wed, 06 Nov 2013 21:16:59 +0100 (CET)
Message-ID: <20131106.211659.1008913569403460043.chriscool@tuxfamily.org>
References: <20131106.074355.225932577498673677.chriscool@tuxfamily.org>
	<CAP8UFD0STna++2StV1RcT2bB83Lh_hFQU94A0y4ziovs61Z==A@mail.gmail.com>
	<xmqq4n7pa1pn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: christian.couder@gmail.com, git@vger.kernel.org, johan@herland.net,
	josh@joshtriplett.org, tr@thomasrast.ch, mhagger@alum.mit.edu,
	dan.carpenter@oracle.com, greg@kroah.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 06 21:17:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ve9Xa-000341-Tu
	for gcvg-git-2@plane.gmane.org; Wed, 06 Nov 2013 21:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755221Ab3KFURX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Nov 2013 15:17:23 -0500
Received: from [194.158.98.45] ([194.158.98.45]:56675 "EHLO mail-3y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754997Ab3KFURW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Nov 2013 15:17:22 -0500
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id C81606E;
	Wed,  6 Nov 2013 21:17:00 +0100 (CET)
In-Reply-To: <xmqq4n7pa1pn.fsf@gitster.dls.corp.google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237366>

From: Junio C Hamano <gitster@pobox.com>

> Christian Couder <christian.couder@gmail.com> writes:
> 
>> To append a s-o-b only if there is no s-o-b already, one would need to use:
>>
>> [trailer "signoff"]
>>          key = "Signed-off-by:"
>>          if_exist = dont_append
>>          if_missing = append
>>          command = echo "$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"'
> 
> But that is insufficient to emulate what we do, no?  I.e. append
> unless the last one is from the same person we are about to add.

Yeah, but, with DONT_REPEAT_PREVIOUS, it would be possible using:

[trailer "signoff"]
         key = "Signed-off-by:"
         if_exist = dont_repeat_previous
         if_missing = append
         command = echo "$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"'

Cheers,
Christian.
