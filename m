From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: show detached HEAD if --all is specified
Date: Tue, 09 Sep 2014 10:02:53 -0700
Message-ID: <xmqqppf4loaq.fsf@gitster.dls.corp.google.com>
References: <1410247756-10879-1-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Tue Sep 09 19:03:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XROom-0004QV-Bl
	for gcvg-git-2@plane.gmane.org; Tue, 09 Sep 2014 19:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757339AbaIIRC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2014 13:02:56 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50051 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754492AbaIIRCz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2014 13:02:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3156A376BE;
	Tue,  9 Sep 2014 13:02:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hYqreWLBHAbfFoRzf8xf7tXQ4SM=; b=Fy9Jzy
	lOu2VCbaMh35JwzlCKIEBYvqEQ+VwtZrWfsoicH5r72PWR7Mof0bqKErOt974YXg
	QM2OGyPnU9ZAA+Rrrr/IC9ItrT8wpDePWX68ViHJPaUKVfW6cjazyhODK5fnXG9U
	P/XbGG5w11d971DYrm6u0o12W9IqIe7Uzl+Kc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o8aRoyzhvlPTKyZVXdyOHaCr+5JWHQw3
	MZZb3llk+z6ncrZyhI/KMZMxbc/g1SdI+7JGNUHs6T2GAtPxA5LZTAN1hIibBedS
	sn1HHwOYiRv5RkP5ZPNn1n9BqCbCQJa8d+BvcKzZ7fuALB4NKvWvMgaXWu/urB6u
	MvOqFSjMqQs=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 28F8A376BD;
	Tue,  9 Sep 2014 13:02:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9E275376BB;
	Tue,  9 Sep 2014 13:02:54 -0400 (EDT)
In-Reply-To: <1410247756-10879-1-git-send-email-max@max630.net> (Max
	Kirillov's message of "Tue, 9 Sep 2014 10:29:16 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 240A23B6-3843-11E4-9910-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256694>

Max Kirillov <max@max630.net> writes:

> If HEAD is detached, 'gitk --all' does not show it. This is inconvenient
> for frontend program, and for example git log does show the detached HEAD.

"git log" does use the same revision machinery as rev-parse uses
internally to parse its command line arguments.  What does it do
differently?
