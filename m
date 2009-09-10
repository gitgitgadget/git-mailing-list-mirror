From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/3] INSTALL: Describe dependency knobs from Makefile
Date: Thu, 10 Sep 2009 11:56:39 -0700
Message-ID: <7v7hw6aas8.fsf@alter.siamese.dyndns.org>
References: <7vpra0hcd3.fsf@alter.siamese.dyndns.org>
 <1252591928-2278-1-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 20:57:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlopI-0007j0-6A
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 20:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753315AbZIJS4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 14:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753266AbZIJS4p
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 14:56:45 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48173 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753246AbZIJS4o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 14:56:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 789132D7F0;
	Thu, 10 Sep 2009 14:56:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GQi2gLVK9hB7yNkdQCy1dLGjbsI=; b=f/p/XQ
	OWlwQBh1Hub4hF72ALP788amvCVogfMUIAmkGNYOXk/0ueDpRX6C+gHbJip29MQ7
	AxBU77cV1nB15iZfTgBeAQDcXqwqoSRplRKnAiipk0YtD6CoZlrh5u3feS2Xl3hb
	NSm9JroMgbiEB74Uv1+dl09hlNVM2a10fe9H4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y+riR67ckEt+B27nKzQikghIzkj2sq4i
	u6XKcVIjUAK4vuoOZStWYrzIz0l2QcZ9JYE3uB3Gp3qmYAOYRKxPRSFtsMX2y4kW
	+1jT3iaQ7X7hbjizT+54+WZW2E+6lXOFfZjKBI0ZqLpW30hb+4OxP0OFJEu1VfIx
	XmLUI69uP+I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D3512D7EE;
	Thu, 10 Sep 2009 14:56:45 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A5C4A2D7EB; Thu, 10 Sep
 2009 14:56:40 -0400 (EDT)
In-Reply-To: <1252591928-2278-1-git-send-email-brian@gernhardtsoftware.com>
 (Brian Gernhardt's message of "Thu\, 10 Sep 2009 10\:12\:08 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AF92070C-9E3B-11DE-9C2E-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128136>

Brian Gernhardt <brian@gernhardtsoftware.com> writes:

> We said that some of our dependencies were optional, but didn't say
> how to turn them off.  Add information for that and mention where to
> save the options close to the top of the file.
>
> Also, standardize on both using quotes for the names of the dependencies
> and tabs for indentation of the list.
>
> Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
> ---
>
>   Junio C Hamano <gitster@pobox.com> wrote:
>   > I did not like calling "make variables" "options", and also it was unclear
>   > what good these "options" are for.  How about...
>
>  Sounds good.  Would have sent this out yesterday, but I ran out of tuits.
>
>  INSTALL |   38 ++++++++++++++++++++++++--------------
>  1 files changed, 24 insertions(+), 14 deletions(-)
>
> diff --git a/INSTALL b/INSTALL
> index 7ab2580..69c97b2 100644
> --- a/INSTALL
> +++ b/INSTALL
> @@ -13,6 +13,10 @@ that uses $prefix, the built results have some paths encoded,
>  which are derived from $prefix, so "make all; make prefix=/usr
>  install" would not work.
>  
> +There are many options that can be configured in the makefile using either
> +command line defines or a config.mak file.  These options are documented at
> +the beginning of the Makefile.

Sorry, but the description still speaks of options and does not say what
good they are.  Sent a wrong patch?
