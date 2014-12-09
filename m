From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFD/PATCH] Documentation: mention category
Date: Tue, 09 Dec 2014 12:26:58 -0800
Message-ID: <xmqqiohklgbx.fsf@gitster.dls.corp.google.com>
References: <538d1a10bda3793ea10ec6f7de43de371d17e709.1418123780.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Dec 09 21:27:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyRNG-0006yG-7u
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 21:27:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbaLIU1E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 15:27:04 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50745 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750857AbaLIU1C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 15:27:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EF667232BA;
	Tue,  9 Dec 2014 15:27:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w5BKKIVgfaiFhOFjF8stlTosmsE=; b=bv2Zh1
	EYvOXspZ8lYTr9mSqkSCqeaCcH+AKxpCGKw7SAA6SQU7Rt37/jr9AoSyCwTgE8ma
	8XNWi2CLQAwGWFEiNB3etzALoaU92tBZXflRMhxrpNZM08P2UmlCHrw690oEwKrX
	AK0216NRmLigah6BUFMiUhtWav0O8ps2W+EYI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VOaAeXPTG5O9W1jBY84K4d/g7xgk9pY0
	Fho2/RH7IUq3d6W80lFPApSvfgaYYSsruw8+Gz4gIsfoTxOVpnZQC2gEFgJV6Dg5
	bqAZ3b4npaSdMfe7NErZkeRseV5rP4LuWkBlo+c2QgsduBhzUQtpriJSTr8AYqRv
	MsyeJg7nHCY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D50B1232B9;
	Tue,  9 Dec 2014 15:27:00 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2778A232B7;
	Tue,  9 Dec 2014 15:27:00 -0500 (EST)
In-Reply-To: <538d1a10bda3793ea10ec6f7de43de371d17e709.1418123780.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Tue, 9 Dec 2014 12:21:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BA868E20-7FE1-11E4-AAA3-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261160>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Rather than changing git-foo.txt, we could do the substitution magic
> from Documentation/Makefile, of course, to keep man pages and command-list
> in sync. Although this would keep me from submitting the final series
> with 1 patch per file :)

I do not get that smiley.  Are you saying that these noisy patches
add to your karma points?

> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index 9631526..b6a8bc6 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -13,6 +13,10 @@ SYNOPSIS
>  	  [--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing]
>  	  [--] [<pathspec>...]
>  
> +CATEGORY
> +--------
> +Main user interface command (porcelain)
> +
>  DESCRIPTION
>  -----------

While I do not have objection to adding this information, I have
a few problems with the execution:

 - These four lines at the very beginning is a precious real
   estate.  The new reader would not benefit from the distinction
   before reading the first paragraph of description to learn what
   it does and what it is for anyway.  Move it much later, perhaps
   at the end.

 - A phrase "Main user interface command" to a new user does not
   help very much if it does not tell enough what that phrase really
   means (e.g. you should not be using it for scripting).  Extend
   the description more, after moving it to the end.

 - As you said, this should be done in a way to keep the two sources
   of information in sync.  Either add these from command-list, or
   generate command-list from these.
