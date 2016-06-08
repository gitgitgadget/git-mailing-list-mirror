From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/6] t9001: non order-sensitive file comparison
Date: Wed, 08 Jun 2016 09:09:29 -0700
Message-ID: <xmqqvb1jmzly.fsf@gitster.mtv.corp.google.com>
References: <1464369102-7551-1-git-send-email-tom.russello@grenoble-inp.org>
	<20160607140148.23242-1-tom.russello@grenoble-inp.org>
	<20160607140148.23242-2-tom.russello@grenoble-inp.org>
	<xmqqziqwmqth.fsf@gitster.mtv.corp.google.com>
	<f34e3636-ce71-8352-259d-9f723d63e2a8@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tom Russello <tom.russello@grenoble-inp.org>, git@vger.kernel.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	matthieu.moy@grenoble-inp.fr, e@80x24.org, aaron@schrab.com
To: Samuel GROOT <samuel.groot@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Wed Jun 08 18:09:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAg31-00047i-4A
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 18:09:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423506AbcFHQJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 12:09:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58137 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423322AbcFHQJd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 12:09:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CA1E21F2A9;
	Wed,  8 Jun 2016 12:09:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hRweDp/SOdKXr+pOzcksr4mszqk=; b=YbNNBM
	jz7jWvWnUxIID1m3A+obsfS1N6NA7buM3IzKZ+aqyuSUoIrvkWJhSDz6pY4+JiG0
	wucXXY3AmFzqGdeMboZ93AeB9JyIY2t6u/TafCE/V/G+vhcNqwI5OjPVqDBhzkK+
	K/iaq2M5Wp4lhOzkvLzSDXOAyzYhVctPNjlU4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mKZKp23LEL3hYbrY+HQng0CG3k6S4bTZ
	Qupx6rZa2vRtpq13DoX0wbQRT2Q3dkTDkWlNFhOjuUdaT2jhXof+mJB5HyMT3Yk3
	TofSoDiMpgj36x+UNoeFihPZgoA+HMWQAKlwEMN1Ph4jgxcQ107wsV3nYtX9Mp+C
	brlUATgXmA0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BFE901F2A8;
	Wed,  8 Jun 2016 12:09:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4B3CA1F2A7;
	Wed,  8 Jun 2016 12:09:31 -0400 (EDT)
In-Reply-To: <f34e3636-ce71-8352-259d-9f723d63e2a8@grenoble-inp.org> (Samuel
	GROOT's message of "Wed, 8 Jun 2016 10:23:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6249FCC2-2D93-11E6-BAF8-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296807>

Samuel GROOT <samuel.groot@grenoble-inp.org> writes:

> Actually we had issues when trying to refactor send-email's email
> parsing loop [1]. Email addresses in output file `commandeline1` in
> tests weren't sorted the same way as the reference file it was
> compared to. E.g.:
>
>   !nobody@example.com!
>   !author@example.com!
>   !one@example.com!
>   !two@example.com!

And the reason why these addresses that are collected from the same
input (i.e. command line, existing e-mail fields, footers, etc.) are
shown in different order in your implementation is...?
