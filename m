From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/1] bash: eliminate dependency on bash_completion
 lib
Date: Tue, 07 Dec 2010 13:03:20 -0800
Message-ID: <7v1v5tpa7b.fsf@alter.siamese.dyndns.org>
References: <1291236582-28603-1-git-send-email-peter@avirtualhome.com>
 <20101202091624.GB1771@burratino>
 <20101202091613.6ac8f816@MonteCarlo.grandprix.int>
 <20101202210207.GA4994@burratino> <20101207160747.GD1867@neumann>
 <20101207194923.GD22587@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Peter van der Does <peter@avirtualhome.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Marc Branchaud <marcnarc@xiplink.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Kevin Ballard <kevin@sb.org>,
	Mathias Lafeldt <misfire@debugon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 22:03:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ4hU-0005Ef-4t
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 22:03:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755202Ab0LGVDp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Dec 2010 16:03:45 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47175 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755145Ab0LGVDo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Dec 2010 16:03:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2BACC3F30;
	Tue,  7 Dec 2010 16:04:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=koH78cLE4y1r
	RF0IZlZmFWYv7Eg=; b=Gdnw2pZWVe2LCXhVEko9XG95ZmKIDrW1b/UI6wumpnQV
	iInYhE2X2gQ47r5PlJ37K0J5r6DRB54pCmKIzWQINakRDwL2kb59J0feWgrEaQQm
	l0bOb5nRhnH41jjPHKenRluzjhRajlTswh7NthgnlhAy70gkwCID5TwFg2ygipk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Q6bXhk
	gdo+eM0fbaK4zgifvYDsWi6Vy3zLXFXxXcZHTX1mjD3AmkTow01cAbKPvvHJ0sXf
	omW9NPbEMug9FCZgDOtKp6a8L4uvJD9ifj5aGs9DZGuzglyc1gO4fO1tNTY4xRS5
	XL5N8MQVL4q9js21gwGNQL4wHyMXkSjfk931s=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8AECA3F2C;
	Tue,  7 Dec 2010 16:03:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DFB453F2B; Tue,  7 Dec 2010
 16:03:44 -0500 (EST)
In-Reply-To: <20101207194923.GD22587@burratino> (Jonathan Nieder's message of
 "Tue\, 7 Dec 2010 13\:49\:23 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 813B14A6-0245-11E0-85F7-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163133>

Jonathan Nieder <jrnieder@gmail.com> writes:

> SZEDER G=C3=A1bor wrote:
>> On Thu, Dec 02, 2010 at 03:02:07PM -0600, Jonathan Nieder wrote:
>
>>> Add a minimal implementation of _get_comp_words_by_ref,
>>> the routine used to work around bash 4.0's COMP_WORDS semantics.
>>>=20
>>> Based on bash-completion 2.x (commit bf763033, 2010-10-26) but
>>> tweaked for simplicity and to allow zsh to at least parse the
>>> code.
>>
>> What is this patch based on?
>
> Ah, sorry, applies to d93f4a297 (bash: work around bash 4.0 change in
> COMP_WORDS semantics, 2010-12-02).

Sorry, but whose repository does that object live in?
