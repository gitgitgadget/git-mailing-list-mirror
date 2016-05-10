From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 05/13] worktree.c: mark current worktree
Date: Tue, 10 May 2016 21:14:16 +0700
Message-ID: <20160510141416.GA22672@lanh>
References: <1461158693-21289-1-git-send-email-pclouds@gmail.com>
 <1461330096-21783-1-git-send-email-pclouds@gmail.com>
 <1461330096-21783-6-git-send-email-pclouds@gmail.com>
 <CAPig+cQszEZLaebwqXNny6_EnhFpwU1xYqEX2_0N=vTEXTk2Fw@mail.gmail.com>
 <CACsJy8D+anuZ-278kaz2ewpcLCGOSrdn2Qq1F7fFTuVUTLv5Yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Reto =?iso-8859-1?Q?Habl=FCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 10 16:14:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b08QX-0005PA-7z
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 16:14:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626AbcEJOOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 10:14:17 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33537 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446AbcEJOOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 10:14:16 -0400
Received: by mail-pf0-f195.google.com with SMTP id y7so1069759pfb.0
        for <git@vger.kernel.org>; Tue, 10 May 2016 07:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6PbKwlbm3kc2TJ90YCBbEoVwyjoHDYyqRYf3/SBVpOw=;
        b=ddVvcmZVEkKVRlYgfkVEl4dIplrKzl//naDiGWHGEaQw5zbeq7YsrNPGPiujPOhSwJ
         FkhIWpXdTj3mcaw12MPYh8IL3ThykrnO9rSwYZm6Al8jFWD61SJGcDCFMB0vnMjxRDBz
         iCtdWGZan6NTF5ZHOcQp0yXWszsoZSMi4mymfvHLYMWMf53oxaAGTwvi59Wzy+DuTun6
         OlegCbtTQAC72+nCxeJgxKumvjaJ1J6YTq9MIJYpG/xMeqI12byVhN34Dorbs1lHY8C3
         T8VYCSauDf0nGeEDxxaoGL38uubwJkR3JQ0ovJ+EtL6W97G9E6HipUP7ibBofyUh1c+3
         IqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6PbKwlbm3kc2TJ90YCBbEoVwyjoHDYyqRYf3/SBVpOw=;
        b=PGUEpvN3GejEhgQuXo0htxTsKaqj/bH+FPs5igzatqsRtLE3cbb9zF2ZPdEx/zhaKh
         aSmuP0eyvdbtNUZ/7saLUrqValPihpYFVRKJhpRdBK2crwmrHznkM1SXfDVhDda6ioAM
         q9cGgNYK4+GaG+h6opWTDon9e2zI61dWWSIaQak7ZDFwKX6JRyUnGwv86/AB1+YrdeWC
         cz7Qu/Cf8KxyTbshVfALD4dyjS8iFqKXxZ0hfoX/aMaLPFcqmy+2JZ8c1XZLXHsvcKze
         ZU339o2FnZXNbzGV26/9urOSoMI2n1CakIOFIGzzOD9EfuX7xjCJiJo5onJu8JzoFmqF
         rwKQ==
X-Gm-Message-State: AOPr4FUqe8ZhYA4RIIpdeR+cP9sKbSbQBbd16euU9QYgJRti6UXQ4tTshujYHYVR9IIUlQ==
X-Received: by 10.98.16.150 with SMTP id 22mr58815084pfq.165.1462889655257;
        Tue, 10 May 2016 07:14:15 -0700 (PDT)
Received: from lanh ([115.76.164.133])
        by smtp.gmail.com with ESMTPSA id 1sm4992268pah.7.2016.05.10.07.14.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 May 2016 07:14:13 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 10 May 2016 21:14:16 +0700
Content-Disposition: inline
In-Reply-To: <CACsJy8D+anuZ-278kaz2ewpcLCGOSrdn2Qq1F7fFTuVUTLv5Yw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294135>

On Fri, May 06, 2016 at 05:21:05PM +0700, Duy Nguyen wrote:
> > Similarly, it looks like 'path' doesn't need to be a strbuf at all
> > since the result of absolute_path() should remain valid long enough
> > for fspathcmp(). It could just be:
> >
> >     const char *path = absolute_path(...);
> >     wt->is_current = !fspathcmp(git_dir, path);
> >
> > But these are very minor; probably not worth a re-roll.
> 
> Yeah. I think the use of strbuf is influenced by the code in
> get_worktrees(). But since this code is now in a separate function, it
> makes little sense to go with the strbuf hammer. If there's no big
> change in this series, I'll just do this as a cleanup step in my next
> series, worktree-move.

On second thought, why hold patches back, lengthen the worktree-move
series and make it a pain to review? I moved a few patches from
worktree-move into this series and I took two other out to create
nd/error-errno. So I'm going to take more patches out of it, creating
two bite-sized series, to be sent shortly.

The first one is purely cleanup (ok, 1/7 is not exactly cleanup)

  [1/7] completion: support git-worktree
  [2/7] worktree.c: rewrite mark_current_worktree() to avoid
  [3/7] git-worktree.txt: keep subcommand listing in alphabetical
  [4/7] worktree.c: use is_dot_or_dotdot()
  [5/7] worktree.c: add clear_worktree()
  [6/7] worktree: avoid 0{40}, too many zeroes, hard to read
  [7/7] worktree: simplify prefixing paths

And the second one adds "git worktree lock" and "git worktree
unlock". This series is built on top of the first one, it needs 1/7.

  [1/5] worktree.c: add find_worktree_by_path()
  [2/5] worktree.c: add is_main_worktree()
  [3/5] worktree.c: add is_worktree_locked()
  [4/5] worktree: add "lock" command
  [5/5] worktree: add "unlock" command

After this, worktree-move becomes ~10 patch series.
-- 
Duy
