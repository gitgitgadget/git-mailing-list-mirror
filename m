From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 0/5] Reroll patches against v1.8.3.1
Date: Thu, 20 Jun 2013 13:10:01 -0700
Message-ID: <7vppvgsfvq.fsf@alter.siamese.dyndns.org>
References: <cover.1359018188.git.Alex.Crezoff@gmail.com>
	<cover.1371720245.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexey Shumkin <Alex.Crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 22:10:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UplBN-0007pw-AC
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 22:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161216Ab3FTUKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 16:10:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50365 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161120Ab3FTUKE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 16:10:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 04BA129B16;
	Thu, 20 Jun 2013 20:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FtSKjCvZXY1aQ488aHYUf5VLlFI=; b=VEbIi8
	UpDkwZUir65+yJ78I6lru1vSuCNR6eunSMS9rHtBVEBG3mSYsFL8BhfoWXrTF4U1
	wApcU5XN5OyrPKd8cmAI9yiA6rNYT5KjeQ3rLmLPG2l2ESwW2Q4V93McTjTQ7a/E
	gY96kc0amW7B6sB/aHPyai9kWXYL1cyJ5iiMA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H5V4VwYe8lywNUx7l11b4wnVuMzilMkP
	+V4WVT8D9T9Gin78TFsp5FFYeOy26pgvP1ix5QDhTdKjzCI3tLQ+UnHJRxYurh8s
	aHelr1L7uXLOi04c+lf5iriYrKcU2PrZz9xK7/bwhCXSaX3OfGsGl6RhMf+7YvsV
	3QDHzwdKKd8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F076E29B13;
	Thu, 20 Jun 2013 20:10:03 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F1D8829B10;
	Thu, 20 Jun 2013 20:10:02 +0000 (UTC)
In-Reply-To: <cover.1371720245.git.Alex.Crezoff@gmail.com> (Alexey Shumkin's
	message of "Thu, 20 Jun 2013 13:26:16 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 646AA39E-D9E5-11E2-A828-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228529>

Alexey Shumkin <Alex.Crezoff@gmail.com> writes:

> Alexey Shumkin (5):
>   t6006 (rev-list-format): don't hardcode SHA-1 in expected outputs
>   t7102 (reset): don't hardcode SHA-1 in expected outputs
>   t4205 (log-pretty-formats): don't hardcode SHA-1 in expected outputs
>   pretty: Add failing tests: user format ignores i18n.logOutputEncoding
>     setting
>   pretty: user format ignores i18n.logOutputEncoding setting

Next time, please jog readers' memory better by giving a bit more
descriptive cover letter.  "Reroll" is known by "v5" alrady, and
"against v1.8.3.1" certainly helps, but what this series is about is
unclear, especially because the end-game patch "user format ignores"
is rather badly stated.  It is unclear if it is a good thing that
user format ignores it and the patch makes sure that is the case, if
we currently ignore it in user format and the patch fixes it by
making user format pay attention to it, etc.

Thanks.

>  builtin/reset.c                  |   8 +-
>  builtin/rev-list.c               |   1 +
>  builtin/shortlog.c               |   1 +
>  log-tree.c                       |   1 +
>  submodule.c                      |   3 +
>  t/t4041-diff-submodule-option.sh |  25 +++--
>  t/t4205-log-pretty-formats.sh    | 179 ++++++++++++++++++++-------------
>  t/t6006-rev-list-format.sh       | 209 ++++++++++++++++++++++++---------------
>  t/t7102-reset.sh                 |  37 ++++++-
>  9 files changed, 299 insertions(+), 165 deletions(-)
