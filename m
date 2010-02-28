From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] merge-file: add option to specify the marker size
Date: Sun, 28 Feb 2010 12:13:22 -0800
Message-ID: <7viq9h3yql.fsf@alter.siamese.dyndns.org>
References: <972adf380be481b5e8d031481586e9c34da2cbb7.1267385538.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 21:13:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlpWC-0002Wu-GF
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 21:13:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031979Ab0B1UNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2010 15:13:31 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56894 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031966Ab0B1UNa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 15:13:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CA129D40F;
	Sun, 28 Feb 2010 15:13:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jb9s+JI+oySn4jeadoe3QIaYK/Q=; b=E0hFjR
	4P5lgbnHMl1NuR2iqgllIgLcgEwhMwZngKIc6B9RKy5i9XYXAAVL2SYT032C32Rl
	wo4vwZYp+083SO8NN4Eu7tXWrBWjM12SwuwX8PUXkoKm9NuwmyVGJB1l2L2uwup7
	Rsqtd2NAjrThYpWd0eEbHaMQ1ipNNt8EYWbi0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kL7NCwFyHvCz3fppHb0GzaZ2hU9nAtSO
	c9NIXmgR04yAFEyehPFs5/D5D1Qsn0WrhNBgynfL3dLtJDtasi19+c0rYUvlYivq
	GcTC1deGfuusa58NtZTHiUwlq9E9rEnN/ll1T3B6zw8qUlDtn4eR40Cr9sSAjlPo
	Mw7cNXX8rRE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 795E19D40E;
	Sun, 28 Feb 2010 15:13:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E53139D40D; Sun, 28 Feb
 2010 15:13:23 -0500 (EST)
In-Reply-To: <972adf380be481b5e8d031481586e9c34da2cbb7.1267385538.git.bert.wesarg@googlemail.com> (Bert Wesarg's message of "Sun\, 28 Feb 2010 20\:56\:19 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BAAFB12A-24A5-11DF-ACD8-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141265>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>
> ---
>
> This can probably improved in a way, that the marker size will be taken
> from attributes. This could be done by an explicit --marker-size-by-path
> option or an option which names one of the three input files as a git
> path.

You don't want any option that is specifically about "marker size".  An
option to specify the path to take attributes for would be the right way
to go.  You might want to see "hash-object --path" for an inspiration.
