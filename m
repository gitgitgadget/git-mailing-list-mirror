From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clean: confirm before cleaning files and directories
Date: Fri, 26 Apr 2013 09:10:41 -0700
Message-ID: <7vbo91z30e.fsf@alter.siamese.dyndns.org>
References: <1826d070612808b301f9295838e226e02d8097ad.1366963586.git.worldhello.net@gmail.com>
	<vpqfvydhfbx.fsf@grenoble-inp.fr>
	<CANYiYbFzEoEgJzKsB_hiKNy2JCxaTDX30wXNjnzComOzJJF_cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 18:11:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVlEi-0003R4-2A
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 18:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755516Ab3DZQKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 12:10:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34477 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755397Ab3DZQKo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 12:10:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CB0C19968;
	Fri, 26 Apr 2013 16:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gDtf0jkxHqnhllieIm72vnWyxr4=; b=CzJyvk
	QL7culcA5ewcUxes4iYYabN2sp9qrlkEL732tE9RcXlmo7kTKaK2Il1YLqeJsndt
	grS2uCQwxO0RHdalJHqkzG90ebCYsZSfzpBW5WHppcjwDg0SXQixLOIuAclBi3oK
	MB0RO4oSinly4UXENoPneVEwgLOFjY0bFDuZM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lDGvzoks5XTFTI7gY8K80d0qiCyW10EB
	oHVHrnSiVKApXxZFBo8issmy4z84XnvAo0kLl5Ccj/kWg8XnmL+JMB3+kKrcfo4Z
	+MDJlVyFbVpf3aSsp4WhCcaMyl255D5FfF70HJNc4vYrKTF7tPOs4qSovyJelGEg
	HyGb6bTFKj0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 93D2819967;
	Fri, 26 Apr 2013 16:10:43 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1BF8C19966;
	Fri, 26 Apr 2013 16:10:43 +0000 (UTC)
In-Reply-To: <CANYiYbFzEoEgJzKsB_hiKNy2JCxaTDX30wXNjnzComOzJJF_cw@mail.gmail.com>
	(Jiang Xin's message of "Fri, 26 Apr 2013 16:41:19 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D88B0410-AE8B-11E2-8A6C-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222537>

Jiang Xin <worldhello.net@gmail.com> writes:

> I don't know how many programmers had been bitten by runing `git clean -fdx`,
> but I bet there were some. I think safety should be put to the 1st place.

"git clean" without -n/f errors out, hinting the availablilty of -n
while mentioning -f; that is the safety, isn't it?  Once the user
decides to give -f, the user _wants_ to remove cruft, and it is a
hinderance to require any further confirmation.

Your problem description sounds like that you want to drive without
wearing seatbelts but in case you get in a collision, you suggest to
make the seat automatically stick to the back of anybody who sits on
it with superglue to make it safer.

That approach might give it an alternative safety, but it would make
it extremely annoying if you apply it also to people who do wear
belts, no?

This extra confirmation should never be the default.
