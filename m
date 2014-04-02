From: Ronald Weiss <weiss.ronald@gmail.com>
Subject: Re: [PATCH v2.1] commit: add --ignore-submodules[=<when>] parameter
Date: Wed, 02 Apr 2014 21:56:07 +0200
Message-ID: <533C6B57.3080901@gmail.com>
References: <CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com>	<5335A78C.60401@web.de>	<CABxC_L-4=qcZiix05dL8GrDJXv=19fw4yB0qFzRRfw=G=_Gxbg@mail.gmail.com>	<53374E49.9000702@gmail.com>	<533874F9.3090802@web.de>	<5338AC36.6000109@gmail.com>	<5338B1B0.3050703@gmail.com>	<5339BAE4.8020306@web.de> <CABxC_L8_tQrANXji_Z0LfigxsAuzSDj3K9ndTGOTHh2ctHvc6A@mail.gmail.com> <5339F122.60801@gmail.com> <5339FBB4.1010101@gmail.com> <533B2036.3050506@web.de> <533B36AA.3090600@gmail.com> <533C5CBD.4050601@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Apr 03 12:25:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeVU-000348-Vd
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 12:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933045AbaDBT4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 15:56:14 -0400
Received: from mail-we0-f181.google.com ([74.125.82.181]:49389 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932688AbaDBT4M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2014 15:56:12 -0400
Received: by mail-we0-f181.google.com with SMTP id q58so749709wes.26
        for <git@vger.kernel.org>; Wed, 02 Apr 2014 12:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=7iJQFn1NqvRCfnzm66QKiQ5wZ7xlms+zqUiZgc9YWg0=;
        b=vw+t8qnr2OczGa7kbIsUnk9PJ7UY3dLiLB++W9dYdM3OVtl/faL8JqR9TKA9SEc5t9
         IRwGWpnM8VLrIAzXZJ/hnqdnSobrrV6+kv/vZ8ZuZoVTr5pHQEJKlRyfG+n7zQgEgTXR
         8XYFxIE6CLm7TQXfinKeYj2NumeNakJYUv5zKUiGuKa6ZTiZjwMltQ+y1EIHURMaltU8
         9gcGr4k/eLiE0TtGl67bGn11ZUNMZgmzJFD0H3Z04xaTI6KO8qcsjPf8ol88kNIHkPgi
         sqyGLTaof3IfpP/mYbR0+qmAl3jQuKYvmniO6Jj8/GTIPNOgTKbb+7vpC3xv8daGbxWe
         rCyQ==
X-Received: by 10.180.94.196 with SMTP id de4mr4862763wib.16.1396468570472;
        Wed, 02 Apr 2014 12:56:10 -0700 (PDT)
Received: from [10.0.1.226] (chello089173067059.chello.sk. [89.173.67.59])
        by mx.google.com with ESMTPSA id y51sm6786923eeu.0.2014.04.02.12.56.08
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 02 Apr 2014 12:56:09 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <533C5CBD.4050601@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245677>

On 2. 4. 2014 20:53, Jens Lehmann wrote:
> Am 01.04.2014 23:59, schrieb Ronald Weiss:
>> On 1. 4. 2014 22:23, Jens Lehmann wrote:
>>> Am 01.04.2014 01:35, schrieb Ronald Weiss:
>>>> On 1. 4. 2014 0:50, Ronald Weiss wrote:
>>>>> On 31. 3. 2014 23:47, Ronald Weiss wrote:
>>>>>> On Mon, Mar 31, 2014 at 8:58 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>>>>>>> As Junio mentioned it would be great if you could teach the add
>>>>>>> command also honor the --ignore-submodule command line option in
>>>>>>> a companion patch. In the course of doing so you'll easily see if
>>>>>>> I was right or not, then please just order them in the most logical
>>>>>>> way.
>>>>>>
>>>>>> Well, if You (or Junio) really don't want my patch without another one
>>>>>> for git add, I may try to do it. However, git add does not even honor
>>>>>> the submodules' ignore setting from .gitmodules (just tested with git
>>>>>> 1.9.1: "git add -u" doesn't honor it, while "git commit -a" does). So
>>>>>> teaching git add the --ignore-submodules switch in current state
>>>>>> doesn't seem right to me. You might propose to add also support for
>>>>>> the ignore setting, to make "add -u" and "commit -a" more consistent.
>>>>>> That seems like a good idea, but the effort needed is getting bigger,
>>>>>
>>>>> Well, now I actually looked at it, and it was pretty easy after all.
>>>>> The changes below seem to enable support for both ignore setting in
>>>>> .gitmodules, and also --ignore-submodules switch, for git add, on top
>>>>> of my patch for commit.
>>>>
>>>> There is a catch. With the changes below, submodules are ignored by add
>>>> even if explitely named on command line (eg. "git add x" does nothing
>>>> if x is submodule with new commits, but with ignore=all in .gitmodules).
>>>> That doesn't seem right.
>>>>
>>>> Any ideas, what to do about that? When exactly should such submodule be
>>>> actually ignored?
>>>
>>> Me thinks git add should require the '-f' option to add an ignored
>>> submodule (just like it does for files) unless the user uses the
>>> '--ignore-submodules=none' option. And if neither of these are given
>>> it should "fail with a list of ignored files" as the documentation
>>> states.
>>
>> It's still not clear, at least not to me. Should '-f' suppress the
>> ignore setting of all involved submodules? That would make it a
>> synonyme (or a superset) of --ignore-submodules=none. Or only if the
>> submodule is explicitly named on command line? That seems fuzzy to me,
>> and also more tricky to implement.
> 
> Maybe my impression that doing "add" together with "commit" would be
> easy wasn't correct after all. I won't object if you try to tackle
> commit first (but I have the slight suspicion that similar questions
> will arise concerning the "add"ish functionality in commit too. So
> maybe after resolving those things might look clearer ;-)

There is one big distinction. My patch for commit doesn't add any new
problems. It just adds the --ignore-submodules argument, which is easy
to implement and no unclear behavior decisions are needed.

You are right that when specifying ignored submodules on commit's
command line, there is the same problem as with git add. However, it's
already there anyway. I don't feel in position to solve it, I'd just
like to have "git commit --ignore-submodules=none".

With git add however, changing it to honor settings from .gitmodules
would change behavior people might be used to, so I would be afraid to
do that. Btw add also has the problem already, but only if somebody
configures the submodule's ignore setting in .git/config, rather than
.gitmodules. I don't know how much real use case that is.

As I see it, there are now these rather easy possibilities (sorted
from the easiest):

1) Just teach commit the --ignore-submodules argument, as I proposed.

2) Teach both add and commit to --ignore-submodules, but dont add that
problematic gitmodules_config() in add.c.

3) Teach both add and commit to --ignore-submodules, and also let add
honor settings from .gitmodules, to make it more consistent with other
commands. And, make add --force imply --ignore-submodules=none.

I like both 1) and 2). I don't like 3), the problem of add with
submodules' ignore setting is a bug IMHO (ignore=all in .git/config
causes strange behavior, while ignore=all in .gitmodules is ignored),
but not directly related to the --ignore-submodules param, and should
be solved separately.
