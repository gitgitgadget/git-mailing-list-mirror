From: Junio C Hamano <gitster@pobox.com>
Subject: Re: configuring cherry-pick to always use -x?
Date: Mon, 14 Feb 2011 13:05:06 -0800
Message-ID: <AANLkTimi=d0qbO3_-BEnPEJ+iy9B=_fksF7TiBE7HorC@mail.gmail.com>
References: <4D596435.9020605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Adam Monsen <haircut@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 22:05:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp5bf-0004NM-77
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 22:05:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015Ab1BNVFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 16:05:10 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51046 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880Ab1BNVFI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 16:05:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BA1CE4DD8
	for <git@vger.kernel.org>; Mon, 14 Feb 2011 16:06:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=mime-version
	:in-reply-to:references:date:message-id:subject:from:to:cc
	:content-type; s=sasl; bh=0R6HRf0A1NsvGwGdQnltHq079PU=; b=ZSUF8l
	IjOlLs9zGtrvh0k6O5aw9tippBJPNckhA2ExIueMBbmH/B8FGjv6zo7afxqzWw6W
	ByKTA80uzmpBXA7kPT2SmnlOGetSiKJq4D/f62Cgbg28eEHM7vUbGVGCWNwHv2zz
	BNaf9l5WPoDQZW8q6xy5aG2CHA8PDYZqhrTL4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=mime-version
	:in-reply-to:references:date:message-id:subject:from:to:cc
	:content-type; q=dns; s=sasl; b=iWSMf1nOXIeTBxCEQfoib1UBeKEDnbr8
	Lk1VPz+4A6/2cdXTS/i4OmuD6i8jzzAwbejzR/ltrrCVs06vWw5hM6eCKNz98+1R
	RgxCaKraQPMamtICATj8R2PMNjOFvPSLGQ3k/LHNa4pt7O8eq2+L7uxugKMFWfvE
	EcmwpnGqQdk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B464D4DD7
	for <git@vger.kernel.org>; Mon, 14 Feb 2011 16:06:12 -0500 (EST)
Received: from mail-wy0-f174.google.com (unknown [74.125.82.174]) (using
 TLSv1 with cipher RC4-SHA (128/128 bits)) (No client certificate requested)
 by a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6FBDE4DD5 for
 <git@vger.kernel.org>; Mon, 14 Feb 2011 16:06:12 -0500 (EST)
Received: by wyb28 with SMTP id 28so5156278wyb.19 for <git@vger.kernel.org>;
 Mon, 14 Feb 2011 13:05:07 -0800 (PST)
Received: by 10.216.145.154 with SMTP id p26mr67176wej.11.1297717507091; Mon,
 14 Feb 2011 13:05:07 -0800 (PST)
Received: by 10.216.80.213 with HTTP; Mon, 14 Feb 2011 13:05:06 -0800 (PST)
In-Reply-To: <4D596435.9020605@gmail.com>
X-Pobox-Relay-ID: 40E69690-387E-11E0-A893-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166767>

On Mon, Feb 14, 2011 at 9:19 AM, Adam Monsen <haircut@gmail.com> wrote:
> Is there a configuration option to make cherry-pick always include the
> source commit hash in the new commit log message?

Not currently, but before we go any further, could you please justify
in what workflow it would make sense to use -x most of the time?

We used to add the "cherry-picked from" by default in the very early
days, and stopped doing so for a reason, and also deliberately stayed
away from adding such a configuration to actively discourage the use
of -x without making the user thinking twice.
