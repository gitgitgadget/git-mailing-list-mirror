From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sha1_file: Remove relative entries limitation
Date: Fri, 02 Sep 2011 09:22:31 -0700
Message-ID: <7vzkimlxrs.fsf@alter.siamese.dyndns.org>
References: <1314772896-22631-1-git-send-email-jason77.wang@gmail.com>
 <4E60A699.9080302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Hui Wang <jason77.wang@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 02 18:22:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzWVs-0000W9-70
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 18:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753150Ab1IBQWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Sep 2011 12:22:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52927 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753251Ab1IBQWf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2011 12:22:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81DE84031;
	Fri,  2 Sep 2011 12:22:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O33A4qIx+ajJpylpBByfEvFONGU=; b=RALVAL
	Pw0ctf3JD5/SKevMaFzSQBfqXxYgff3egqNsXRtHNu70XOQNO/nfxCbheUD7hByZ
	f33IKNA6+ZI/JlSBB4FfO35fRZlaInhts19YCcdVZ3lBzYrtvO4Opl9lHwLu487d
	nYLNMRFk7H3uPnJZfZxZAlaH9DIL8BS9TVUFk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rlNdV/4UQdGsOJn4Nke8xnXyWbUQ6YK8
	LcAhS9ssv2siNdI069auPj8D4It7pL4mYn1S2LOZhFxF+dTnCDq+VS5PZT1jCKRc
	mFSTkT9qhW1DH58BK+nRIMMA8RdkWPjjugJsmilYpKeCtz7G4xpqrywbzpBagL7C
	5FOSvT0nVhM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 78F6B4030;
	Fri,  2 Sep 2011 12:22:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EE7AB402F; Fri,  2 Sep 2011
 12:22:32 -0400 (EDT)
In-Reply-To: <4E60A699.9080302@gmail.com> (Hui Wang's message of "Fri, 2 Sep
 2011 17:49:13 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C2FA90C0-D57F-11E0-9B2A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180619>

Hui Wang <jason77.wang@gmail.com> writes:

> Does this patch make sense?

I do not see anything wrong with it per-se, but I'd like to see somebody
made an effort to dig why the restriction is there in the first place. The
check is very much deliberately placed there and there may be a good
reason why we do not resolve relatives of indirect alternates that you are
missing when you wrote the patch (and I am missing when I wrote this
response).
