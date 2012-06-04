From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] parse-options: introduce parse_subcommands
Date: Mon, 04 Jun 2012 10:01:21 -0700
Message-ID: <7vlik3t3j2.fsf@alter.siamese.dyndns.org>
References: <1338802534-32394-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 19:01:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbaeo-00071B-6S
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 19:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295Ab2FDRB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 13:01:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59184 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753138Ab2FDRBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 13:01:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E3AB8A29;
	Mon,  4 Jun 2012 13:01:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b/X0pEqmVlSSxsw/Zxs7BE1jVwY=; b=ZVlrdw
	pnDS6Y+ST3JzRJRc6sPe5nGeN96A0g7yyd88nJ39nqlNzCZ2N1sFAazvAPkmT917
	TS80IpIaAJZW7W43eNSsvzhyCxEMD/wu2mMhz4y7yjppV3OeSVq/cTXWZZext8b/
	3bj6C1iNR7VZJKpWZObl71JJ1sq/J/RVOpIAs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nZx7f+pJUH3g65KmGjAVQUJjWCpVCIAS
	CqKgva2qE1O5cBcDhcjgvu+yVlNEwRU894lkgf2187AxSIvuEvaY6+Ib2Wibp+EO
	U1gJ17i5iMQ+Q2wMHLE0XI/0665U9cpfxlWhYhzfOWPADQZqeKCTBKh9dmTbQcA9
	lmhGLT459Og=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 550E48A28;
	Mon,  4 Jun 2012 13:01:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 36B7E8A26; Mon,  4 Jun 2012
 13:01:24 -0400 (EDT)
In-Reply-To: <1338802534-32394-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Mon, 4 Jun 2012 15:05:34 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EACD327C-AE66-11E1-A598-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199150>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>  I found this patch in one of my branches from a long time ago.  I
>  haven't written documentation and tests yet because I'm not fully
>  convinced that I like this.
>
>  Thoughts?

It looks like a static version of string_list_lookup() and does not
have much reason to tie it to "subcommand".
