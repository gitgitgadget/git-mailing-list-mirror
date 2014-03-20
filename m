From: George Papanikolaou <g3orge.app@gmail.com>
Subject: Re: [PATCH] builtin/apply.c: fuzzy_matchlines:trying to fix some inefficiencies
Date: Thu, 20 Mar 2014 12:58:12 +0200
Message-ID: <CAByyCQAsjoBiv54PR+AP=2ci60o39TNw5FhM0aNOhzbZpLd7gg@mail.gmail.com>
References: <1395279167-20354-1-git-send-email-g3orge.app@gmail.com>
	<532ABBE1.4090001@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 20 11:58:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQafy-0006r1-H6
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 11:58:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755070AbaCTK6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 06:58:14 -0400
Received: from mail-ve0-f179.google.com ([209.85.128.179]:59328 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbaCTK6N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 06:58:13 -0400
Received: by mail-ve0-f179.google.com with SMTP id db12so704354veb.38
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 03:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tzQZ00aG0u00Sq8bNEUjyWhAk/TR6d6kvs6964eD0F0=;
        b=yFGltP6eMIZ8lXF0kgaM5QLD9Tvw5XpAlpnLYZgZhcYks+nNcwXOu1VzZivyogeevK
         1qms4TbbvrzgKIL1HpkNeLvC69t4cgzRk1Is3ggZEL6aJAmULJr7RGV/Xl62sLe0zT0s
         VzyAZ0GdPF1PNqFbz3uM0tgUoLrecBiWyonKi9TGVViOn4IUP9VBWnNt9Qd2x4gquyKe
         teKnRZJhnavNNCHkiaZsQFl0hrg0ZmhpwmCOvP4K3Tomy/mggv3J7u3h8bYnqY7cMNDb
         oXtguF/Sflxq+GAAT39BGo8Acw4An5/lW0y/WPnU3juWC8fdljct+Nbqnes+deRMvhNG
         TpqA==
X-Received: by 10.52.8.225 with SMTP id u1mr108082vda.64.1395313092396; Thu,
 20 Mar 2014 03:58:12 -0700 (PDT)
Received: by 10.58.29.48 with HTTP; Thu, 20 Mar 2014 03:58:12 -0700 (PDT)
In-Reply-To: <532ABBE1.4090001@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244540>

Hi,
Thanks for the feedback,

On Thu, Mar 20, 2014 at 11:58 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>
> Why is this an improvement?  Do you expect this function to be called
> often for empty lines (as opposed, for example, to lines consisting
> solely of whitespace characters)?
>

Yes, you are probably right, we are not gonna get much (if any)
completely empty lines

>
> The comment just above this change gives a justification for putting an
> "if" statement surrounding the "while" statements.  Do you think the
> comment's argument is incorrect?  If so, please explain why, and remove
> or change the comment.
>

I see what I did wrong. I thought since that the if-condition is double checked
(from the while clause) so I removed it.

Also this lead me to see that since the while clause is now unconditioned, there
is no point of it being replicated exactly the same above, so I
removed that too. =(

I'm trying to find other inefficiencies/irregularities on that
function. I'm currently
thinking on merging the first checks with a call to iswspace() or
something similar.

Also thanks for clarifying the way patches/mails work.

Cheers.

---
papanikge's surrogate email.
I may reply back.
http://www.5slingshots.com/
