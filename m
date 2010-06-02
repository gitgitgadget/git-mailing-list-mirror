From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Libgit2 on the Summer of Code
Date: Wed, 02 Jun 2010 11:42:21 -0700
Message-ID: <7vvda1cm42.fsf@alter.siamese.dyndns.org>
References: <AANLkTil-M3kQGbRZIacItlwr37Lf3lso7FspftLr43_F@mail.gmail.com>
 <20100527174636.GB9909@LK-Perkele-V2.elisa-laajakaista.fi>
 <20100527180554.GM16470@spearce.org>
 <AANLkTilE7UI3zg180U9GCB6DsByu3B9pwlG6xIyR8uiG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	srabbelier@gmail.com
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 02 20:42:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJstp-00055b-Hl
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 20:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758270Ab0FBSmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 14:42:40 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58856 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756370Ab0FBSmj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 14:42:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 92A3EB8A3B;
	Wed,  2 Jun 2010 14:42:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WFD6XbePhzVpOx22Aqkx6zdNnFk=; b=OPzaMT
	Jw9xVbABhAbkLOjhwIybPvMJZp4nvK/TO7DTIYYzLQllhBJQZ7mb6E6zweeP6cgh
	uoazYcYcKTLWAgEPSWATvaOrx0t/yWNTboZnhxY44975j1i9KqlkZSFCaDU7KUN7
	QkscRA9RC+lRz8VDE+Y+LpCoZr8DtwD2d0t5k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZNw7NCKjwVZ1xJ0QP6qQUw0ZAud9HXig
	5vGt/9fNvk4ZHwIeLg+Qg127L/JWLqS17/fDFbgTaSXoqErLdWmKzEBIcD/IXy1S
	wWIHL47/LosoEN9IRLj66ISPj5cGgJ2/PigigKBaIR7i1R6jOvZlydiWAlpq1Xwp
	uQVdwaq1HeU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 22E02B8A2E;
	Wed,  2 Jun 2010 14:42:30 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 00E40B8A2D; Wed,  2 Jun
 2010 14:42:22 -0400 (EDT)
In-Reply-To: <AANLkTilE7UI3zg180U9GCB6DsByu3B9pwlG6xIyR8uiG@mail.gmail.com>
 (Alex Riesen's message of "Thu\, 27 May 2010 20\:22\:29 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 99465028-6E76-11DF-ADF2-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148269>

Alex Riesen <raa.lkml@gmail.com> writes:

> On Thu, May 27, 2010 at 20:05, Shawn O. Pearce <spearce@spearce.org> wrote:
>> Ilari Liusvaara <ilari.liusvaara@elisanet.fi> wrote:
>>> * Where algorithm in git_revpool_table__hash() is from? Since it appears to
>>> hash binary object IDs, wouldn't just simple sum/xor over words be sufficient
>>> (all SHA-1 output bits are very nearly independent). Or do you need to be
>>> compatible with some other implementation (doesn't appear so, because hash
>>> is computed differently depending on endianess)?
>>
>> If you need a hash value for a SHA-1, why not just cast the unsigned
>> char* to unsigned int* and load the first int as the hash code?
>> The output of SHA-1 is pretty evenly distributed, using the first
>> few bytes as an int should yield a sufficient distribution throughout
>> the hashtable.
>
> Just make sure the SHA1 data are properly aligned for your platform

Also I'd prefer to see the code watch out for reproducibility across
platforms with different endianness and integer size.
