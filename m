From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] rebase: new convenient option to edit a single commit
Date: Tue, 04 Mar 2014 10:37:13 -0800
Message-ID: <xmqqeh2hlsiu.fsf@gitster.dls.corp.google.com>
References: <1393506078-7310-1-git-send-email-pclouds@gmail.com>
	<1393728794-29566-1-git-send-email-pclouds@gmail.com>
	<1393728794-29566-4-git-send-email-pclouds@gmail.com>
	<CAPig+cTn-YcWHsGRKUZWqACJ5ZspWoB+f4i7hNj09_4Ci6odiw@mail.gmail.com>
	<CACsJy8Ct41PRb=_Ez7FLXbdiZkTU-tFYqtAxow9mCw7wYAfOhg@mail.gmail.com>
	<53159601.8020702@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Mar 04 19:37:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKuDV-0008Tk-VB
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 19:37:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755107AbaCDShT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 13:37:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37435 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754632AbaCDShR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 13:37:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D06D56FADA;
	Tue,  4 Mar 2014 13:37:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HBk46ba2RwpYO1DG8Pj2/YR1UYU=; b=JPL1MN
	8I+QN0D7l6s6wX+7U/4ccORuOG5ny99MkaUvN29CH9ympnQmEbSOAB4bhJfexnOn
	KQAi++ccSFVGwhrOkxMO76Gdodh7Hb+7IlQ2WkLcEC1/Jk727MuGhl8n+WdTxEDg
	sTeM+P1xXWuGmr5Z8yLrMbKJ6v0nctKdZAfY4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WmG7fFfd4iH8wy8iyFjDQZwzNKVJih9x
	wi8fuplgDtntTsCm9U/+rKyl71U7K77OCWj9HA6SPo4fz2+63n0tFBMxOI1itMC6
	mgSq5SQR9S9WZON3LcLtQI/IYRP9661SX674fIp0N+5VNTpW59V6seDAX2jQMFBF
	8WvAbmNR58g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C03106FAD9;
	Tue,  4 Mar 2014 13:37:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 094BB6FAD5;
	Tue,  4 Mar 2014 13:37:16 -0500 (EST)
In-Reply-To: <53159601.8020702@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 04 Mar 2014 09:59:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 02766D42-A3CC-11E3-A73C-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243367>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> ...  All of the following seem to make sense:
>
>     git rebase --edit COMMIT
>
>         A long-form for the -e option we have been talking about.
>         It is unfortunately that this spelling sounds like the
>         "--edit" option on "git commit --edit" and "git merge --edit",
>         so people might use it when they really mean
>         "git rebase --reword COMMIT".

I agree, so the "--edit" does *not* make sense as it invites confusion.

>     git rebase --reword COMMIT

Yes, that would make sense.

>     git rebase --fixup COMMIT
>     git rebase --squash COMMIT

I am not sure about these.  What does it even mean to "--fixup" (or
"--squash" for that matter) a single commit without specifying what
it is squashed into?  Or are you assuming that all of these is only
to affect pre-populated rebase-i insn sheet that is to be further
edited before the actual rebasing starts?  I somehow had an impression
that the reason to have these new options is to skip the editing of
the insn sheet in the editor altogether.

>     git rebase --kill COMMIT

This _does_ make sense under my assumption: "remove this commit from
the insn-sheet and go ahead with it, without bothering me to edit
the insn-sheet further".

> I'm quite confident that I would use all of these commands.

If "--kill" takes only one, I would probably do "rebase --onto"
without bothering with "-i" at all, but if it lets me drop multiple
non-consecutive commits, by accepting more than one "--kill", I see
how I would be using it myself.  I can see how "--reword"/"--amend"
would be useful even when dealing with only a single commit.

I do not know about --fixup/--squash though.
