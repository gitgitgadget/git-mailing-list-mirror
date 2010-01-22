From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Remove diff machinery dependency from read-cache
Date: Thu, 21 Jan 2010 19:50:21 -0800
Message-ID: <7vzl46bxxe.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.00.1001211119130.13231@localhost.localdomain>
 <7vljfrp6g2.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001211215080.13231@localhost.localdomain>
 <alpine.LFD.2.00.1001211355500.13231@localhost.localdomain>
 <alpine.LFD.2.00.1001211515470.13231@localhost.localdomain>
 <7v636vj7c2.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1001220158381.4985@pacific.mpi-cbg.de>
 <7v3a1zhrzz.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1001220242170.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 22 04:50:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYAXm-0000MO-1v
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 04:50:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410Ab0AVDuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 22:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275Ab0AVDuf
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 22:50:35 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55077 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244Ab0AVDue (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 22:50:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 69DBF92CB1;
	Thu, 21 Jan 2010 22:50:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=biX8FMORKnk0jQaRHDzF5Fo2qQA=; b=GVv3f5
	v+r6sUkT7SZ2XX3puWwJKExsUxBDUqZGoRevGYyUeOX6OFp6vdSFOP5vArDGuEzW
	ojFdu27u+SpCREWAuFMmxK7yfUlTbxfMd4G0nzMLQK0aMJdUia9ehXhJqzsA37Zs
	Exy2g99MFjkeuXv5JgahxhOuj+V1JXSrU0WK8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GXSybGbHt96Ebl3i3rZZ6nIRvZ2C+l/U
	U2Kr2ImM0ft0zQD/fluNbCJ/J5THPlnuWXpttFPzcRhzKN22Ft8abLzWUNO/Wpv3
	EszJHo1IkgPhdPmXvCzJlGQGP/9nW7uaEA5brh1Rm29p8yZe5xA7S0teIPBg6WHA
	Mb3FhhJAZrM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 22F7992CAD;
	Thu, 21 Jan 2010 22:50:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3FFBF92CAA; Thu, 21 Jan
 2010 22:50:23 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1001220242170.4985@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Fri\, 22 Jan 2010 02\:43\:30 +0100
 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 478FF826-0709-11DF-8C94-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137731>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>>     In the meantime, I think applying this patch is the right thing to do.
>> 
>>     -- >8 --
>>     Subject: merge-recursive: do not return NULL only to cause segfault
>> 
>> would help us?
>
> Sorry, I cannot have a look at this now.

That's fine; I know you've been busy outside git (you've kept saying that
for past several months), and I didn't really expect you to be single
handedly fixing or rewriting merge-recursive.  "In the meantime" patch is
not about attempting to "fix" anything deep inside the guts of it; it is
merely to die() with messages in a function that returned NULL when the
caller never expected to see NULL and caused segfault.

> But in the long run, I think that it gets tiring to chase all kinds of 
> weird interactions between unpack_trees(), the rename detection and the 
> recursive merge.

I don't think there is any interaction; as Tim Olsen reported, "resolve"
that uses the same unpack_trees() merges the trees just fine.  The bug
seems to be all inside merge_recursive().
