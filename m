From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-submodule.sh: Support 'checkout' as a valid update command
Date: Mon, 06 Jan 2014 15:48:53 -0800
Message-ID: <xmqqtxdgfz8a.fsf@gitster.dls.corp.google.com>
References: <1389034726-8744-1-git-send-email-ceztko@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Francesco Pretto <ceztko@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 00:49:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0Jus-0008B9-1F
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 00:49:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbaAFXs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 18:48:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33083 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932502AbaAFXs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 18:48:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48CFB616BE;
	Mon,  6 Jan 2014 18:48:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fey+ayPJPr3eR5HEsIyj7f4y1NM=; b=rgXAs4
	oWN3e9FZ/lxbbDIxMVyIN2q2REKNwAdnZpogemS5URAUfZ6K5uy6CmOWEV8lsUw1
	bZQi1chCMjgCxpzzwpXi4XYKyPAcND+ooSrxgnpzUeCGuH3PTeln6aRF2+k0oVhU
	r7eF9mQ0CNJa8pURS3OMNnZn2DM03TZAh8vlE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iWOHbLMqj7RV7pPBci1aVW3iOzr/riVH
	Cg0FR7AJ4bt3MPnD3Fdt1elgcAnGTv1i0QO3Qp0c+2PapAQDYBqnxrPbOuI/ko5r
	p1sfFeW1g6Ngy+mHEYCeShs5ndi9YOC2Wui5CtKwYkMYp6GEt/nNE3MrvLQj5oEe
	mp0ZD3soBM4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36B48616BD;
	Mon,  6 Jan 2014 18:48:56 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F847616BC;
	Mon,  6 Jan 2014 18:48:55 -0500 (EST)
In-Reply-To: <1389034726-8744-1-git-send-email-ceztko@gmail.com> (Francesco
	Pretto's message of "Mon, 6 Jan 2014 19:58:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1AA1F830-772D-11E3-A1CA-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240087>

Francesco Pretto <ceztko@gmail.com> writes:

> According to "Documentation/gitmodules.txt", 'checkout' is a valid
> 'submodule.<name>.update' command.

As you can see in the surrounding text, we call the value of
submodule.*.update a "mode", not a command.

> Also "git-submodule.sh" refers to
> it and processes it correctly.

This present tense puzzles me.  If it already refers to checkout and
handles it correctly is there anything that needs to be done?  Or
did you mean "it should refer to and process it but it doesn't, so
make it so?"

> Reflecting commit 'ac1fbb' to support
> this syntax and also validate property values during 'update' command,
> issuing an error if the value found is unknown.

Sorry, but -ECANNOTPARSE.
