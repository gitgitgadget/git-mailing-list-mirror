From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v7 25/31] prune: strategies for linked checkouts
Date: Sat, 19 Jul 2014 19:52:30 +0700
Message-ID: <CACsJy8A7bS+1Z1yrpS94WWg6Lr_F39vvuqbH7L-pQY7vK-f10w@mail.gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
 <1405227068-25506-1-git-send-email-pclouds@gmail.com> <1405227068-25506-26-git-send-email-pclouds@gmail.com>
 <87r41i352a.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Sat Jul 19 14:53:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8U8T-0001yi-S3
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 14:53:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754703AbaGSMxC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2014 08:53:02 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:62558 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122AbaGSMxA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2014 08:53:00 -0400
Received: by mail-qc0-f174.google.com with SMTP id o8so4230209qcw.5
        for <git@vger.kernel.org>; Sat, 19 Jul 2014 05:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5nDQWW0LSjwLu7QJgV+5EHpYcrGHCQJRp+tj649vHHg=;
        b=bCp9GtngOgNLkouQw4SUWuiwqduV5ma08rNn9dmuXtEz5IxPiJXP/n3v9nRS1DWBf/
         EzjojB74vMm8OJt7zXP24RjWhxHa75teOhRPwccVbu13FPTDQZ22eTeRHb/+lYOOI6PK
         v2U0gA/mlJFfs4ca+qa7u6HC9T6AHt+ynUwQAvyM763AfTL+ZpGVdwRTYNsv1ZC/mGa9
         HN6VuWnAiPzzdxsucxx6277LhVDnmEM2j7zR5OqJH6JMrsTmfCGqXSmfpmR35RarScRU
         UnmhF+VuLcXEJSm5qEW4O3op6/I7km+fR52X/aqR6PQpsOieXPqrz9xTS0J/Kt0YZyLr
         ZE0w==
X-Received: by 10.224.5.193 with SMTP id 1mr18851203qaw.89.1405774380065; Sat,
 19 Jul 2014 05:53:00 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Sat, 19 Jul 2014 05:52:30 -0700 (PDT)
In-Reply-To: <87r41i352a.fsf@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253879>

On Sat, Jul 19, 2014 at 1:17 AM, Thomas Rast <tr@thomasrast.ch> wrote:
> I get this from t2026.2 under valgrind:
>
>   ==21334== Conditional jump or move depends on uninitialised value(s)
>   ==21334==    at 0x46D49B: prune_repos_dir (prune.c:182)
>   ==21334==    by 0x46D8C0: cmd_prune (prune.c:252)
>   ==21334==    by 0x405C2F: run_builtin (git.c:351)
>   ==21334==    by 0x405E47: handle_builtin (git.c:530)
>   ==21334==    by 0x405F6B: run_argv (git.c:576)
>   ==21334==    by 0x40610B: main (git.c:663)
>   ==21334==  Uninitialised value was created by a stack allocation
>   ==21334==    at 0x46D3BB: prune_repos_dir (prune.c:169)

Will fix. Thanks.
-- 
Duy
