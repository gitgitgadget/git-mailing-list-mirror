From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fsck option to remove corrupt objects - why/why not?
Date: Thu, 16 Oct 2014 09:36:34 -0700
Message-ID: <xmqq8ukgug31.fsf@gitster.dls.corp.google.com>
References: <20141015234637.9B4FC781EFB@mail110.syd.optusnet.com.au>
	<543F0DAE.2050205@optusnet.com.au>
	<CALKQrgda8mVbqP5=Ag8juN9HMQp7iQ9eDJETfRJe1b0taAFGkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ben Aveling <bena.001@optusnet.com.au>,
	Git mailing list <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Oct 16 18:36:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xeo2m-0006tN-9d
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 18:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbaJPQgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2014 12:36:42 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50783 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751298AbaJPQgl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2014 12:36:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 93B5B14EDA;
	Thu, 16 Oct 2014 12:36:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RePn/MQo7B6VxBp6vVvlWZ4kEUY=; b=vozr/k
	Kffkc2gwdCPs/0e8oSMOVakqSTKY9Gt4Hit+ir7k6uIUyk7lQOssi9fWJ99FFNJb
	wtNIHcDsVmf0zIWl6LpHC6MPsBiOhOmrNMTytTf9WSGW27VJuGiDgwom+CzI4AXq
	5qpu9VcfYB1vvTD6RZnbHE/CuX4SAcdct/YSM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TD8ajMBRisScsB9nNchlmo6bGWawMH2P
	VKSR4dXt1YlwWUlX0T2/aWkmXujUudGtodX6UnjksEnSO5Efp8mlVoBSzMnasfTw
	AOESufSDP7SlkYB+tN/7nDLrGIu0rrPfD6uPee6ZtJrYnBDiFeQIlUia1KIqkIsk
	rzn5f0mm/Xo=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 893D414ED7;
	Thu, 16 Oct 2014 12:36:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 27B5814ED1;
	Thu, 16 Oct 2014 12:36:36 -0400 (EDT)
In-Reply-To: <CALKQrgda8mVbqP5=Ag8juN9HMQp7iQ9eDJETfRJe1b0taAFGkg@mail.gmail.com>
	(Johan Herland's message of "Thu, 16 Oct 2014 11:04:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 987981AC-5552-11E4-B7DD-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johan Herland <johan@herland.net> writes:

> I simply copied the packfile containing the good copy into the
> corrupted repo, and then ran a "git gc", which "happened" to use the
> good copy of the corrupted object and complete successfully (instead
> of barfing on the bad copy). The GC then removed the old
> (now-obsolete) packfiles, and thus the corruption was gone.
>
> However, exactly _why_ git happened to prefer the good copy in my
> copied packfile instead of the bad copy in the existing packfile, I do
> not know.

By design ;-)
