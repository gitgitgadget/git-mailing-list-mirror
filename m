From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] fetch: verify we have everything we need before
 updating our ref
Date: Fri, 02 Sep 2011 16:14:30 -0700
Message-ID: <7v39ge1qqx.fsf@alter.siamese.dyndns.org>
References: <7vpqjkw3nb.fsf@alter.siamese.dyndns.org>
 <1314917015-3587-1-git-send-email-gitster@pobox.com>
 <1314917015-3587-4-git-send-email-gitster@pobox.com>
 <CACsJy8C4qX=p6d1v+i7TJanACOqL9R6-pv9AOaU_CM6DNjJfyQ@mail.gmail.com>
 <7v8vq7muzi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 03 01:14:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzcwZ-0005Nz-Ut
	for gcvg-git-2@lo.gmane.org; Sat, 03 Sep 2011 01:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756680Ab1IBXOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Sep 2011 19:14:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41033 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756646Ab1IBXOc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2011 19:14:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 540F95AE4;
	Fri,  2 Sep 2011 19:14:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n+MpNTxzObivZkaWH6SVzS5jtrI=; b=nS+AWb
	piF5Y8on1uEyhttfEH0ZgLCsjlLky5lGv1WzKaXyvPmzsKfytFNwWDWYZ9sgMbzu
	czqNtv03wEoOHTY2JulFNfUEHUDNM3jrRQnyWN8pW6CO7V/q5OLEGgP6LIWws7tc
	jSJvpudqedbVkiG85YyLCO8xl1z4WXVEZHjiA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BTUwZieuzGjbx4tDu4xYr0wZrSsNh/2w
	N85M/WqkyWRbQEWXM4eRmhHpw/pYmLdOxNPj2N+q8QKnNo5fInqvE+LAPzEppB8u
	fn8ZLvO11cJvHaQf4RCjNZPjxWuD8JETNXyfEM3TgNUL8i1r/fpk/OLOKJhrMgjC
	83GxnbJd0Jo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AE6B5AE3;
	Fri,  2 Sep 2011 19:14:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D9BA85AE2; Fri,  2 Sep 2011
 19:14:31 -0400 (EDT)
In-Reply-To: <7v8vq7muzi.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 01 Sep 2011 21:25:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 50998C04-D5B9-11E0-BB2E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180641>

Junio C Hamano <gitster@pobox.com> writes:

> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> What about receive-pack? Does it have the same breakage?
>
> I didn't look---you tell me ;-)

I looked. It needs a similar check, and I'd need to refactor the
check_everything_connected() function a bit to take an iterator.

Will send a follow-up series this weekend.
