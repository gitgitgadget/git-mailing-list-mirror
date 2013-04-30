From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log -p unexpected behaviour
Date: Tue, 30 Apr 2013 13:38:26 -0700
Message-ID: <7vvc73bvp9.fsf@alter.siamese.dyndns.org>
References: <CAHQ6N+qdA5Lck1_ByOYPOG4ngsztz3HQSw8c_U_K8OnDapj4bQ@mail.gmail.com>
	<20130420140051.GB29454@ruderich.org>
	<7vd2towdiq.fsf@alter.siamese.dyndns.org>
	<CAHQ6N+pKb-44rOM7ocYMvSDyimvAGZppX1Gc=st59aVKzJSBKw@mail.gmail.com>
	<20130421102150.GJ10429@elie.Belkin>
	<CAHQ6N+rXE42NOyQPfLiDN8jYfL8w06hEE5MFLeFNxMR4ORD0aw@mail.gmail.com>
	<20130421160939.GA29341@elie.Belkin>
	<7vli8bu3ne.fsf@alter.siamese.dyndns.org>
	<CAEBDL5VspccUmkkYBf17soGTyT3sinjnnNzRB_kytnOr3OBVQw@mail.gmail.com>
	<7va9ogezzx.fsf@alter.siamese.dyndns.org>
	<vpqy5c0oson.fsf@grenoble-inp.fr>
	<CAEBDL5W-xuNhyL81TBGhriAr2jM7CC3FtLhfcbEfEAf9GjCJAQ@mail.gmail.com>
	<CAHQ6N+pDeeZBabiArTXJy9POv10xCBU+=46YdYmW0Ge1qVgUCA@mail.gmail.com>
	<7vd2tbdcsa.fsf_-_@alter.siamese.dyndns.org>
	<CAHQ6N+pgz3yzFCumgRd3yzpxpqFbkMSzB=tHxmY5hdhzTjeXAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 22:38:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXHJq-0001cs-Rc
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 22:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933485Ab3D3Uib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 16:38:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63330 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933034Ab3D3Uia (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 16:38:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C68501AA07;
	Tue, 30 Apr 2013 20:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RJkATKWn2JXrs9Wjzq9aBIwNfi0=; b=S8EljN
	4moBl1SiRzbQG68bsnw3b4c09odbRWZ7iMfLKDQfJI+I0jEuHvGRiexP8HaG0dSf
	/hAH7o6p081GYs6vzkSglCDcsOFlwpUQNGIsShhx+qztpJ52wdgcB2jkX1EIrjvP
	6SNksssOjQGfbS2b9JYyKmm3QzXlv2+7WLUyk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SDFzfD2hbtn+nSUvyEcMiUhEIm7re8ep
	t2jLZuzQaFhix0qNAygccpNu20V+lrCNXP97fY3CXcC51kdDxEAr9PkrVn37PC5k
	3XeFY5eNeC64wkiGMAOzxpgaRe1UiU/Zrbef1DhDKqW/E+wyYiPcgLA/iH5MPs9R
	Z35bI3UQfjE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC3841AA05;
	Tue, 30 Apr 2013 20:38:29 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 40B451A9FA;
	Tue, 30 Apr 2013 20:38:29 +0000 (UTC)
In-Reply-To: <CAHQ6N+pgz3yzFCumgRd3yzpxpqFbkMSzB=tHxmY5hdhzTjeXAg@mail.gmail.com>
	(John Tapsell's message of "Tue, 30 Apr 2013 21:12:49 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EA5E3296-B1D5-11E2-8CF3-A3355732AFBB-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223008>

John Tapsell <johnflux@gmail.com> writes:

> On 30 April 2013 20:44, Junio C Hamano <gitster@pobox.com> wrote:
>> John Tapsell <johnflux@gmail.com> writes:
>>
>>> Is there no way to fix --cc to work even in the edge cases?
>>
>> Can you clarify what you mean by "fix" and "edge cases"?
>
> My understanding is that even with -cc there will be changes that
> won't be seen - and hence why --cc could be even more of a "security
> risk", no?

Combined diff is a way to show a tricky conflict resolved in a
tricky way, so that the tricky-ness of the resolution can be
examined.  A trivial resolution that takes one side is not shown
because it is not usually interesting. This design choice of course
have to trust people involved in the project do not pull from
untrustworthy sources.

You would need "log -p -m" (without any pathspec) for the kind of
"security" you are talking about.  Note that "-p -m --first-parent"
is not necessarily enough.
