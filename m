From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge: --no-ff configuration setting
Date: Mon, 22 Feb 2010 22:32:10 -0800
Message-ID: <7vljekbgyd.fsf@alter.siamese.dyndns.org>
References: <1266807555-86199-1-git-send-email-bryanalves@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bryan Alves <bryanalves@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 07:32:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjoJl-00046s-1F
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 07:32:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119Ab0BWGcU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 01:32:20 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63926 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958Ab0BWGcT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 01:32:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A3F29CE87;
	Tue, 23 Feb 2010 01:32:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TUzxT6nUPu22iGnixaws6M2a/ag=; b=AXHd+v
	IlK6WPR09mRoTTR1z7B4jZNmA8xZ5MOUX2pfJKikSftbSDBPPlFbg4rYvUBapWQB
	yXh9ww/9I181wHnlbbgmjWaOXVX0f2TLX2TTk5eeDL8KIdzBEMybnEzCopjtoMsJ
	JM2Orxq7fleH8Lweki+tzxwCIKMWn9QNCCdx4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=drHH3sTmzXJH/0MnbmGERcvCRzNgQcXS
	JFF1WGW37HIU4VtWlTuqRk+4ROIMrUWAtjdg+uIvliqWIZGfxpk7t1G/pwr2aTVR
	EApT3KRHMVVFvqMnIqzftJEnjHcMRVfoqSA76bCaGJhyEDmQ8dsanZAbKrKGN4PH
	2hgXnFQXA2Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E251F9CE86;
	Tue, 23 Feb 2010 01:32:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 074589CE85; Tue, 23 Feb
 2010 01:32:12 -0500 (EST)
In-Reply-To: <1266807555-86199-1-git-send-email-bryanalves@gmail.com> (Bryan
 Alves's message of "Sun\, 21 Feb 2010 21\:59\:15 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2F11506A-2045-11DF-AFB1-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140769>

Bryan Alves <bryanalves@gmail.com> writes:

>  Documentation/merge-options.txt |    4 +++-
>  builtin-merge.c                 |    3 +++

This needs tests to make sure that existing programs that internally use
"git merge" (e.g. "rebase -m", "rebase -i") do not break when the end user
has this configuration set in the repository, in addition to that "merge"
works as expected with and without this configuration variable, with
combinations with the use of relevant command line options.
