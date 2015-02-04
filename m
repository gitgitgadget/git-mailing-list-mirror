From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Invalid responses to 8bit encoding and In-Reply-To questions
Date: Wed, 04 Feb 2015 10:34:56 -0800
Message-ID: <xmqqa90to78v.fsf@gitster.dls.corp.google.com>
References: <CAMuHMdWbHMPEwkYvzKzzc6L0T8ufk62DGS2sZ1w1BthL1kAZWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
X-From: git-owner@vger.kernel.org Wed Feb 04 19:35:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJ4n8-00059A-Er
	for gcvg-git-2@plane.gmane.org; Wed, 04 Feb 2015 19:35:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161874AbbBDSfB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2015 13:35:01 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59735 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161871AbbBDSe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2015 13:34:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BD632344E0;
	Wed,  4 Feb 2015 13:34:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iMeZVMTJMQFlyyp8BH++6gcMj6U=; b=jDUo0Q
	YyhUnB0H63TQ8kKKgRSOwBfugJts0Erd18s3VKIdXSHVQO0PtjI8+eUp+11PrTZz
	fXoJJLDRd4GFuryqWySFBivtnP7cW0vx20INR835OV9/n5WtQOFkZOsrjpRqhwoM
	h5SSr7dnMoRCYztxw9ceaZKh4As4HI8R7ZLU4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j28Qeu4Ci8+ToEaelxv2UE0HEgwcJrtB
	6ozFBlLCii3gGXAWHZm2zx01RKRjR8M/ozm7wtUhEmMFnzf1Etg7l28q9DJj6BOO
	Fs3YPwEtV7eVcUQ0GcBWhh9l5BZED0zwCOy3aRx36NZJvFPEhD8M6cTJ7kuXpLYr
	byGhe3ulBDk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B46AF344DF;
	Wed,  4 Feb 2015 13:34:57 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3B198344DD;
	Wed,  4 Feb 2015 13:34:57 -0500 (EST)
In-Reply-To: <CAMuHMdWbHMPEwkYvzKzzc6L0T8ufk62DGS2sZ1w1BthL1kAZWA@mail.gmail.com>
	(Geert Uytterhoeven's message of "Wed, 4 Feb 2015 10:07:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 84E676F8-AC9C-11E4-8DA4-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263354>

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> | Oops, I'm afraid automatic-I replied "y" to the git-send-email question
> | "Which 8bit encoding should I declare [UTF-8]?"
> | (happened before with the In-Reply-To questions ;-(
>
> Would it be possible to reject obviously wrong replies ("y", "yes", "n", "no")
> to the 8bit encoding and In-Reply-To questions?

There is no canned configuration to do so, if that is what you are
asking.

It would be possible to do so with code changes to git-send-email;
look for "ask(", "valid_re", and "confirm_only" to see how they are
used in existing code that ask questions, if you are interested.
