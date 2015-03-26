From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [RFC/GSoC] Proposal: Make git-pull and git-am builtins
Date: Thu, 26 Mar 2015 13:02:54 +0800
Message-ID: <CACRoPnQusL85-ZOoM3Mg579eyvcL=BOgzz6KsnnNC5hRY9uAFw@mail.gmail.com>
References: <20150324163730.GA8366@yoshi.chippynet.com>
	<xmqqwq265jjl.fsf@gitster.dls.corp.google.com>
	<CACRoPnTL78ZrqPYYNPkNcW7vConHZXZ66z5P2=3HySrtmZKcrg@mail.gmail.com>
	<xmqq4mp92c9h.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 06:03:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yazwa-00028O-87
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 06:03:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbbCZFC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 01:02:56 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:32843 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbbCZFCz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 01:02:55 -0400
Received: by labto5 with SMTP id to5so36798579lab.0
        for <git@vger.kernel.org>; Wed, 25 Mar 2015 22:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tcToLIc8hL7WJEampuKaUsFNp4MVKUbkX7xDojGDeEM=;
        b=w17weANJqjfl++R3SrsiatH+uSyePngimShN8rEz4oKmu9h2QsBqUb/u/9jC+8/sPw
         PQxkFYy2J2qlQZFRNaBJnvmDiVDcSUdXE024hSPOSMU80SxBqglLFu6+E4//4zJcuquf
         81FC2+5B4OcL2SxdCCLdVm3/m4o7bUhfmnnHueeoNXujzYv/J/CPWgYyjiIRGTEJPfxx
         5Pd061HYur2N2w0knAbwxPDczps4p9came61eN4UfiyjuWPRYiTlqX2BWiQAsCEz3T4W
         8b6LWc7s7/JFH9eEqXhWieMi4dG1bF4Ee3QofgdTRSZyvAmwOA7ZR7eT57P/BJpPZiVc
         ipjw==
X-Received: by 10.112.44.132 with SMTP id e4mr11732998lbm.66.1427346174106;
 Wed, 25 Mar 2015 22:02:54 -0700 (PDT)
Received: by 10.112.130.228 with HTTP; Wed, 25 Mar 2015 22:02:54 -0700 (PDT)
In-Reply-To: <xmqq4mp92c9h.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266312>

On Thu, Mar 26, 2015 at 1:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>
>> I think it's still good to have the ideal in mind though (and whoops I
>> forgot to put in the word "ideal" in the text).
>
> Using or not using fork is merely one of the trade-offs we can make.
>
> "If all other things are equal, no fork is better than a fork" is a
> meaningless statement, as all other things are never equal in real
> life---doing things internally will have a cost of having to clean
> up and a risk to get that part wrong, for example.  Engineering is a
> fine balancing act and setting an absolute goal is not a healthy
> attitude.

No, I do not mean "all other things are equal", I meant "all other
things are ideal", meaning that human factors are not involved.

I thought we were in agreement that calling functions in the internal
API is technically superior to forking, assuming that there are no
bugs or errors. Isn't this one of the reasons why libgit2 exists? If
for whatever reason spawning an external git process is chosen, it
would be because rewriting all the code paths without committing any
errors would take too much effort.

I will switch the word "requirements" to the word "guidelines" to make
it sound less strict. However my above point still stands.
