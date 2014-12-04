From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] introduce git root
Date: Thu, 04 Dec 2014 13:30:07 -0800
Message-ID: <xmqqfvcvrtls.fsf@gitster.dls.corp.google.com>
References: <1417291211-32268-1-git-send-email-arjun024@gmail.com>
	<2AC7B765F56B4AA8A0DB76E8C670A889@PhilipOakley>
	<CAJFMrCEciWXhBb36MVeFPi7Y7D=9zQ2xGPpiyUz9y4_hOh_taw@mail.gmail.com>
	<vpqoaro99xd.fsf@anie.imag.fr>
	<xmqqd284rryz.fsf@gitster.dls.corp.google.com>
	<CAP8UFD2jES1i+6zOt1gXqTWFy1UHu2GBwAisQktd_Ymbj9Db2g@mail.gmail.com>
	<20141202070415.GC1948@peff.net>
	<xmqqd282m09j.fsf@gitster.dls.corp.google.com>
	<20141204092251.GC27455@peff.net>
	<xmqqlhmntf02.fsf@gitster.dls.corp.google.com>
	<20141204211232.GC19953@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Arjun Sreedharan <arjun024@gmail.com>,
	Philip Oakley <philipoakley@iee.org>, Git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 04 22:30:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwdyu-0002ak-RD
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 22:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754532AbaLDVaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 16:30:15 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63517 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752997AbaLDVaO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 16:30:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A3BC224CBF;
	Thu,  4 Dec 2014 16:30:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9lMG1O9astDcR2d4uFR1NgSLxVI=; b=JX0ghO
	u/Q6QEY7sWNAA5iGfbfhkJXkwNbqkhpZayWPb5WzKPnuUZopMWyQVFJ0EDFzxqwq
	SBWs5C+gNL8YiquwJ5xvmtFJxKAB2bleNJKfmhglYGNYg8pYNmfa86MPc/ytoyJY
	/b7CA9QVUKATs94uU9loFEvlJNqrVm4OSd8RE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uBidZm6CnrJppBhJjTndr7F6CT9vUkNU
	NdOCPXUg+LmoYnimRmQ/aFt9xy9XxbKSYZFt+P1fceyKn8RDCGhdW+WbsuAWjHBA
	jPB9x6r6MLbK6qD6Rcac7+UYNptb9/AvVBj1Qmt44D7A4QOG06P/McYHGv8AxHZ+
	hI2j6X1Y7qQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 99C1324CBE;
	Thu,  4 Dec 2014 16:30:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4332124CAB;
	Thu,  4 Dec 2014 16:30:09 -0500 (EST)
In-Reply-To: <20141204211232.GC19953@peff.net> (Jeff King's message of "Thu, 4
	Dec 2014 16:12:32 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B8F34B36-7BFC-11E4-87C0-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260804>

Jeff King <peff@peff.net> writes:

> ... I was thinking of
> just creating a new namespace, like:
>
>   git var exec-path
>   git var author-ident
>
> and deprecating the 4 existing GIT_* variables.

I'm fine with that.  As I wrote in my response to MMoy, I forgot
about other kinds of options the "git" potty takes, and "git var
name-without-needless-double-dashes" is a perfectly fine way to
consolidate the querying of computed values in a single place.

Thanks.
