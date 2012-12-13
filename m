From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/7] remote-bzr: update working tree
Date: Thu, 13 Dec 2012 15:47:40 -0800
Message-ID: <7vobhxwm3n.fsf@alter.siamese.dyndns.org>
References: <1352643598-8500-1-git-send-email-felipe.contreras@gmail.com>
 <1352643598-8500-5-git-send-email-felipe.contreras@gmail.com>
 <7vtxs9vda3.fsf@alter.siamese.dyndns.org>
 <CAMP44s1ZdMK+0_pP3qkZUepOvkfMaXeY2BV0MFu5YOSV=40Dcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 00:48:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjIVU-0004FB-EB
	for gcvg-git-2@plane.gmane.org; Fri, 14 Dec 2012 00:48:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755353Ab2LMXrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2012 18:47:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53649 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754757Ab2LMXrm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2012 18:47:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81901A1B3;
	Thu, 13 Dec 2012 18:47:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8DOGmUqs1cO817sSBEeqjGlPqNQ=; b=Fz/+E+
	jUncNB87p1D5dFvJwoM0D5J2B7ppAdcOQi/Xm0RmUsmkhA0wLbH4mrDtTGOk3rUx
	alW1EKs01Q/KBRwwppf6QRXAerEk7Y+Z8mUuZMYI8Xi/bsZ8brHoMLXxiB6BvYeE
	zuGJNqET+m6muv8OjNNDJfCILbRygtS1M/ckY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AKxuoC+LcZFISw05b10Vnq3gqX6lE2PL
	GVE9VBv3nBUdUVLm0uiI8Ani2nyBRzoI0+jEUSXBHWJ0iMjmTzTkZzVPmPDvAYGw
	rc4bUd0N4xJjS9XM8Fj1Edd8r5b5OytM5vN9zdkYiFQvZct00WYyZUvamHtpPiQ4
	xQEUuLIy4Tg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66EF6A1B2;
	Thu, 13 Dec 2012 18:47:42 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BFD50A1B0; Thu, 13 Dec 2012
 18:47:41 -0500 (EST)
In-Reply-To: <CAMP44s1ZdMK+0_pP3qkZUepOvkfMaXeY2BV0MFu5YOSV=40Dcw@mail.gmail.com> (Felipe
 Contreras's message of "Thu, 13 Dec 2012 16:08:54 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7BFDE5B6-457F-11E2-A498-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211478>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Wed, Nov 28, 2012 at 11:38 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>> ---
>>>  contrib/remote-helpers/git-remote-bzr | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
>>> index 2c05f35..5b89a05 100755
>>> --- a/contrib/remote-helpers/git-remote-bzr
>>> +++ b/contrib/remote-helpers/git-remote-bzr
>>> @@ -571,6 +571,8 @@ def do_export(parser):
>>>              repo.generate_revision_history(revid, marks.get_tip('master'))
>>>              revno, revid = repo.last_revision_info()
>>>              peer.import_last_revision_info_and_tags(repo, revno, revid)
>>> +            wt = peer.bzrdir.open_workingtree()
>>> +            wt.update()
>>>          print "ok %s" % ref
>>>      print
>>
>> Shouldn't this be squashed as part of one of the earlier patches?
>> The split between 1/7 (import first) and 2/7 (then support export)
>> makes sense, but this one looks more like "oops, we forgot to touch
>> the working tree while updating the history in the previous steps
>> and here is a fix" to me.
>
> Perhaps. It's not really clear if we should update the working tree at
> all. A 'git push' doesn't update the working directory on the remote,
> but a 'bzr push' does. I thought it was better to leave this
> distinction clear, in case this becomes an issue later on.

If you explained that in the log message, then we would have avoided
this exchange, and more importantly, if you had a in-code comment
there, it may help people who later want to add a knob to leave the
working tree intact.  The seed you sow now to help others, who may
be less skillful and knowledgeable than you are, will help the
project in the longer term.

Thanks.  I don't mind rephrasing that four lines and amend the
log message of what I have in 'pu', if that is what you want.
