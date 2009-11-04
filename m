From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] format-patch: autonumber by default
Date: Wed, 04 Nov 2009 09:38:55 -0800
Message-ID: <7vskcui40g.fsf@alter.siamese.dyndns.org>
References: <20081002205539.GA36768@Hermes>
 <m1ws261qqi.fsf@fess.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Git List <git@vger.kernel.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <ae@op5.se>
To: ebiederm@xmission.com (Eric W. Biederman)
X-From: git-owner@vger.kernel.org Wed Nov 04 18:44:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5jtv-00039S-Q0
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 18:44:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbZKDRjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 12:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbZKDRjO
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 12:39:14 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48596 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932479AbZKDRjM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 12:39:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BF920928E3;
	Wed,  4 Nov 2009 12:39:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b+apkbwx2yRMxwHV45yoYQw0Q6A=; b=woNgbX
	usyguxrTnh4nBs/vOcMyoRbomwtWom2C2qxGd30cWmXPKK+1PNBzj/Rn+VLq01C8
	bkR+tuRnOlEZOuISFKbmxllKPpWl4nbOwZUzp/ZOYD2owjIChya4Jt8LtQYNtkFs
	EBa3LC5k36B+DLTXzZnMR0fqHsoyrEpFS91wo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B+ThrowpTbP9d41VECmhfNcRMZzs8UpL
	WC5BdcLnryUdFqJUsa+6lNJ+ZslXsmYmWVv2wAalSQZdFewVxmQwzTqzOcLOYGoj
	8F7VOUSjrtgFcaGzppExJDcpL1UZZLqH0noEmjv9GKhHqYLWg7ZdwN4qJITVEmoK
	xel4cIvw1/0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4F4D0928D9;
	Wed,  4 Nov 2009 12:39:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9F1D7928D5; Wed,  4 Nov 2009
 12:38:57 -0500 (EST)
In-Reply-To: <m1ws261qqi.fsf@fess.ebiederm.org> (Eric W. Biederman's message
 of "Wed\, 04 Nov 2009 03\:20\:05 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F474B452-C968-11DE-AC7D-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132098>

ebiederm@xmission.com (Eric W. Biederman) writes:

> Brian Gernhardt <benji@silverinsanity.com> writes:
>
>> format-patch is most commonly used for multiple patches at once when
>> sending a patchset, in which case we want to number the patches; on
>> the other hand, single patches are not usually expected to be
>> numbered.
>>
>> In other words, the typical behavior expected from format-patch is the
>> one obtained by enabling autonumber, so we set it to be the default.
>>
>> Users that want to disable numbering for a particular patchset can do
>> so with the existing -N command-line switch.  Users that want to
>> change the default behavior can use the format.numbering config key.
>>
>> Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
>> ---
>
>
> Grumble.  I updated git last night and this change just bit me.
> Grumble.
> Grumble.
>
> It is probably a good change, but it was unexpected.
> Grumble. Grumble. Grumble.

That change was in 1.6.1.1 or so, no?  Welcome to year 2009 ;-)

Out of curiousity, which version did you update _from_?
