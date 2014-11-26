From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] pre-commit hook updates
Date: Wed, 26 Nov 2014 10:35:22 -0800
Message-ID: <xmqqfvd5res5.fsf@gitster.dls.corp.google.com>
References: <cover.1416953772.git.oystwa@gmail.com>
	<20141126045246.GD15252@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 26 19:35:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XthR4-0005iX-H6
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 19:35:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbaKZSf0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Nov 2014 13:35:26 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52459 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750736AbaKZSf0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Nov 2014 13:35:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B163210C3;
	Wed, 26 Nov 2014 13:35:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ZyvEW3MG9Wux
	Exz9bHfIUkOpEIc=; b=dwJHjnBz0w4nCWsBsdO7n/tWRIF+NryWpnThbBB0hV/Y
	4hLN/lBgwYXxFn9eGC1ESuZZQXYKZ2KmS2fvp29sNC3cLrgJnbDdgdBSUPeHToJG
	7Z4wOHA5PgNo7isTEGLZUUPQ7Sdnnc+TG3qJPQr4mCMvsw6QFTEJaMIjasQzFiw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=XBICD1
	yi+QDCg7hTmc8RCtrCe634yL1N+uwhbhiJg0j5fW5y6zkjapRR6MxQj03q2uRiS4
	U/llXtVZxsaURysbhg6fURg/SBnt0ppIisiWVQfUzp6CN+jDo8HdTHulJ3dPyWU6
	VaDlK3iZJHEMKRixhmKAPGIIs/UJthIVe0EH8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3210B210C2;
	Wed, 26 Nov 2014 13:35:25 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AAD6D210C1;
	Wed, 26 Nov 2014 13:35:23 -0500 (EST)
In-Reply-To: <20141126045246.GD15252@peff.net> (Jeff King's message of "Tue,
	25 Nov 2014 23:52:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FBC0C550-759A-11E4-90F3-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260289>

Jeff King <peff@peff.net> writes:

> On Tue, Nov 25, 2014 at 11:51:27PM +0100, =C3=98ystein Walle wrote:
>
>> I agree with Junio Hamano that it's better to provide no argument at=
 all
>> rather than an empty one. I also agree with Jeff King that "noamend"=
 is
>> better than an empty argument. I went with the second one since Jeff
>> seemed to get the last word :)
>
> I am not sure the last word counts for much. :) We'll see if Junio
> responds (there, or to your patch). I do not feel _too_ strongly eith=
er
> way, and I don't have much else to say besides what was said.

I _think_ "give only info that is necessary" is cleaner as an
interface in theory, but have two niggles myself:

 1. the hooks must do the "argument parsing" loop (you already
    mentioned this);

 2. the hooks cannot tell if the lack of "amending" argument is
    because the version of Git predates that "amending" hint
    support, or because the user action is a straight "commit" not
    an "commit --amend".

In any case, I do not have strong preference myself.
