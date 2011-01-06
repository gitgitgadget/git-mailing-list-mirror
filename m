From: Junio C Hamano <gitster@pobox.com>
Subject: Re: clone breaks replace
Date: Thu, 06 Jan 2011 13:59:23 -0800
Message-ID: <7v7hehae2s.fsf@alter.siamese.dyndns.org>
References: <4D262D68.2050804@cfl.rr.com> <20110106213338.GA15325@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phillip Susi <psusi@cfl.rr.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 06 22:59:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Paxrx-0001yK-PF
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 22:59:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754167Ab1AFV7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 16:59:37 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62384 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988Ab1AFV7g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 16:59:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1541E3260;
	Thu,  6 Jan 2011 17:00:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iW4SPp7/yD1SlNG0IZgZ7SdTgnM=; b=BA4pPw
	y9GirFjf/EGlN8uthESEeJ5qIUVcEy0Xrr6LPVZKc5mYjp82ZcQsn4HuW7qvkwnA
	8Gcppqn3mdCiHxuZpvCZF5M3LNw/TNfQRTgmLBy1yRzV6W+m3RNrnbTuzDuOv9U4
	iD7KVxV+Q25+79qYxGG06b5IrWdHxlUcsg+Fo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jy4iPa8NczYbMCWs6tbGteV7IWnBD8+6
	lrr4RA7hF74JPcGNFmgViF68pHszmnOCazwKd7sIZ8jlGJUlU6pqKklJu6QVK81R
	C0Gtk0cPwAUa1qSn2K4Hbd+kHnuz+CwuOIvBHFOr1c3MC/Q6pHzu9Ib1nxu5y4pt
	LVGj8VGWQ6U=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C673F325C;
	Thu,  6 Jan 2011 17:00:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6DE62325B; Thu,  6 Jan 2011
 17:00:02 -0500 (EST)
In-Reply-To: <20110106213338.GA15325@burratino> (Jonathan Nieder's message of
 "Thu\, 6 Jan 2011 15\:33\:38 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 530B7744-19E0-11E0-B345-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164682>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Therefore if you want clients to be able to choose between a minimal
> history and a larger one to save bandwidth, it has to work like this
>
>  - to get the minimal history, fetch _without_ any replacement refs
>  - to get the full history, fetch the replacement refs on top of that.
>
> because an additional reference can only increase the number of
> objects to be downloaded.

Very nicely and clearly put.  Can we have this somewhere in the docs?
