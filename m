From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 2/2] ident: add user.useConfigOnly boolean for when ident shouldn't be guessed
Date: Fri, 05 Feb 2016 15:19:50 -0800
Message-ID: <xmqqsi16bv8p.fsf@gitster.mtv.corp.google.com>
References: <1454711337-25508-1-git-send-email-alonid@gmail.com>
	<1454711337-25508-3-git-send-email-alonid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Dan Aloni <alonid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 00:20:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRpfW-0003Ct-Sr
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 00:20:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbcBEXT6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 18:19:58 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61973 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750699AbcBEXT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 18:19:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2C6EF424FE;
	Fri,  5 Feb 2016 18:19:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lUUqIRqvpBXdiWYFvRk7N2oO7w8=; b=ec8EbP
	RAj6O29uaaOdh1vpsenfOjknuxgLK2uR5PTEuVXizMu6YP87Qf2rb1Y0NrthfkGO
	UQmk8aaGNtJJF3KSiqP9CLFl/AdMeUOlueGNmso/gvamYweTIEkpQCEuL+kjW+I+
	QQ+FBVZsFfqVflInLdNiGHelboTOlLU05sEKE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wIIm2vLm7jqBYwtcI7aT6qp6QFduvll/
	mVNsHqkGJT2GJQhck3S6gAU9Y8aL/ktMSFXRZ+svzvAfDl0SfcS3DU/RQusTWt3Z
	1zQArUfyWO4WS1UBkMiwid3nBs1N/eYYvVTaItSj4I7GzWE/AflGIaT0UIiTP9i7
	aeDfPCi2aSc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 21E9D424FD;
	Fri,  5 Feb 2016 18:19:52 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 99764424FC;
	Fri,  5 Feb 2016 18:19:51 -0500 (EST)
In-Reply-To: <1454711337-25508-3-git-send-email-alonid@gmail.com> (Dan Aloni's
	message of "Sat, 6 Feb 2016 00:28:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F523BB32-CC5E-11E5-BD1A-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285651>

Dan Aloni <alonid@gmail.com> writes:

> +user.useConfigOnly::
> +	Instruct Git to avoid trying to guess defaults for 'user.email'
> +	and 'user.name', and instead retrieve the values only from the
> +	configuration. For example, if you have multiple email addresses
> +	and would like to use a different one for each repository, then
> +	with this configuration option set to `true` in the global config
> +	along with a name, Git will prompt you to set up an email upon
> +	making new commits in a newly cloned repository.

I do not think this is wrong per-se, but s/upon/before/ may be more
accurate and would assure the users more that no commits with a
wrong identity will be created.

Other than that, these two patches look very good to me.

Thanks.
