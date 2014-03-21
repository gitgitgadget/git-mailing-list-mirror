From: Brian Bourn <ba.bourn@gmail.com>
Subject: Re: [RFC] [GSoC] Draft of Proposal for GSoC
Date: Thu, 20 Mar 2014 23:39:34 -0400
Message-ID: <CAM+=D-D6Vn613YuadqiByhYk9gFM8MLfiS_x=YcYb-9qHQTgOg@mail.gmail.com>
References: <CAM+=D-BWCt9kNSUUQ19ZcPykb6j-tuEr=igBz0ukEk2TA3vWkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 21 04:39:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQqJ3-000342-3c
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 04:39:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758883AbaCUDjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 23:39:37 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:53244 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758783AbaCUDjf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 23:39:35 -0400
Received: by mail-qg0-f49.google.com with SMTP id z60so5438564qgd.8
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 20:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=Ll/Ad1u995M/fxWzX/rb5VjeJQeCaQaFJOfAs8yjY/I=;
        b=H6ijkLYhJjCh47swHLUBZvAIEQwFqlnCimu91zkHBVgBfam3LOwg+S+pnFsqfZkQDu
         ntr4Q5V/n4XKehTBY2W+NSNRizYLJCwMdSXbHKLPa3kIqsvk49a3NK2rYrQDklFaPPOj
         UbpgsKFWnB5gA4TSztBXfehjE6Tvp76U1YKWkoUfcQkdXnTw1vd6iF0Ffw+S2+oOnJ0z
         vRROwOM12x7mUaO867z6tZhRCxcCjzMoefDSefCHoe1UY2zKyyKDaa/ypF//0ld5Es2e
         GFaGvfklpO2QeylAfxeC8T3Q75LH+CP7TsZLjtM6op2VfPHWuM1JE5G7vmX1ZvkpsLPq
         1/kw==
X-Received: by 10.224.160.142 with SMTP id n14mr55748352qax.17.1395373174760;
 Thu, 20 Mar 2014 20:39:34 -0700 (PDT)
Received: by 10.96.86.38 with HTTP; Thu, 20 Mar 2014 20:39:34 -0700 (PDT)
In-Reply-To: <CAM+=D-BWCt9kNSUUQ19ZcPykb6j-tuEr=igBz0ukEk2TA3vWkg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244633>

Hello again,

Please it would be very helpful for me to get some comments on this
proposal I would be very grateful towards anyone who could take some
time to look at it, even if it's just the wording.
Regards,
Brian Bourn


On Thu, Mar 20, 2014 at 2:15 PM, Brian Bourn <ba.bourn@gmail.com> wrote:
> Hi all,
>
> This is a first draft of my Proposal for GSoC, I'd love feedback about
> what I might be missing and any other files I should read regarding
> this, so far I have read most of tag.c, branch.c,
> builtin/for-each-ref.c, parse-options.c. once again I hope I can get
> the same amount of helpful feedback as when I submitted my
> Microproject.
>
> My name is Brian Bourn, I'm currently a computer engineering student
> at Columbia university in the city of New York.  I've used git since
> my freshman year however this past week has been my first time
> attempting to contribute to the project, and I loved it. I'd
> particularly like to tackle Unifying git branch -l, git tag -l, and
> git for-each-ref.  This functionality seems like an important update
> to me as it will simplify usage of git throughout three different
> commands, a noble pursuit which is not contained in any other project.
>
> Going through the annals of the listserve thus far I've found a few
> discussions which provide some insight towards this process as well as
> some experimental patches that never seem to have made it
> through[1][2][3][4]
>
> I would start by beginning a deprecation plan for git branch -l very
> similar to the one Junio presents in [5], moving -create-reflog to -g,
>
> Following this I would begin the real work of the project which would
> involve moving the following flag operations into a standard library
> say 'list-options.h'
>
> --contains [6]
> --merged [7]
> --no-merged[8]
> --format
> This Library would build these options for later interpretation by parse_options
>
> Next I would implement these flags in the three files so that they are
> uniform and the same formatting and list capabilities can be used on
> all three. The formatting option will be especially useful for branch
> and tag as it will allow users to better understand what is in each
> ref that they grab.
>
> For the most part I haven't finalized my weekly schedule but a basic
> breakdown would be
>
> Start-Midterm
> Begin deprecation of -l
> Spend some time reading *.c files even deeper
> Build Library(dedicate Minimum one week per function moved)
>
> Midterm-finish
> Implement the list flags
> Implement the format flags
> (if time is left over, add some formatting)
>
> Additionally I am thinking about adding some more formatting tools
> such as numbering outputs. What do you all think of this?
>
>
> [1]http://git.661346.n2.nabble.com/More-formatting-with-git-tag-l-tt6739049.html
>
> [2]http://git.661346.n2.nabble.com/RFC-branch-list-branches-by-single-remote-tt6645679.html#a6725483
>
> [3]http://git.661346.n2.nabble.com/RFC-PATCH-tag-make-list-exclude-lt-pattern-gt-tt7270451.html#a7338712
>
>  [4]http://git.661346.n2.nabble.com/RFC-branch-list-branches-by-single-remote-tt6645679.html#a6728878
>
> [5]http://git.661346.n2.nabble.com/RFC-PATCH-0-2-RFC-POC-patterns-for-branch-list-tt6309233.html
>
> [6]https://github.com/git/git/blob/master/builtin/branch.c#L817
>
> [7] https://github.com/git/git/blob/master/builtin/branch.c#L849
>
> [8] https://github.com/git/git/blob/master/builtin/branch.c#L843
>
> Regards,
> Brian Bourn
