From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-reflog 70 minutes at 100% cpu and counting
Date: Mon, 14 Dec 2009 16:36:50 -0800
Message-ID: <7vk4wpax99.fsf@alter.siamese.dyndns.org>
References: <1260822484.9379.53.camel@localhost>
 <20091214211142.GC9364@coredump.intra.peff.net>
 <1260825629.9379.56.camel@localhost>
 <20091214212343.GA11131@coredump.intra.peff.net>
 <1260827790.9379.59.camel@localhost>
 <alpine.LFD.2.00.0912141924030.23173@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Paris <eparis@redhat.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Dec 15 01:37:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKLPd-00025d-U8
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 01:37:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692AbZLOAhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 19:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbZLOAhG
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 19:37:06 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50635 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbZLOAhF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 19:37:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3FDD0A7F16;
	Mon, 14 Dec 2009 19:37:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N53peW5zV4ENk65bygrJkiAXBn4=; b=Ju2kHA
	VZzEfGVKsFdf5pqejDW6T4RMeyWSDTSE8+OZ5sMoKBEkh7m1fBMOnoglhgA1DRql
	FbNJLBKFdZV3EQ/ql/YfjQ5wg9wjtVFEYHPIX4c1ALG+z39TqPOoyiavm1eF5zrr
	WpMHui/VCwprGUfOwRixs27tO5qqZOm4zcONc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yfqZGuYamh88SivNBBvUF2Y5W121KgDf
	nybtjwCb9i4jADlgh6i8XM5yNOy/QSe4WA1bMBwZCvQef4gK68GDfppfXNNoXryj
	J9aahJBQ5lLwxOz3PmzJ7xGILFPOiu0jKW0jxRpFY9RhSjmKgJ3vBo8a7l33bSq0
	gNPxDJv0KEg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C187BA7F15;
	Mon, 14 Dec 2009 19:36:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EB6DAA7F14; Mon, 14 Dec 2009
 19:36:51 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.0912141924030.23173@xanadu.home> (Nicolas
 Pitre's message of "Mon\, 14 Dec 2009 19\:26\:33 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F38B9DDA-E911-11DE-8EFC-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135258>

Nicolas Pitre <nico@fluxnic.net> writes:

> On Mon, 14 Dec 2009, Eric Paris wrote:
>
>> On Mon, 2009-12-14 at 16:23 -0500, Jeff King wrote:
>> > On Mon, Dec 14, 2009 at 04:20:29PM -0500, Eric Paris wrote:
>> > 
>> > > Updated to git-1.6.5.3-1 from Fedora rawhide and still git reflog ran
>> > > for >5 minutes at 100% cpu (I killed it, it didn't finish)
>> > > 
>> > > I'm pushing a copy of the whole repo (all 1.9G after bzip compression)
>> > > to
>> > > 
>> > > http://people.redhat.com/~eparis/git-tar/
>> > 
>> > Wowzers, that's big. Can you send just what's in .git?
>> 
>> So I zipped up just .git   1.2G.  I did a make clean and zipped up the
>> whole repo  1.3G.
>> 
>> Just started pushing the 1.3G file.
>> 
>> Maybe having a .git directory that large is the problem?
>
> Shouldn't be, unless your repo is really badly packed.
>
> What's the output of 'git count-objects -v' ?

Didn't somebody say that the trace hints an infinite loop not "slow
because of bad packing"?
