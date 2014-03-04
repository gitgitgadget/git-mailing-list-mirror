From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] test-lib: GIT_TEST_ONLY to run only specific tests
Date: Mon, 03 Mar 2014 16:08:32 -0800
Message-ID: <xmqq4n3en7un.fsf@gitster.dls.corp.google.com>
References: <1393842298-5944-1-git-send-email-ilya.bobyr@gmail.com>
	<1393842298-5944-2-git-send-email-ilya.bobyr@gmail.com>
	<CAPig+cT46ekT87TuoTtwvt0G+DraB9cdgW1wd6NsodjJ5FmJrA@mail.gmail.com>
	<xmqqob1mn9t6.fsf@gitster.dls.corp.google.com>
	<531514D9.4000101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Ilya Bobyr <ilya.bobyr@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <tr@thomasrast.ch>
To: Ilya Bobyr <ilya.bobir@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 01:08:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKcuX-0001jr-Oq
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 01:08:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755395AbaCDAIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 19:08:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38357 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755301AbaCDAIg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 19:08:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DAECC55C58;
	Mon,  3 Mar 2014 19:08:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NLMRdlHTgwgBZ81F/ji77yCUedQ=; b=qdLhjN
	mBpHL9gnve/NygTvgXwkN8dy6hjx7HvYlFNf5t8kYF7GUvynbLe7X3LD5jMNAE4r
	W/Cjf3eFzF4KYuM6j7FbSA9FY/eW+1B9CZylfG9xP0AWGahqppWX1DWiAM/JHQ9v
	OPRn5kBwm+kl19CT224kUsQovD7ZZ36TFuhzc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qCKE8MpOhGGIK3qXog30S+3ZN/81zOtA
	gyWUHXO7RPZ+XbROjHtFS83uxjtufDupq/wDDOxNTD9hMKgbRJwGLByYiz+ZeC8B
	gN7G1Y+646okdgYKK8/dbwQ6wCBoYK3VsNt51k9iZbRyjNvL/bbA/utfevehL6gQ
	D2zjnZpMMgY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F65655C57;
	Mon,  3 Mar 2014 19:08:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9E9AB55C53;
	Mon,  3 Mar 2014 19:08:34 -0500 (EST)
In-Reply-To: <531514D9.4000101@gmail.com> (Ilya Bobyr's message of "Mon, 03
	Mar 2014 15:48:41 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 20A0BE58-A331-11E3-8451-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243317>

Ilya Bobyr <ilya.bobir@gmail.com> writes:

> It might be that we are looking at different use cases, as you are
> talking about whole test suits.

I do not think so.

I do not see anything prevents you from saying

	GIT_SKIP_TESTS='t0000 !t0000.1 !t0000.4'

to specify test-pieces in individual tests so that you can run the
setup step (step .1) and the specific test (step .4) without running
two tests in between.
