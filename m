From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] fix quotes in maint-reflog-beyond-horizon and
 detached-stash
Date: Tue, 31 Aug 2010 10:03:08 -0700
Message-ID: <7vzkw2btpv.fsf@alter.siamese.dyndns.org>
References: <1283266160-11665-1-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 19:03:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqUEz-0004QG-23
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 19:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754127Ab0HaRDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 13:03:16 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57486 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753770Ab0HaRDP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 13:03:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 44596D259A;
	Tue, 31 Aug 2010 13:03:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=PAAhiS6tYhxGzbThYuszwmNuHng=; b=MJ2+zDcWt42dYjfpr3c4LA7
	2JazsR18KYjT5MDmU38HX5v1TZ59m5HjixUZrMUpDxj2uEUXxf0ysbNm69WlCQ7x
	aZ4j/ZtyL8erMJI9xVv50fi9JY36677x5KGxci1lKqXjrvCow2fTnHRIzz9kI8m5
	rnVPsQrF63oHM09vS/XU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=IA1qVPPfe1nBXJ5OugioWEdOo3p1oxtVH0engfwSIByMcLUPl
	d/JfqEwDBVcJisMXpITYRBOUjWNIfe8ptuhvXnSVBT1rJhF2BRz3tYOXrnuuXryg
	K3rCzAoZUS+B7e1sFNnFmOJUc62QclLTUrd4FZhY6jdC16g3Or8Js3418s=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 07461D2596;
	Tue, 31 Aug 2010 13:03:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C874AD2592; Tue, 31 Aug
 2010 13:03:09 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A3BA5FC6-B521-11DF-A3A6-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154941>

Jon Seymour <jon.seymour@gmail.com> writes:

> In two recent series, I introduced tests that use test_must_fail incorrectly.
>
> In effect, I was calling:
>
>    test_must_fail "foo bar"
>
> but this was failing because "foo bar" is not comamnd and not because
> the command "foo" fails with arguments "bar".

Blush; sorry for not noticing them earlier, and thanks for the fix.
