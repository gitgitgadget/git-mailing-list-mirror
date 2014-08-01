From: Nico Williams <nico@cryptonector.com>
Subject: Re: cherry picking and merge
Date: Fri, 1 Aug 2014 18:40:58 -0500
Message-ID: <CAK3OfOiG8kzKYRUGZJW90t-DyjWf775MfMDxzin0gw94ATS7nw@mail.gmail.com>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net>
	<20140801024329.GA28914@vauxhall.crustytoothpaste.net>
	<53DBBFE8.8060607@gmail.com>
	<5AF18A76-DD3B-4B9A-BF70-EFE4BB852C3D@comcast.net>
	<53DBF4C9.2090905@vilain.net>
	<4E372CD5-33CA-4AF5-8647-F6BBC64BABA8@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sam Vilain <sam@vilain.net>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git discussion list <git@vger.kernel.org>
To: Mike Stump <mikestump@comcast.net>
X-From: git-owner@vger.kernel.org Sat Aug 02 01:41:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDMRe-0007wy-5n
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 01:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754618AbaHAXlC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Aug 2014 19:41:02 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:57391 "EHLO
	homiemail-a36.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753980AbaHAXlA convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Aug 2014 19:41:00 -0400
Received: from homiemail-a36.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a36.g.dreamhost.com (Postfix) with ESMTP id 4F4B877805B
	for <git@vger.kernel.org>; Fri,  1 Aug 2014 16:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=cryptonector.com; h=
	mime-version:in-reply-to:references:date:message-id:subject:from
	:to:cc:content-type:content-transfer-encoding; s=
	cryptonector.com; bh=qkzdSkr6WZD8t3i4US3nhJhP/50=; b=L66CVrKSSg4
	DN+YojYeUo4/T6wXAZ4o1xUmvY2AqFdar1EjfhBYipfeLJXk1Qja6tTrowOun1AD
	baR6OtEx7SLVStOeMG5i1Gu3rOpZHVQ4e+BvZ01j9vhTKs8npGK08uHVidKiQoKa
	eFN5MSBv740MPvHdiOhpki1h5g5xryRw=
Received: from mail-we0-f176.google.com (mail-we0-f176.google.com [74.125.82.176])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by homiemail-a36.g.dreamhost.com (Postfix) with ESMTPSA id 04DAE778057
	for <git@vger.kernel.org>; Fri,  1 Aug 2014 16:40:59 -0700 (PDT)
Received: by mail-we0-f176.google.com with SMTP id q58so5024476wes.35
        for <git@vger.kernel.org>; Fri, 01 Aug 2014 16:40:58 -0700 (PDT)
X-Received: by 10.194.92.196 with SMTP id co4mr12901991wjb.4.1406936458906;
 Fri, 01 Aug 2014 16:40:58 -0700 (PDT)
Received: by 10.217.98.6 with HTTP; Fri, 1 Aug 2014 16:40:58 -0700 (PDT)
In-Reply-To: <4E372CD5-33CA-4AF5-8647-F6BBC64BABA8@comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254683>

On Fri, Aug 1, 2014 at 6:06 PM, Mike Stump <mikestump@comcast.net> wrot=
e:
> On Aug 1, 2014, at 1:12 PM, Sam Vilain <sam@vilain.net> wrote:
>> Git merge has a notion of discrete "merge strategies=E2=80=9D.
>
>> There's no particular reason that you couldn't implement a merge
>> strategy which works more like SVN's approach, which essentially doe=
s an
>> internal rebase and then commits the result.
>
> Well, being a simple user, wanting to do a simple thing, I want the d=
efault strategy to just work.  [...]

Different users want different defaults.  You can't always have the
one you want.

As for rebase, I still don't understand why it doesn't work for you.
You didn't really explain.  Suppose we're right and it's the right
solution for you, then you might be ecstatic, but you gotta try it
first.

My workflow is rebase-heavy.  It's long been so, and it was so before
git happened.  The only case where I can imagine not using a
rebase-heavy workflow is where I have to track multiple forked
upstreams and so I want to merge each into my branch.

If tracking multiple forked upstreams is not your case and yet rebase
can't work for you then I'd like to understand why.  Please help me
understand your use case.  OTOH, if your use case is amenable to
rebase, then I highly recommend that you try it.

(I find that many users are allergic to rebasing.  Many people have
told me that rebase is lying, that history must be immutable, and so
on, all ignoring that: git users don't rebase published branches, and
that other VCSes tend to squash (therefore lose) history anyways when
pushing merges upstream.  But this all seems theological rather than
rational.  It's true that I dislike merge commits, but that's a
different story; I'm not allergic to merging after all.)

Nico
--
