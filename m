From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: [PATCH 0/4] remote-hg: more improvements
Date: Wed, 14 May 2014 11:12:12 +0200
Message-ID: <CAGK7Mr7AcqKnEBk1NwzJFJVSSQE9uWTE00zi+B9z6i0V5tBrEg@mail.gmail.com>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
 <xmqq8uqdbgqg.fsf@gitster.dls.corp.google.com> <536a83097302f_76ff7a52ec6c@nysa.notmuch>
 <xmqqvbth8ha9.fsf@gitster.dls.corp.google.com> <536a999e2c0c_76ff7a52ec1e@nysa.notmuch>
 <xmqqoaz95ees.fsf@gitster.dls.corp.google.com> <536ad9601b73b_3caaa612ecdc@nysa.notmuch>
 <CAGK7Mr4DYuU34Zf_3fRQFkT+1TGOkpfLPUnQh=tYh6EMtBEt9A@mail.gmail.com> <xmqq8uq6rd30.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 14 11:12:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkVF4-0006at-5v
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 11:12:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752739AbaENJMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 05:12:46 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:38549 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbaENJMm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 05:12:42 -0400
Received: by mail-oa0-f47.google.com with SMTP id i7so1817752oag.34
        for <git@vger.kernel.org>; Wed, 14 May 2014 02:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Ayjhpa4RbI4f9X0GrhvGM3eE2wsXZ4cVLGvUuCUPcn4=;
        b=VG0/ywso+XZSP2mnoXQ2T0xfxt0gSVlNF+mJwnxy0RepG0zubUUYVYa8fwTZjXBTIP
         qjktVSC5JdVotSYfYdRYzgOIYpIlUyvffeOgTxMX/bUKJ2LezVg+nXn5Vqm6EcCaif2a
         QDCIJOYaSBoFU1mq14C3HmX63Fh+dLUgHyA9jPUaL/Tag4Uddbw7XrvxfJVscBMZcfIC
         AYi+1oMdKAPvmpO8Dsz6RR0US2btAI76jAioe1LnaniYEmrx4InRfCAgGrUL9Z+/DDEf
         SamGntf8FigH96hXt34Hm23yywbY4Huc7hFhRligHs3wdChT3rAVwI+Awn/hF5UEWNGz
         ikNg==
X-Received: by 10.182.28.104 with SMTP id a8mr2248523obh.30.1400058762245;
 Wed, 14 May 2014 02:12:42 -0700 (PDT)
Received: by 10.76.76.228 with HTTP; Wed, 14 May 2014 02:12:12 -0700 (PDT)
In-Reply-To: <xmqq8uq6rd30.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248901>

>>> It is *way* beyond the quality of any other tool in 'contrib/' and even
>>> some tools in the core, like 'git-request-pull' (which has known bugs),
>>> and probably even 'git-pt'.
>>
>> Junio, can you comment on this? I understand this probably doesn't
>> really affect the issue at hand, but it'd help clarify if it's ever
>> possible to move out of contrib/ nowadays.
>
> I was originally led to believe that its code quality was good
> enough, and that was why I merged the bottom three patches of the
> series even down to 'next' in the first place.  But after seeing the
> "Of course" response that led to [*1*], which made me recall many
> patch-review interactions with him, I have started to have doubts.
>
> The code quality of Git that many projects have come to trust their
> code with is much more than just "the code at each moment keeps
> working for the users as long as the original author is around".
> The maintainer of a port to the platform X may lose access to the
> platform after switching jobs, the maintainer of a bridge to the
> foreign system Y may stop needing to talk to the foreign system
> after completing the switch to Git.  Anybody can be hit by a bus,
> get sick, or simply lose interest in his past creations.
>
> By reading "git log contrib/remote-helpers" and comparing it with
> the logs for the rest of the system, you would realize that the
> former would not lead to a quality discussion similar to the one
> that led to [*2*], which was only possible because the change was
> adequately described to allow anybody to understand the original
> issue the change was meant to solve.  The commit that made the
> original change made it easy to ask a critical question: "You are
> improving B but at the same time breaking A.  Can we do better to
> help both A and B?"  And it allowed us to move forward without
> having to rob Peter to pay Paul.
>
> Granted, these contrib/ patches were applied with the understanding
> that contrib/ stuff can be substandard, because having anything is
> often better than having nothing, and you cannot go back in time to
> update the history to make these commits more useful to others who
> will come later.  But I would be lying if I said that I would expect
> that things will suddenly improve and that the codebase will be
> maintained for the long haul in a healthy way the minute we move it
> out of contrib/ to the core.  Especially after seeing [*1*], which
> is just one of the examples that illustrate that there clearly is no
> will to explain the changes to help others who come later to help
> maintaining the code.  "I'll take good care of the codebase", "I've
> spend the time to make it better", "Me, me, me", is not what the
> open source process is about.

Thanks for the explanation. I think it underlines well the A)
technical issues (quality commits) and the B) social issues (ability
to communicate in a friendly way & respond constructively), which we
discovered are both *essential* for contributing to git.

Neglate one or the other, and sooner or later people will refuse to
collaborate with you, because it's just too much "work" to deal with
the downsides.

My hope is that for future events of this nature to be detected sooner
and dealt with more rigidly, e.g by making it clear this or that
behavior is not acceptable. I think part of the problem here is that
we let the situation install itself, by accepting B-side issues just
because A-side was ok, hopeful that B-side would solve itself.

Philippe
