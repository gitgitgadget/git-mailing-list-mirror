From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how to determine oldest supported version of git
Date: Fri, 10 Feb 2012 11:42:45 -0800
Message-ID: <7vwr7upj9m.fsf@alter.siamese.dyndns.org>
References: <jgeekn$of2$1@dough.gmane.org>
 <7v8vkktt6y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Neal Kreitzinger" <neal@rsss.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 20:43:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvwNM-0001H6-UR
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 20:43:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506Ab2BJTmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 14:42:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51216 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932481Ab2BJTms (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 14:42:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8071618B;
	Fri, 10 Feb 2012 14:42:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=umaI7JWuz4Ocuy96QKLLt8LVqrg=; b=hmX/Ip
	S9t49xmFEvf9ld20Yx59HVR6ja3zq5qvY2XdRLwySIn/vlPUFmHN6wQpAun8nJnn
	nb7PT9sZOpIEMPt//KObmY9RzcFnJ65uOSs9XrAgDlkA8SmjtjY/ltsJQ7wKF5Ym
	lfb0xF6Al/JGioyVPO+Esg0qNtdPp+trjWzsU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PYYr6wcl4wnq/volFqL18m7uy3aqyKzp
	6kuunj9JkoLpJpWcfrSpO0HB11D+FKh0S6YNuUNUAdgGfQDF6sA7gcbYO1OFXuXq
	p3bYwAbwxyMDx5Erngl/TsxiHQmRvLL6JpLFw1drCTm7L0kiE1//uah468Cx1Avt
	XDXSVEks5X4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0833618A;
	Fri, 10 Feb 2012 14:42:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C8FF6189; Fri, 10 Feb 2012
 14:42:47 -0500 (EST)
In-Reply-To: <7v8vkktt6y.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 02 Feb 2012 20:52:05 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 68788DAE-541F-11E1-9879-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190439>

Junio C Hamano <gitster@pobox.com> writes:

> "Neal Kreitzinger" <neal@rsss.com> writes:
>
>> What is the best way for me (a git user) to determine what is currently
>> the oldest supported version of git (the oldest version still getting
>> bugfixes)?  IOW, when can I tell that my version of git is no longer
>> supported?
>
> "A note from the maintainer" only promises that the latest major release
> (as of this writing, 1.7.9) gets regular maintenance releases until the
> next major release happens.
>
> When queuing a fix to an old bug, however, I try to build a topic branch
> for that fix from as old an release as practical, in order to make sure
> that older maintenance tracks could benefit, and I do give updates for
> older maintenance tracks when able (but no promises).
> ...
> One cycle of major release development is expected to last between 8 to 10
> weeks, so keeping two stale maintenance tracks in addition to the latest
> maintenance track alive would roughly translate to 6 months shelf life for
> an ancient release.

Having said all that, I am starting to doubt what the point of all
this is.

Maybe I am being slow to come to this realization after having done this
for all these years, but Git is not like the Linux kernel, where hundreds
of companies maintain their own internal forks, e.g. out of tree drivers,
filesystem tweaks or scheduler tweaks, all tied to a specific version of
the internal API that is a rapidly moving target and cannot afford to
adjust to the bleeding edge.  Also our strict no regression policy means
that it is not like an option --foo in one version of Git changes its
meaning from X to Y across version boundaries, and even if on rare
occasions we need to introduce incompatibilities to improve the system, we
give enough advance warning and execute careful migration plans to ensure
that third-parties can keep up, and the "fix at the oldest branch and
merge upwards" policy means fixes to important bugs will be in all the
maintenance tracks, including the 'master' version.

So in practical terms, once 1.7.9 is out, there is *no* practical reason
for anybody to use 1.7.8.x or anything older. The only two things people
are gaining by sticking to an older version are that (1) they do not have
a way to use new features, and that (2) they get fixes that are less
rigorously tested, because the testing happens mostly in the context of
the 'next' branch and then subsequently in the 'master' branch, and fixes
cooked in these two contexts may have unintended consequences that will
never be discovered until they are merged down to the older maintenance
tracks.

If we only released the feature releases without _any_ maintenance
releases, distros no longer have an excuse to stick to older maintenance
tracks ("For the upcoming Zesty Zebra LTS, Git will stay at 1.7.7.x and
never updated to any newer major version.")  This in turn removes the need
for the third-party tools that support wider Git ecosystem to worry about
their users who are kept on very stale versions of Git by distros, because
any reasonably maintained distro will not pin their users to an ancient
version of Git.  If we can change the distro's idea of what constitutes a
release of Git that is on a single maintenance track from the current
"1.7.7.3 and newer, but not anything that does not begin with 1.7.7."  to
"1.7.9 and newer, but not anything that does not begin with 1.7.", that
would be a major win, I would imagine.

And dropping the maintenance tracks for older major releases may be a good
first step in that right direction.

With that in mind, the real answer to the original question in this thread
may be "the oldest supported version is the current one. stay at the
latest major release, in other words, do not even ask that question".

Thoughts?
