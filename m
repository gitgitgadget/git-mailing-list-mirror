From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix 'Cloning into' message
Date: Thu, 27 Oct 2011 10:39:09 -0700
Message-ID: <7vvcraz64i.fsf@alter.siamese.dyndns.org>
References: <1319648748-9150-1-git-send-email-richih.mailinglist@gmail.com>
 <1319734013-8956-1-git-send-email-richih.mailinglist@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 27 19:39:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJTvB-00025s-Kd
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 19:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960Ab1J0RjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Oct 2011 13:39:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52708 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753671Ab1J0RjM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2011 13:39:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7A704F0F;
	Thu, 27 Oct 2011 13:39:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PSkNOQh/5jIkIUodz/WwU297rqs=; b=hS8WeN
	0S4n6hqquZ+/ea/JlD0HEk42tPHdVgtnEzdTl/4IWGBZGNQ8jYYBCtajvIAy7VV+
	K2YIdK23/m+HhhhXO7+CH2gf42kXQBGsFpisCDYCSgx68bm/vNXqMXjDaUAEubU+
	lyE1vqfzpGrKY2CAabGGMdDv8YSqXVqlfixPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UtrUJQX8wVG/E6CC2E9qPkcPQIdHXDQP
	vPi7DJP4T6eCWcBIHRIElg9IQhNtMebFjwLDud8I3zV3Bl5Mh3TWmR+rjZePqbZf
	a0qSslhEUq+tl1XYAK0ncsHecsAApmiAlMYb/KZIENteRpJFoOpVNlRJZQuiX6hY
	Tm2lJrHWSB4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF7384F0C;
	Thu, 27 Oct 2011 13:39:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4572B4F05; Thu, 27 Oct 2011
 13:39:11 -0400 (EDT)
In-Reply-To: <1319734013-8956-1-git-send-email-richih.mailinglist@gmail.com>
 (Richard Hartmann's message of "Thu, 27 Oct 2011 18:46:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9480C778-00C2-11E1-AFBF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184304>

Richard Hartmann <richih.mailinglist@gmail.com> writes:

> Without this patch,
>
>     git clone foo .
>
> results in this:
>
>     Cloning into ....
>     done.
>
> With it:
>
>     Cloning into '.'...
>     done.
>
> Signed-off-by: Richard Hartmann <richih.mailinglist@gmail.com>

We try to be consistent and many places do quote user supplied paths in
pair of single quotes in human readable messages, and this is in line with
that pattern.

    $ git clone foo "joey's foo"

would result in

    Cloning into 'joey's foo'...

but that is probably Ok ;-)

Thanks.
