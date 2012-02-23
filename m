From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 3/5] tag --exclude option
Date: Wed, 22 Feb 2012 17:00:12 -0800
Message-ID: <7vty2i749v.fsf@alter.siamese.dyndns.org>
References: <1329874130-16818-1-git-send-email-tmgrennan@gmail.com>
 <1329874130-16818-4-git-send-email-tmgrennan@gmail.com>
 <7vhayjbcna.fsf@alter.siamese.dyndns.org>
 <20120223002215.GE2410@tgrennan-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, jasampler@gmail.com,
	pclouds@gmail.com
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 02:00:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0N2l-0006sR-FJ
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 02:00:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563Ab2BWBAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 20:00:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54961 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753413Ab2BWBAP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 20:00:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B08A867E2;
	Wed, 22 Feb 2012 20:00:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KfMwWAzk1/1KMUuvmpQhvoJrrIU=; b=sjrwt5
	oNdc/4mV/JbJcVt5IoHlPeOkCvM3EkncdyD211ygUOoP0e0XQTJDy8mPe+as6CBl
	xu/+DUxcFgS0YUFeBjyRgFH0A72x5U3VCSrJ6Kvhu1SbN5unoqepGvR7t0GjE63b
	3Ot71AUhzuWa0m/AjCdPp1IBTs7d7t6uQeOZw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MkI1IHuyNppHb/anvX5mky+DdKbc6Xxf
	LZnZDdWBddLD/d9drtIZ8pLuO2DBZr6dg6fo96LBObtS7avc4gmsAVI6+AIAORf5
	2QN1mlu89Q8CzbzlK91keoDVZCT4BcM0u2NwRheaX9hSvJFfkOxm/UQXmEaYswvL
	TjKuItK7wTg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A767867E0;
	Wed, 22 Feb 2012 20:00:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 276C467DF; Wed, 22 Feb 2012
 20:00:14 -0500 (EST)
In-Reply-To: <20120223002215.GE2410@tgrennan-laptop> (Tom Grennan's message
 of "Wed, 22 Feb 2012 16:22:15 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BE5A0CAE-5DB9-11E1-AC65-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191318>

Tom Grennan <tmgrennan@gmail.com> writes:

> On Tue, Feb 21, 2012 at 10:33:29PM -0800, Junio C Hamano wrote:
>
>>As you do not specify what kind of pattern matching is done to this
>>exclude pattern, it is important to use the same logic between positive
>>and negative ones to give users a consistent UI.  Unfortunately we use
>>fnmatch without FNM_PATHNAME for positive ones, so this exclude pattern
>>needs to follow the same semantics to reduce confusion.
>>
>>This comment applies to all the patches in this series to add this option
>>to existing commands that take the positive pattern.
>
> OK, should I also describe the --no-exclude option?

If you support it, yes.  What does it do?

--no-exclude::
	Cancels all the `--exclude` options given so far on the command line.

perhaps?
