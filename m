From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH revised] git_mkstemps: add test suite test
Date: Tue, 06 Aug 2013 13:50:11 -0700
Message-ID: <7vd2pqfssc.fsf@alter.siamese.dyndns.org>
References: <201308061805.r76I51If026086@freeze.ariadne.com>
	<7vsiymfzuh.fsf@alter.siamese.dyndns.org>
	<201308061902.r76J2W33027399@freeze.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@inf.ethz.ch>
To: worley@alum.mit.edu (Dale R. Worley)
X-From: git-owner@vger.kernel.org Tue Aug 06 22:50:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6oD0-0007YM-Fv
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 22:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755955Ab3HFUuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 16:50:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55552 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754720Ab3HFUuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 16:50:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CAFA36D2E;
	Tue,  6 Aug 2013 20:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7z12OG1/Eg3dWHJ8wMbVBlnNV08=; b=McwgRo
	k9QW3jEks0TsQ4kMowSiyOlLfpQAOfG9z1x+2SU+85+sHju5fsdN0WK9y2/GxWvp
	kq5mZ3Lh+buZQiK8oGQTdTXKTLw892moMcwug3lFuaoaqy8SQAWb2OBQtk0MVvsI
	EmO4Msdb7DOfc5Puwe0t1829rl/BZIzsFuOY8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ff3jK02g1vwWBx5ziKSp3MCdqmIg6yQh
	J9UWWyfm3ZoNvGw/1y7bS0S6GAwy1GVMyeMaLK4TezXmDVvuSXx0k8XoCiwlvt7a
	WC4968t5L4aipCazH69gMxtxLraxDLFUdh1lDb+aC0Y4bYGRu9IoVerX3hy3bqTH
	0cul111KjHo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80F7136D2C;
	Tue,  6 Aug 2013 20:50:13 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD68936D2B;
	Tue,  6 Aug 2013 20:50:12 +0000 (UTC)
In-Reply-To: <201308061902.r76J2W33027399@freeze.ariadne.com> (Dale
	R. Worley's message of "Tue, 6 Aug 2013 15:02:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CA41376E-FED9-11E2-8F13-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231785>

worley@alum.mit.edu (Dale R. Worley) writes:

>>     git commit --allow-empty -m message <&-
>
> Though as of [fb56570] "Sync with maint to grab trivial doc fixes",
> that test doesn't fail for me if I revert to
>
> 		fd = open(pattern, O_CREAT | O_EXCL | O_RDWR, mode);
> 		if (fd > 0)
> 			return fd;
>
> I haven't been watching the code changes carefully; has there been a
> fix that is expected to cause that?
>
> Dale

That is because a11c3964 (git: ensure 0/1/2 are open in main(),
2013-07-16) happened in the meantime, I think.
