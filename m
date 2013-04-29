From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: improve recipients_cmd()
Date: Mon, 29 Apr 2013 01:15:56 -0700
Message-ID: <7vhaipn45f.fsf@alter.siamese.dyndns.org>
References: <1367101561-14671-1-git-send-email-felipe.contreras@gmail.com>
	<7vbo8yqxas.fsf@alter.siamese.dyndns.org>
	<CAMP44s0x8fK-6vbY20eKA9QjWqhiOCvx+KFOgKOZ8q58bwk8Tw@mail.gmail.com>
	<7vd2tdoqna.fsf@alter.siamese.dyndns.org>
	<CAMP44s3QkiQhYr7pKHgKFoXH5m9_ZHLHmwC4c9WC2OGjv7LHdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Joe Perches <joe@perches.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 10:16:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWjFm-0006Bg-7o
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 10:16:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220Ab3D2IQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 04:16:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53940 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750710Ab3D2IP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 04:15:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B736A16E48;
	Mon, 29 Apr 2013 08:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q5+u/DVd9ew5iaB01ArRH5jgTCM=; b=kULAUc
	PHqjuMfPaKSgo10H3oVsHVfBRsjzzdYYOAidjiwyYffc4WMCVOaD9r4rw+NlqIki
	rvL4TlAQKH1NBzhoDGALl4etSNmKYkyeln/aWc2Oylt5c4yi5w6JRfspXdelZEXV
	Fen1qQSTyX7Z1DU4YV9R62zIg8ToE1+5+xOPg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SFuoHCml+3dfa9gk7iPsxdkzIrhNz9P+
	RrrCn8MkV0gXoRxQPSTsMahIRpJCKjsMlOyjn4jXGnUrXSoW63L0kja5RTyV6D0Y
	Zrqg2tJybZMGm0hiLFWznbTfvOIY0/VhBtRAstWe6loD7ZlybjoPUT/pZZJ7j+L7
	uDtJDI0K2W0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABB8516E46;
	Mon, 29 Apr 2013 08:15:58 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2082616E42;
	Mon, 29 Apr 2013 08:15:58 +0000 (UTC)
In-Reply-To: <CAMP44s3QkiQhYr7pKHgKFoXH5m9_ZHLHmwC4c9WC2OGjv7LHdg@mail.gmail.com>
	(Felipe Contreras's message of "Mon, 29 Apr 2013 00:32:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0570DFC0-B0A5-11E2-8859-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222780>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> so if we want to get rid of \Q\E, it would be:
>>
>>         open $fh, '-|', qw(sh -c), "$cmd " . '"$@"', '-', @args
>>
>
> I don't know if that would be better, or converting @args to a list of
> quoted strings, essentially keeping the current behavior.

I tend to agree, so let's drop it for now.
