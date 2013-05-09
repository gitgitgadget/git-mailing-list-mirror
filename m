From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2/3] mergetools/kdiff3: allow opting-out of auto-merges
Date: Thu, 09 May 2013 09:10:51 -0700
Message-ID: <7vli7ob0c4.fsf@alter.siamese.dyndns.org>
References: <1368090810-40596-1-git-send-email-davvid@gmail.com>
	<1368090810-40596-2-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	Charles Bailey <charles@hashpling.org>,
	Theodore Ts'o <tytso@mit.edu>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 09 18:11:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaTQp-00009a-Kx
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 18:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868Ab3EIQKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 12:10:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58231 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751753Ab3EIQKz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 12:10:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 260D61BEC3;
	Thu,  9 May 2013 16:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oWWd1yjZFmaCfWfSxJTux0XzQd8=; b=vR4KIL
	UphCGJRrORGnhqdTjz3f5p+xBSd5bvZ8YtOLnN0k0JCXzNUpPSXuzHV3e206oNOT
	tyrKOrFVyRtf3T7L3QMiN+ySva5U7xc3Il0p4TqK28PkQg6rZ8l4GlMuUuzhJpvC
	ljs6HmTUVQXx2VmWY1GK/OPIYKUX5HcGNmxRo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DsWhIpDs9C+y/CtJWrFJME+mUwBla1rl
	LVO8NvlcCh+iM5+zkgHJYzamf2obAs1tEnZv9jejkgGYqpEfM0VVrNbwEpW44day
	O3urzx6aMqdMGOA92f96D3rRPAm7//IMP+YCVJlHj1hmlSVrY3orjbOVgmoPafv2
	D7y+AJiPdtw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18E561BEC2;
	Thu,  9 May 2013 16:10:54 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 920201BEC1;
	Thu,  9 May 2013 16:10:53 +0000 (UTC)
In-Reply-To: <1368090810-40596-2-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Thu, 9 May 2013 02:13:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 062A2CA2-B8C3-11E2-87F9-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223739>

David Aguilar <davvid@gmail.com> writes:

> Marked "RFC" because I am kinda against adding more configuration
> variables.

Just like "git merge" has -X<option> escape hatch to allow us to
pass backend-specific options, perhaps you can add a mechanism to
"git mergetool" to let the user pass --no-auto from the command
line?
