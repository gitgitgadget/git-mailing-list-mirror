From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2/3] mergetools/kdiff3: allow opting-out of auto-merges
Date: Thu, 09 May 2013 12:15:36 -0700
Message-ID: <7v38tw9d7r.fsf@alter.siamese.dyndns.org>
References: <1368090810-40596-1-git-send-email-davvid@gmail.com>
	<1368090810-40596-2-git-send-email-davvid@gmail.com>
	<7vli7ob0c4.fsf@alter.siamese.dyndns.org>
	<20130509172334.GK25912@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	Charles Bailey <charles@hashpling.org>,
	Theodore Ts'o <tytso@mit.edu>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu May 09 21:15:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaWJb-0000rt-Rq
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 21:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900Ab3EITPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 15:15:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60854 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751419Ab3EITPj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 15:15:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07CAF1D9E3;
	Thu,  9 May 2013 19:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SSVYvY3RF8FrYEK/FdENt1i5DYY=; b=M4yXLt
	nocNkfKfS//bQo8YYvOj7mm7YDfJjqorsKCap193n1Z4xdOqbvij7nacTvN+RlPV
	GSg8vgYEOz72YWu2MRmHoAWASVGLe0OJ9p0RJ1SM5ZVf6WaZEiBMvXa0rh8BQTnR
	Sech8DhBcrjBLD4mOU7BqvMI0fdkhxkmnnxss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K+kYVV02w7c7kdR1x0gApSnVur0Dc/X1
	6ODAp802JYu8GtbcUDX4yLYuxvE7dJrX8RfcNSqddCbmmbRUa0C8YZH836XQqg7N
	TdAlEvAEUu0SYJ1wtXBlSSUlZsKx4ngbhTsGpiCNCMCO3Wp75BzVBoEoFWtURL0s
	dvMi6aIDppg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F134F1D9E2;
	Thu,  9 May 2013 19:15:38 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7710A1D9E1;
	Thu,  9 May 2013 19:15:38 +0000 (UTC)
In-Reply-To: <20130509172334.GK25912@serenity.lan> (John Keeping's message of
	"Thu, 9 May 2013 18:23:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D545A1CE-B8DC-11E2-8981-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223772>

John Keeping <john@keeping.me.uk> writes:

> On Thu, May 09, 2013 at 09:10:51AM -0700, Junio C Hamano wrote:
>> David Aguilar <davvid@gmail.com> writes:
>> 
>> > Marked "RFC" because I am kinda against adding more configuration
>> > variables.
>> 
>> Just like "git merge" has -X<option> escape hatch to allow us to
>> pass backend-specific options, perhaps you can add a mechanism to
>> "git mergetool" to let the user pass --no-auto from the command
>> line?
>
> We already have "mergetool.<tool>.cmd" which allows a completely custom
> command line to be specified.

Then probably it is a good idea to drop this patch and replace it
with a documentation patch to suggest those who do not want --auto
to use that mechanism?
