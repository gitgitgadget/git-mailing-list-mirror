From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Fix relative path issues in recursive submodules.
Date: Thu, 31 Mar 2016 10:04:00 -0700
Message-ID: <xmqq7fgipojj.fsf@gitster.mtv.corp.google.com>
References: <1459383457-6848-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, norio.nomura@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 19:04:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alg0x-000077-6q
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 19:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756100AbcCaREG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 13:04:06 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:50501 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751728AbcCaREF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 13:04:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1FB6F516FC;
	Thu, 31 Mar 2016 13:04:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZSpBhMfesj3NtQ0LBOx5p5hc2do=; b=UfUrLm
	Vdu9fKiOBioVyEPPbx05zwSyxQMDbjAVJxN3nWoe6Wwba+FKDThY5fOuWUSNSYWy
	2XAN8UeHyz3ve9HtWzpai5/uFDqGpMONdNyiBA6qDc2fP2zq+ONt51zMDyNaXFZZ
	ylUtYdKUOUu0zqCHmbyNN11dDT2MaR1KVJjlk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZEwUlqyDhNjEzFgmoWkxa/MbboHFC3cB
	NxIxgmjXoTzJctbrBz9sBim6GEGGtDI49Hr4tc/seX7L/hJMUpu5b4Suzwx9HrA3
	ODSAIYBmVswDUPinPQk0ne2to7QxcbAItUniH2VJsjyThaCiyayC+AOAYKjX3srz
	qeot2hqqnbk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D3ECC516FA;
	Thu, 31 Mar 2016 13:04:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1F630516F7;
	Thu, 31 Mar 2016 13:04:02 -0400 (EDT)
In-Reply-To: <1459383457-6848-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Wed, 30 Mar 2016 17:17:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 914FB424-F762-11E5-BE3E-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290420>

Stefan Beller <sbeller@google.com> writes:

> It took me longer than expected to fix this bug.
>
> It comes with a test and minor refactoring and applies on top of
> origin/sb/submodule-helper, such that it can be merged into 2.7, 2.8 as well
> as master.
>
> Patch 1 is a test which fails; it has a similar layout as the
> real failing repository Norio Nomura pointed out, but simplified to the
> bare essentials for reproduction of the bug.
>
> Patch 2&3 are not strictly necessary for fixing the isseu, but it removes
> stupid code I wrote, so the resulting code looks a little better.
>
> Patch 4 fixes the issue by giving more information to relative_path,
> such that a relative path can be found in all cases.

There were some minor nits, but I saw nothing glaringly wrong to
break the topic.  Thanks for working on this.
