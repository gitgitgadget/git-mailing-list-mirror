From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Feeding an annotated but unsigned tag to "git merge"
Date: Wed, 06 Jun 2012 09:37:52 -0700
Message-ID: <7vzk8gmm5b.fsf@alter.siamese.dyndns.org>
References: <1338926312-4239-1-git-send-email-gitster@pobox.com>
 <20120606134207.GB2597@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 06 18:38:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScJFA-0004ic-SS
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 18:38:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756292Ab2FFQh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 12:37:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46713 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752936Ab2FFQhz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 12:37:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3995684C9;
	Wed,  6 Jun 2012 12:37:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H9zwdMKhJBCPWTCsLmgHGxNanTk=; b=eQRKGH
	S4rVKRVgMsmORBYsEn3CotqWV5k1s6H76r4w6C/NhtSDQ0kTXLW+AUxAAIrDTKEt
	ThTyLsD8Jd+DLBJE3eLCZTG1mmMNIWO3ryxGiH52B48GZeP1tHbizh3tTG4p/JFy
	JF9ihbqdGFbjia2/QJlmBG1ulfTPg0bXwGKo4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Lu9DFEHBkmhPGE64IuCsAOxkh/WBzpd3
	XyPdWX06RlNg49AfRQZsUtifi0JFmKveDffzrPM+q1QcMeY6pB1sCyNY/xis6h53
	puCk+QJdDV09nfmmofW11R0F47cZrxqTRoFLPpzR3HRgD4xBELyOqaP4bDYUS53f
	fCPTyJbyzVA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FA5284C8;
	Wed,  6 Jun 2012 12:37:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA07184C7; Wed,  6 Jun 2012
 12:37:53 -0400 (EDT)
In-Reply-To: <20120606134207.GB2597@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 6 Jun 2012 09:42:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F6A5AAC6-AFF5-11E1-AC06-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199336>

Jeff King <peff@peff.net> writes:

> On Tue, Jun 05, 2012 at 12:58:30PM -0700, Junio C Hamano wrote:
> ...
>> But since I've written it already, I thought it might be worth
>> showing it to the list for discussion, if only to publicly reject
>> the idea ;-).
>
> It has been nearly a day, and nobody has publicly rejected it. So I will
> do so. :)
>
> This just doesn't make sense to me. Why would we treat annotated but
> unsigned tags differently from signed tags? In both cases, the new
> behavior is keeping more information about what happened, which is
> generally a good thing.
>
> I haven't seen any good argument against creating these merges[1].

It is in line with --ff-only special casing, though.  The argument
against it is that "we used to fast forward", I would think, even
though in general my reaction to that would be "so what?" because I
agree with your "keeping more information instead of discarding as
we used to is a good feature enhancement, why should we retreat?"

> [1] From the tone of your message, I think you are not the right person
>     to be arguing that side, anyway. It sounds as though you are not all
>     that invested in this series. :)

I am actually ambivalent; instead of being 0% supportive like I
usually am for many topics, perhaps I am 30% sympathetic to this
one.

This was triggered by
http://thread.gmane.org/gmane.comp.version-control.git/198828
