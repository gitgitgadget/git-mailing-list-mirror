From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why does "git log -G<regex>" works with "regexp-ignore-case" but not with other regexp-related options?
Date: Tue, 21 Apr 2015 09:59:39 -0700
Message-ID: <xmqqr3rdific.fsf@gitster.dls.corp.google.com>
References: <1090496912.6338.1429264855691.JavaMail.open-xchange@ox1app>
	<55311831.6010004@drmicha.warpmail.net>
	<CAPc5daUULhhV0+kL_htLnA8Z_woFLjxg_pO_cB0KLAMuxJnsMQ@mail.gmail.com>
	<5534BD87.8020709@drmicha.warpmail.net>
	<xmqqbniin1cw.fsf@gitster.dls.corp.google.com>
	<CA+55aFzdSgvYo11PHamkOVASz61RUq26+s0na0Zh2RRwsEkrMg@mail.gmail.com>
	<xmqqtwwaljwb.fsf@gitster.dls.corp.google.com>
	<55360D3D.3010201@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Tim Friske <me@tifr.de>, git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Apr 21 19:00:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkbXN-0004Di-Tr
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 19:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933975AbbDUQ7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 12:59:54 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57394 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933725AbbDUQ7r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 12:59:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D54D49D88;
	Tue, 21 Apr 2015 12:59:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/IMMFktOTIVv+DFyyANA0InO0o0=; b=CjOxEF
	AvizIoPSAkbJFByX9d1uL31pa8qmTABZCkcXCS6mZMi4xgZfdzqIeWkm6aAntIEJ
	AQ9G0Fnsz2AZaBeHToJ3Gwok3Jz3WoKlB/wF6MxcPbPf6kF0rdkwWgD3xJ8Mbt/n
	OqVwsJkoU/S+vkNztX6C9eic/Y4Oa9bxKvSs8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YKJrbmRvKVVMPSxIsLCdxmblFB9RmP11
	yl+CZ9D52cz7Ko4iWqJ4v9mN37AM8sPLP/jJ69548fTcflZ1HzYITobUCkEYD7rl
	mKO+cqxsuaJ9pz328F4DEGiqMtnaXevNUZfW1WowVT3bCmVN6Gwp/CAdXOGn3lCl
	FJzBJC9B8w0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 44EF149D87;
	Tue, 21 Apr 2015 12:59:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BFEAE49D86;
	Tue, 21 Apr 2015 12:59:40 -0400 (EDT)
In-Reply-To: <55360D3D.3010201@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Tue, 21 Apr 2015 10:41:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CD05FDB4-E847-11E4-8A12-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267532>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> We have engine-switching options and engine-modification options. The
> latter are certainly good in the expression itself. Maybe even the
> former, though I don't know how to switch away from fixed-strings in
> that way...

I do not think mixing matching engines in a single request makes
much sense. As the internal machinery is not even prepared to do
that, even though it is prepared to apply engine-modifications ones
to each grep term AFAIK, let's not go there.
