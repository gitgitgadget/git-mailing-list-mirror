From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/8] git-merge-recursive-{ours,theirs}
Date: Mon, 30 Nov 2009 11:56:43 -0800
Message-ID: <7viqcrlrb8.fsf@alter.siamese.dyndns.org>
References: <d243a513ffb8da4272f7a0e13a711f9b65195c25.1259201377.git.apenwarr@gmail.com>
 <905749faf5ccb2c7c54d3318dbc662d69daf8d0e.1259201377.git.apenwarr@gmail.com>
 <cover.1259201377.git.apenwarr@gmail.com>
 <7e1f1179fc5fe2f568e2c75f75366fa40d7bbbfb.1259201377.git.apenwarr@gmail.com>
 <7vr5rlerqf.fsf@alter.siamese.dyndns.org>
 <32541b130911261405q6564d8f2o30b7d7fd6f708d05@mail.gmail.com>
 <7vvdgs1qip.fsf@alter.siamese.dyndns.org>
 <32541b130911301008v4156f0c6ge9f30952565392f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 20:56:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFCMj-0001jD-WD
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 20:56:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752891AbZK3T4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 14:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752861AbZK3T4p
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 14:56:45 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61465 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469AbZK3T4p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 14:56:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A728E84BDD;
	Mon, 30 Nov 2009 14:56:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BlE2RyaPP+XjTEiNyzogF8yu8gI=; b=tW95Ct
	bNzpX9WKPgH/l75wL8q7h8I6dRS9eBTy8wFLNu3yzaOZJSzGRKyNUSu4ckdUs04z
	7UBiRnxaAVeJBknK0At8+nQhvGa6eqk9LWWvSlstMHEBqftW0KEmsoB8AX3Wf//M
	niOMLdWpIgv559L8hMVpgY7PiaqTdo9agCGNg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=syua3AhcMALUryOlvc3XgS1XTMuFarxN
	gMsU69M/l4ep9cxFc5zi9k07gypMqtJ1HZNmXkTKF6RTNYlyrYemuFiHllwEvNko
	WBq8f7PGuwAmr02Vt9tCshD9B/wGLpuNEH1gJAvAUbh1H3SM9JstwWOMqor/9gz3
	OK0AdAdgX9I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 70D8084BDC;
	Mon, 30 Nov 2009 14:56:48 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8148484BDB; Mon, 30 Nov
 2009 14:56:45 -0500 (EST)
In-Reply-To: <32541b130911301008v4156f0c6ge9f30952565392f9@mail.gmail.com>
 (Avery Pennarun's message of "Mon\, 30 Nov 2009 13\:08\:58 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7EA0FB1E-DDEA-11DE-B2AC-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134133>

Avery Pennarun <apenwarr@gmail.com> writes:

>> I've queued the series with minor fixes to 'pu' and pushed it out.
>
> Since I see you didn't change a couple of things you mentioned in
> earlier comments (the NEEDSWORK comment and the sq-then-eval trick) do
> you still want me to respin this series?

The commit still is NEEDSWORK and shouldn't be in 'next' in its current
shape.  I don't think the topic is 1.6.6 material yet, and we will be in
pre-release feature freeze any minute now, so there is no urgency.

As I did the sq-then-eval in many places in our Porcelain scripts (and
many of them are converted to C and lost the need for the trick), I may
get tempted to fix it up when I am bored ;-).  But no promises.

Thanks.
