From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] commit/status: show the index-worktree with -v -v
Date: Thu, 15 Jan 2015 12:38:10 -0800
Message-ID: <xmqqoapz6aq5.fsf@gitster.dls.corp.google.com>
References: <xmqq387db6xy.fsf@gitster.dls.corp.google.com>
	<038e08973a5872ea13a0ea76bf2a0443fe3c3b50.1421337740.git.git@drmicha.warpmail.net>
	<xmqq1tmv7qjg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ivo Anjo <ivo.anjo@ist.utl.pt>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jan 15 21:38:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBrBJ-0003dY-Ia
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 21:38:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753197AbbAOUiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 15:38:14 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62709 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752699AbbAOUiN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 15:38:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E71D2FA83;
	Thu, 15 Jan 2015 15:38:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6beu3b+Mcezl0RS83w2bEcEiryY=; b=YXm3w/
	FUJqT3E72s273u7JicqlcZoV7ZiFk5TLFKd4cFGlOfHh0TT9Rh0praHvXA8rc7Sx
	r9ZR/MCpJeem+DRU1YZDIDPraZeRWDSnx6MLstZsSWQ4DgqL3L/4Mcbe5Ieqlw7z
	sHll4chUfMJZNJblkFqP2OcMb549dlQ1LJPV8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NUD04GmQYdcZciXZqLUTimqeP4kotbph
	baz2QMhWyvSa1t90g/Qqr/YsIfLqGQbcmnx05fu2kOg9LhfQUfJNkhjU+twfG0Wm
	JviJaqWeY42Y/IAuODbL2w9WLKERMkWRlx8jjQUaqNCyZSdiSZJPTU3Y2qAQMOLt
	IHS++0RrpKQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 74E692FA82;
	Thu, 15 Jan 2015 15:38:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EB6812FA81;
	Thu, 15 Jan 2015 15:38:11 -0500 (EST)
In-Reply-To: <xmqq1tmv7qjg.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 15 Jan 2015 12:11:15 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6C3C42D2-9CF6-11E4-BEC0-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262509>

Junio C Hamano <gitster@pobox.com> writes:

> I do not think that output order is very helpful.  Two diffs to the
> same file next to each other may make it easier to notice, though.
> ...
> or it may want to even be like this:
>
> 	  diff --git a/A b/A
>         ...
>         diff --git to-be-committed/A left-out-of-the-commit/A
>         ...
>         diff --git a/B b/B
>         ...
>
> by using a custom, unusual and easy-to-notice prefixes.

FWIW, with such a loud custom prefixes, I think it is OK to have all
the changes to be committed first and then everything that is left
out at the end.
