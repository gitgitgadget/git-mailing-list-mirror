From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Anomalous AUTHOR and DOCUMENTATION sections in manpages
Date: Wed, 22 Jan 2014 07:51:37 -0800
Message-ID: <xmqqfvogypyu.fsf@gitster.dls.corp.google.com>
References: <52DFA9EF.4080309@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Johan Herland <johan@herland.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jan 22 16:51:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W605h-0000lT-LN
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 16:51:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755550AbaAVPvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 10:51:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35202 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755304AbaAVPvk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 10:51:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3687262C46;
	Wed, 22 Jan 2014 10:51:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4Wecn5VB0WnVxDBLXPBgcEpzcl8=; b=Bwx1gX
	pdqNxWB4NlRzK4huKXL9WqZY/KydQDxZFbEEIqFwZfgDnTCDq349qMrzehYwUfO/
	wiC+WnYJ0dXTrhUuNABJ6U6eZzfJ6pPWCMSpqlMcdqH4hNcaFl+xea4G5q1dDwKg
	C8uGt1luF/l75yJj5MvyNrVZ2TVeyXluuJEJM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Zh0YsrHXRB2Nue5o6pnCdab4PMQqqWX7
	PP9y0RBQu2ziiYRnaIk++dkED1KlVn5CD2ljFqUByWoNWbfDBtNDObNLaizkHAkd
	cB0BQp1LcgA8Ho+2QBqdvNAVSIp/sk/XSDMCorjw/+VaKL+6v9Zm4Fy1bwk7lp5i
	NlqKIZyTAjs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 24C8F62C45;
	Wed, 22 Jan 2014 10:51:40 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2FA6562C43;
	Wed, 22 Jan 2014 10:51:39 -0500 (EST)
In-Reply-To: <52DFA9EF.4080309@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 22 Jan 2014 12:22:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 14B48E9A-837D-11E3-8879-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240833>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I just noticed that there are exactly four Git manpages with an "AUTHOR"
> section and five with a "DOCUMENTATION" section:
>
>     $ make doc
>     $ grep -nIE -e '^\.SH "DOCUMENTATION|AUTHOR"' Documentation/*.[0-9]
>     Documentation/git-column.1:80:.SH "AUTHOR"
>     Documentation/git-for-each-ref.1:272:.SH "AUTHOR"
>     Documentation/git-for-each-ref.1:275:.SH "DOCUMENTATION"
>     Documentation/git-http-backend.1:404:.SH "AUTHOR"
>     Documentation/git-http-backend.1:407:.SH "DOCUMENTATION"
>     Documentation/git-notes.1:395:.SH "AUTHOR"
>     Documentation/git-notes.1:398:.SH "DOCUMENTATION"
>     Documentation/git-remote-ext.1:133:.SH "DOCUMENTATION"
>     Documentation/git-remote-fd.1:71:.SH "DOCUMENTATION"
>
> These sections are inconsistent with the other manpages and seem
> superfluous in a project that has, on the one hand, a public history
> and, on the other hand, hundreds of contributors.

We decided at 48bb914e (doc: drop author/documentation sections from
most pages, 2011-03-11) to remove them for that exact reason.  I'd
be happy to see the one in for-each-ref under my name go.

Thanks.
