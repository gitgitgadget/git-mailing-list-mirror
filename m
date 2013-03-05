From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Extend runtime prefix computation
Date: Tue, 05 Mar 2013 08:13:50 -0800
Message-ID: <7vd2vdvn7l.fsf@alter.siamese.dyndns.org>
References: <20121127163004.GC7499@science-computing.de>
 <20130305115837.GD21473@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Weiser <M.Weiser@science-computing.de>
X-From: git-owner@vger.kernel.org Tue Mar 05 17:14:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCuVP-0001SC-52
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 17:14:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756235Ab3CEQNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 11:13:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50544 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751792Ab3CEQNx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 11:13:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0E8DA99E;
	Tue,  5 Mar 2013 11:13:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4QNQRYpojnp+9ad/c3rlpNLtXus=; b=Kxgf38
	kvPXlXTfd46PaF5KAQIHrsLTp0sNPhUeOp7kXCDe+0O2b4AFwg8yHLxcPvE5rL/B
	O1Txe/fUZjNl7UGg2S3e1gW2MLYNuKyax0IPyFQRE0Dq5HjfDaRjVyt2pI3qRHDG
	lPUVQwo9rtpAX7choHlHe2Et64SnIcM6KvMzw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ShH0w/7yhxytnM8HfrmCYFQwnQnxR6EL
	eSlbjTmVC0skmA05MpapycDQYChDiAWPFH7uU9o3KqWs460VcilKMQlMuhjbo3b+
	exwlapXWiFwjd76CIPkGZZSJBaQGU8jDMftyuRw4NGkGw1nN52lU39kU89fUTXkq
	N83jWQN8qL0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 956B5A99D;
	Tue,  5 Mar 2013 11:13:52 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 159E8A99A; Tue,  5 Mar 2013
 11:13:51 -0500 (EST)
In-Reply-To: <20130305115837.GD21473@science-computing.de> (Michael Weiser's
 message of "Tue, 5 Mar 2013 12:58:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ABB3713E-85AF-11E2-81CD-2F862E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217459>

Michael Weiser <M.Weiser@science-computing.de> writes:

> On Tue, Nov 27, 2012 at 05:30:04PM +0100, Michael Weiser wrote:
>
>> Support determining the binaries' installation path at runtime even if
>> called without any path components (i.e. via search path). Implement
>> fallback to compiled-in prefix if determination fails or is impossible.
>
> I see this hasn't made it into git, yet. Is there any reason?

Most likely nobody was interested.

The default for any change is not to include it.  Is there any
reason why we want this change?
