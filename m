From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: confirm on empty mail subjects
Date: Mon, 24 Aug 2009 11:19:46 -0700
Message-ID: <7v1vn1gjlp.fsf@alter.siamese.dyndns.org>
References: <1249490994-23455-1-git-send-email-jengelh@medozas.de>
 <7vhbwlpigo.fsf@alter.siamese.dyndns.org>
 <alpine.LSU.2.00.0908241927300.5382@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Mon Aug 24 20:20:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mfe9Q-0007Tf-DK
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 20:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011AbZHXSUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 14:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752889AbZHXSUD
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 14:20:03 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58826 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647AbZHXSUC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 14:20:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4BC67368A7;
	Mon, 24 Aug 2009 14:19:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DPbGsr0X+UA0QOqZU8bO8g8RjW8=; b=ephXw8
	JB3AL+a0Bxgpe+CVke7BjOqNiJ7gHTroOrwSjbbuq+jZGvbdw48ZPSQI5sYnnn6p
	6UxBiQrPoL2uKC2tDYWwMAS+SHQFUUG/6vZPykCJxOAyCLY8ZEySgwn+BjFMc8yJ
	HGp/T1/OAduLEWV1YNyZtc0lvdzjEINQQMStw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bZ5JoWPzQQyS+V6bQzgs1Ug1f4iagKGd
	N3BZzCi2ZsNXpR/HkdqHkeCikoM4G6EoDaAFzZTJtcrI+V0fsCRqW8uS5uhhI3QV
	l/0Te/aT1iEN6Btz39YV6wkfzLAjyhsBetPYzQ/9RGYiK9EaDyHPVENcvaZC1oZx
	R/uO788Q+Rs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2D8DB368A3;
	Mon, 24 Aug 2009 14:19:52 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E3A86368A2; Mon, 24 Aug 2009
 14:19:48 -0400 (EDT)
In-Reply-To: <alpine.LSU.2.00.0908241927300.5382@fbirervta.pbzchgretzou.qr>
 (Jan Engelhardt's message of "Mon\, 24 Aug 2009 19\:27\:56 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B75E8B68-90DA-11DE-AFA9-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126950>

Jan Engelhardt <jengelh@medozas.de> writes:

> On Thursday 2009-08-06 08:25, Junio C Hamano wrote:
>
>>Jan Engelhardt <jengelh@medozas.de> writes:
>>
>>> When the user forgot to enter a subject in a compose session,
>>> send-email will now inquire whether this is really intended, similar
>>> to what the Alpine MUA does when a subject is absent.
>>
>>This seems to break t9001...
>>
>
> Did I miss something in building?
>
> 19:26 sovereign:../git/git-1.6.4.1 > quilt pu
> Applying patch patches/send-email-empty-subject.diff
> patching file git-send-email.perl

Is this using 'pu' with your patch?  Near the tip of the 'pu' branch I
have a iffy workaround to "unbreak" the issue, but it is a rather
sledgehammer approach I do not feel comfortable enough to squash into your
patch yet.
