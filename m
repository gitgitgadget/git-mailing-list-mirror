From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] clone: use --progress to mean -v
Date: Mon, 28 Dec 2009 17:30:00 -0800
Message-ID: <7vljgmpnxj.fsf@alter.siamese.dyndns.org>
References: <18831.46833.862.196815@hungover.brentg.com>
 <1261761126-5784-1-git-send-email-rctay89@gmail.com>
 <alpine.DEB.1.00.0912260952020.4985@pacific.mpi-cbg.de>
 <be6fef0d0912261927p4aff3ecet5cc26bd6dfc7e1c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Miklos Vajna <vmiklos@frugalware.org>,
	Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 02:30:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPQul-0002dk-4p
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 02:30:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbZL2BaR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Dec 2009 20:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751899AbZL2BaR
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 20:30:17 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46792 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638AbZL2BaP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Dec 2009 20:30:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F41C8B203;
	Mon, 28 Dec 2009 20:30:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=JYcF+KZisIOz
	yFnwS29sgnS1H40=; b=e3jN9O8PjCFMCIL09PXqdD7sqLCsoI76SNdL2h6DpH5X
	slB5EPiFulp1Idv1Tzlh0GgciKnJbhU9dSE5Bt1V7chOVx7p98PVvZHwCrBA3lMH
	YCx4AAxAVgommX290liY+fBcgBsOm4B0gT+bCZfyc2Q/iOLQiEUHZac66ivqye8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qRyDt2
	rTUHWZRSBQlrNJ1pi6M52gvCm5vDQtMFWe2SkBza6JaBqNBNtNHdhGhkU5+YndNg
	hZrsEPc93qJLDN0Bv9uyurdEhf8dqRWTOftuA3OxHA1ARbyIQQBLbJFWIycTbV53
	yA4aDH6MwsPC2937189gwoiX2/I+QhR5+LFhk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F288C8B202;
	Mon, 28 Dec 2009 20:30:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA3878B1FF; Mon, 28 Dec
 2009 20:30:01 -0500 (EST)
In-Reply-To: <be6fef0d0912261927p4aff3ecet5cc26bd6dfc7e1c2@mail.gmail.com>
 (Tay Ray Chuan's message of "Sun\, 27 Dec 2009 11\:27\:05 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B371FC68-F419-11DE-8CD3-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135777>

Tay Ray Chuan <rctay89@gmail.com> writes:

> On Sat, Dec 26, 2009 at 4:53 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> On Sat, 26 Dec 2009, Tay Ray Chuan wrote:
>>
>>> This series makes git-clone follow the "argument convention" of
>>> git-pack-objects, where the option --progress is used to force repo=
rting
>>> of reporting. This was previously done with -v/--verbose.
>>
>> No objections from my side, although you might want to advertise mor=
e that
>> this is a change in behavior. =C2=A0(Meaning in the release notes)
>
> Indeed, -v/--verbose to force reporting of progress was done sometime
> last year (Thu Oct 9 2008) so there may be scripts/applications
> dependent on this option.
>
> Junio, do you have any advice on this front?

[1/4] sounds like a sane thing to do regardless of the remainder of the
series, as stderr is where we write the progress output anyway. [2/4]
looks trivially correct.

It is unclear what impact [3/4] has.  I can read "With this patch,
transport can pay attention to the verbose option given from the end us=
er
and act more verbosely, which was not something they couldn't do before=
",
but what is the practical difference our existing users would see?  IOW=
,
which transports are silent without this patch even when the user gives=
 -v
from the command line?

And continuing the theme to separate the "verbosity" and the "progress"
into two separate switches, and push them down to the transport layer b=
y
[3/4], [4/4] sounds like a logical conclusion.

I however wonder if it is of lessor impact if we only added --progress
but without removing the progress from -v.  Is there a downside?
