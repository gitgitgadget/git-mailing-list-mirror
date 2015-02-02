From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5] sha1_file: fix iterating loose alternate objects
Date: Mon, 02 Feb 2015 12:49:23 -0800
Message-ID: <xmqq7fw0t4x8.fsf@gitster.dls.corp.google.com>
References: <E05CAD49-755C-4F26-A527-597B1AD412D8@jonathonmah.com>
	<20150202202733.GB28915@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathon Mah <me@jonathonmah.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 02 21:49:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YINw7-0005ed-P9
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 21:49:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbbBBUtc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 15:49:32 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55594 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753588AbbBBUtb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 15:49:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5AF3435AC2;
	Mon,  2 Feb 2015 15:49:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jHchIIHZQr2F/LSfsjvldkcO3i4=; b=m3foAQ
	HzFN+iwKDc4wP5SzUp5I3fvVD8rfJx4x+GYLBFVtWzyCfPEhVYIDPxdpfvWoPy6Z
	pUys6TyiElI+Q0TKZCUXsWriTn6GkwrtHWaIG2vlWEvEJ/habj4baWlDXA3RDqyo
	JXbwgeXoeiRx6fwJLdUUPFcu9grekkxMBMB38=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VlBEUg4x+bd0GBXVe11nimjVHx1uoBb6
	ut3I1aDZJnveX6coSOQExytXfWblHuKTVxSiTTwNxTLjlH6Q2e7iq5TyOQWRCD+1
	ldL6+9hGOmIgpHvTtQmsBR2Hd+wD1odo8mJiH5YF4WqoRpaNiy/CNzmV0vel0/cC
	SrbYkeb9on4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 520E535AB9;
	Mon,  2 Feb 2015 15:49:25 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C584B35AB8;
	Mon,  2 Feb 2015 15:49:24 -0500 (EST)
In-Reply-To: <20150202202733.GB28915@peff.net> (Jeff King's message of "Mon, 2
	Feb 2015 15:27:33 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F8B7F29A-AB1C-11E4-86E7-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263288>

Jeff King <peff@peff.net> writes:

> So I actually do not see how the situation would come up in practice,
> and possibly we could drop the iteration of the alternates' loose
> objects entirely from this code. But certainly that is orthogonal to
> Jonathon's fix (which is a true regression for the less-exotic case that
> his test demonstrates).

Sure.

This needs to go to both 'maint' and 'master', right?
