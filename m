From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] teach fast-export an --anonymize option
Date: Thu, 21 Aug 2014 14:57:22 -0700
Message-ID: <xmqqiollqzel.fsf@gitster.dls.corp.google.com>
References: <20140821070130.GA15930@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 21 23:59:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKaNt-0002lU-J1
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 23:59:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755398AbaHUV5f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 17:57:35 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56762 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755340AbaHUV5c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 17:57:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AEDE034E4C;
	Thu, 21 Aug 2014 17:57:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TJ4LCtObNbQNNaPfmakuOBGl6OI=; b=fu7MOA
	WFZTINrfYN3F8oHRw2CzWGTY55mIJfVZFm7HoBEtvdydcafw5oEAnSx9Tn70bQJf
	yRA/vZj/8Q3pll3yf8R57A8e+mVrxUohNnzWv9t0M7m5/u8nxJlig4CImSFl3W9i
	XLEcD+OJcmPc1xgPqP1h66BE29yY46bfDaWwI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AmdK+BH4qauYq5F+KH0tCYo2Xg0ma4pJ
	qqVuoAADieTGOuh9HN15S4t5oTiTXlxprgGP2QkizfZSCB5E+CklflMzgJCnyXrK
	stgKw3KSZBcDSS2A9X/H9keiT5DKF8myPml4Wa31FWaZhcU9ljyMW73sZIyNLMBd
	K4nVYzI1990=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A420F34E4B;
	Thu, 21 Aug 2014 17:57:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BE3E334E43;
	Thu, 21 Aug 2014 17:57:23 -0400 (EDT)
In-Reply-To: <20140821070130.GA15930@peff.net> (Jeff King's message of "Thu,
	21 Aug 2014 03:01:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 21D08370-297E-11E4-B96C-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255639>

Jeff King <peff@peff.net> writes:

> +--anonymize::
> +	Replace all paths, blob contents, commit and tag messages,
> +	names, and email addresses in the output with anonymized data,
> +	while still retaining the shape of history and of the stored
> +	tree.

Sometimes branch names can contain codenames the project may prefer
to hide from the general public, so they may need to be anonymised
as well.
