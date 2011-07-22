From: Junio C Hamano <gitster@pobox.com>
Subject: Re: reset: silent for some commands, verbose for others?
Date: Fri, 22 Jul 2011 10:43:36 -0700
Message-ID: <7vei1iyzw7.fsf@alter.siamese.dyndns.org>
References: <4E29A792.9020805@avtalion.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ori Avtalion <ori@avtalion.name>
X-From: git-owner@vger.kernel.org Fri Jul 22 19:43:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkJlJ-0001pK-3J
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 19:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754283Ab1GVRnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 13:43:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44537 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754013Ab1GVRnj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 13:43:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD24831E7;
	Fri, 22 Jul 2011 13:43:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S0V9BXJQCryAsyscHqk/xAXEzBg=; b=tbBCEm
	a+XZRMUEf0U104EHkjoPFxnqdutUzLntNA4KMqyo81fU+s6KABJm82XbS4w5rhko
	Jq3gkfQUnU9eL/1n4FMh9ef8qCLGIrTK0XtcKAUGCqsWWhFc/xspQA3RdLrZ7oow
	lMe3ORA9jngdvIBG3F5VPeircUq19TE3cSUBY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XbQ9T/1mYEpz94mNCL8BPCRRA39xxdwB
	TkShXSh3pixwDJ94VutYlgkLTxkt3tIzTUIAr/DZBW7Oc6+1JmVLdOxwAY7VWIFU
	cwwKczTwpnxsEZ9fNjcC6foUoydnKImk76+sFJCBo2Tl061RrpsCjUw+P4aH8np3
	ksmDQQmqCNg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A569631E6;
	Fri, 22 Jul 2011 13:43:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 40BF431E5; Fri, 22 Jul 2011
 13:43:38 -0400 (EDT)
In-Reply-To: <4E29A792.9020805@avtalion.name> (Ori Avtalion's message of
 "Fri, 22 Jul 2011 19:38:42 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 21912534-B48A-11E0-85F2-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177651>

Ori Avtalion <ori@avtalion.name> writes:

> Looking at the reset's command third form:
>
>   reset [--soft | --mixed | --hard | --merge | --keep] [-q] [<commit>]
>
> * --soft, --merge, --keep are silent.
> * --mixed prints "Unstaged changes after reset: ..."
> * --hard prints "HAED is now at..."
>
> If all of those commands move HEAD, shouldn't all of them print "HEAD is
> now at..."?
>
> Why should only --mixed print the list of unstaged files? e.g. Isn't it
> useful for --soft to give a list of "Staged changes"?

I would say not, as you would use "soft" only when you _know_ what you
have in the index is what you want, and more importantly it does not
change what is in the index, unlike "mixed" variant.
