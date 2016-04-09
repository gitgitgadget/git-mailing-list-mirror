From: Elijah Newren <newren@gmail.com>
Subject: Re: [RFC/PATCH 00/18] Add --index-only option to git merge
Date: Fri, 8 Apr 2016 20:09:55 -0700
Message-ID: <CABPp-BG49Gr3Kf8Q3E6Vc=GF9MG+m10HkhkwbaOBfzs1cFcgVw@mail.gmail.com>
References: <1460098726-5958-1-git-send-email-newren@gmail.com>
	<5707ABBF.2050701@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Apr 09 05:10:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aojHj-0007yV-M5
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 05:10:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbcDIDJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 23:09:58 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33024 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbcDIDJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 23:09:57 -0400
Received: by mail-io0-f195.google.com with SMTP id g185so18882351ioa.0
        for <git@vger.kernel.org>; Fri, 08 Apr 2016 20:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=qWqDfcPAGVot/zt1JQAWQFclzumS+pt9/AlHIogdQOs=;
        b=pESu+yx4kRmpI74DeC3wil4En3jYmBQ5QRaW0MCnQ9Cn6jepg25g6Xbxafk9gGzqZ9
         4D9x4ocUIQr0TeiboiP1Sc+iDB/ay9FgbbYVO610f7dwep50efbc3ZaX0mNdYc/9JHiu
         pA/j36MUjYPuqZX4JQh2LdsLjwDU/eh5V5V7UJFjV6ghTeEt1o/QJInaqC2LOLHUqw/W
         NNWgLyUcPcnKVwtM/jgVu7dV5J4qfaa1I/rmY5SULHH1duKz+YdmTkTgqGkFkWkR0Mtf
         4596OK7XXATHs0TfSN6tOfE69ozBQ+vBsCbZB4ZkGIKLpCNru3aL6bpVKqjek8PvjNgU
         hoRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=qWqDfcPAGVot/zt1JQAWQFclzumS+pt9/AlHIogdQOs=;
        b=RcxrU3rFjbA2dRPi3GvC+AEioIoGk1waztI0/lIS3E8myDyLZfbUOzAPHf2Wg535p2
         u6tQRJKYEgVORhDVMj5/3msgnOEUFgCc8ErwEEj6aKf6UpnNlx/R70xvoIRHMj5S4A4W
         GsF9I2l7mhMYqfmnXWSs+ETvH/GBHDpgogruOhxoLlKicNz9GevcivWNkjvbC+nbGPPL
         fdxThbIKHGvDMukPy0zrTLc1/K6UvkDavYv6Q0vbnOTtchgbldnB7QgGZeWynXnt1dNu
         IFk4rRx1xzbuyCKGOJPbg35XX0K/lWJ4vT7H3Rliy+7omFgQlYajAIHcGrKosQsAbFkL
         14hQ==
X-Gm-Message-State: AD7BkJIYD2cWobtZR0U71imKxQry8j92H7NSBdY26CDr4KvDBCCebUACeI8ClEWJ1/GJDtH8rygWbN/s+ETeOA==
X-Received: by 10.107.15.159 with SMTP id 31mr12475550iop.3.1460171395665;
 Fri, 08 Apr 2016 20:09:55 -0700 (PDT)
Received: by 10.64.0.173 with HTTP; Fri, 8 Apr 2016 20:09:55 -0700 (PDT)
In-Reply-To: <5707ABBF.2050701@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291078>

On Fri, Apr 8, 2016 at 6:01 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> I haven't looked at your series thoroughly but immediately had to think
> of 'tr/remerge-diff' (on 'pu'), see
> http://permalink.gmane.org/gmane.comp.version-control.git/256591
>
> There, Thomas used index-only merge to reproduce an automatic merge as
> the base for a useful "remerge-diff".
>
> I've been rebasing (and using) that series on 'next' for a while now
> without any problems; some reasons kept it from being merged on next,
> see the thread.
>
> So, it would be interesting whether you solve the same problem
> differently, or face the same problems ;)

Thanks for the link.  Looks like a very interesting series, even if
we're solving slightly different problems (I don't want conflicts
auto-resolved; I want to be able to look at what conflicted and why
with commands like 'git ls-files -u' afterward.)

But the problem he's trying to solve is interesting to me too.  We
have one patch from each of our series that does overlap, the
index-only modification to merge-recursive, though implemented
slightly differently.  I think mine's a little clearer, and I have a
hunch that he might be able to use the idea in mine to dramatically
simplify some of the other stuff he's doing.  In particular,
merge-recursive already has code to auto resolve conflicts that he
could just re-use instead of reimplementing, which I believe would
dramatically simplify his patch #8.

I didn't read all his code super closely, so I might be missing
something important, but I got the feeling that he didn't need
different behavior than what merge-recursive already implements for
virtual merge bases, and that even he wasn't certain whether he had
handled all cases (e.g. not only conflict markers and modify/delete,
but also rename/delete, rename/add, rename/rename (both 1to2 and
2to1), D/F conflicts, and perhaps others I'm not thinking of at the
moment).  We already have well reviewed and tested code for all those
cases; it's just a subset of the things triggered by o->call_depth for
virtual merges bases.  Also, like the index-only stuff triggered by
o->call_depth, the auto-resolve-conflict stuff is pretty well
separated so it should be easy to add a flag to trigger just this
portion without getting all the other stuff that o->call_depth
normally does.

As far as I could tell, his series stalled out both because of
concerns surrounding whether all the automatic-conflict-resolutions
were correct, and because it made git log no longer be a read-only
operation.  Neither of those concerns are applicable to my patchset; I
invented totally new problems and concerns instead.  :-)  I don't have
a good solution to the second concern for his patchset, but I think
there's probably an easy solution to the first.  Once I get my
patchset cleaned up, I may take a look at reviving his (if he doesn't
beat me to it.)
