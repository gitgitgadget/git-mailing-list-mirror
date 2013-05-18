From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] fetch: add --allow-local option
Date: Sat, 18 May 2013 07:25:37 -0500
Message-ID: <CAMP44s3xdWzVviPvrN7D1fTG6Lwgg-dEzju--VuiwZA-8bV+MQ@mail.gmail.com>
References: <1368689474-28911-1-git-send-email-felipe.contreras@gmail.com>
	<1368689474-28911-2-git-send-email-felipe.contreras@gmail.com>
	<7v61yi9arl.fsf@alter.siamese.dyndns.org>
	<CAMP44s14TSGtQ7kvWUgrOQvT1uKciSV5fd5pQvy1ven8Z=qVcg@mail.gmail.com>
	<7v8v3e7udi.fsf@alter.siamese.dyndns.org>
	<CAMP44s0Szu8oHBKMapZ6dQ1K67MXDcACuUF-+Y-jC+EgHs2QEA@mail.gmail.com>
	<7vk3my6bu1.fsf@alter.siamese.dyndns.org>
	<CAMP44s2W5MUneTwcSnr=Ey715paKgSL6MqXmYKdSmw4NqdL4qQ@mail.gmail.com>
	<7vk3my33vb.fsf@alter.siamese.dyndns.org>
	<CAMP44s0J7vcxno=v9_ewUE6FcuRVuYQhCNVS8D+AvP6cG2XNfQ@mail.gmail.com>
	<7vtxm1xxvd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 18 14:25:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdgCm-0004jx-Va
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 14:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987Ab3ERMZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 08:25:40 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:37586 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713Ab3ERMZj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 08:25:39 -0400
Received: by mail-la0-f49.google.com with SMTP id fp13so4420608lab.22
        for <git@vger.kernel.org>; Sat, 18 May 2013 05:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=3EAxPHj4PtYFiJ6koIUYMpTp5tZIBuAFapagQMya+OQ=;
        b=WzwMdxcMli2SNslCJzdGxvHMHY71fMdN+nD+yDkqXjYrSXiKz9BhTZvqC3PTlM29nq
         pgdtPsI08g/2k70iwKDekDywklK0AaKxYAaZ3Y2JreZTbpl5nUcFFWEEx68HQQYIIupU
         jqgVuTXk54BGE9NBkUbKpkp1ieS/1EKG38yUSTlCmCYEiZVmdYDSv5+oxMve5dAOjwDv
         1vut21nUALjD73apMvzXOOKhAMRgxzr8QaNEZosY0ydPqGFKZKQzI4SO1ZuZ2CgWHe4f
         MJ1u4fBfV+hmi5fIPwTrtGJHNYHhRvTNW7VxwJ8hkqZaD+blZwyrJD4BryDi7rejcjNU
         2bnA==
X-Received: by 10.112.172.40 with SMTP id az8mr13355797lbc.88.1368879937787;
 Sat, 18 May 2013 05:25:37 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Sat, 18 May 2013 05:25:37 -0700 (PDT)
In-Reply-To: <7vtxm1xxvd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224791>

On Fri, May 17, 2013 at 1:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> This is irrelevant, it's an implementation detail of 'git pull'. *THE
>> USER* is not running 'git fetch .'
>
> To those who fear running "git pull", the following has worked as a
> quick way to "preview" what they would be getting.
>
>         git fetch
>         git log ..FETCH_HEAD
>
> and then they can "git merge FETCH_HEAD" to conclude it, or run a
> "git pull" for real.  We teach the more explicit form to end users
> in our tutorial,

That "tutorial" is mostly irrelevant; it has not been properly updated
in years, and it doesn't do it's job properly.

Nowadays most people use the Pro Git book, which doesn't mention
FETCH_HEAD even once. And why would it? It's not a useful concept for
typical users.

> So when "the user" is running "git fetch" on "mywork" branch that
> happens to be forked from a local "master", i.e. her configuration
> is set as
>
>         [branch "mywork"]
>                 remote = .
>                 merge = refs/heads/master
>
> we still need to have FETCH_HEAD updated to point at what we would
> be merging if she did a "git pull".

No, we don't need that. That is only needed by 'git pull', and in
fact, it should be possible to reimplement 'git pull' so that it skips
FETCH_HEAD when the remote is local.

These are mere implementation details.

> As I said in the very beginning, it was a mistake for me to suggest
> adding a special case behaviour for '.' remote in the first place.
> It breaks a long-standing expectation and workflow built around it.

The fact that it's "long-standing" doesn't mean it's sane.

> So sorry for wasting our time, and consider this as a misguided
> excursion.

It doesn't matter, the problem that 'git fetch' does something totally
and completely uses is still there.

-- 
Felipe Contreras
