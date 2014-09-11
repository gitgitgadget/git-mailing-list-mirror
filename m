From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] pretty: add %D format specifier
Date: Thu, 11 Sep 2014 12:42:37 -0700
Message-ID: <xmqq8ulqdjv6.fsf@gitster.dls.corp.google.com>
References: <5410C998.5060701@exec64.co.uk> <5410C9EF.9080509@exec64.co.uk>
	<xmqq61guf641.fsf@gitster.dls.corp.google.com>
	<5411DB50.8080602@exec64.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Harry Jeffery <harry@exec64.co.uk>
X-From: git-owner@vger.kernel.org Thu Sep 11 21:42:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSAGS-0006fN-9M
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 21:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756097AbaIKTmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 15:42:40 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52350 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753999AbaIKTmk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 15:42:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 83A5E3A44A;
	Thu, 11 Sep 2014 15:42:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EVdZd57L6hwjgdqtINXjoUVDjEI=; b=mCA96x
	2DCQeHLc9dIbHgjsS6GB2Wxk9uHIxgnEZGNn9AqXvxwELYI3JjsY4vAdWieswJ4p
	5VxD4fEkCjfAJbNR9HI5Emtx0apYN/UTsswVy36sBWR7nGpkLdvIbWNi9iCtpj+j
	wJMZt/d54siD+0w6Cl1WEBHCCc74GW5LJRy+I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pxZ83QYylOBpw8um4sbFx00iI2hmofY9
	w98f7OxjjqGmMzhxnoh6zH6oYK4v4PAgo8uTBCpL1SN1Od1VPXh8MyZSingt7yTx
	wDHgCT+0lZOfxuK4/0YdoQfqIAshLQh4IQsSVwKgTF+E1fHE74DasMtFYXK7slt3
	XCImoxG5Oq0=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 783133A448;
	Thu, 11 Sep 2014 15:42:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EFFAF3A447;
	Thu, 11 Sep 2014 15:42:38 -0400 (EDT)
In-Reply-To: <5411DB50.8080602@exec64.co.uk> (Harry Jeffery's message of "Thu,
	11 Sep 2014 18:26:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C9930056-39EB-11E4-B97F-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256870>

Harry Jeffery <harry@exec64.co.uk> writes:

> On 11/09/14 17:56, Junio C Hamano wrote:
>> Because patch 1/2 alone does not make much sense without 2/2, it
>> probably would have been better to do these as a single patch.
>
> Would you like me to resubmit it as a single patch, or are you
> applying them as is?
>
>> And of course a few additional tests to t4205 would not hurt ;-)
>
> Sure. Should the tests be in the same patch, or a subsequent one?

All in one; that way, "git show $that_single_patch" later can become
more useful by demonstrating expected uses in its test.
