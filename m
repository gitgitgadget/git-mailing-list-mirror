From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] optionally disable overwriting of ignored files
Date: Tue, 24 Aug 2010 09:19:25 -0700
Message-ID: <7vpqx8x9te.fsf@alter.siamese.dyndns.org>
References: <4C6A1C5B.4030304@workspacewhiz.com>
 <7viq39avay.fsf@alter.siamese.dyndns.org> <20100818233900.GA27531@localhost>
 <vpqd3t9656k.fsf@bauges.imag.fr> <4C727E17.5070707@ira.uka.de>
 <20100823151146.GA15379@localhost> <7veidp2ufh.fsf@alter.siamese.dyndns.org>
 <20100824072854.GA22951@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Holger Hellmuth <hellmuth@ira.uka.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Aug 24 18:19:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnwDz-0000e9-Je
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 18:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755445Ab0HXQTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 12:19:41 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65182 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755073Ab0HXQTk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 12:19:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A1752D0454;
	Tue, 24 Aug 2010 12:19:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q3Nkmz2h2Zx4Ge2X0XKnOTrmQEE=; b=ovcPqM
	OCam1uw7Y1l6syN9SKIJkrewg41Yb+fuIYCgG+lr0iX490mMP7A4I2pWn4pexC2O
	9YNzAKAJTvn46tL/0uwBmxgoVpV04wIMd5ELSQ+v4yJLjv+g6czzi8ofaT74UmBP
	253hb8zboOn18ExWfarnAnLSTgUMA1HKWMw6g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EYinIGgFf1geRmntS88rKqTO25QqxKUB
	XS96ZMcLc2BzeuqFQB1+3YMkLfyKGiAFeT6YqPaYubibfuS43vjJHQ5fqZROf6XA
	tFavgi4AiT5VSFrP5MvsM951KhC64aIkxKMi8COfI0XaePGaBWwSggi7u70oVene
	jzqM7852ExY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 46E5DD0453;
	Tue, 24 Aug 2010 12:19:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 574CAD044E; Tue, 24 Aug
 2010 12:19:27 -0400 (EDT)
In-Reply-To: <20100824072854.GA22951@localhost> (Clemens Buchacher's message
 of "Tue\, 24 Aug 2010 09\:28\:54 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 615C37AC-AF9B-11DF-92EC-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154320>

Clemens Buchacher <drizzd@aon.at> writes:

> The fact that files in .gitignore are considered trashable, and the
> ones in .git/info/exclude are not.

Is that a fact?

There may be a subtle bug in the ignore handling code.  The entries in
these various places are never meant to produce different behaviours.
