From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Pull is Evil
Date: Wed, 30 Apr 2014 12:10:05 -0700
Message-ID: <xmqq38gufxbm.fsf@gitster.dls.corp.google.com>
References: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com>
	<xmqqoazlqot4.fsf@gitster.dls.corp.google.com>
	<536106EA.5090204@xiplink.com>
	<536129068cc28_1404fdd310fd@nysa.notmuch>
	<vpqha5akamh.fsf@anie.imag.fr>
	<5361416a172fe_f9b15012ec7e@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 21:10:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfZta-0008Lr-ML
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 21:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759235AbaD3TKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 15:10:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33012 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759107AbaD3TKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 15:10:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 168E87EBC1;
	Wed, 30 Apr 2014 15:10:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9asZ9SCqJzKeLjS6pjbX919UdY4=; b=LIv0gv
	rujKHeHhheRtZa0vOVs6jgVf25HRdraXL1HtW9VZA7LTnYJN1McYOwV2SzGTs8up
	OQP7JDnDSngd+YxEW4cO7/kjuEQRTkO680edBJqMH4SLIYgQ4kTo391ywpSWymJo
	iZDSRNwmhPQz35qb66YtFvKZoqTwjf09hGBLU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XByr6cvGIOZBpbs/XlkzO3pRVB9hUTTs
	0w7SDc0rdQHFWvO+290DHhlQNB5Mbqen5qPScljtG69jxVgFUimW8SK4DmmntNLo
	Ae7Fb4Yx23B0iZ7Xq+2te8GU3W6tCNUECkl9f6B/bWcob79c3Y2SGOFS4/+4iCeC
	uCydn2ipHmk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E18337EBC0;
	Wed, 30 Apr 2014 15:10:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C98087EBBE;
	Wed, 30 Apr 2014 15:10:06 -0400 (EDT)
In-Reply-To: <5361416a172fe_f9b15012ec7e@nysa.notmuch> (Felipe Contreras's
	message of "Wed, 30 Apr 2014 13:31:06 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0AB49460-D09B-11E3-8EC0-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247758>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Matthieu Moy wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> ...
>> > Yes, this has been discussed many times in the past, and everyone agrees
>> > the default behavior is not correct.
>> 
>> You definitely have a strange notion of "everyone".
>
> Do I? Let's look at some of the discussions:
>
> http://thread.gmane.org/gmane.comp.version-control.git/225146
>
> * W. Trevor King agrees the default should change
> * Junio C Hamano agrees the default should change
> * John Keeping agrees the default should change
> * Matthieu Moy doesn't agree anything should change
> * Linus Torvalds agrees changing the default is fine
>
> http://thread.gmane.org/gmane.comp.version-control.git/233554
>
> * Richard Hansen agrees with my proposal
> * Ramkumar Ramachandra agrees with my proposal
> * Brian M. Carlson is not happy but can live with my proposal
> * Jeff King accepts my proposal is a good way to move forward
> * Matthieu Moy is OK with change, but only if the default remains the same
>
> So, by "everyone" I mean everyone but one person (you).

I looked at the latter thread and re-read what Peff wrote (added to
Cc).  I think the most relevant (other than solving it in quite a
different way $gmane/233554) one to your version of the solution is
this:

  http://thread.gmane.org/gmane.comp.version-control.git/233554/focus=234365

where he responds to my "how about this way forward" with this:

    > ... I think other people are also in
    > agreement. So perhaps:
    > 
    >  - drop jc/pull-training-wheel and revert its merge from 'next';
    > 
    >  - update Felipe's series with a bit of tweak to make it less
    >    impactful by demoting error into warning and advice.
    > 
    > would be a good way forward?

    I think that would address the concern I raised, because it does not
    create a roadblock to new users accomplishing their task. They can
    ignore the warning, or choose "merge" as the default to shut up the
    warning (and it is easy to choose that if you are confused, because
    it is what git is doing by default alongside the warning).

While I do not quite see the previous discussion as deciding the
particular implementation is good without further tweaks, I would
say that everybody agrees that the default behaviour is not good for
everybody and therefore should (or for Linus, "it is OK to") change.

> Rational people don't think in absolute terms, "everyone" means
> virtually everyone, which is the case.

True for "should change", not virtually everyone for "should change
with that particular solution".

But after re-reading the series description 0/n this round in the
other thread, I think the overall direction is good (just like Peff
said in the previous thread), especially if there is a warning not
error period.

The step (I am not sure you have it in your series or not, but I
would strongly recommend adding one if it doesn't yet) that gives a
"will change the default, and here is how to configure" warning when
we see an actual merge made (or rebased) after "git pull" without
"--merge/--rebase" is not just a way to prepare existing users, but
is a good way to bring new goodness to newbies.  The session might
go like this:

	$ git pull
        ... fetching ...
        ... merging ...
        ... diffstat ...
        warning: you merged the $branch from $remote into your
        warning: work, which may not be what you wanted to do unless
        warning: you are acting as a project integrator.  If that is
        warning: the case, "git config --set pull.mode ff-only" to
        warning: cause "git pull" to refuse working when it does not
        warning: fast-forward.  Use pull.mode=merge if you did mean
        warning: it, to squelch this message.

I am not advocating the exact wording above, but am illustrating
that there is a place for us to tell the new people to live in a
better future before the switchover happens.
