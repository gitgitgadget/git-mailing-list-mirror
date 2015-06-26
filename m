From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: revise manpage
Date: Fri, 26 Jun 2015 10:54:25 -0700
Message-ID: <xmqq8ub6uzhq.fsf@gitster.dls.corp.google.com>
References: <12a2e2d5e545459837b5eb2356cfc2fe4e3ef631.1435317576.git.mhagger@alum.mit.edu>
	<vpqwpyqws53.fsf@anie.imag.fr> <558D67FD.2000607@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jun 26 19:54:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8Xph-0003oS-Kg
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 19:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219AbbFZRya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 13:54:30 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:33668 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbbFZRy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 13:54:28 -0400
Received: by igtg8 with SMTP id g8so6604937igt.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 10:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ffz3eC2JMXIyQuIoR46s4djMWcCbS0ILyNyRCd+MI8I=;
        b=vnrce3QLr2wP8G9ocwea4n2twwNgZ7P8+bRKBU3pdqT5NcNeI2XYNLoT0rgva8YtiP
         kzAwLRdLZIDuHuYAFCPETMjIP5r6Zr/YeUgP9G8O7hq1GM3SwS0HGOPSg3hir8CHjBvs
         NYrYjVSoLLyy7pnh2g27Vzm8H+wQOKzyxHA9nkuXOMb8iTTpNDTQYc2zRazGNYVvTwxR
         UKYarxy0Zo7iHVe6wqb6m/7QCTGJXpUV+Us9wRPjt35bagNXU6Qn+30QI8b59DywZmg0
         MYPosbqzLXnlQc6GPVP11NzpU1UBKAHOqok7FfZC9H6/al7PQnIXwO7M+fxc5qXM/a8r
         dLxA==
X-Received: by 10.42.154.5 with SMTP id o5mr4548241icw.16.1435341268084;
        Fri, 26 Jun 2015 10:54:28 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6587:7c7a:db33:ca35])
        by mx.google.com with ESMTPSA id rj5sm1295186igc.2.2015.06.26.10.54.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Jun 2015 10:54:27 -0700 (PDT)
In-Reply-To: <558D67FD.2000607@alum.mit.edu> (Michael Haggerty's message of
	"Fri, 26 Jun 2015 16:55:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272807>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> By the way, when I was revising the text two things occurred to me that
> have probably been discussed to death elsewhere but let me mention them
> anyway:
>
> 1. I found it confusing that `git bisect terms` lists its arguments in
> the order `<term-new> <term-old>`. I think that listing them in
> "chronological" order would have been a lot more intuitive. But I expect
> this choice was made because `git bisect start` takes optional arguments
> in that order, so the inconsistency might be worse than the backwardness
> of this single command's arguments.

Consistency with 'start' is truly a good motivaition.  And 'start'
asking for 'bad' first is not backwardness but comes primarily from
syntactic need.  You need one and only one 'bad' and can give zero
or more 'good' to the command, so "start bad [good...]" becomes a
more natural way than "start [good...] bad" to form a command line.

> 2. When I was describing "old/new", I kept wishing that I could type
> "before/after" instead, because those terms seemed to agree better with
> the prose description of what "old/new" mean. I wonder if "before/after"
> might be better names for commits determined to be before/after the
> change being sought?

Yeah, I like that, but I do not think replacing 'old/new' with
'before/after' is worth the trouble.  Both would work equally well
at least for me.
