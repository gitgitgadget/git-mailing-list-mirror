From: Nathan Gray <n8gray@n8gray.org>
Subject: Re: Why aren't tag refs namespaced?
Date: Thu, 26 Apr 2012 16:48:33 -0700
Message-ID: <CA+7g9Jy24VRO9Tr0o_4RNZN05fhyn5TZLo1C74CK+LbZduCJbw@mail.gmail.com>
References: <CA+7g9Jxc6eaCUR8aVhqKH--sOrvQVrZn+se7wtFJsOiKNjz9Pg@mail.gmail.com>
	<CABURp0okZ=-sq7e0ReUepCOEUC=9r2845wQ6H3HhruRg8Jd6Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 27 01:48:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNYQT-0003gv-17
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 01:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759479Ab2DZXsg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Apr 2012 19:48:36 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44682 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758866Ab2DZXsf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Apr 2012 19:48:35 -0400
Received: by bkuw12 with SMTP id w12so107252bku.19
        for <git@vger.kernel.org>; Thu, 26 Apr 2012 16:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=oU04hgZYfzKVxIGkva64yEWe5PhaG5zcsQlq+LRQ0/M=;
        b=OPK7GssWpEywAmuc5QDFHUqtm/cbs6hX+vtb7aQkUjlhSsyzbdZTmik14hXUuyKPcp
         1ZI833A2ThQfCq+1SRDJtm5Lbm1AHJosxgYYTNCErIuIy2VtSUN9ESUiL2mp57aUOwUr
         2XqmPKKCzQYHVsCU5n40dCof3pxeqK88UXb3LQl2WNqRCmDK5JOxxgTBPTJB9RCpRxVk
         ntlXci8qV/vrt5ZVX+VIJjr7CG9b3VkMavzYQOmAr21GeAkscHT3FozwXYtHFaf5qK+j
         YrWwo/aobyNaKqvnZhDX0fAp1EwKmLZxrIQAi1xKXIzarkhKAlpqm4Slls95oJespQNs
         yKwQ==
Received: by 10.204.128.75 with SMTP id j11mr2925880bks.2.1335484113983; Thu,
 26 Apr 2012 16:48:33 -0700 (PDT)
Received: by 10.205.119.8 with HTTP; Thu, 26 Apr 2012 16:48:33 -0700 (PDT)
X-Originating-IP: [184.182.186.242]
In-Reply-To: <CABURp0okZ=-sq7e0ReUepCOEUC=9r2845wQ6H3HhruRg8Jd6Dg@mail.gmail.com>
X-Gm-Message-State: ALoCoQlA6V95NQ0lpBmDviaor3r3iG9qYhMtKizseDMqWI05k09FFbtwCK+C2WZOTJcdFflivqBl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196447>

CC'ing the list

On Thu, Apr 26, 2012 at 12:04 PM, Phil Hord <phil.hord@gmail.com> wrote=
:
> On Thu, Apr 26, 2012 at 2:40 PM, Nathan Gray <n8gray@n8gray.org> wrot=
e:
>> Namespacing works really well for branch refs. =A0I know that
>> remotes/origin/master is origin's master branch. =A0I may or may not
>> have a master branch, and it may or may not have anything in common
>> with origin's. =A0Our repositories are independent, after all, so it
>> makes sense that our refs would live in different namespaces.
>>
>> So why is it that tag refs don't follow this model?
>
> I expect the simple answer is that no one has been motivated to creat=
e
> such a mode.
>
>
>> Why is my
>> "best-commit-ever" tag assumed to be the same as origin's? =A0Given =
a
>> ref in refs/tags it's unclear if the ref is public, private, on orig=
in
>> or not on origin. =A0Will pushing my tags create anything new or not=
?
>> Who knows? =A0Compare this to branches, where the same questions are
>> easy to answer thanks to namespacing.
>>
>> OTOH, am I just not "getting it?" =A0I've been using git for about 4
>> years now and I feel like I know it pretty well but it's possible I'=
m
>> just misunderstanding things.
>
>
> Tags are presumed not to move, so there's no point in having a remote
> tag which you follow with your local tag.=A0 In that sense, they are
> fundamentally different from branches.=A0 Also, tags are not pushed b=
y
> default, though they are fetched if they're on branches you are
> fetching.

All that is true, but...

>=A0On the other hand, it does invite namespace collisions if
> you pull tags from a remote whilst having local tags and no
> agreed-upon convention.

Exactly!  Imagine tracking 5 different forks of the same project on
GitHub.  They can't be expected to coordinate their tagging
conventions.

> But perhaps a convention is what you need.=A0 Suppose you name all yo=
ur
> local tags "refs/tags/n8gray/best-commit-ever"?=A0 Or maybe you can '=
git
> fetch origin "refs/tags/*:refs/tags/origin/*"'.

That could probably be made to work, but it requires a fair bit of
effort to keep clean.  Plus you have to make sure you never
accidentally use the built-in tag pushing/pulling stuff or it all
falls apart.

Cheers,
-n8

--=20
HexaLex: A New Angle on Crossword Games for iPhone and iPod Touch
http://hexalex.com
On The App Store: http://bit.ly/8Mj1CU
On Facebook: http://bit.ly/9MIJiV
On Twitter: http://twitter.com/hexalexgame
http://n8gray.org
