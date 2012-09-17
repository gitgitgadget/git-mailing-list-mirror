From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/perf: add "trash directory" to .gitignore
Date: Mon, 17 Sep 2012 14:26:50 -0700
Message-ID: <7vpq5ks5lx.fsf@alter.siamese.dyndns.org>
References: <1347901579-5545-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 23:27:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDiqM-0007X4-7R
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 23:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321Ab2IQV0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 17:26:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45873 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752670Ab2IQV0x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 17:26:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 601628FE4;
	Mon, 17 Sep 2012 17:26:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mm9VKVwbPDR4us/SKrf9ESp0B6c=; b=ktpilK
	jvEBbcIYJiEcz2Ln9uAYYbWOBNOYkMelbnme0VpACSCijkpr9bCNeHhFqgV76Qy9
	RE9AMGL6tbaumiCy2T1fb+MzNEHobuJZnquNGDIozUuWQPp45oAkwXwBYBMfx2ZW
	SVXonhagme4mgT0+5W80DPY24Fu/pI8UzotMs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qPtwHYoqO8dwRNW7rmP0LDjbLrFA6Pjb
	TrJEE5p3wo3kbs2JbaYWatFlSs7PoGZBIDa3C9q1i00hQjGveOxGnqPbW8Cdapuh
	hPpbs2x+MC0a7cnNqSSJ+qfHFTzBdAkGn07ys14VwKNyzTez9mDryHHAb+qvaGAF
	iEumZqXveWU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D24F8FE3;
	Mon, 17 Sep 2012 17:26:52 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A8AB68FE2; Mon, 17 Sep 2012
 17:26:51 -0400 (EDT)
In-Reply-To: <1347901579-5545-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Mon, 17 Sep 2012 22:36:18 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 65677F52-010E-11E2-9ED8-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205755>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  t/perf/.gitignore |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/t/perf/.gitignore b/t/perf/.gitignore
> index 50f5cc1..0061cbc 100644
> --- a/t/perf/.gitignore
> +++ b/t/perf/.gitignore
> @@ -1,2 +1,3 @@
> -build/
> -test-results/
> +/build
> +/test-results
> +/trash directory*

Thanks.  I _think_ you still want to make sure these are
directories, so instead of losing the trailing slash, you would want
to keep it and add a leading slash to anchor them to the t/perf
directory, i.e.

	/build/
        /test-results/
        /trash directory*/
