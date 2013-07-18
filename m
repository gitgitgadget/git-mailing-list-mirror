From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Git tag output order is incorrect (IMHO)
Date: Thu, 18 Jul 2013 22:51:55 +0700
Message-ID: <CACsJy8CpZHTCr0=MkSpfurPW_fyLGN_zd4uSzvBSYbuqH8aXew@mail.gmail.com>
References: <840FACA0-7E13-41DB-A0F8-124FAB53BFBD@rtcamp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Rahul Bansal <rahul.bansal@rtcamp.com>
X-From: git-owner@vger.kernel.org Thu Jul 18 17:52:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzqVL-0000yn-9h
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 17:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474Ab3GRPw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 11:52:27 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:48329 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932148Ab3GRPw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 11:52:26 -0400
Received: by mail-ob0-f177.google.com with SMTP id ta17so3835330obb.22
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 08:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FZlKqkRW9EUggMCZT8PUALgy32h1Nt3daYr1/0joBKk=;
        b=gpiL2Jk1/eASSlwjEu4aRyK45pcFZoJUDDwLLWw7I+8QcoeDFbRtJNQ8wIykZ0SH/e
         ycszjuoZl4VJk2hwX2+f7gVeJkMjr/QPSCQYqyMxSk78FItjV3YeMryNVBaOAuPRHH49
         m2s3r1bNS3MZs96mbJ8GvlMONEmIgSNEBggkDHEoRPA+m6KkwVyoy/GM/E964GYIUdjJ
         iq9QcVKunlUbx5eMks8UNOR9wPKz478z37chHfR6abYEyJAS/z8x5+x3qdE4AhAWOMVG
         f76Tws7waP3CYjn7STC5yRPLZdxcJDJwYDbv1pFnLzSExbfZ6B91aHS4+6dy3yNOqXoA
         W+Lg==
X-Received: by 10.60.47.41 with SMTP id a9mr13750731oen.78.1374162745883; Thu,
 18 Jul 2013 08:52:25 -0700 (PDT)
Received: by 10.76.88.230 with HTTP; Thu, 18 Jul 2013 08:51:55 -0700 (PDT)
In-Reply-To: <840FACA0-7E13-41DB-A0F8-124FAB53BFBD@rtcamp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230695>

On Thu, Jul 18, 2013 at 10:27 PM, Rahul Bansal <rahul.bansal@rtcamp.com> wrote:
> I am posting here first time, so please excuse me if this is not right place to send something like this.
>
> Please check - http://stackoverflow.com/questions/6091306/can-i-make-git-print-x-y-z-style-tag-names-in-a-sensible-order
>
> And also - https://github.com/gitlabhq/gitlabhq/issues/4565
>
> IMHO "git tag" is expected to show tag-list ordered by versions.
>
> It may be case, that people do not follow same version numbering convention. Most people after x.9.x increment major version (that is why they may not be affected because of this)
>
> Another option like "git tag --date-asc" can be added which will print tags by creation date. (As long as people do not create backdated tag, this will work).

Try

git for-each-ref --sort=committerdate --format='%(refname:short)' refs/tags
--
Duy
