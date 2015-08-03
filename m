From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/RFC 0/2] bisect per-worktree
Date: Mon, 3 Aug 2015 20:02:40 +0700
Message-ID: <CACsJy8Cx_PTehaeQgXxGaTNRF2DUSNqbBYPQ5gQ0BYGpz6kQvQ@mail.gmail.com>
References: <1438387012-29229-1-git-send-email-dturner@twopensource.com> <55BC4438.8060709@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Aug 03 15:03:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMFOd-0004fM-MA
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 15:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187AbbHCNDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 09:03:11 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:32844 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178AbbHCNDK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 09:03:10 -0400
Received: by ioii16 with SMTP id i16so143489322ioi.0
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 06:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=pyx0giK/qwf8viVuA+WzH3VwYMg4ivoIbXeEj9BjrB4=;
        b=vx+ig1WBHI0EhXPB2pI21goEzOSktToZnJSxg06C/M+j98fYTMxASxztS/1RH8VJX+
         We3IdXLjwqz/eU7SckQe6AE8K/VUFLDT8rcvPiu6XEElT5uI3CF2L3rmx6Qq2TajowbB
         xYZ9yP/tlpEFkAa2BVL+dSAObZZ0gdhp0Q7Y29oE75GLAs7HMmkctCB84BNo68obe0DO
         +HBUEb3XKo87Ok29ulDT0Oh8acwE5OGtjtzsokBKZ0uI4U6DOzeL7z4OBpSZOfVuOccj
         TBVrMXPUNUECMmmr+q/xZ3bdymGk1u9hQ/LGgVsP1rpLrG6l7DWrGhDFbfvJSwA4C4IX
         NrOw==
X-Received: by 10.107.19.206 with SMTP id 75mr19314899iot.191.1438606990102;
 Mon, 03 Aug 2015 06:03:10 -0700 (PDT)
Received: by 10.107.191.193 with HTTP; Mon, 3 Aug 2015 06:02:40 -0700 (PDT)
In-Reply-To: <55BC4438.8060709@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275163>

On Sat, Aug 1, 2015 at 10:59 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Either way, there's also the question of who should know how to find the
> worktree-specific references--the program that wants to access them, or
> should there be a secret invisible mapping that is done on lookup, and
> that knows the full list of references that want to be worktree-specific
> (for example, that in a linked worktree, "refs/bisect/*" should be
> silently redirected to "refs/worktree/<name>/bisect/*")?
>
> It's all a bit frightening, frankly.

I would think all work to make pluggable backends happen should allow
us to do this kind of transparent mapping. We can add a new file-based
backend with just this redirection, can't we? I haven't read the
updated refs.c though, need to do it now..
-- 
Duy
