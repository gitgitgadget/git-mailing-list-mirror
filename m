From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/4] t5541-http-push: add test for chunked
Date: Wed, 04 May 2011 13:28:37 -0700
Message-ID: <7vmxj2dxca.fsf@alter.siamese.dyndns.org>
References: <1304503896-5988-2-git-send-email-rctay89@gmail.com>
 <1304437649-7052-1-git-send-email-rctay89@gmail.com>
 <1304503896-5988-1-git-send-email-rctay89@gmail.com>
 <1304529590-1032-1-git-send-email-rctay89@gmail.com>
 <7vr58ee261.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dan McGee <dpmcgee@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 04 22:28:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHigs-0004PT-2l
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 22:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755500Ab1EDU2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 16:28:53 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54312 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327Ab1EDU2w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 16:28:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 98A6A5F2C;
	Wed,  4 May 2011 16:30:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/3yz2GFkV+r664VgSVjZ2J8Dt78=; b=wjstT4
	ldLkcL+mqQW7itrOqGrj+j/H8QPm3nxGn6fFHa2YrIkJNaAz2wUjgde6RrPD/U2I
	d37n+SA/8sbeQkGJL0PORmHpOUlvcvGp+hYlTXrs4r/E+Hjrtq4nH74nyULizxCS
	t4HyFQfxayZppBtsLJqrqONCXvDPkT3j1Sx/4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K/Tr965opftZdqPDB/2GWWzQV1v5FiBQ
	I3jMRaYjCk0NxWDSIJmRsUtv9NjEr7hkQ9SgmgmMebu9/MMv8efHjZjd++HRGXux
	ZiiDjdpHjVxYHDgm3M/DvRlXgqTPKwEBTSuw/Jzk+Thp/IB2izDQP5nWZdrrEqXt
	gEg7mzdjBFI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 569105F2B;
	Wed,  4 May 2011 16:30:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C94685F2A; Wed,  4 May 2011
 16:30:43 -0400 (EDT)
In-Reply-To: <7vr58ee261.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 04 May 2011 11:44:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 66759A26-768D-11E0-BA28-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172766>

Junio C Hamano <gitster@pobox.com> writes:

> By the way, the "(chunked) test" is failing for me, with
>
>   Pushing to http://127.0.0.1:5541/smart/test_repo.git
>   POST git-receive-pack (chunked)
>   POST git-receive-pack (chunked)
>   POST git-receive-pack (chunked)
>   fatal: The remote end hung up unexpectedly
>   fatal: The remote end hung up unexpectedly
>
> in trash/test_repo_clone/err; sometimes with two POSTs and sometimes with
> three POSTs before we get the "fatal:".

Sorry.  False alarm.
