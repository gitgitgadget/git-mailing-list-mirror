From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Add submitGit patch-submission information
Date: Thu, 14 Apr 2016 15:27:18 -0700
Message-ID: <xmqq37qng721.fsf@gitster.mtv.corp.google.com>
References: <0102015416d52ae9-da060607-a742-4efc-8b40-98301c2bb261-000000@eu-west-1.amazonses.com>
	<0102015416d52b62-ce575cc4-6dc2-4097-8883-79baac701105-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Roberto Tyley <roberto.tyley@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 00:27:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqpjT-0007E5-JV
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 00:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbcDNW1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 18:27:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56772 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751782AbcDNW1W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 18:27:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 734AB13F49;
	Thu, 14 Apr 2016 18:27:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uF6+bE7Lbedfqlm8qEZZ/w6hUF0=; b=wQikes
	L+J93fCipT1THzwz7cSvt2anDF53TExWriBKnNC2bwgFMtkfG2LMhQzZl9FjqD5Q
	5Kh2qpO3I2M4Ppt/K/b94fQpbjJ179dQLts/YT/mfynxr23oyB6j9oa/4k7LtNKm
	FKckPe+oA9tBv9WTRmMYzSbsGs+UMqjQhDU9A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EFbJsED84o0rqi/0nVyD8/BqXP4NYoRq
	Ah0OeM0au7RFwt+QaOr8ASByLmNGpuYi6oTpw3fnHFWFjVGm6Vw9HsN5dD20PSKy
	dAycs/l6jRrPf79lAD2OCGCrYcl2Sb17AhuFxPBnohBCJfaFMGbbZ57VEY54VmS0
	Q8Fu0xKUaE0=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5590213F48;
	Thu, 14 Apr 2016 18:27:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B125D13F46;
	Thu, 14 Apr 2016 18:27:19 -0400 (EDT)
In-Reply-To: <0102015416d52b62-ce575cc4-6dc2-4097-8883-79baac701105-000000@eu-west-1.amazonses.com>
	(Roberto Tyley's message of "Thu, 14 Apr 2016 22:12:29 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0CF60046-0290-11E6-AC1C-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291573>

Roberto Tyley <roberto.tyley@gmail.com> writes:

> +(3) Generate and send your patch to the Git mailing list
>  
>  People on the Git mailing list need to be able to read and
>  comment on the changes you are submitting.  It is important for
>  a developer to be able to "quote" your changes, using standard
>  e-mail tools, so that they may comment on specific portions of
>  your code.  For this reason, each patch should be submitted
> -"inline" in a separate message.
> +"inline" (not as an attachment) in a separate message.
> +
> +There can be unexpected problems in sending patches:
> +
> +  . Webmail clients like Gmail generally corrupt whitespace in patches.
> +  . messages using HTML-formatting (used by default in many webmail
> +    clients) is automatically rejected by the Git mailing list server.
> +
> +Because of these factors, it's recommended that you use one of these
> +specific methods to generate and send your patchs:

Perhaps:

    It's recommended ... your patches, unless you already know how
    to correctly send your patches as plain-text e-mails.

That is, the ones listed below are known to produce good patches,
but our recommendation is _so_ strong to urge users with working
set-up to migrate to them.

> +
> +  - Generate mail-ready patch files using "git format-patch" and
> +    send them using "git send-email" to the Git mailing list.
> +    See SubmittingPatchesByMUA for further details.
>  
> +  - Create a pull request on https://github.com/git/git and
> +    use https://submitgit.herokuapp.com/ to send it as a patch series
> +    to the mailing list.  Note that the PR is just the place where your
> +    patch is born - discussion of the patch should still take place on
> +    the Git mailing list.

This is a tangent but I am wondering if you can do this _without_
creating a pull request to that repository.  I have a watch on that
repository and my notification gets unnecessarily large because of
these pull requests that were made _only_ for submitGit.  Can't
submitGit be taught to take a branch in a repository of the
submitter as input, (instead of a pull request to that public
repository)?

Once it is done, you do not even have to say "Note that", as there
is no room for confusion.

> +Please make sure to review your patch before sending it, to ensure that
> +it:
>  
> +  . accurately reflects the change you want to make
> +  . does not add commented-out debugging code, or include any extra
> +    files which do not relate to what your patch is trying to achieve.
> +  . cleanly applies to the "master" branch head.  If you are preparing
> +    a work based on "next" branch, that is fine, but please mark it as
> +    such.
>  
>  It is a common convention to prefix your subject line with
>  [PATCH].  This lets people easily distinguish patches from other
> @@ -186,7 +200,7 @@ patch.
>       *2* The mailing list: git@vger.kernel.org
>  
>  
> -(5) Sign your work
> +(4) Sign your work
>  
>  To improve tracking of who did what, we've borrowed the
>  "sign-off" procedure from the Linux kernel project on patches
>
> --
> https://github.com/git/git/pull/223
