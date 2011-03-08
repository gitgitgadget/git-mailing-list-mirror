From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Documentation fix: git log -p does not imply -c.
Date: Tue, 08 Mar 2011 11:43:08 -0800
Message-ID: <7vmxl5e6ur.fsf@alter.siamese.dyndns.org>
References: <7vsjuyzckd.fsf@alter.siamese.dyndns.org>
 <1299545378-22036-1-git-send-email-haircut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
To: Adam Monsen <haircut@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 20:43:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px2ob-00035t-Fc
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 20:43:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755862Ab1CHTnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 14:43:23 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45729 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755706Ab1CHTnW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 14:43:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D502C331C;
	Tue,  8 Mar 2011 14:44:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D7XFKSYY21FYbA59XFaVHnYPjhg=; b=ffu3eK
	OlzHiCi1ZhAgT0oiAB3ON9LrS+d9FdGybM/oXjx/7aHZt8BuzvZ8NgG2i5KnFJ+4
	QPlGEtjG8/MbrCcyUboQCiw+jrUmx0DOScA4OUyOqZi7JAbfAkPu3k/C4U1Fdm8o
	4xY6n6v/nXMguu/7njNN4a0luXqpwmSdB3N+M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Owb1RQNKSoAItRIHIdtdKrXpUIe+og2m
	7WNcnAJSE+hNJMXZ0ZoX88BWtsAnzj+z+BkZcJ4zYV9YtQ2tGDQuHshQBA9Rfa1O
	S2HJDoHLpKr+79nne9zhf6w1QOHVxpTIRoST6k/ALofT6glANKo9Hnae+vcFEsrL
	tK1UbWovsBM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 90A1A3318;
	Tue,  8 Mar 2011 14:44:42 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 345FF3317; Tue,  8 Mar 2011
 14:44:36 -0500 (EST)
In-Reply-To: <1299545378-22036-1-git-send-email-haircut@gmail.com> (Adam
 Monsen's message of "Mon, 7 Mar 2011 16:49:38 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 83359F60-49BC-11E0-B1FA-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168681>

Adam Monsen <haircut@gmail.com> writes:

> Relates to the thread with subject "frustrated forensics: hard to find
> diff that undid a fix" on the git mailing list.
>
>     http://thread.gmane.org/gmane.comp.version-control.git/168481
>
> I don't wish for anyone to repeat my bungled forensics episode.
> Hopefully this will help others git along happily.
>
> See also:
>
>     http://thread.gmane.org/gmane.comp.version-control.git/89415
>
> Signed-off-by: Adam Monsen <haircut@gmail.com>

Please don't do this.

Re-read what you wrote above while pretending that you do not have any
knowledge of the "frustrated forensics" you did.  Does it convey _any_
useful information?  Log messages should be sufficiently understandable
offline without having the web access.

Instead, summarize why the change is necessary.  IOW, don't be lazy now
while writing the log, to save time for people who later need to read log.

Something like

    Subject: diff format documentation: clarify --cc and -c

    The description was unclear if -c or --cc was the default (--cc is for
    some commands), and incorrectly implied that the default applies to
    all the diff generating commands.

    Most importantly, "log" does not default to "--cc" (it defaults to
    "--no-merges") and "log -p" obeys the user's wish to see non-combined
    format.  Only "diff" (during merge and three-blob comparison) and
    "show" use --cc as the default.

should be sufficient.
