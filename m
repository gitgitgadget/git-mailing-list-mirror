From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Correct way to pull using subtree merge without guesswork?
Date: Tue, 24 Jan 2012 10:27:01 -0800
Message-ID: <7vy5sx2byi.fsf@alter.siamese.dyndns.org>
References: <jfmr88$1p8$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Manuel Reimer <Manuel.Spam@nurfuerspam.de>
X-From: git-owner@vger.kernel.org Tue Jan 24 19:27:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rpl5L-0002s4-Am
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 19:27:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756032Ab2AXS1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 13:27:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57017 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753952Ab2AXS1E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 13:27:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C88916895;
	Tue, 24 Jan 2012 13:27:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=arY1Bk9A6ug2Lbs6WQeOiqO4orY=; b=rWaeXI
	p0b3G8GvvyBgsaQRUcEDXyLU3YA3jbfhfP1DbQZngomIQjRa4QhJWDTW222N3NYy
	h7mf9ApKRB7fyjwbxoWm09sxMSyxq3QNW492tXayYcmG/iI7aLcJL5FT63Af+ghX
	pcmI4/9LkWL9kO0wNYVkpW9Fva8vbCbxCrtuY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DXKySz1CYo7pvZbTJjeAa8KYFvqdgm0M
	V/RlvadHVLs8j5l5q/Xz1TGyYW6bPBmZGpJcqMrLicGWGYcOlnDsPHr5SAEGv4he
	bVkD/wKBsCkxrYd9WjcnmVw8l5v/KD/jfxCpYrx7aikPOSssq3s8NQnu36LGeS5O
	SGN6CEtdhbg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C18B16894;
	Tue, 24 Jan 2012 13:27:03 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 546046893; Tue, 24 Jan 2012
 13:27:03 -0500 (EST)
In-Reply-To: <jfmr88$1p8$1@dough.gmane.org> (Manuel Reimer's message of "Tue,
 24 Jan 2012 18:49:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 032644A0-46B9-11E1-A234-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189054>

Manuel Reimer <Manuel.Spam@nurfuerspam.de> writes:

> git pull -s subtree -X subtree=path/to/subtree externalproject master
>
> Returns with success, but is "-X subtree=" the right way to force a
> subtree path and disallow git to autodetect the subtree?

More or less. Note that with the syntax, you cannot still express the
distinction between mapping the root of external to path/to/subtree of
your current tree and mapping the other way around, but that is not an
issue in practice.

By the way, I had an impression that "-X subtree" makes "-s subtree"
redundant and unnecessary.
