From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/2] submodule init: fail gracefully with a missing .gitmodules file
Date: Fri, 29 Apr 2016 10:06:51 -0700
Message-ID: <xmqq4mak1h04.fsf@gitster.mtv.corp.google.com>
References: <1461873766-14703-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 19:07:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awBsa-00026y-0O
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 19:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356AbcD2RG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 13:06:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55697 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752272AbcD2RGz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 13:06:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EBC26151F6;
	Fri, 29 Apr 2016 13:06:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=O1zTsX6IOBvo918gQ7iyommE8Mc=; b=E9q1ZA
	p+QkHxUvF7bSWLbLgJufrnbWmfzFZ3laJZsKvZ4s0Zj51AzpUVVpTKyObwmos2Bt
	4b56cv1JQLw9khYnLPtx37InH48ZI7Zn6PmSCIAY9NJ0JKLX/SmMdbizDRa2/8Zg
	i9b3m6VQz1X2G4F+wxJiX3lilO/CdfF3Uh/f0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Op1VCMny0VY98aBoBzf7t2LqMqfB+3Yl
	0+mpQZJcDUDnxgi1doPDDY7bJKKyrEc0kpM5O1KkBotWa4P4Mvtu+EDMnGLsXdUv
	25i8VU37zEI1eSDWm+HCfSPZkjQs1i1RoXO3hivdIp9II8GkvKFoVzDoze0tnRjE
	VeZAPRPaQNs=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D3517151F5;
	Fri, 29 Apr 2016 13:06:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 28234151F4;
	Fri, 29 Apr 2016 13:06:53 -0400 (EDT)
In-Reply-To: <1461873766-14703-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Thu, 28 Apr 2016 13:02:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C53C7516-0E2C-11E6-9ECC-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293026>

Stefan Beller <sbeller@google.com> writes:

> When there is no .gitmodules file availabe to initialize a submodule
> from, `submodule_from_path` just returns NULL. We need to check for
> that and abort gracefully. When `submodule init` was implemented in shell,
> a missing .gitmodules file would result in an error message
>
>     No url found for submodule path '%s' in .gitmodules
>
> Replicate that error message for now.

Good to start from a faithful conversion.  Thanks for adding a test,
too.

Will queue.
