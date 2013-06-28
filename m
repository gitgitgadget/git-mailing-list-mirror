From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [submodule] Add depth to submodule update
Date: Fri, 28 Jun 2013 11:44:26 -0700
Message-ID: <7vk3lenkhh.fsf@alter.siamese.dyndns.org>
References: <1371974698-28685-1-git-send-email-iveqy@iveqy.com>
	<20130624224925.GC32270@paksenarrion.iveqy.com>
	<20130625221132.GB4161@sandbox-ub>
	<20130626160219.GC9141@paksenarrion.iveqy.com>
	<7vli5wvb3n.fsf@alter.siamese.dyndns.org> <51CC5235.6030908@web.de>
	<20130628065001.GA2783@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri Jun 28 20:44:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Usder-0003Em-On
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 20:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752438Ab3F1Soa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 14:44:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38285 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752435Ab3F1So2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 14:44:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5433B2C017;
	Fri, 28 Jun 2013 18:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OI4GkKWuwNAyTmN/W4NSl47gMkw=; b=hoUlHZ
	EynD72dmkBfEuK5XeUJpHZQS98o4FFa2RzNK6v2Hzv9K9MbLQwkYn33ayGq8dcG9
	yOlRyx+Uc3h/nad/EHb7MZWEA73unOlmeEE6sYvkoFDE30/F7/xYnDtJD2Wl3SxC
	qOK+vkSlXlvaSQ9aDb5k7aoiDvIJ/O0MEsHys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lTbcnrKwC2fukb8x+8os2vrKihkdFG6t
	VC9x5lvhiRBQbvIfv+YdXqLFoUiZVpXt9py9Us/fcMbxZ3AGiH5P6zYv6p5so9kr
	HoEXEMDRqm1/r/coRM/5R70yzFNfmI7poJjzmR8IQJik2oVyhVcBk8vVZsk9+Z+W
	1WFilgkq1u0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FF412C016;
	Fri, 28 Jun 2013 18:44:28 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99F472C015;
	Fri, 28 Jun 2013 18:44:27 +0000 (UTC)
In-Reply-To: <20130628065001.GA2783@sandbox-ub> (Heiko Voigt's message of
	"Fri, 28 Jun 2013 08:50:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C2CF59AA-E022-11E2-9656-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229225>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> On Thu, Jun 27, 2013 at 04:54:45PM +0200, Jens Lehmann wrote:
> ...
>> Me too thinks adding "--depth" to "update" makes sense (and I don't
>> think that this pretty generic name will become a problem later in
>> case someone wants to add a maximum recursion depth, as grep already
>> uses "--max-depth" for the same purpose).
>
> Hmm, but does it have a --depth option for revisions? Maybe we should
> call it --clone-depth or --rev-depth to make it clear? --depth and
> --max-depth would be completely orthogonal but the name does not allow
> to distinguish them properly.

I do not have a strong opinion either way, but as you suggest, it
might be a good idea to call this new option --clone-depth to be
more specific.
