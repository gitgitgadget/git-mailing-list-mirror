From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2016, #04; Wed, 23)
Date: Thu, 24 Mar 2016 09:14:30 -0700
Message-ID: <xmqqlh57am55.fsf@gitster.mtv.corp.google.com>
References: <xmqqpoukc30t.fsf@gitster.mtv.corp.google.com>
	<54B6C1E1FE6A4BAEA07E97B7BA81EB01@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Mar 24 17:14:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj7uB-0006ag-8q
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 17:14:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754695AbcCXQOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 12:14:35 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:64769 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753902AbcCXQOe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 12:14:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6E1824B00E;
	Thu, 24 Mar 2016 12:14:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5RqlkKBeiZvXK4nZp/kMn3ZI/Y8=; b=pmF+7w
	ni8KN0sjbiU6ABv77hEDh3moa7oY5tx8TrvdcwY+PwautZ6ZP3f3a8X4f+5whXr8
	93xDpW7pI4HILgmkXIKg2dWnlzkU2ObWZg4Prmu/B9f0CFKIFCPLrrb7TUL3nJKn
	fPlfa6E29kD4p9clLHUDUof7lg/RwyYjcznOM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nBf2MhI9JZqjhKSJstZ1f2eTlHAmNx/a
	OFetW+OhKFXplCEb2ZnJ0e1Aok9yzUpaLOVEX7FTkM95n5Vcab6YsGgud6es5LEH
	KrYZJ9L2S2k54mxizGHvLkG1Be78eaUO0/dlxs82DyH6Z02+as+2BDvObVMjfw2i
	I4D/t0Gsc+8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 64D594B00D;
	Thu, 24 Mar 2016 12:14:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BFF7B4B00C;
	Thu, 24 Mar 2016 12:14:31 -0400 (EDT)
In-Reply-To: <54B6C1E1FE6A4BAEA07E97B7BA81EB01@PhilipOakley> (Philip Oakley's
	message of "Thu, 24 Mar 2016 07:42:07 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7DF58598-F1DB-11E5-9BA3-EB7E6AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289756>

"Philip Oakley" <philipoakley@iee.org> writes:

>>
>> The beginning of "split bundle", which could be one of the
>> ingredients to allow "git clone" traffic off of the core server
>> network to CDN.
>>
> ...
> Hi Junio,
>
> I think there may be a concept clash between the ideals of a
> sneakernet bundle' and the 'resumable clone'.

Notice the "could" above ;-)

Read the original thread and notice that the inclination is for the
first one the primary "clone priming" mechanism would likely to be a
packfile, not a bundle, even though use of "bundle" is not ruled out.
