From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 7/8] add a test for semantic errors in config files
Date: Mon, 04 Aug 2014 11:13:57 -0700
Message-ID: <xmqqk36orul6.fsf@gitster.dls.corp.google.com>
References: <1406912756-15517-1-git-send-email-tanayabh@gmail.com>
	<1406912756-15517-8-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 20:14:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEMm1-00053O-PW
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 20:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbaHDSOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 14:14:08 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60094 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750907AbaHDSOG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 14:14:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C150D2D3C5;
	Mon,  4 Aug 2014 14:14:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DL0+Wzkfz1bxrb8EnhEwOW1Xs98=; b=u1ONIm
	QJMaQiLUBFqw+Oh/NAY5b5gV7+2Mbfsubpj2LVSGUo3W4dYo3q2KqYbhSDZ0lkpc
	HORXZri9ICSBCjBRtaOdHod/7Hu6LkQKGD3cavTeyPw4h2TCS3fk7qFsJNqr74tE
	dAPpQNGEitmohX5O57uZQxHogsN31Plo56v9E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ipENaZUaocYpHCCtOGNH8kzdXWWfxvwI
	kuRi4jy0caV+U1LcBYaBcMCxA2Uvx84v0003MfegqV4iDZQRPuAk2ISifHf398ay
	jXkKMEeUqXU0GGIE2P1dywRIVTSAYB72RujqZKzLyIehqMhSSJG4IUMRA8sRUBiA
	R5WmzwXM4ks=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B8A622D3C4;
	Mon,  4 Aug 2014 14:14:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1D7EF2D3A7;
	Mon,  4 Aug 2014 14:13:59 -0400 (EDT)
In-Reply-To: <1406912756-15517-8-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Fri, 1 Aug 2014 10:05:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1AFED642-1C03-11E4-84D9-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254749>

Tanay Abhra <tanayabh@gmail.com> writes:

> +	grep "fatal: bad config variable '\''alias.br'\'' at file line 2 in .git/config" result

This test is too tight (the full string), and also needs to know
about i18n, I think.
