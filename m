From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] merge-recursive: Fix multiple file rename across D/F
 conflict
Date: Wed, 18 Aug 2010 12:00:13 -0700
Message-ID: <7vaaojagqq.fsf@alter.siamese.dyndns.org>
References: <1282089199-17253-1-git-send-email-newren@gmail.com>
 <1282089199-17253-3-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 21:00:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Olns9-0001RP-Ko
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 21:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404Ab0HRTAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 15:00:21 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64484 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751964Ab0HRTAU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 15:00:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C8034CEC31;
	Wed, 18 Aug 2010 15:00:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wOcEHzjaKSBFn8HtXz5GZtOYXvE=; b=lLLczt
	rzaY57dbDorwuIU0Sn1UGYwSvkDwXhtgckmerEt6vpHpIPEPOmpCbNbcbZbrCYcP
	A0xPE//tJhgrMZ+E3qGkP5h+Fi3Eqv81ps9MgIeEZWJ6LqukxWoMqdDdPNausr9J
	vNg3bhXwKh5tGp5g62R7eUC2dNNKtJhyz66uQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Dvf6j8qDR21AiI6sUqKBAgwROt3Q5WpZ
	UN+VGxd+aOUCv0HqydYrmY5dPqwICR4dzKRG4L0GUxq50Clp3pfeGrJuMTFs9iVQ
	Dm14wuqpxYMlLAmXgKJWAZuWd63MEZIc/ao0h/ZIs/3M6T+vZOj1dX9/S15XtCeP
	M+2R83JpBDg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A22ECCEC30;
	Wed, 18 Aug 2010 15:00:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F164CCEC2F; Wed, 18 Aug
 2010 15:00:14 -0400 (EDT)
In-Reply-To: <1282089199-17253-3-git-send-email-newren@gmail.com> (Elijah
 Newren's message of "Tue\, 17 Aug 2010 17\:53\:19 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D75FC3CE-AAFA-11DF-B539-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153876>

Elijah Newren <newren@gmail.com> writes:

> In 5a2580d (merge_recursive: Fix renames across paths below D/F conflicts
> 2010-07-09), detection was added for renames across paths involved in a
> directory<->file conflict.  However, the change accidentally involved
> reusing an outer loop index ('i') in an inner loop, changing its values
> and causing a slightly different type of breakage for cases where there are
> multiple renames across the D/F conflict.  Fix by creating a new temporary
> variable 'i'.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> I'm really embarrased about this one...  :-/

I am too ;-)  Thanks for a fix.
