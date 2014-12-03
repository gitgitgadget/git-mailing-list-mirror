From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC][PATCH] send-email: add --[no-]xmailer option
Date: Wed, 03 Dec 2014 09:39:43 -0800
Message-ID: <xmqqtx1ciqe8.fsf@gitster.dls.corp.google.com>
References: <20140324213814.GA1267@achilles.my.domain>
	<xmqqfvcwk6en.fsf@gitster.dls.corp.google.com>
	<xmqq388wk5q8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Luis Henriques <henrix@camandro.org>
X-From: git-owner@vger.kernel.org Wed Dec 03 18:39:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwDu3-0001WY-8A
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 18:39:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbaLCRjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 12:39:47 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62452 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751287AbaLCRjq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 12:39:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 855592208A;
	Wed,  3 Dec 2014 12:39:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oxglmt4aaBHFAneV+N9qvADW9pI=; b=mYeWpo
	QEjfxQh1t2oDybh9vV2+3JrL5p9ufnJw0ovy1cIQpbx7027SVCpo5lOkYP53EUpS
	mCcenBCRBM1Yv2PJ8qrEZrPl9gEzgMrhB1Z1im5HLuT6CdYHWDXRB9BucDC8SrJb
	J3w6iUBwDARrK4kQEiBH65owqpjw9OGeyGsTg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=REdZyYQwV82mXcji8aXs/0XY87squAiA
	RqSUVbejRsBOrxRkrCUgOO+b6pV7M9nDdZGbVcCGroGcaS74w79qTqCseE/Z1MGM
	anEprPptVf3DgwGEGdHxy5ePYOvRjChhGBaJPLoG02XrkiRvijFI+HayVI+6KX7i
	CEq0YrBgvs4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D13D22089;
	Wed,  3 Dec 2014 12:39:45 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F227422085;
	Wed,  3 Dec 2014 12:39:44 -0500 (EST)
In-Reply-To: <xmqq388wk5q8.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 03 Dec 2014 09:23:11 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5E9FAEF2-7B13-11E4-BC56-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260669>

Junio C Hamano <gitster@pobox.com> writes:

> @@ -177,8 +177,7 @@ sub format_2822_time {
>  my $multiedit;
>  my $editor;
>  
> -# Usage of X-Mailer email header
> -my $xmailer;
> +my $use_xmailer;

Just another small thing.  The version of "SQUASH???" commit I will
queue on 'pu' will have this next to where $annotate is defined.
