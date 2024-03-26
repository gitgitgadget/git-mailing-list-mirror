Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F30B130AEC
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 07:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711438995; cv=none; b=qPTmvhpC7QpI/m4+I2SsoNk8UjneQx/lAQqOWK5XRvBD49rM51BMtLMBjC/mBX639bocDzLG7nnluERcJt1BKW5ASodeKC1xNrT30CXL1B4lTKgxsNCqVIcePudm0lDCBHCCJ6eylSzRi9ei1QkxdYF+0kBd0CrIbdtMhp/7jEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711438995; c=relaxed/simple;
	bh=w40HBWt21a1QWvQhe3Bt7k4wzt6VmeQjkp2nUZyQPzc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=AKicW0vj/KlQTPyptn5om6R4BIl7ptu0dwsOOjzJYA9pj/hXyWkbGH/JYYtNGz2Mh6O6Kvc/eAuWxR25/yn7fHLSt+p2uNwBm1TcphpkqhfjGHgv2v4aCpPcsmirvDn+OkEsJCLR0vOnFK/cRveql1Ev/gWLNd7NZYzfJ01uwC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=TGfA5nU7; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="TGfA5nU7"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711438989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ILxetwx92v/mACxoPSkv0s3CLoCSIFQH8SSZpv7r/l0=;
	b=TGfA5nU7LLYbs9qAjgWnWkaTHOA6KpHbR57hU+2hMdkEjaBuHIxMoBwKcm+mOVt3NCWEi3
	ECYUXS9ygIbh8O0soYQY8yny/o9TMAYd69n4PSmjhIbHvT+Ea469vKiwFV3JV6FFgdiVBA
	A5+5fvzO5ZQkbg9hqEXR2gd7gGpsS+BicXXD9BpvoHXOYeF+8WjW+iznMgBRQO6G/cH2nx
	Cn524Xwr4LZipuYfpVHY/OlgJot7sXQWvqi9fwm+caM1ftfOtk4ScWO2F5ZbrNukd8dfDA
	DL72KS5GCNKziRLtT/spzUx0cLHNzEzzE2vv9AQnuNqhSryDqCggLCo8wFueIA==
Date: Tue, 26 Mar 2024 08:43:08 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Brian Lyles <brianmlyles@gmail.com>,
 phillip.wood123@gmail.com, =?UTF-8?Q?Jean-No=C3=ABl_AVILA?=
 <jn.avila@free.fr>
Subject: Re: [PATCH v2] SubmittingPatches: release-notes entry experiment
In-Reply-To: <xmqq8r26eyva.fsf@gitster.g>
References: <xmqq8r26eyva.fsf@gitster.g>
Message-ID: <506be88207b63ed25067c374d3da8c09@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-25 23:21, Junio C Hamano wrote:
> The "What's cooking" report lists the topics in flight, with a short
> paragraph descibing what they are about.
> 
> Once written, the description is automatically picked up from the
> "What's cooking" report and used in the commit log message of the
> merge commit when the topic is merged into integration branches.
> These commit log messges of the merge commits are then propagated to
> the release notes.
> 
> It has been the maintainer's task to prepare these entries in the
> "What's cooking" report.  Even though the original author of a topic
> may be in the best position to write the initial description of a
> topic, we so far lacked a formal channel for the author to suggest
> what description to use.  The usual procedure has been for the
> author to see the topic described in "What's cooking" report, and
> then either complain about inaccurate explanation and/or offer a
> rewrite.
> 
> Let's try an experiment to optionally let the author propose the one
> paragraph description when the topic is submitted.  Pick the cover
> letter as the logical place to do so, and describe an experimental
> workflow in the SubmittingPatches document.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Looking good to me.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  * An experimental procedure for a topic author to propose the topic
>    description to be used in "What's cooking" report and in the
>    release notes have been added to the SubmittingPatches document.
> 
>  The above is an example that follows this protocol for a
>  single-patch series.
> 
>     >> Would it be beneficial to request some specific heading, phrase, 
> or
>     >> other structured text such that this summary is obvious, or even 
> easily
>     >> extracted with some sort of script? Or is that perhaps overkill 
> for now?
>     >
>     > ... the rule might end up
>     > to be as simple as "When the first paragraph of the message looks
>     > like an entry in the Release Notes, it is used as such".
> 
> Range-diff:
> 1:  83f8b69ab9 ! 1:  86b861255b SubmittingPatches: release-notes entry
> experiment
>       ## Documentation/SubmittingPatches ##
>      @@ Documentation/SubmittingPatches: an explanation of changes
> between each iteration can be kept in
>     @@ Documentation/SubmittingPatches: an explanation of changes
> between each iteratio
>      +paragraph summary that appears in the "What's cooking" report 
> when it
>      +is picked up to explain the topic.  If you choose to do so, 
> please
>      +write 2-5 lines of a paragraph that will fit well in our release 
> notes
>     -+(see Documentation/RelNotes/* directory for examples), and put it 
> in
>     -+the cover letter, clearly marked as such.  For a single-patch 
> series,
>     ++(see Documentation/RelNotes/* directory for examples), and make 
> it
>     ++the first paragraph of the cover letter.  For a single-patch 
> series,
>      +use the space between the three-dash line and the diffstat, as
>      +described earlier.
>      +
> 
>  Documentation/SubmittingPatches | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/SubmittingPatches 
> b/Documentation/SubmittingPatches
> index e734a3f0f1..e29a3d9a5b 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -459,6 +459,17 @@ an explanation of changes between each iteration
> can be kept in
>  Git-notes and inserted automatically following the three-dash
>  line via `git format-patch --notes`.
> 
> +[[a-paragraph-summary]]
> +
> +*This is EXPERIMENTAL*.  When sending a topic, you can propose one
> +paragraph summary that appears in the "What's cooking" report when it
> +is picked up to explain the topic.  If you choose to do so, please
> +write 2-5 lines of a paragraph that will fit well in our release notes
> +(see Documentation/RelNotes/* directory for examples), and make it
> +the first paragraph of the cover letter.  For a single-patch series,
> +use the space between the three-dash line and the diffstat, as
> +described earlier.
> +
>  [[attachment]]
>  Do not attach the patch as a MIME attachment, compressed or not.
>  Do not let your e-mail client send quoted-printable.  Do not let
