From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/14] Improve git-status --ignored
Date: Mon, 15 Apr 2013 12:33:07 -0700
Message-ID: <7vwqs3r3m4.fsf@alter.siamese.dyndns.org>
References: <514778E4.1040607@gmail.com> <516C4F27.30203@gmail.com>
 <7v1uabsin7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Adam Spiers <git@adamspiers.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 21:33:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URp9V-0007bx-Op
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 21:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755106Ab3DOTdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 15:33:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51719 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754812Ab3DOTdK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 15:33:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6C3716593;
	Mon, 15 Apr 2013 19:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nzR6pqwmbRTcfqrKRYBHHNdAR8k=; b=cRLoY2
	zxrj2muBmwGgz/8PXT8I1GzQ1cbmszs6fzIW7+82Rr9SWU+8UMF0MOPlIQu4yCTk
	N0FWfqr/IuTjjaeKgoSL8dXmTVupEIzkybb3XPt43L/3l2ruuAyE/5vU9tgkhkS+
	8WBW9umjIbt+dh7ubuZaPgauM8YXelXEMHhr8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yXXAtiLeR5uXu3tKjoMQDW7gk9bWlhNb
	bJcwNPMCP0QLYj2V+aOMip6uTQH4/EgTlttpECAQpS5BdnUqjmc38ZjpvQvXAAjj
	lX1L0Fqx7hlhENXDHWk5Vii50M1cQEo54AwUe0cuX7SE9quBEfODLjC+UL0WTCu+
	ycuDIxjsLR4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 995D716592;
	Mon, 15 Apr 2013 19:33:09 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 052011658C; Mon, 15 Apr
 2013 19:33:09 +0000 (UTC)
In-Reply-To: <7v1uabsin7.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 15 Apr 2013 12:23:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4D933E76-A603-11E2-896E-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221306>

Junio C Hamano <gitster@pobox.com> writes:

> Karsten Blees <karsten.blees@gmail.com> writes:
>
>> This patch series addresses several bugs and performance issues in
>> .gitignore processing.
>
> A 8-patch series ending at 5d765dc7888b (dir.c: git-status: avoid
> is_excluded checks for tracked files, 2013-03-18) has been cooking
> in 'next'; in general we won't revert and requeue a new round for a
> topic that has already merged to 'next'.
>
> Is this "v2" an update for that topic?

Hmph, it seems to be the case.  I was hoping that the one in 'next'
was basically in a good shape, not so broken to require a wholesale
replacement like this.  Overall, this round of reroll seems to be
better structured.

Let's revert the v1 from 'next', queue this one to 'pu', and make it
advance slooowly this time.

Thanks.
