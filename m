From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V5 2/2] user-manual: add section documenting shallow clones
Date: Tue, 29 Dec 2015 11:24:00 -0800
Message-ID: <xmqqtwn1gisv.fsf@gitster.mtv.corp.google.com>
References: <xmqqfuymji50.fsf@gitster.mtv.corp.google.com>
	<1451415296-3960-1-git-send-email-ischis2@cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: "Stephen P. Smith" <ischis2@cox.net>
X-From: git-owner@vger.kernel.org Tue Dec 29 20:24:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDzsy-0003Ge-Eq
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 20:24:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753656AbbL2TYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 14:24:06 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53527 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753587AbbL2TYD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 14:24:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2B4E9357E6;
	Tue, 29 Dec 2015 14:24:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iYwuGk7aGnaDYdNWx/jo+c9P5rs=; b=i2zepv
	Qc27IA9KLCwtmTXKbHl59gXJhVIXWtldoKy1LzOmeixKp6GESrMqOI7hPvpx/PPc
	s/NnRmYeA/ElXw90BNR1+1k0Q3vk83quS9rewwT4ab+Tj4wfNEt60MWh/NeCLOUy
	/tZDY9PLH8KqhFGGlnZPKPFLJ/DsTaa/7YJ8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IVHJfGUKXyMpUyytyAKgkcDgNm4KG2sq
	NPE1dAR6OmVWPWQ/lK6J3IUU9M+b35GqPtyPdWu+VGyZ1DgDvaR4Caa48+cHXNoN
	hLU+exCbbWOkZVcIjL3czRDw/8LEgiRQ+cxxEwFzh602SHwOJIkz71g1RLpSiWfo
	cQejblo9e/Y=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 20FD6357E4;
	Tue, 29 Dec 2015 14:24:03 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 94BD5357E3;
	Tue, 29 Dec 2015 14:24:02 -0500 (EST)
In-Reply-To: <1451415296-3960-1-git-send-email-ischis2@cox.net> (Stephen
	P. Smith's message of "Tue, 29 Dec 2015 11:54:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B7F88EE2-AE61-11E5-AF8A-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283146>

"Stephen P. Smith" <ischis2@cox.net> writes:

> Rather than merely pointing readers at the 1.5 release notes to
> learn about shallow clones, document them formally.
>
> Signed-off-by: Stephen P. Smith <ischis2@cox.net>
> ---

Thanks.  I do not think the reference to RelNotes were meant for the
end-user readers, though.  That was a hint for whoever is working to
clear the "todo" items from that list i.e. you ;-).

> +[[how-to-get-a-git-repository-with-minimal-history]]
> +How to get a Git repository with minimal history
> +------------------------------------------------
> +
> +A <<def_shallow_clone,shallow clone>>, with its truncated
> +history, is useful when one is interested only in recent history
> +of a project and getting full history from the upstream is
> +expensive.
> +
> +A <<def_shallow_clone,shallow clone>> is created by specifying
> +the linkgit:git-clone[1] `--depth` switch. The depth can later be
> +changed with the linkgit:git-fetch[1] `--depth` switch, or full
> +history restored with `--unshallow`.
> +
> +Merging inside a <<def_shallow_clone,shallow clone>> will work as long
> +as the merge base is in the resent history.  If the merge base is not

recent?

> +present then the merge would be of un-related histories.  This
> +limitaion is fundamental and will not be removed.

I think "fundamental and will not change" is much less important
than the "huge conflicts, making the result of 'clone --depth=<n>'
not very useful to perform merges in", which is what the users would
need to know before deciding to use this feature.

> +
>  [[sharing-development-examples]]
>  Examples
>  --------
> @@ -4645,9 +4664,6 @@ standard end-of-chapter section?
>  
>  Include cross-references to the glossary, where appropriate.
>  
> -Document shallow clones?  See draft 1.5.0 release notes for some
> -documentation.
> -
>  Add a section on working with other version control systems, including
>  CVS, Subversion, and just imports of series of release tarballs.
