From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Documentation/SubmittingPatches: Explain the rationale of git notes
Date: Mon, 22 Dec 2014 09:55:41 -0800
Message-ID: <xmqqwq5ja7s2.fsf@gitster.dls.corp.google.com>
References: <xmqq1tnx961q.fsf@gitster.dls.corp.google.com>
	<1418864895-18583-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 18:55:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y37Cw-0006II-Bv
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 18:55:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755512AbaLVRzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 12:55:46 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57208 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755359AbaLVRzp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 12:55:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 932C828754;
	Mon, 22 Dec 2014 12:55:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A55mELH4ujJtDwmjQF/3y1YOHmM=; b=QjuB7N
	D5O6ST2wv+b+Ty4cDbTGSS445L3TfnJyJ9y56ZpfTyX2crWRJaPdRIgFIUEZjntS
	9tVJ7dXReO0OcsL8YYvK6f3vyfaw/neIeZrnxiY6iSOOQFFdo21KzOcQGMYPxZfi
	ACThb+xc1gmIXQylhEmWRMliJMVMrptDj39Pw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JnPSTme7VQABExa7Mh2GedbiWx8isAn6
	aAFcM58YczqPAWtywALnIfHQg8wGGRASvgjDDWQthrWnmJszFzqccq92MIxQTp/w
	12bK70zAlmr9DxwzGDMjPWqQYccMvlU03WMazlkhRGIz2Z7SIH0PPjweBL634SJE
	vQfNZIXG9wM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8AFBA28752;
	Mon, 22 Dec 2014 12:55:43 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 063A828750;
	Mon, 22 Dec 2014 12:55:42 -0500 (EST)
In-Reply-To: <1418864895-18583-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Wed, 17 Dec 2014 17:08:13 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BF8023EC-8A03-11E4-88F1-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261657>

Stefan Beller <sbeller@google.com> writes:

> This adds an explanation of why you want to have the --notes option
> given to git format-patch.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> Notes:
>     > with optionally update Documentation/SubmittingPatches
>     > to point at the file.
>     
>     That file actually talks about notes already.  I am sending
>     two patches touching that file, one of them explaining
>     the --notes workflow rationale and one of them just changing
>     white spaces.
>     
>     A few weeks ago I wanted to patch format-patch to remove
>     change ids. This is not needed any more for the git workflow
>     as I disabled them and do not upload any patches to an optional
>     Gerrit code review server anymore.
>     
>     I do like the workflow using --notes as well from a developers
>     perspective as I take literally notes for my own sanity.
>     I wonder if I should add a config format.notes = [default-off,
>     always, on-if-non-empty] so I don't need always add --notes
>     manually to the command line.
>     
>     Thanks,
>     Stefan
>
>  Documentation/SubmittingPatches | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index fa71b5f..16b5d65 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -176,7 +176,11 @@ message starts, you can put a "From: " line to name that person.
>  You often want to add additional explanation about the patch,
>  other than the commit message itself.  Place such "cover letter"
>  material between the three dash lines and the diffstat. Git-notes
> -can also be inserted using the `--notes` option.
> +can also be inserted using the `--notes` option. If you are one

Because the previous sentence is talking about the cover letter to
describe the overall series, it probably is a good idea to add
"after the three-dashes of each patch" after "... using the notes
option" for clarity, perhaps?

> +of those developers who cannot write perfect code the first time
> +and need multiple iterations of review and discussion, you are
> +encouraged to use the notes to describe the changes between the
> +different versions of a patch.

Perhaps s/you are encouraged to/you may want to/?  It might be
better to be even more explicit, e.g. "you may want to keep track of
the changes between the versions using the notes and then use
`--notes` when preparing the series for submission"?

>  Do not attach the patch as a MIME attachment, compressed or not.
>  Do not let your e-mail client send quoted-printable.  Do not let

Thanks.
