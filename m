From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Gitk "External diff" broken when using worktree
Date: Thu, 24 Mar 2016 16:22:12 +0700
Message-ID: <CACsJy8D84e4iQ6Pz_zyqsXuV6c2ier6s_W99+1hKszd0gHiUaQ@mail.gmail.com>
References: <CAC4jX8FWs30v-Vh7XyPP9_ba3HKd4hAhRBrwfMpBPZd5ku8rUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Daryl Van Den Brink <daryl.vandenbrink@maptek.com.au>
X-From: git-owner@vger.kernel.org Thu Mar 24 10:22:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj1Td-0004VW-O9
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 10:22:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755203AbcCXJWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 05:22:46 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:34220 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752314AbcCXJWo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 05:22:44 -0400
Received: by mail-lb0-f175.google.com with SMTP id k12so26378099lbb.1
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 02:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5paP46DMJtM8M5NZ4BiBrwQEXJgGYDbouUvtwBuKV7M=;
        b=H7AosH7s7WIuPQFkeJOILbJfM33PDsViqhEN+IwuBgx48oJZV9JHGZCAJhFmwXcI4W
         TvoWJHN5q96m+ngTWi92rRNjJ+dNDlP9EJoHT1Hkg+q47RbU3qMN+7GcrZezn2AS45Vu
         GbcFJpellaFvD+JsYe+PDjvXfMMgtAvib8ZRXftgqEyGuw5PPkrwyjqLj3tATsJESFLD
         YNhp9LzUMAFTiGxXQIe5rz0VMFKhGHPOBA+49kNhfP2uquHNDJ58wIfX8arJ0y+vq13r
         tmw+4xE+UA+l1SMbWDt0psjRyQcAe5zG9hA8H/HoX5MNgS7cikrcNCtszwveu2wMLPN4
         enXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5paP46DMJtM8M5NZ4BiBrwQEXJgGYDbouUvtwBuKV7M=;
        b=OlyocMmVH+EH+OKOsIIcRXrlbWBySSyVBJ3D8jc0YF7F5xByMuY/FZu6POBP6I4u+i
         F2nwWdkLonP4Yzf1kpntreggHOqQxFASimdEmuanUesQhZj3EeP+QOFuMqw3Mf/wR95K
         6X5Ufp/nK3ehsTS2tHqKbMdZor7YgOSbHc1g4Qu+/S+3M1/B5Wu/pUL/FeMUmMPgapsX
         0cZSF/HvdawbGzqHWYSQy/D0StnxJGyA2IzBiTWZXowBvi3GT7Cov7Hn/mWIBZpqBf2q
         IoZ7aAQVChLU0+3a5CsULLWwE6xSgmOBkvaPN1ep4o7m91tXjvHCbUic+JtQsMh1aNc6
         7tkg==
X-Gm-Message-State: AD7BkJLwNd2OHit+jg0N6gyR+N27dmg6YLl728ITtNGBRVjgsQvsM7IOtePR+6SLQI+Ne/WQOW+nte96WbGahA==
X-Received: by 10.112.130.41 with SMTP id ob9mr2906029lbb.81.1458811362564;
 Thu, 24 Mar 2016 02:22:42 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Thu, 24 Mar 2016 02:22:12 -0700 (PDT)
In-Reply-To: <CAC4jX8FWs30v-Vh7XyPP9_ba3HKd4hAhRBrwfMpBPZd5ku8rUA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289728>

On Thu, Mar 24, 2016 at 9:55 AM, Daryl Van Den Brink
<daryl.vandenbrink@maptek.com.au> wrote:
> Hi,
>
> I'm using git 2.7.3 on cygwin, and have been taking advantage of the
> new "git worktree" feature. I noticed that when I launch gitk from one
> of the attached working directories, its "external diff" feature
> doesn't seem to work. Nothing shows up in the diff tool at all.
> However, it works if you launch gitk from the main repository.
>
> To reproduce:
> 1. Create a new working tree with "git worktree add"
> 2. From that new worktree, launch gitk.
> 3. Right-click in a file in the bottom right pane and click "External diff"
> 4. No useful diff appears.

Works for me (on linux with 'master' branch). Maybe gitk selected
invalid tempdir on cygwin. You can try replace your external diff
program with a script or something that prints the whole command line.
That should reveal if gitk given paths are correct or not (or if gitk
fails even before that)
-- 
Duy
