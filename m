From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] builtin/grep: allow implicit --no-index
Date: Mon, 11 Jan 2016 07:50:40 +0700
Message-ID: <CACsJy8Bs3z0Gk3CjhyZGfOLA7R3pZQz7K5gk4BTytvYkZeyBtQ@mail.gmail.com>
References: <1452435597-12099-1-git-send-email-t.gummerer@gmail.com> <1452435597-12099-4-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 01:51:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIQhx-0004My-Iu
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 01:51:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757627AbcAKAvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2016 19:51:12 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:32959 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757375AbcAKAvL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2016 19:51:11 -0500
Received: by mail-lf0-f66.google.com with SMTP id z62so3237162lfd.0
        for <git@vger.kernel.org>; Sun, 10 Jan 2016 16:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=c5MkDNQe+9nIWAS7HEPqKDj51Xwz9v6a+wbe//rMPKg=;
        b=oOPSYNj5UB/l+I1LwnCxWe+iY9E1pwn+42o0wX41aftr8tcx8Mk7Q7OxthPWRtam44
         GF1TbjBFtGPCcsdUU/BMSJLSU6s2SE8zep/oplU6u1uLoiwrjXgkN2muq+XIAx2UFehh
         7M5xAVjpgTnB/yCqhA4SOhnuxrAFDtdQgxKwMgmZCop58g0srAt+zQaD7UeL6pSW4lfa
         Yr15echGJW6YCHBQYLSGK3DmKErSHX/x9H5swxVJ+kTDp+1x5sUguQ1e+FBh56WIbM7w
         VNHHZvR+ppgoZxHi5VkCNCPXGwpcFvO/cnafE2hdwgcVMDUliSY8WSS/lrCYqRC1avJl
         TY6A==
X-Received: by 10.25.144.17 with SMTP id s17mr30967862lfd.94.1452473469879;
 Sun, 10 Jan 2016 16:51:09 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Sun, 10 Jan 2016 16:50:40 -0800 (PST)
In-Reply-To: <1452435597-12099-4-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283629>

On Sun, Jan 10, 2016 at 9:19 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Currently when git grep is used outside of a git repository without the
> --no-index option git simply dies.  For convenience, implicitly make git
> grep behave like git grep --no-index when it is called outside of a git
> repository.

Should we have a line about this behavior in git-grep.txt, maybe the
description section? I wonder if anybody wants the old behavior (e.g.
non-zero exit code when running outside a repo). If there is such a
case (*), we may need an option to revert it back (--no-no-index seems
ridiculous, maybe --use-index). The safest way though, is introduce a
new option like --use-index=<always|optional|never> then you can make
an grep alias with --use-index=optional.

(*) I've been hitting really weird real-world use cases so I'm a bit paranoid..
-- 
Duy
