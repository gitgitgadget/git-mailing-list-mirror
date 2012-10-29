From: Chris Rorvick <chris@rorvick.com>
Subject: Re: git push tags
Date: Sun, 28 Oct 2012 21:15:00 -0500
Message-ID: <CAEUsAPa2bEn1q-s469jfc87JBbuPAnMNm1VpkQ6cDGoTy0UHfw@mail.gmail.com>
References: <CAB9Jk9DMOwhDf3SvMzTmTZiyZg_4pgXx-evrfWkB3U4w-KqtVw@mail.gmail.com>
	<508D7628.10509@kdbg.org>
	<CAEUsAPYREy=CvPxy_Mzh5icVQo3=NV-AMC096Op0WWODLPH47Q@mail.gmail.com>
	<4B8097A9D6854CDFA27E7CF6574B37BA@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j6t@kdbg.org>,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	git <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Oct 29 03:15:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSesq-0003Q0-RE
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 03:15:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757509Ab2J2CPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 22:15:04 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:44662 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757565Ab2J2CPC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2012 22:15:02 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so2734994lbo.19
        for <git@vger.kernel.org>; Sun, 28 Oct 2012 19:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=oUuWvwVsMHkJnqTGWu7KWxA6C2WzbPlcNpY8IIkWMt8=;
        b=SKWsYJzajgHPjdIuHGL2rVS/jHj03MIBIZ6APhEYA8yLDFGqmHSCPU6olV3b7wP2yq
         ONSOd6NvE22BfKF/ebDLymeFopl0CiBZdGY7Iik8M/5CYQWeZdpb2hVCz8ynTdtvPIE5
         rfXc2NgI/qJ07KtrDN+WUS9z5I7J9+GwLpAAdWQjcD7x5IE+yXeosZ3fY6xqxmgMTVO4
         WAU5E3/B6/FxOEn9EtoFAZ0B7mrsR5eqPVaUXIDkG732bbk0YJeMHJNPRlNay790ttmU
         dN5fetO7THGrT07fIKSNmXVKFarFfGmWunCZvJCe9RB4Xao7Y7jFQDxAA9Fjr9cDc96z
         VgbQ==
Received: by 10.152.104.50 with SMTP id gb18mr26375951lab.9.1351476900368;
 Sun, 28 Oct 2012 19:15:00 -0700 (PDT)
Received: by 10.114.2.45 with HTTP; Sun, 28 Oct 2012 19:15:00 -0700 (PDT)
In-Reply-To: <4B8097A9D6854CDFA27E7CF6574B37BA@PhilipOakley>
X-Google-Sender-Auth: fF92kZ8ffvNSVI16jPSK1aLs2jk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208581>

On Sun, Oct 28, 2012 at 4:49 PM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Chris Rorvick" <chris@rorvick.com> Sent: Sunday, October 28, 2012
> 7:59 PM
>
>> On Sun, Oct 28, 2012 at 1:15 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>>>
>>> Tags are refs, just like branches. "Tags don't move" is just a
>>> convention, and git doesn't even respect it (except possibly in one
>>> place[1]). You can't reseat tags unless you use -f, which is exactly the
>>> same with branches, which you can't reseat unless you use -f.
>>>
>>> [1] By default, git fetch does not fetch tags that it already has.
>>
>>
>> Also, git checkout <tag> puts you on a detached HEAD.  This seems
>> pretty significant with regard to Git respecting a "tags don't move"
>> convention.
>
>
> Surely the convention is the other way around. That is, it is branches that
> are _expected_ to move, hence unless you are checkout a branch (movable) you
> will be on a detached head at a fixed place/sha1 [aka not on a branch].
>
> The checking out of a tag action doesn't make it more or less significant.

Ah, that makes sense.  Thanks.  So it sounds like the solution should
be something more general than checking if the prefix is "refs/tags"
if I understand your point correctly.

Also, setting the status to REF_STATUS_REJECT_NONFASTFORWARD even when
it would be a fast-forward (does that terminology apply to non-branch
refs?) is confusing.  It's already confusing that a failure to push a
tag tells me I need to fetch and merge in the changes.

Chris
