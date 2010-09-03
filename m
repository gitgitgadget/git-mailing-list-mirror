From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Fri, 03 Sep 2010 10:12:29 -0700
Message-ID: <7voccezr7m.fsf@alter.siamese.dyndns.org>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
 <AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
 <AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
 <4C7FC3DC.3060907@gmail.com>
 <AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
 <alpine.LFD.2.00.1009021249510.19366@xanadu.home>
 <AANLkTinFPxsY6frVnga8u15aovQarfWreBYJfri6ywoK@mail.gmail.com>
 <alpine.LFD.2.00.1009021624170.19366@xanadu.home>
 <B757A854-C7BF-4CBF-9132-91D205344606@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	git <git@vger.kernel.org>
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Fri Sep 03 19:12:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrZok-0006Eg-Ty
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 19:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756543Ab0ICRMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Sep 2010 13:12:41 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58885 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756290Ab0ICRMk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Sep 2010 13:12:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 92013D30C4;
	Fri,  3 Sep 2010 13:12:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5lGTFmmUAzhW4Pd+snSm/EUd8RE=; b=VcCOrX
	W2z8DcC5z5kgx/bw5hPCeXtFVohMS/RHl1zDo10TDfqEK8GWcHJXjZHhXYdwTYoV
	EbqXHI66fbN59ztMWfibVB4vgeo/8AT2TlHKDBCFTNOPtJdr8KbYkSx9oao0c8ne
	op/AmHYmsuNA+mwMyPxDt5ig239tGjSPGWA5k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HThhZkXnZtVzV5ZfLWjliYzGy9EPRGGr
	c/5rES6h5ojXv5QPnisXXyx6LUoUw4dBBGepKitvQrGPUIajW5aM8ya4TxQaQmW2
	kwWVFWF8tVoRvx8MXCv8ItRG1jumekfkdLoWtCt0IGaYP9+Nk2Jwr76JtooAmM/t
	uqlXHoFVldE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F237D30C3;
	Fri,  3 Sep 2010 13:12:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D001D30BB; Fri,  3 Sep
 2010 13:12:31 -0400 (EDT)
In-Reply-To: <B757A854-C7BF-4CBF-9132-91D205344606@mit.edu> (Theodore Tso's
 message of "Fri\, 3 Sep 2010 06\:37\:12 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 72AE6576-B77E-11DF-8F63-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155252>

Theodore Tso <tytso@MIT.EDU> writes:

> ...  So people who are willing
> to participate as part of the peer2peer network can download the
> instructions for how to make the canonical pack once a month, and use it
> to create the canonical pack.  If the "Gittorrent master" has spent a
> lot of time to carefully compute the most efficient set of delta
> pairings, they will get the slight benefit of a more efficient pack
> which they could use instead of th eir local one without having to use
> large values of --window and --depth to "git repack".

Hmm, is the idea essentially to tell people "Here is a snapshot of Linus
repository as of a few weeks ago, carefully repacked.  Instead of running
"git clone" yourself, please bootstrap your repository by copying it over
bittorrent and then "git pull" to update it"?
