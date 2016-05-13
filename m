From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] pathspec: record labels
Date: Thu, 12 May 2016 21:32:16 -0700
Message-ID: <xmqqfutmbmsv.fsf@gitster.mtv.corp.google.com>
References: <20160513001936.7623-1-sbeller@google.com>
	<20160513001936.7623-5-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: pclouds@gmail.com, git@vger.kernel.org, jrnieder@gmail.com,
	Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 13 06:32:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b14m4-0006lD-FZ
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 06:32:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbcEMEcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 00:32:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63239 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750816AbcEMEcU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 00:32:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A23831B495;
	Fri, 13 May 2016 00:32:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D5oVelpryYMwVdaLFB7sM1vL0YQ=; b=mZAq4o
	1juVnzMOuoHIlEUi1fN0g0mdATSJtLnYM72Qr3u4dvHKdEhZOFbD4LzclODz/NJf
	W/UdeUdU87Rl+063edAqNbLr4hlIfmjD4stWmys8zf603k2lzX6ZEuHS+BCF+NWb
	sXiJVXvpwInq4QCvRzJjI+S1dtEfpHoFmQcGk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JmCAuO3aq0PVE+El7O41DJg0RWVtFZKZ
	O2VEBB+0sFqfl6KqXo5E5az4DxCVdr/nQW2KsIsSU0NS0q8rGX0uU+gqtR7VoWZa
	tX4CIMd7d0p9TWA8/OVV6YVIMtZb33uEw3DZqrCe/Lmb7IZUQrkFS6sAoelHI3xW
	qs1qrGztv84=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 976AB1B494;
	Fri, 13 May 2016 00:32:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C9691B493;
	Fri, 13 May 2016 00:32:17 -0400 (EDT)
In-Reply-To: <20160513001936.7623-5-sbeller@google.com> (Stefan Beller's
	message of "Thu, 12 May 2016 17:19:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ACF233E6-18C3-11E6-B2F1-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294498>

Stefan Beller <sbeller@google.com> writes:

> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index 8ad29e6..a1fc9e0 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -362,6 +362,11 @@ glob;;
>  	For example, "Documentation/{asterisk}.html" matches
>  	"Documentation/git.html" but not "Documentation/ppc/ppc.html"
>  	or "tools/perf/Documentation/perf.html".
> +
> +label:<white space separated list>;;
> +	Labels can be assigned to pathspecs in the .gitattributes file.
> +	By specifying a list of labels the pattern will match only
> +	files which have all of the listed labels.
>  +
>  Two consecutive asterisks ("`**`") in patterns matched against
>  full pathname may have special meaning:

I think the new text is stuffed in the middle of the "glob;;" entry.
