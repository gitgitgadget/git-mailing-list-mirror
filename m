From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Fix typesetting in Bugs section of 'git-rebase' man page
 (web version)
Date: Tue, 19 Nov 2013 17:24:53 -0800
Message-ID: <20131120012453.GD4212@google.com>
References: <1384906483-15260-1-git-send-email-jstjohn@purdue.edu>
 <20131120003130.GC4212@google.com>
 <CAEjxke-C1H1NpD=Hmiz6MO3OjtPvkUktKvF7zSqfGnruHQ9-Ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Jason St. John" <jstjohn@purdue.edu>
X-From: git-owner@vger.kernel.org Wed Nov 20 02:25:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViwXO-0005tu-AL
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 02:25:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358Ab3KTBY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Nov 2013 20:24:58 -0500
Received: from mail-yh0-f54.google.com ([209.85.213.54]:59940 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355Ab3KTBY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Nov 2013 20:24:57 -0500
Received: by mail-yh0-f54.google.com with SMTP id a41so4207702yho.27
        for <git@vger.kernel.org>; Tue, 19 Nov 2013 17:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=rm1asd/dpWr4hVYA1k8T+ZrpyDzW+CxSGu7tZ/JlAMA=;
        b=HFTJGOuGVgXX4OfQdBQDbE4cZ3TtE32n+wJhEJCd+8ZMSyL3TbIYgTD56V556KLZsT
         TVd5BnIkcv5o7thImhFp6Gbzm5eepsiHU/y1WRmD3ftkURMpjCuu3HKDadwefMBpcv4v
         b5QY/QR416M7UyVGPbpYPVQqB5Wz8hX5DxWxzw1key1mhEZmE7mnYgwPaM3H+srF/FVg
         YCUoiTKeSdlE3UdJUCsGLr8X0q/C8ZOfQIQYB1SjODdDcqwYkD0Pz0Qxh6Gm9c2wIfKy
         oWwDW8quG9SH4D6rXt1BehMkmKrTMAaWAHBmUKwQIIjSmaywCtBcgMobt78BOCCfYNQg
         R/Tw==
X-Received: by 10.236.77.231 with SMTP id d67mr73003yhe.113.1384910697340;
        Tue, 19 Nov 2013 17:24:57 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id u52sm39291838yhg.5.2013.11.19.17.24.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 19 Nov 2013 17:24:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAEjxke-C1H1NpD=Hmiz6MO3OjtPvkUktKvF7zSqfGnruHQ9-Ew@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238059>

Jason St. John wrote:
> On Tue, Nov 19, 2013 at 7:31 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Jason St. John wrote:

>>> Documentation/git-rebase.txt: add a blank line after the two AsciiDoc
>>>     listing blocks
>>
>> I'd leave out the above two description lines, since they're redundant
>> next to the patch text.
>
> I included that because SubmittingPatches says to do so.

Thanks for explaining.  Can you point me to which part of
SubmittingPatches said to include that kind of thing?

[...]
> How do you recommend I proceed? Should I resubmit with just a revised
> commit message? Should I incorporate this into a larger patch set that
> should fix all of the errors in git-rebase.txt, git-svn.txt, and
> gitweb.txt?

Thanks for checking.  You have a few choices.

 a) Check if asciidoctor reproduces the problem, and if so, report it
    as a compatibility bug.  Ask the gitscm-next maintainers to get
    their copy of asciidoctor up to date.

 b) Come up with a simple rule about how these "----" blocks should be
    formatted, and apply it consistently to the documentation in
    Documentation/, with a commit message explaining the story so
    future contributors know to continue to follow it.

 c) Resend the same patch that just fixes git-rebase.txt.  Include a
    Reported-by line to credit the person who originally caught the
    error.  Explain what's going on in the commit message and that
    there are other instances of the problem that this patch doesn't
    yet fix.

I prefer (b), since it would solve the problem more completely and
means future readers wouldn't be confused about which style to use,
but other possibilities (e.g., some combination of the options listed
above, or something else entirely) could work as well.

Thanks again for tracking this down, and hope that helps,
Jonathan
