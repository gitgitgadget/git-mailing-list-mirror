From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] created helper function for both winmerge and examdiff mergetools
Date: Tue, 22 Mar 2016 19:41:40 -0700
Message-ID: <xmqqpoulex0b.fsf@gitster.mtv.corp.google.com>
References: <20160321033201.GA2004@gmail.com>
	<1458693794-9124-1-git-send-email-jacob.nisnevich@gmail.com>
	<1458693794-9124-3-git-send-email-jacob.nisnevich@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: davvid@gmail.com, git@vger.kernel.org
To: Jacob Nisnevich <jacob.nisnevich@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 03:41:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiYk1-0005sb-MS
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 03:41:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753933AbcCWClp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 22:41:45 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:54998 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753752AbcCWClp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 22:41:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2AAFE4F2CE;
	Tue, 22 Mar 2016 22:41:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m0+Sq3dDp6I9EHCZ3ZZOcIbeH4s=; b=SkxBCI
	EAF6HwvUWqdIqWekQa1L9obB1V699KPjNlfZs0vljcuBncHiK4uu2PM8LSPeQcZq
	L/WgbFkfQgY5wDhxQc+SmooXCF9P6AU5ZF91LEJupRE6fFiOd/711SQ6D1pABznW
	5Lj79o0DgnXp7fhAh2F5lsW/crb33U/7vLpvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HDpbGfsLBy7GgzyiEyFzFubfXRZHh0gO
	XDdQdgun1cEWSEV8Mn0mgaACwGS9aGv6mXgqSNCMszRGAyXRwkyDJlYrsnKzzNaT
	LPfSh+M0QZt4OX/J1N1oVtvaG/UBrCnEE/b8lI8O0RUt9EcLqN1DGP4jH8nrD9lH
	g+Q/y1CGi9g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 221414F2CB;
	Tue, 22 Mar 2016 22:41:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6AE3D4F2CA;
	Tue, 22 Mar 2016 22:41:42 -0400 (EDT)
In-Reply-To: <1458693794-9124-3-git-send-email-jacob.nisnevich@gmail.com>
	(Jacob Nisnevich's message of "Tue, 22 Mar 2016 17:43:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C6BF0380-F0A0-11E5-9E0D-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289593>

Jacob Nisnevich <jacob.nisnevich@gmail.com> writes:

> diff --git a/mergetools/examdiff b/mergetools/examdiff
> index 474fffe..8b66c17 100644
> --- a/mergetools/examdiff
> +++ b/mergetools/examdiff
> @@ -1,3 +1,5 @@
> +. mergetools_helpers
> +

The way dot-inclusion is done in existing mergetools/* files may
give you a hint, perhaps?

$ git grep '^\. ' mergetools
mergetools/bc3:. "$MERGE_TOOLS_DIR/bc"
mergetools/gvimdiff:. "$MERGE_TOOLS_DIR/vimdiff"
mergetools/gvimdiff2:. "$MERGE_TOOLS_DIR/vimdiff"
mergetools/gvimdiff3:. "$MERGE_TOOLS_DIR/vimdiff"
mergetools/vimdiff2:. "$MERGE_TOOLS_DIR/vimdiff"
mergetools/vimdiff3:. "$MERGE_TOOLS_DIR/vimdiff"
