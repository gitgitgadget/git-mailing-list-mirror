From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pre-commit hook question
Date: Mon, 16 Jun 2014 11:23:03 -0700
Message-ID: <xmqqppi8r9x4.fsf@gitster.dls.corp.google.com>
References: <539C8796.3070709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nick Dimov <dimovnike@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 20:23:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbYw-0007sw-Af
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbaFPSXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:23:14 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53695 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932370AbaFPSXL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:23:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B56CF20205;
	Mon, 16 Jun 2014 14:23:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vd4SPZdDR73MDiD4W+r6IDE9p1M=; b=Nge/I+
	exPsMLw+Zi/X0uQBV9ZETVLV2svqJLataUsZcDjtZRnShczP6wJh+U9AF5J0nJCI
	sWFNMc5kpuQQ+ci+Wngm06zcK9ZqwGkI53EmR4qWmPlnpvcyCX8lAwO7wqVSvDMf
	P2dT7KlSA2c9vef2PJOR9/+foE/ePGJNrcGj4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EgocBhWFC0TCt2m5lVOi0+hZI+zOaOlu
	SWry+1myYsQGbT4caWywXy+smQAWgAJcpuVZoou1EO/VsIrHicN0ZOuEQ8zSceCr
	G/zwQe71WtP4lymKilcFaO+SD6+auqULyDeR8/IX7TVwjv4D1bHGc8B+w2PxD06U
	A7S81rnicqA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2E58820204;
	Mon, 16 Jun 2014 14:23:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 50B3E201FD;
	Mon, 16 Jun 2014 14:23:03 -0400 (EDT)
In-Reply-To: <539C8796.3070709@gmail.com> (Nick Dimov's message of "Sat, 14
	Jun 2014 20:34:14 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 41205522-F583-11E3-A2FB-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251793>

Nick Dimov <dimovnike@gmail.com> writes:

> Im struggling for a couple of hours to make git store metadata of the
> files using metastore and I use hooks/pre-commit for this.

The pre-commit hook is about checking if the commits being created
is sensible and rejecting otherwise, and it is not designed to allow
futzing what is recorded behind the user's back.
