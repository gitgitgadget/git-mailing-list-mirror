From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] gettext.h: add parentheses around N_ expansion if supported
Date: Mon, 12 Jan 2015 11:08:20 -0800
Message-ID: <xmqqbnm395qz.fsf@gitster.dls.corp.google.com>
References: <47914a9078cc9d272204ec00825d67f@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git mailing list <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 20:08:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAkLq-0004WW-M6
	for gcvg-git-2@plane.gmane.org; Mon, 12 Jan 2015 20:08:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756697AbbALTI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2015 14:08:29 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57220 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755337AbbALTI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2015 14:08:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E93A52F731;
	Mon, 12 Jan 2015 14:08:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=+PW9fx1KmW84ZTlvvACOkw7cd88=; b=f1B170CwXD7IPwHQyHbn
	8qnzsD7/nh6LfebxqCZRBwuGHTovnyxs05TLSsSrMidnPVtv4vRQHTMvWV5+vBMX
	MhTcWfdN9V1pqggWx51NycUbI9Efxty/G878zetEskNRpXe3JB30nA7fzcklqpFH
	/exAKxvLLrzexfop3pO0mkI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=AMFY/ciWAvS29fKnqhz6W1CqDoG8RiLbnsbEa2Xs9+i8CS
	gr/v4rUmy0F1YKbmumS7L5Mr8pVQudL3rea/bqFQ10TQ63bNWrq0oZ/nWeFUGugI
	m1MDwgjaPsgiu4Yyl2MS9mMN+i8Hon+uXxsIniCJZL3AwI2RxyIzCckDtgPPs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D9BEC2F730;
	Mon, 12 Jan 2015 14:08:25 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9B9392F727;
	Mon, 12 Jan 2015 14:08:21 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 601E97C6-9A8E-11E4-B579-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262288>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> The "yes", "no", "auto" settings for the new Makefile configuration
> variable "USE_PARENS_AROUND_GETTEXT_N" are based on the way the
> Makefile variable "COMPUTE_HEADER_DEPENDENCIES" works.  So I used
> "yes" and "no" for consistency instead of "Yes" and "No".

Thanks for a careful execution of my clumsy illustration.

> +# and define it to "no" if you need to remove the parentheses () around the
> +# constant.  The default is "auto", which means to use parentheses if your
> +# compiler is detected to support it.

Strictly speaking, s/detected to/most likely to/, as we are only
checking "__GNUC__", but we can leave the phrasing as-is and wait
until somebody complains.

Thanks.
