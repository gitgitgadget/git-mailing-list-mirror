From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/5] pull: rename pull.rename to pull.mode
Date: Tue, 10 Sep 2013 14:34:24 -0700
Message-ID: <xmqqppsgwecf.fsf@gitster.dls.corp.google.com>
References: <1378689796-19305-1-git-send-email-felipe.contreras@gmail.com>
	<1378689796-19305-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>,
	John Keeping <john@keeping.me.uk>, Jeff King <peff@peff.net>,
	Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	sandals@crustytoothpaste.net
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 10 23:34:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJVZx-0004b6-Kr
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 23:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853Ab3IJVea (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 17:34:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47860 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750886Ab3IJVe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 17:34:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B94FC40478;
	Tue, 10 Sep 2013 21:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zjzX9qPgtJrGqhW6fSQLl4ZP/Ds=; b=enyzNJ
	FNXky2R/t2Y6By8WYEAxjmxnCIIAbzpYashA7eo5e5fDzFg7nBPE/scWtqocz8su
	1LJt1iK2TrKZ84cZm+EzutlXd8wPhPEP69ypIEWvg18qQn5NWMcOXqaDRWRl4Piw
	W7iXCeuEv8yDxWqYA1VFHSGpkQ2Kd2nYbgrbs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oUKm3KKdKIcTAif4SQUkiFdFuKybly52
	k0OEpNMUaLZPP57gX5faRE4WCmo33dZ0jrAAmdwD33NfnM3y6De9Z+QKGuUTSaay
	q4qQC/YlppICn1zPgnl8FLrFTDib/4mELezb9bFT2wl1lkn4ysJeGs8QVdvBeWAj
	96jRIXftP08=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6955F40476;
	Tue, 10 Sep 2013 21:34:28 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DBFE64046B;
	Tue, 10 Sep 2013 21:34:26 +0000 (UTC)
In-Reply-To: <1378689796-19305-2-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Sun, 8 Sep 2013 20:23:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C4BECE26-1A60-11E3-AF26-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234486>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Also 'branch.<name>.rebase' to 'branch.<name>.pullmode'.
>
> This way 'pull.mode' can be set to 'merge', and the default can be
> something else.
>
> The old configurations still work, but get deprecated.

Sounds good, but we should still mention these old names in the
documentation (and mark them as deprecated).

> +test "$mode" == 'rebase' && rebase="true"

POSIX test does not take "==" as string equality; it is a bash-ism.

	test "$mode" = rebase
