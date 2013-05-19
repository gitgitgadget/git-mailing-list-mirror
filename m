From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] fetch: add new fetch.default configuration
Date: Sun, 19 May 2013 07:37:14 -0500
Message-ID: <CAMP44s0p067aR4XKqrNimdsp2GrYa42mdnarTZoSGFuNdgy1dA@mail.gmail.com>
References: <1368843536-19781-1-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0mGPMw8NuhJFS0gK2BVutRO=FxX1ss+1o8fnndCc13LWw@mail.gmail.com>
	<CAMP44s3pZYw87awogjjOdFRP39Ou0=td2erhV2-aC-9_A_Z75A@mail.gmail.com>
	<CALkWK0nQzEK6-E7aMnGg6eYZJ_=XsE6FBmRgu9_8jBGkYmJe+Q@mail.gmail.com>
	<CAMP44s1rV+Pe_58qZLvTDt-r7XkDAinh3npY-dr+W5vnfNk4NA@mail.gmail.com>
	<CALkWK0=poS43aGYuMzEP9K7e0P0khFRnzQxihtgAvh3rtb9Mdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 14:37:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue2ra-0005f1-VU
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 14:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754573Ab3ESMhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 08:37:17 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:37982 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576Ab3ESMhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 08:37:16 -0400
Received: by mail-la0-f49.google.com with SMTP id fp13so4885902lab.8
        for <git@vger.kernel.org>; Sun, 19 May 2013 05:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=3sFCh6tShrpDEGDklqE8C72ROHGoQEvLeWWB+2s+UUM=;
        b=HQJRX7CTf8pv9xHlzgEzlXAxiNh8POv07oR7oFI6qZ8gKLXSmm7/3sQbNPRVoiyWB8
         slH5cbpriK58S0H2fKgLQCh5t8D4AdQ+dui0d6KwIeIQ9F0FAvGkjC1picsWQ/RiVOL0
         O+dfmycpGz4OkEBZu1JMnE2R5ZF3Xp4C2rCKlCV8mSiUpha/4jtQzBm303POeLKu4ubK
         wY9QKBQA3Igwt9TJXbCN5OsS8yGHLSK1UIu5ueLsKp10v+VMLxpZ1Cj8nWJZPVScZeVc
         8l35DXgy1vA3kRIQ2HzObEcDLrVWosxP71vG3wGBxyL4gc/HHEZ4H0v9kTe4DyG2FZR7
         GeGw==
X-Received: by 10.112.63.169 with SMTP id h9mr11072782lbs.135.1368967034313;
 Sun, 19 May 2013 05:37:14 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Sun, 19 May 2013 05:37:14 -0700 (PDT)
In-Reply-To: <CALkWK0=poS43aGYuMzEP9K7e0P0khFRnzQxihtgAvh3rtb9Mdw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224883>

On Sun, May 19, 2013 at 7:26 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> My itch is very simple.
>
> Felipe Contreras wrote:
>> % git checkout fc/remote/hg-next
>> % git rebase -i # rebase to master
>
> % git pull # I want: pull from origin

Then do 'git pull origin', 'fc/remote/hg-next' has *nothing* to do with origin.

>> % git checkout fc/remote/hg-notes
>> % git rebase -i # rebase to fc/remote/hg-next
>
> % git pull # I want: pull from ram

Ditto.

>> % git checkout fc/remote/hg-gitifyhg-compat
>> % git rebase -i # rebase to fc/remote/hg-notes
>
> % git pull # I want: pull from felipe

Ditto.

> With your series, rebase works and I like that.  But, by specifying
> branch.<name>.remote as '.',

I'm not doing that *GIT* is doing that.

What does this throw?
% git checkout --track -b foo master
% git config branch.foo.remote

> I've essentially lost a way to specify a
> remote I want.  Why can't I have both?

You haven't lost anything. The upstream is
'branch.x.remote'+'branch.x.merge', and it remains so before and after
this patch. You can set 'branch.x.remote' to whatever you want.

-- 
Felipe Contreras
