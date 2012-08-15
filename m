From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v3 10/16] Create a note for every imported commit
 containing svn metadata.
Date: Wed, 15 Aug 2012 12:49:04 -0700
Message-ID: <7v1uj85427.fsf@alter.siamese.dyndns.org>
References: <1344971598-8213-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 22:38:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1kM4-0000UI-4R
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 22:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757362Ab2HOUiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 16:38:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47074 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756211Ab2HOTtH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2012 15:49:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81DD89084;
	Wed, 15 Aug 2012 15:49:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mGMYp+2wOMIOMhDVWU2vEGFG5Oo=; b=vBn5ml
	oWPJVQzQqC9ORjeQW7foHb8tY+A9dvtiqQEXkAsvF6vI+95P1fHGcxFE5DFaTdDC
	tD7dpQ1Zdy2PCU/OshJfSPPWGXbsiH42vMxv6edvm/MdvRSIN+xLBIzLzgmomSef
	/lm3lm1e2FuOralCKCW593Lt2Pw8iiiQcQ4lo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IQbfamPAA89nipESSlzrDvw8x513Eg/U
	ZM0+QnWFvul96j8PM9oVFf6sEmhccICBpMSSv+pos30FDnqwdxggmp/kjeTZmUtd
	h6u4m52dXMCBBqWhBLUhEWzDsX7IgQ0OXj/c/RqGZl1DT4cRylU4/iozEVeubn6h
	MiR5tNb7d70=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FFB59083;
	Wed, 15 Aug 2012 15:49:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C5D5A9082; Wed, 15 Aug 2012
 15:49:05 -0400 (EDT)
In-Reply-To: <1344971598-8213-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
 (Florian Achleitner's message of "Tue, 14 Aug 2012 21:13:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 456F84DA-E712-11E1-8A34-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:

> To provide metadata from svn dumps for further processing, e.g.
> branch detection, attach a note to each imported commit that
> stores additional information.
> The notes are currently hard-coded in refs/notes/svn/revs.
> Currently the following lines from the svn dump are directly
> accumulated in the note. This can be refined on purpose, of course.
> - "Revision-number"
> - "Node-path"
> - "Node-kind"
> - "Node-action"
> - "Node-copyfrom-path"
> - "Node-copyfrom-rev"
>
> Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
> ---
>  vcs-svn/fast_export.c |   13 +++++++++++++
>  vcs-svn/fast_export.h |    2 ++
>  vcs-svn/svndump.c     |   21 +++++++++++++++++++--
>  3 files changed, 34 insertions(+), 2 deletions(-)
>
> diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
> index 1ecae4b..796dd1a 100644
> --- a/vcs-svn/fast_export.c
> +++ b/vcs-svn/fast_export.c
> @@ -12,6 +12,7 @@
>  #include "svndiff.h"
>  #include "sliding_window.h"
>  #include "line_buffer.h"
> +#include "cache.h"

Shouldn't it be near the beginning?  Also if you include "cache.h",
it probably makes git-compat-util and strbuf redundant.

>  
>  #define MAX_GITSVN_LINE_LEN 4096
>  
> @@ -68,6 +69,18 @@ void fast_export_modify(const char *path, uint32_t mode, const char *dataref)
>  	putchar('\n');
>  }
>  
> +void fast_export_begin_note(uint32_t revision, const char *author,
> +		const char *log, unsigned long timestamp)
> +{
> +	timestamp = 1341914616;

The magic number needs some comment.

> +	size_t loglen = strlen(log);

decl-after-statement.  I am starting to suspect that the assignment
is a leftover from an earlier debugging effort, though.
