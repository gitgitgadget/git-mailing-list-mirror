From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 0/3] Towards a useable git-branch
Date: Thu, 30 May 2013 11:19:41 +0700
Message-ID: <CACsJy8DA4oCj3WPmJY6aA7Gq3Xx4xqZ2XxxiZUuR6TqgK=f6Ww@mail.gmail.com>
References: <1369405177-7855-1-git-send-email-artagnon@gmail.com>
 <CACsJy8AEkmiWP46tOBkXRkWDGO+k5YW+GJB-ak8HfTpghQP5eQ@mail.gmail.com>
 <CACsJy8Av8LmiefR5XFuFadZERmivZAAB9TbysFjeUSb2hzgWBw@mail.gmail.com>
 <CACsJy8CW-xtXR15m80oaoex0QF5Vi2L2-kqEzOPxCY2UBmdhxw@mail.gmail.com>
 <CALkWK0kb2D2nH_pDi0TihmFzuEAvWnGJeX0sOXD1TEWLZ7YWHw@mail.gmail.com>
 <CALkWK0k=2NZsbSnxS50w+bux8q9mZh7GZzpCqhTP=2jqyHnBSg@mail.gmail.com> <CALkWK0nFDdfGKeRqKKTTMSm4zqHDOt_iGc1aA7LgD9=y2DJO5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 30 06:20:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhuLZ-0000Dy-Tz
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 06:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778Ab3E3EUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 00:20:14 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:35304 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717Ab3E3EUM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 00:20:12 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so8513037obc.6
        for <git@vger.kernel.org>; Wed, 29 May 2013 21:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YCajH/k95CUQCgaD9k/2wnw1soVEWWbVMK9Hn3/KDqc=;
        b=iSlvQNREPU6+57D/UZPLbY+kkzQAlk9eZeJqiFHMMoakH8iMUtIXp8ZQzRUP5F4/cv
         r0HjUt3Hutjtka6IIvhkmFoexqyhoO9J9iwUPtV32vrYhN0XTsgt6gdJvDiWF29cr2Ng
         KrQIkEvdWAvVn3+D1Ai8fFVGbhd5/yFXndBK6dMXD04BAhW7lfzMEGwdrUnv/2PomTpx
         v2a5y6z0Q5vDZYL1kEnXpAoCGHJ5vQEaNu8HvoVptQ6ywvqomHJj18620PpQMjTYI+ex
         9QLwMaCea70nK2tpybCHxydBZGDYnewUBXIX7xBpgySh5dG/hC7dyprDcPSaeDF0z+Za
         O9lg==
X-Received: by 10.60.97.232 with SMTP id ed8mr2293436oeb.96.1369887611808;
 Wed, 29 May 2013 21:20:11 -0700 (PDT)
Received: by 10.76.171.199 with HTTP; Wed, 29 May 2013 21:19:41 -0700 (PDT)
In-Reply-To: <CALkWK0nFDdfGKeRqKKTTMSm4zqHDOt_iGc1aA7LgD9=y2DJO5A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225921>

On Tue, May 28, 2013 at 9:24 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Oh, and by the way:
>
> We're pretty close we are to replacing branch -v and branch -vv.
>
> brv = for-each-ref --format='%(HEAD)
> %C(green)%<(*)%(refname:short)%C(reset) %<(*)%(objectname:short)
> %(subject)' refs/heads
>
> brvv = for-each-ref --format='%(HEAD)
> %C(green)%<(*)%(refname:short)%C(reset) %<(*)%(objectname:short)
> %C(blue)%(upstream:short)%C(reset) %(subject)' refs/heads
>
> There are small differences:
>
> 1. In branch -v, the green-color of the branch name is dependent on
> %(HEAD).  Not worth ironing out, in my opinion.
>
> 2. In branch -vv, there are dependent square braces that come on when
> %(refname:short) is set.  We might want to introduce an undocumented
> %(refname:branchvv) for internal use by branch -vv, for backward
> compatibility.
>
> What do you think?

I think we can change -v and -vv format slightly as long as the
information remains the same. Nobody should ever parse these output
with scripts. The color can be generated from color.branch.*. A bigger
problem is show_detached(), --[no-]merged, --with and --contains. We
need to move some of those code over to for-each-ref. Another problem
is the new "branch -v" seems to less responsive than old "branch -v"
because (I think) of sorting, even if we don't need it. I checked out
your branch, made some more updates and pushed out to my
for-each-ref-pretty again. Changes are:

 - fix segfault with "for-each-ref --format=%something refs/tags/'
 - add --pretty for new format syntax and keep --format unchanged
 - add --[no-]column to for-each-ref (for "git branch" with no arguments)
 - remove branch listing code and use for-each-ref instead (41
inserts, 378 deletes, beautiful).
 - add --sort and --count to git-branch
--
Duy
