From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git config does not reuse section name
Date: Mon, 07 Dec 2009 12:54:45 -0800
Message-ID: <7vfx7m1p4a.fsf@alter.siamese.dyndns.org>
References: <4B1D360B.4070203@ubicom.com>
 <7vy6le35zv.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0912071223l21c70e2ax9b0e3c9976ae9d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Yakup Akbay <yakbay@ubicom.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 21:55:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHkbv-0003rt-Mj
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 21:55:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935577AbZLGUyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 15:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbZLGUyy
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 15:54:54 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44977 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935574AbZLGUyx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 15:54:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 52F4BA4F4C;
	Mon,  7 Dec 2009 15:54:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f1Wds8vdWnronSakJ8NrBFuXl7g=; b=F6ODDt
	lNPsmdieWf+g/8rKPZLQaUD26mBHT1vpNlpzZlI5pf5Cj+ravrsWXMIOlv7pzCNU
	7p7WbJdJNdlTYY8ly7O+K2ONTytX6Gxy5dVzj9cH7tKRhsW+4wsrCoWENvR8kgjy
	cGnROyj3z7VEhADn6GL/9gEvY8dW6B2FSpu+E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=trox0BxadK3gEcvOLtn+yZ5t0CscxN4s
	MCyF/5xIODODrBjsaPpGQwXzTdLmhbruEDtwzDVBCyJv+eGxeppjcvDI3l4iZM4s
	vNNNC+/G2wmmc3mHMpny6oEzkHu6H8Lf90vug9d8+910yCgmLgcdYvDJX1McAMj6
	5GQkk0voPx0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 13C42A4F4B;
	Mon,  7 Dec 2009 15:54:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DE1F8A4F48; Mon,  7 Dec 2009
 15:54:46 -0500 (EST)
In-Reply-To: <fabb9a1e0912071223l21c70e2ax9b0e3c9976ae9d7@mail.gmail.com>
 (Sverre Rabbelier's message of "Mon\, 7 Dec 2009 21\:23\:20 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C51A4EFA-E372-11DE-97A7-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134784>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Mon, Dec 7, 2009 at 21:04, Junio C Hamano <gitster@pobox.com> wrote:
>> If I recall correctly, this hasn't been even noticed/reported/recognized
>> as an issue, ever since the "git repo-config" was introduced (which later
>> was renamed to "git config").
>
> I poked Dscho about it at some point.
>
>> Dscho, do you remember details?
>
> He told me that the 'git config' code is so horrible that it's
> nigh-impossible to change the behavior, hence why he didn't do it :P.

Hmm, sad.  I thought it was mostly his code...
