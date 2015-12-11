From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] notes: allow merging from arbitrary references
Date: Fri, 11 Dec 2015 11:47:22 -0800
Message-ID: <xmqqr3isepit.fsf@gitster.mtv.corp.google.com>
References: <1447432462-21192-1-git-send-email-jacob.e.keller@intel.com>
	<20151124224709.GA13691@sigill.intra.peff.net>
	<20151124234206.GA31949@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org,
	Mike Hommey <mh@glandium.org>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 11 20:47:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7TfH-00068O-8M
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 20:47:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753199AbbLKTrf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2015 14:47:35 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62240 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752625AbbLKTre (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2015 14:47:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 71C1A326BB;
	Fri, 11 Dec 2015 14:47:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XRlkAfVZGSCvfIfddNT+6+cq338=; b=m4Y8PJ
	dyyfiz2i+nn9GrMIFUkEz8bkfphaeu89P0acn4KQcApRgYafVgd0iNPWZFSEhViw
	RhXAV6cY31oIuy4i04lVUs9LTw28f5F+a5h4lgTUEjlzyzN7hbqOKVdcwaO18Ly7
	tbbT3Kd8MdZec/WL+zBTlv7dv44nyrZMb2oHs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QRgvcYstw/IjTXI/D88Fo4CPQ/0//AYq
	pZPG3eGxS0i8mW5Y20mUKczPCbMlW9HP32mSVyqh9fNHn6rIfKboCb5qHkyTsZ5o
	dI6xamawvWMd2vniNn+z+WPSlcz9vsbeGdWl1hIZ5XFE0EdU56d1UcML/zBFvgbZ
	f9mRIUAt5UQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 670CB326BA;
	Fri, 11 Dec 2015 14:47:33 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BDE9B326B9;
	Fri, 11 Dec 2015 14:47:32 -0500 (EST)
In-Reply-To: <20151124234206.GA31949@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 24 Nov 2015 18:42:06 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 051967D0-A040-11E5-8475-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282273>

Jeff King <peff@peff.net> writes:

> On Tue, Nov 24, 2015 at 05:47:09PM -0500, Jeff King wrote:
>
>> On Fri, Nov 13, 2015 at 08:34:22AM -0800, Jacob Keller wrote:
>> 
>> > ---
>> > I do not remember what version this was since it has been an age ago
>> > that I sent the previous code. This is mostly just a rebase onto current
>> > next. I believe I have covered everything previous reviewers noted.
>> 
>> Please keep topics branched from master where possible. And if not
>> possible, please indicate which topic in 'next' is required to build on.
>> 
>> We never merge 'next' itself, only individual topics from it. So I can't
>> just apply your patch on top of 'next'.
>> 
>> I did get it to apply on the current master with "am -3", but some tests
>> in t3310 seem to fail. Can you take a look?
>
> I just noticed v2, which I missed earlier. But the same complaints
> apply. :)

I tried to queue
<1447432462-21192-1-git-send-email-jacob.e.keller@intel.com> from
Nov 13 directly on top of 'master', and t3310 does seem to fail.

I'll discard the topic for now, expecting the resurrection sometime
later.
