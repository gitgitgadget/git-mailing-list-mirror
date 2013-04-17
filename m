From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Tue, 16 Apr 2013 21:44:57 -0700
Message-ID: <7vy5chhik6.fsf@alter.siamese.dyndns.org>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
 <CAMP44s2_wiNr4RaBOEnKnZzT4CF0qKK+bp+Lyi=Nfx3Q9ggqOQ@mail.gmail.com>
 <7vip3npet0.fsf@alter.siamese.dyndns.org>
 <CAMP44s3NE3yrQoa1nZXAgy3KFXGF56Ki8icJ2z2TDigzax0nWg@mail.gmail.com>
 <8761zm4wzg.fsf@linux-k42r.v.cablecom.net>
 <CAMP44s0a2VsPBMd9Vrrhwdw=SPp2HrvDdXZ9Dmzhr9A6T+Sz7w@mail.gmail.com>
 <CABURp0qGYG4T+t36=Us328YdLzy9KjBOWot2gSOk=FgCRUCLnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 06:45:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USKF1-0006ZS-8D
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 06:45:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754552Ab3DQEpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 00:45:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33723 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754341Ab3DQEpA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 00:45:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 834EC1158B;
	Wed, 17 Apr 2013 04:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=coi0XnEAEoYOrkPkj6d1maKQBHA=; b=Eclw4J
	CR8kAeaFWOvCKAZy0ufnPYyDTtTqtaPGVLpOUQT8+0Grxe3NZ4o+tpta7W4Z17xy
	EUTi/shJBI5vM+44NTx3D2PKLwqbAkiP0RPpT5Qa+2FEc+IpmY/wJPPti1Kb1OMM
	M+9ZroS4O/uQQdrb+MzPMwqvsQY9xwvu+2gFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I83Bvp++vu/r1FQ3VYLzBmKYn00vLJUm
	wS7zfRxf2FgSUraF8s0UvWuwsrHJex7GXS0WuscjUVcEii0EkN1Rnak/8zTMm1CS
	o39c8obSWa2QltfjBJo5EGDJWyAVmXgghwiNdxq7HhskXUnS3X/hblSdcYmsjttD
	/V5bmwRvT4w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7729011589;
	Wed, 17 Apr 2013 04:44:59 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E81D811583; Wed, 17 Apr
 2013 04:44:58 +0000 (UTC)
In-Reply-To: <CABURp0qGYG4T+t36=Us328YdLzy9KjBOWot2gSOk=FgCRUCLnQ@mail.gmail.com> (Phil
 Hord's message of "Tue, 16 Apr 2013 18:45:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8EFEEFEC-A719-11E2-AE62-CC48E7F0ECB6-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221503>

Phil Hord <phil.hord@gmail.com> writes:

> ...  Almost every time I bisect a regression
> in git.git, I find the commit message tells me exactly why the commit
> did what it did and what the expected result was.  I find this to be
> amazingly useful.
> ...
> Of course, 99% of the commit messages may never be useful to me or
> anyone else.  But we do not eschew them altogether.  The 1% I have to
> rely on are nearly always helpful and clear, and that is the part I
> care about.

It is nice to be appreciated for our efforts by somebody every once
in a while ;-)

Thanks.
