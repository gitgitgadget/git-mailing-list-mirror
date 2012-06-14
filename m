From: Junio C Hamano <gitster@pobox.com>
Subject: Re: drivers/block/cpqarray.c:938:2: error: too many arguments to
 function =?utf-8?Q?=E6=85=B4lk=5Frq=5Fmap=5Fsg=EF=BF=BD?=
Date: Thu, 14 Jun 2012 10:26:20 -0700
Message-ID: <7vpq91erer.fsf@alter.siamese.dyndns.org>
References: <4fd91c3f.KAwMcygw9fFGn9Cx%wfg@linux.intel.com>
 <4FD984F3.3070502@kernel.dk> <20120614090151.GA12013@localhost>
 <4FD9A95D.40903@kernel.dk> <20120614092519.GA12482@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
	linux-raid@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Fengguang Wu <wfg@linux.intel.com>
X-From: git-owner@vger.kernel.org Thu Jun 14 19:26:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfDoR-00015Z-LX
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 19:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241Ab2FNR0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 13:26:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35458 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756285Ab2FNR0W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 13:26:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C42F8536;
	Thu, 14 Jun 2012 13:26:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tuPpT6NXW3IJ3j/WGU45q4X3YSo=; b=l3ySnu
	G18jtyZwqupoBe5KgpFp10OuQm73FvoVQUjqWEw82/nOWgvc1/K17CNrj+rguRiq
	XbZhIPAN6oO8jz+v8uHEPLfZvmpuKgsxhLiZQWHWY/l+alPDbgvIN7EQDrytYMsi
	2b/drZZgQ1WhUteMP3JK8pD4sBZ1ZRgqndMvA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yEmmGHpUNz+UYOjFp0wnwF+WNR4PPuZC
	bBVK350Be3X/wYGroOlCCuRkfv+L5Vdc7hfvsjH9hSyUm9/Jk953vuA0uMsELfQS
	oZ+QsBQ5wYrbmyUulDccLM3ahFtIH3xHMvYN7aQh7Edm4jjkJBI7jDJMVHZX6EvF
	GS6oFeIAn+c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 43A348535;
	Thu, 14 Jun 2012 13:26:22 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B4D1B8534; Thu, 14 Jun 2012
 13:26:21 -0400 (EDT)
In-Reply-To: <20120614092519.GA12482@localhost> (Fengguang Wu's message of
 "Thu, 14 Jun 2012 17:25:19 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0F41EA3A-B646-11E1-AB0F-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200023>

Fengguang Wu <wfg@linux.intel.com> writes:

> If we can somehow tag the whole branch, it would be most convenient.
> Git can add description to a branch with
>
>         git branch --edit-description [branch name]
>
> However I don't know how to retrieve that description on a remote
> branch..

The branch description is designed to be a place you leave your
temporary note locally outside the history, until you are ready to
set the contents of the branch in more permanent storage (e.g. by
merging it to an integration branch, or sending pull requests for
it) at which time the information is consumed (e.g. inserted in the
merge commit message or pull request message).  The history exchange
via "git push" / "git fetch" is by definition about exchanging the
history, and will not transfer branch descriptions.

For shared and more permanent notes, "git notes" may be more
suitable vehicle.
