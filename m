From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] helping smart-http/stateless-rpc fetch race
Date: Mon, 08 Aug 2011 16:26:19 -0700
Message-ID: <7vpqkftrhg.fsf@alter.siamese.dyndns.org>
References: <7vbow337gx.fsf@alter.siamese.dyndns.org>
 <CAJo=hJvdMCyU-5wzy0p1r+QJxXU=DJTE+Mu5G6pk9iAwAD51mA@mail.gmail.com>
 <7vbow01ols.fsf@alter.siamese.dyndns.org>
 <7vsjpbzv07.fsf@alter.siamese.dyndns.org>
 <CAGdFq_i=8p4jvKo1C=UFpmQyPtUd9JOtr9VW8vn7viC0dQkQmg@mail.gmail.com>
 <20110808230812.GA16974@LK-Perkele-VI.localdomain>
 <7vty9rtrk4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 09 01:26:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqZDG-0002X4-UD
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 01:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080Ab1HHX0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 19:26:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49052 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752376Ab1HHX0V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 19:26:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DA1446B5;
	Mon,  8 Aug 2011 19:26:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=juOX+YdTw/AsV8fruZlQ3aTXpgk=; b=vlgwzQ
	xTgF9YiouWKIY1rUaQR2Vgy9G4zpA1otmc/o/A0JJPHM6IeOX/RGGfHd0dvg5K87
	vvzHwsNUbfK70wL43bpnwozgW5/i2Vs7d6macR1+nVEGHelwKcB1go4DLx7wBA9s
	PFr8KkVEUe6K+mITQHPSiDa2sceL7QKHkqTZY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZNlXaDcBjtPs+0YoqFuOvG2KlqBULwQu
	5CGnvL/SyqdYwRbrGso5UE9QOBHRAVUaMqxs/bi2+h47LSwxzYwVvdyIt33Oh9/E
	S8ObyKTex7CWaQ2dRvHloWZmFNE1JHZhVsIyigQi0VYkoKakK+iu/4zwkGEMuF/D
	UqakxgLJVI4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85CA246B3;
	Mon,  8 Aug 2011 19:26:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C2FF46B1; Mon,  8 Aug 2011
 19:26:21 -0400 (EDT)
In-Reply-To: <7vty9rtrk4.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 08 Aug 2011 16:24:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D300E294-C215-11E0-80F4-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179009>

Junio C Hamano <gitster@pobox.com> writes:

> A separate option would allow admins to let their clients ask to fetch
> 4bc5fbf (that is v0.99~2) even if that commit is not at the tip of any ref
> if they choose to. That is what (1) is about, and people who do not want
> a separate option needs to argue that it is an unnecessary "feature".

By the way, I personally do not think it is necessary, but as long timers
on the list may recall, this has come up on the list for a few times.
