From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] notes: read copied notes with strbuf_getline()
Date: Mon, 01 Feb 2016 13:34:05 -0800
Message-ID: <xmqqd1sgunci.fsf@gitster.mtv.corp.google.com>
References: <56ACF82B.2030005@moritzneeb.de> <56ACFB53.7070400@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Moritz Neeb <lists@moritzneeb.de>
X-From: git-owner@vger.kernel.org Mon Feb 01 22:34:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQM6v-0007tq-RW
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 22:34:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338AbcBAVeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 16:34:09 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53221 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751722AbcBAVeI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2016 16:34:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B90B541307;
	Mon,  1 Feb 2016 16:34:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kbD1bUpq/1dyD1xCKVSPbDqI7Zo=; b=pSNJke
	u+AFCNqH+hAVtCFRwktByj/LEVzrSjkjhalTTgUDOvaxdcFEByF3TKmtxwxi1e1Y
	Hgars/qH5DKxnYXREVdCqImB6N1Ww0v3Wn083OhNJe8fddR43TFhUaYqiXRRDyFd
	xzQjMLGNo7zzAMWlc+8IsK/7YdJHZ6D/4otIo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bxhtrG0FcR7gtZmJSkXT9rFnS+I1NZvm
	bgb1ZUJkRr00hH+B0Kyodn+f9EzNh/SQgf+gqLkln2mx6cE3PrAHev97Xf0rt1m5
	WjdwWDK8/JNF+923ar96HROC4hl/E07DnCfWtL8Ao00ceBPhCxnPZi1uvXOGKFsN
	H8aR4GlWikA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B14AB41306;
	Mon,  1 Feb 2016 16:34:07 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1F19A41304;
	Mon,  1 Feb 2016 16:34:07 -0500 (EST)
In-Reply-To: <56ACFB53.7070400@moritzneeb.de> (Moritz Neeb's message of "Sat,
	30 Jan 2016 19:05:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 85DEC9AA-C92B-11E5-9CD1-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285216>

Same comment as 1/5 and 2/5 applies.  You need to think if
strbuf_rtim(split[1]) is necessary here.
