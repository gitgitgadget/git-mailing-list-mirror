From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 02/21] path.c: rename vsnpath() to git_vsnpath()
Date: Mon, 16 Dec 2013 12:16:23 -0800
Message-ID: <xmqqfvpso8ko.fsf@gitster.dls.corp.google.com>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
	<1387018507-21999-1-git-send-email-pclouds@gmail.com>
	<1387018507-21999-3-git-send-email-pclouds@gmail.com>
	<52ACBE2B.3040909@ramsay1.demon.co.uk>
	<CACsJy8BdLt8ZUU2z4LAgTcfXUjruFaOFsvrv6dSziZVizAopGA@mail.gmail.com>
	<52AE1B5E.6020506@ramsay1.demon.co.uk>
	<CACsJy8AJT5XXyJvVi_6Gjrn=AqA1M9KWY_62p=d3CPjg7nXFWw@mail.gmail.com>
	<20131216171147.GA28604@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 16 21:16:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vsead-00026I-KG
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 21:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113Ab3LPUQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 15:16:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38690 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751019Ab3LPUQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 15:16:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 368765B813;
	Mon, 16 Dec 2013 15:16:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+I+peSWOqvQhdMkpXtYN7cwlxC4=; b=K+PK3o
	3ASaXhuGtAf6ZDVsAqjdU+hns0w/AIuIu+2FgvFAU4xWXzbc/mookpYP0lW+Q/4X
	nMVl0X6Au+UBij0fCs+WqumVIeJbYBqytjdRv/fryhYNEByqt6b99hZOTR2mstOt
	GcmCQWK73SuJfkMB/VB8wbZhN3NvRKplW6KUA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ww42tCJ+/1vkIKkckJS48UOlftn/UDW2
	JLlsAVGrQPq/KoRCQyBrYQq418I5os2mp1oDG1px2734mN16xjFqDFHuBDvxYGxY
	+kOp144sZlAzHxhzHjZc1MCR12CKWGyaTLdmONhd6NBrEkoJYMPjnkJGh+mFHPQO
	xJX8x1g5RCY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21DFE5B811;
	Mon, 16 Dec 2013 15:16:26 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 440DA5B810;
	Mon, 16 Dec 2013 15:16:25 -0500 (EST)
In-Reply-To: <20131216171147.GA28604@google.com> (Jonathan Nieder's message of
	"Mon, 16 Dec 2013 09:11:47 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F03873B6-668E-11E3-8306-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239364>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Duy Nguyen wrote:
>>>> Ramsay Jones wrote:
>
>>>>> :-D I renamed this _from_ git_vsnpath() in commit 5b3b8fa2 ("path.c: Remove the
>>>>> 'git_' prefix from a file scope function", 04-09-2012), because ... well it's a
>>>>> file scope function! (i.e. the git_ prefix implies greater than file scope).
>>>>> I'm not very good at naming things, so ...
> [...]
>> OK I go with this. I think it makes sense
>>
>> vsnpath -> do_git_path
>
> I think this renaming would be still losing clarity --- it loses the
> information that this is the vsnprintf-like variant of git_path.
>
> Do we actually have a convention that functions with git_ prefix
> should be global?  If git_path were not global, would it have to be
> renamed?  If git_vsnpath should be renamed to avoid mistaking it for
> git's replacement of a hypothetical standard library vsnpath function,
> shouldn't git_path, git_pathdup, etc be renamed for the same reason as
> well?
>
>> its three callers are
>>
>> git_vsnpath -> strbuf_git_path (it's updated to take strbuf)
>> git_path
>> git_pathdup
>
> Yeah, independently of everything else, a strbuf variant sounds nice.

OK, then strbuf_vsnpath_in_gitdir() perhaps?
