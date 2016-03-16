From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Tabs in commit messages - de-tabify option in strbuf_stripspace()?
Date: Wed, 16 Mar 2016 09:15:39 -0700
Message-ID: <CA+55aFwFsBKZZeqhBDf_YXG6vrSrvfFVCsRc0mkFUiDS9Rd+QA@mail.gmail.com>
References: <CA+55aFzHMp4hiCp7+2Yxy=KNQ_rBru3RM-pghXUPtoxr_L+w2w@mail.gmail.com>
	<xmqq4mc76yji.fsf@gitster.mtv.corp.google.com>
	<CA+55aFyXXHNrJW56A_DKkmrmGpWxeUd6row_ja3bzqhs_yswhw@mail.gmail.com>
	<CAGZ79kZihaftwwmY23mZ_i4H6vv2Z9r=LC68M0MMD1o2h2Z4Sw@mail.gmail.com>
	<CAGZ79kZtAm1M=9CGDGxPdecXEuNEQcbpQb3FNj9=Py0VE2UrKQ@mail.gmail.com>
	<56E96D61.6060007@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 17:15:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agE6s-0005Um-32
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 17:15:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753388AbcCPQPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 12:15:41 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:35582 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbcCPQPk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 12:15:40 -0400
Received: by mail-io0-f177.google.com with SMTP id g203so65249446iof.2
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 09:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=MqsBz7Dko/wTKfH0ClYx2woqgROINhTwUAwBo7lE70Y=;
        b=c4ILtRxhJISb1LsIJUH1YaznIlHsO31w6gMOQVMgLp24kTDp8zXopspJl4q6LXTUXo
         6WYu5b4aYLYm5pcSbH8f5y6fjTH4PWF0W46ybG31k/Fs6rW8o9zP52KDD2OP6ywSn2Xs
         YdwLs4UQhr0cTIrX+aZT4eB3oRBJw+vKBVZEVs089ApLIm8trMc9Y/lQwQMpI84GFiL6
         XwTYN7NBbULNwFYjUqmBszGL4wquQkCN1VHjXz38pkJCO/fBi2U6UzB99bQXuIsD74K0
         VA+knRU3jnbSYso4zUHvBnaQtmtMmoBS0gpm2zHkg2+nm1LzcU26bWfHr8/L4nuWyg4Z
         FLfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=MqsBz7Dko/wTKfH0ClYx2woqgROINhTwUAwBo7lE70Y=;
        b=dqSQxqXf0DN7NVE2eTW0Arf1ixg0fjcMpKRbIiaW/5sAzW2856MYug2kVVWm1gu3lO
         7xT/krvV26r503xfxUPpJ2+Z9yLQBmgDzHJEt9NQ8CvSUdNCC2lq8m8v7klanvU8jlFX
         yd13EgJ7lMhtauG/FDan6/n/r3RlhqRlZvuqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=MqsBz7Dko/wTKfH0ClYx2woqgROINhTwUAwBo7lE70Y=;
        b=ZYsjzGRozpGl5cAnZgNbmtqqAM22W65EdSwy/aVameMyNhYwyQMNx5Ow67x9QWjbmW
         UEWMUQRQk1SvZOKxsAVrQ/lanICL4j7//FRxdUavPEv1MgkHQLFUEkezkGpG8mi3dDyK
         mwmIbt3nf9UfgIT8FrSbWFu0hSnEXSVN6iRm3qSA6sUMsZjDXp/jTpE2sl7kbAFd/wmS
         DkicGvTMJVnXVi8GjuliZP4tnsAy3T1RhRNE5FUSJ3x+MluF1uJUdwe+fUhiUqfdpgPD
         z/yR1h/OPjmQLezSPLwojWxCvQgkxREGEwBkTUOlOF2vPQxwk2VUf/MIRX9nHWdRg4BQ
         /ptA==
X-Gm-Message-State: AD7BkJI9ZWSRgFM7gr09QS10X7Bi991BxVEsgm1Ui6+e32LcixzFHhYQ3cObf7g/e6Q/XhtH6akpzqlkEjxkng==
X-Received: by 10.107.6.224 with SMTP id f93mr5138088ioi.137.1458144939977;
 Wed, 16 Mar 2016 09:15:39 -0700 (PDT)
Received: by 10.36.93.202 with HTTP; Wed, 16 Mar 2016 09:15:39 -0700 (PDT)
In-Reply-To: <56E96D61.6060007@xiplink.com>
X-Google-Sender-Auth: SAThpVtkwV1-kbsbuiwajGOaFns
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288984>

On Wed, Mar 16, 2016 at 7:27 AM, Marc Branchaud <marcnarc@xiplink.com> wrote:
>
> Could this also help with diff output, where the leading + or - mars the
> indentation in a similar way?

I don't think that's a good idea at least by default, since then it
will break things like running diff in emacs capture mode.

So even if you're in a terminal, you can't assume that you can munge
the output too much.

Of course, if colorization is on, you might as well pretty-print the
diff by indenting things properly too, since the end result isn't
going to be used as a _diff_.

              Linus
