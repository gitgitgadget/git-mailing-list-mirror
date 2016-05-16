From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] pathspec: record labels
Date: Mon, 16 May 2016 12:08:38 -0700
Message-ID: <xmqqzirp253d.fsf@gitster.mtv.corp.google.com>
References: <20160513231326.8994-1-sbeller@google.com>
	<20160513231326.8994-6-sbeller@google.com>
	<xmqqk2iw78aq.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZsVH3mE0zXu9wSWgit3QZ_CiKZqg-TQdyWnZw6D9=Cgw@mail.gmail.com>
	<xmqqlh393nuv.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbN_pzAVeAa-St_KRs60SbURTfKKP0v+do_+MK7orTkTg@mail.gmail.com>
	<xmqq8tz93kf9.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaV+hQRn6ZraZcG9ZRp1XwPGrEFibBEX5qFJdWDCg0uxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon May 16 21:08:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2Nsk-0004pd-Qk
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 21:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754521AbcEPTIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 15:08:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58551 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754411AbcEPTIm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 15:08:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C28AB1C655;
	Mon, 16 May 2016 15:08:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/HZXdlEgQwYtJXXdmoQgV6VQjH0=; b=Je7Fxj
	WUUMO35zkH8FXQK0bBtLzsfcR38X8YZFqOIRFjnRjAcwudILNnwli2NRg29eJhaM
	l323n+LT3s7Y1IxC62nh0UxPb3umpbp9P21xJSy7dW4TDkD0d1KkSVEdGHaTKd+x
	cwmBfsKfRZ7rII3ykPMDu54vq5KYIPwiHdKpw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rw5mAKjV9n6sBWJICeCl9zG5RfaKCLvS
	hZ1X7wSddHtjmOViz5gQoUVnKrBRcM9RRS74VZeLxGiqPv59eqru4Odk610By+GM
	1WCRsxnpC5gTqCZp/vXweTc91oU2o+nutvNGVcHL3IaG9qYUVL/gUSl8Gz4+9/G8
	Xo/O9u8US5w=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BABE11C654;
	Mon, 16 May 2016 15:08:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3293F1C652;
	Mon, 16 May 2016 15:08:40 -0400 (EDT)
In-Reply-To: <CAGZ79kaV+hQRn6ZraZcG9ZRp1XwPGrEFibBEX5qFJdWDCg0uxQ@mail.gmail.com>
	(Stefan Beller's message of "Mon, 16 May 2016 12:03:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 99A29898-1B99-11E6-916D-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294779>

Stefan Beller <sbeller@google.com> writes:

> "... but for now Git treats it as if it is not set at all" is a valuable
> information to the user, still?

Not at all.  "What you are using is wrong and there is no guarantee
what behaviour you would get" is the message we need to convey.
