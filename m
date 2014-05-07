From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] remote-hg: more improvements
Date: Wed, 07 May 2014 16:59:07 -0700
Message-ID: <xmqqoaz95ees.fsf@gitster.dls.corp.google.com>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
	<xmqq8uqdbgqg.fsf@gitster.dls.corp.google.com>
	<536a83097302f_76ff7a52ec6c@nysa.notmuch>
	<xmqqvbth8ha9.fsf@gitster.dls.corp.google.com>
	<536a999e2c0c_76ff7a52ec1e@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	Scott Chacon <schacon@gmail.com>, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 08 01:59:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiBkG-0006E1-2b
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 01:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbaEGX7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 19:59:20 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53048 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751458AbaEGX7S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 19:59:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 81B0E168B2;
	Wed,  7 May 2014 19:59:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=lOKpoE7+H2CvalmUHNLoijBSitY=; b=sWL5FVGzP9YdkvEYsQaD
	V8dq4iU4sWHv9ZsaSvWsbphEpTEZjUVU7rz9AbiVk87NpQMT1/b1A9bqywnQwoP6
	ZmqnocuxsYkrTiD+vE6rTyqYufo2aI7i/GQeo491WHiqOsKPM/ZdNd0UfD+V9DsY
	3nplcc5ItDN5QDQtdQEyy6M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=TgS2JzzCvEr/unFWCrAQy8cpF80KLzxUTlMIA62/YgzcfM
	aXnntrEkLXS/7hf/2b1TmxD2rOTozSETO6VWVHp5VIMEHTqUDM6B/4Fv4+EaJNsF
	Mtt8t8GrJmOEogaanUWHzKSAovHoqlHv+YoUyyogvASeo8sjHn1u1lUVOTZnk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 750EA168B1;
	Wed,  7 May 2014 19:59:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 15DB1168AD;
	Wed,  7 May 2014 19:59:09 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 945FCD80-D643-11E3-BE28-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248391>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> And you are still conveniently avoiding the question:
>
> Based on what reasoning?

Go re-read what was already said in the thread.  I still think
remote-hg and remote-bzr can and will flourish on their own merit,
and unbundling will be better for the end users for the reasons
stated there already.

Having said that, I've been thinking (not because of this thread,
but because I like imerge better and better these days) that there
should be a much better way to have a list of recommended third-party
plug-ins that enrich the Git ecosystem.  We have 

  https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools

(Jakub cc'ed as he often nudges those who announce their tools to
add an entry there) but honestly, git-scm.com is the first site the
end users who do not hack on Git would visit, and we probably should
have a catalog there (Scott and Peff cc'ed for that site).  One way
to help it may be to add a Documentation/gitthirdparty-tools.txt in
my tree that would automatically be pulled into git-scm.com site as
a part of the manual.  A richer ecosystem with tools outside my tree
would not materialize unless there is such a mechanism to advertise
the existence of them, and having to include a copy of each and
every third-party tools in my tree and keeping them relatively fresh
is not going to scale in the long run (Michael and Matthieu Cc'ed as
I saw exchanges on multimail in a near-by thread).

Such a file would probably cluster "plugins" into different
categories (post-receive hooks, remote-helpers, mergetools, etc.)
and limit the entry descriptions to a single paragraph of several
lines tops, with URL referring to the third-party maintainer's site
(e.g. a repository at GitHub).

>> > Of course it wasn't a mistake.
>> 
>> I doubt about the "Of course" part.  The first reaction after seeing
>> that the new "changegroup" is used only inside check_version(3,0)
>> and nowhere else was to wonder if that import is necessary (or even
>> safe) for the pre-v3.0 versions.
>
> I don't care about your first reaction. If that was only present in
> newer versions, how do you think it would pass the testing on older
> versions?
>
> https://travis-ci.org/felipec/git
>
> Normally I would explain the details of why this is the case, and send
> the crash regresion fix for v2.0 with a clear explanation,...

Without such an explanation in the log message, how would you expect
anybody to guess correctly?

Seriously, if you do not care about my first reaction, why do you
even want to live in my tree?

> The fact that I'm the maintainer and I say it'ss good should be good
> enough, and if the current version in "master" renders unusable the
> existing Mercurial clones, hey, it's only in contrib, right?

One potential merit I would see for keeping them in my tree is that
your change will see second opinions from others involved in the
project (including me), without giving a total rein based on the
sub-maintainership alone.  All the changes from sub-area maintainers
are vetted by at least two sets of eyeballs that way.

But after having to deal with you and seeing that you do not take
constructive criticism well, I doubt such a possibile merit will
ever materialize in the area where you alone work on.  Letting you
do whatever you want in your own tree may benefit the users of
remote-hg/remote-bzr better as the (bitter) second best option.
