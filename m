From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/2] pretty: support right alignment
Date: Sun, 23 Sep 2012 01:17:43 -0700
Message-ID: <7vvcf517bs.fsf@alter.siamese.dyndns.org>
References: <CACsJy8BP0vzWG-Po=WBVC_V5Z5_ysoCOTkU-XV3Hy_jVE4H1XQ@mail.gmail.com>
 <1348143976-4506-1-git-send-email-pclouds@gmail.com>
 <1348143976-4506-3-git-send-email-pclouds@gmail.com>
 <20120920143803.GA9527@lanh> <7v392cd4vi.fsf@alter.siamese.dyndns.org>
 <CACsJy8AAjxMN7MX09Eq4Dy6NJHMkyxGJZm9uZquXWTi0goAYLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 23 10:18:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFhOw-0006q0-DA
	for gcvg-git-2@plane.gmane.org; Sun, 23 Sep 2012 10:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722Ab2IWIRs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2012 04:17:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54383 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421Ab2IWIRp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2012 04:17:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 931D46301;
	Sun, 23 Sep 2012 04:17:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gCm5EmtxQA00VTUiSolkBttWYpQ=; b=pd6umG
	eKsIe80bJiBMdHi8DfpJLFRV3LMull7+pxsw0wrV55pS4aZMcTSskYbC8b/R/gQ5
	e00O1TLGdxQLtCOzrTG5Mpt4lIl39bRb1R6r5Jn/q3cy6/KKSHDBOQt4VTfxflEj
	Zx9f2P+4SNAEHxPO8jDXMS0Dosgo/XZFrCZZs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RuKFvIX+zGCgXC8k++EmSuQuktj8HYZ/
	6NwmNL2GvR0jrqv/XxmR82Ddnd9uU/H9suyhVwv0GmH3yUwlN5NcXQ+GkEoG/rWc
	6xEw/IyJtueu0TOg8ddyLovg3o832FWDEzysnVmfyYHcGiC0HW2KtK1xtWTXeSqN
	oUt4deRahjg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81C716300;
	Sun, 23 Sep 2012 04:17:45 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 03ECC62FF; Sun, 23 Sep 2012
 04:17:44 -0400 (EDT)
In-Reply-To: <CACsJy8AAjxMN7MX09Eq4Dy6NJHMkyxGJZm9uZquXWTi0goAYLQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Fri, 21 Sep 2012 15:55:13 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2710C720-0557-11E2-9E83-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206223>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> ... On the other hand, I don't
> really wish to turn pretty format machinery into a full feature text
> layout engine (by ripping of links/lynx?).

That is very true.  We should restrain ourselves and avoid going
overboard piling shiny new toys on a not-so-useful foundation that
is not expressive enough.  One feature that is probably much more
needed on the foundation side would be some form of conditional
output, without which built-in output elements like --show-notes
cannot be emulated with --format option.
