From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] notes: attach help text to subcommands
Date: Fri, 08 Jun 2012 10:03:17 -0700
Message-ID: <7vmx4dd9d6.fsf@alter.siamese.dyndns.org>
References: <7vd359eu4s.fsf@alter.siamese.dyndns.org>
 <1339169317-12134-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 19:03:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd2ar-0001cu-5B
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 19:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762119Ab2FHRDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 13:03:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39360 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761333Ab2FHRDU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 13:03:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4C779F7E;
	Fri,  8 Jun 2012 13:03:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=91SnuIv+BLUE2Wv0Pnav4jCNQdY=; b=iVku92
	AXT2XxzAGzn01Q6UBvtLe/5s+RAQv4oyejcvRWmV7ZMtacHclyuTpkUTkX3gfjvG
	C96RPnaXCvVsy7c3lfV8FAR/eJEqKfkBjTvpdqOC873optHgmciXzQZ/wRCUj1Fk
	DV3uCwAAuCxIVGXYjm04Y6AtjoxA3o9LjMADQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jTjGRk7Wj52GVDXwa6zbjwKh5wGD/K9V
	ApGYW7BPjcMHF5enUQuv0dXJRyoitx3bWgj/U4GUqFKOBOSfyILId5sJfffOXH5e
	OKv9tM68e9WzlY2yY+3O890CByhPOXH1Sz0Y87Nv2021Arw2n6ZzuIOBZOV7obYt
	QsIiOo7pevQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B8429F7D;
	Fri,  8 Jun 2012 13:03:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 296CD9F7C; Fri,  8 Jun 2012
 13:03:19 -0400 (EDT)
In-Reply-To: <1339169317-12134-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Fri, 8 Jun 2012 20:58:37 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D8B0119A-B18B-11E1-A109-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199514>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> +struct subcommand {
> +	const char *name;
> +	const char *help;
> +	int (*callback)(int, const char **, const char *);
> +};

In what way is this a "callback"?  It is not like you call some API
function with this structure as its argument, and then the
implementation of the API function calls this function back.
