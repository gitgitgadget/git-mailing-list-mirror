From: Junio C Hamano <gitster@pobox.com>
Subject: Re: show refs points to a commit
Date: Fri, 08 Jun 2012 13:03:03 -0700
Message-ID: <7v4nqld11k.fsf@alter.siamese.dyndns.org>
References: <CAN0XMO+G6K0FZgu35OuuqGEp322vLpakXHXBTPpUQmoex68srA@mail.gmail.com>
 <4FD256CC.5010801@lyx.org>
 <CAN0XMO+FpCWgf96ffZ0qd7TNEmdBXicvvk23fnXBaTK_7weV-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Vincent van Ravesteijn <vfr@lyx.org>, git <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 22:03:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd5PM-00036R-D0
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 22:03:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758598Ab2FHUDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 16:03:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48284 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756834Ab2FHUDG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 16:03:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D50A8789;
	Fri,  8 Jun 2012 16:03:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hy3Qf+pIZLIwpySDz2jZjxJigi0=; b=qBRxsS
	NiI8gti8XOqTAnHABgwUHd8k0qzgCvGdLNXi3v9cN+iaaHwdAQ+0bb9UMpdqCDIs
	V3gnS3aD0DEVwRwQMgQ1OWpynTALM/brJm7yKf2jaS/cQEva2gDskUuUMSSwAtUu
	ZO2Rs0b6TeVfi01CwdcvVUaPNBID/zAIjJyuw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xpqJJTf4cpJXxrExc0TptEVO4kYCiFiW
	8/Ky9r6KhL4UhdyWaxUQ9y5sz3bC8gdCk6CEFLCTuM+cBgBK66vywdQWgSK4cVHC
	qgTOh80WvAhZ5qQ859gmQTbN34m9xi41Rf5GgJPk5+9ybCJf+M51p/q5TUV656Qd
	7ZIZpQi5W9Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 841688787;
	Fri,  8 Jun 2012 16:03:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 134F78786; Fri,  8 Jun 2012
 16:03:04 -0400 (EDT)
In-Reply-To: <CAN0XMO+FpCWgf96ffZ0qd7TNEmdBXicvvk23fnXBaTK_7weV-g@mail.gmail.com> (Ralf
 Thielow's message of "Fri, 8 Jun 2012 21:51:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F597366C-B1A4-11E1-B992-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199525>

Ralf Thielow <ralf.thielow@googlemail.com> writes:

> On Fri, Jun 8, 2012 at 9:47 PM, Vincent van Ravesteijn <vfr@lyx.org> wrote:
>> Is this what you mean ?
>>
>> $ git rev-parse master
>> f623ca1cae600e97cb0b38131fdd33e4fb669cf8
>> $ git name-rev f623ca1cae600
>> f623ca1cae600 master
>> $ git name-rev --refs=refs/heads/* f344333cd
>> f344333cd master~10
>>
>
> I just want to know what's the refs where
> the *tip* points to my specified commit.

"git for-each-ref" gives the mapping from the tip of your refs to
object names.  We do not keep and give reverse mapping but there
should be enough information in for-each-refs output to get the
information yourself, I think.
