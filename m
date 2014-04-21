From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] remote-helpers: move out of contrib
Date: Mon, 21 Apr 2014 14:42:45 -0700
Message-ID: <xmqqeh0q8ilm.fsf@gitster.dls.corp.google.com>
References: <1398112633-23604-1-git-send-email-felipe.contreras@gmail.com>
	<1398112633-23604-3-git-send-email-felipe.contreras@gmail.com>
	<xmqqppka8jiw.fsf@gitster.dls.corp.google.com>
	<53558c7fbd4d4_604be1f30c30@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 23:42:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcLzK-0002CR-Fh
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 23:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754493AbaDUVmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 17:42:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60274 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752896AbaDUVmt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 17:42:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F4727F885;
	Mon, 21 Apr 2014 17:42:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m5QFcdwsuxhDOvg08rxKMlopAIg=; b=hT/I52
	cNtBpHun1ADclfiIuU8api4Blu9E49vFCF4JkHmUPhxYL/uSGaBf9hpE8dnZHi5N
	uU6XOCmJvjqfgHEc/yMyX3UAWeKSxj1rYuuRZIqfhb3IOgBh2Vebdct1BJwa1bFi
	elgeoovK7bkTmc02OdC4Lk/I9brXxP1B9Qjog=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=REV2eiZaVthmVH89YEWudUxnm27475kd
	o1+scTsLUzh48Rn2e1y+dYhGQbo/3zpF515VzLAt8jxWZ5NrqbA66AZMpxcbaLEc
	nf8lZIjL2fe6z1AYQ//GLc3xLLJHYAACO4HjBJRw7mnRVjf3r+myr6B1cPFfwlZD
	ELQ1djOzrkc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19AC87F882;
	Mon, 21 Apr 2014 17:42:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F6E07F87E;
	Mon, 21 Apr 2014 17:42:47 -0400 (EDT)
In-Reply-To: <53558c7fbd4d4_604be1f30c30@nysa.notmuch> (Felipe Contreras's
	message of "Mon, 21 Apr 2014 16:24:15 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E10FD704-C99D-11E3-9E97-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246651>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> Does this change relate to the moving of main scripts, and if so
>> how?
>
> Yes.
>
> Before the scripts were not generated, the shebang was '/usr/bin/env python',
> that means if the user doesn't have 'python' but 'python2' git-remote-hg would
> fail, even if the user did PYTHON_PATH=python2, therefore the test scripts
> should fail too, and that's the reason 'python' is used in the test scripts.

Ahh, OK, I agree that is a sensible change, then.  I would think
that deserves to be explained in the proposed log message, though.
