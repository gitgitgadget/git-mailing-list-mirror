From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch: avoid quadratic loop checking for updated
 submodules
Date: Mon, 12 Sep 2011 13:21:42 -0700
Message-ID: <7vwrdd5x61.fsf@alter.siamese.dyndns.org>
References: <20110912195652.GA27850@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	git-dev@github.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 12 22:21:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3D0n-000236-R3
	for gcvg-git-2@lo.gmane.org; Mon, 12 Sep 2011 22:21:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754524Ab1ILUVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 16:21:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55318 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754477Ab1ILUVo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 16:21:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CCA1F5955;
	Mon, 12 Sep 2011 16:21:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YLUyHUtp4bqlmnekOltFyP43F2M=; b=sSQ8XE
	7zk0oLveHNQQvwKZ05TNwgV5YXC16s2GSvJG4Kj70ZVJTcQeELE04eNdi6+FcREd
	nWW3yOP8cqpTwjzvVDqjjn6Xk7WjmU6SSU26pT0AFiKjUv8Ondk47bZ/gNGcVLJF
	C0XYlyVMEmKE1rmVs374EZhJh1mv/eMOgRhGI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sKv5OrSJlR7In3Q+tRUyq+ogiHMPqAdB
	n08+l/52/zrUrJ6tXDkkmeF526NpYPCiCHVIBrwhpLGlU4ZrQCAAFDAE/t3ys+Cz
	LI4dYfTTF7jTWO4fZR6yf0cdoPKudt3/34W+4zXs8TqDAJ2sUNiC/NYpmhagOyAF
	q3Lpts6Un2E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C3C855953;
	Mon, 12 Sep 2011 16:21:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5DC0A5951; Mon, 12 Sep 2011
 16:21:43 -0400 (EDT)
In-Reply-To: <20110912195652.GA27850@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 12 Sep 2011 15:56:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D49E63EC-DD7C-11E0-BB74-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181239>

Jeff King <peff@peff.net> writes:

> Instead, this patch structures the code like this:

Yup, I agree that's the right way to do the other half of the issue.

Will queue for 1.7.6.X series, but I've already pushed out 1.7.6.3
so... ;-)
