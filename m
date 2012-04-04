From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] Prefix-compress on-disk index entries
Date: Wed, 04 Apr 2012 08:33:37 -0700
Message-ID: <7v7gxvbjfy.fsf@alter.siamese.dyndns.org>
References: <1333493596-14202-1-git-send-email-gitster@pobox.com>
 <CAFfmPPOqb8Kn-LERyiLKL838DKw=X6=CTV1x0s8coPgAvNLUdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 17:33:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFSDS-0000yl-PM
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 17:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756788Ab2DDPdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 11:33:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63649 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756311Ab2DDPdl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 11:33:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A923264BF;
	Wed,  4 Apr 2012 11:33:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nMzDtS5EZpdFIYOmNDKMUvSoygw=; b=LfYmlr
	M8giphsjamSsX/Wmj/iNVweJIBpMjbUV7mvE8r3x4v4uFdWGvY0IM/TNju3ZAS/t
	YAYLDjJJE9icNloH1qd9t4ZPSWFMTCfLVy5vvdWmfu12E7k/IuFonUb8WDKXbmyM
	hWm7GSgJPMBfemQZ8xTudxPs+qvrf24HNBW9s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cZ9mOVN9brHDNePRECYKoCoBHWykXV+N
	vry8B5RTbjRS0PfugNMXFAPH2hxFWk8dGCPMYuF6tllwzD6pYt/3xlGdoi11YSXc
	5Q9/I6cBmSzljjOloyOUMYlYVC4MwWwunP3ed0O2P71OhHLfnODjX++QysODTZnj
	hMHVZ1dVGU8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A070C64BE;
	Wed,  4 Apr 2012 11:33:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3EFD364BB; Wed,  4 Apr 2012
 11:33:39 -0400 (EDT)
In-Reply-To: <CAFfmPPOqb8Kn-LERyiLKL838DKw=X6=CTV1x0s8coPgAvNLUdw@mail.gmail.com> (David
 Barr's message of "Wed, 4 Apr 2012 11:44:24 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8D28E8F8-7E6B-11E1-8B35-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194701>

David Barr <davidbarr@google.com> writes:

> As I am hacking on WebKit daily, I'll try out this series and give feedback.

Thanks; the write-out codepath needs to learn to keep the format of the
index it originally read from when there is no preferred format defined, I
think, as I do not think core.indexformat configuration is particularly a
good idea, by the way.
