From: Bernd Jendrissek <bernd.jendrissek@gmail.com>
Subject: Re: git diff vs git diff-files
Date: Tue, 14 Aug 2012 15:11:46 +0200
Message-ID: <CAF7PVPqZRjWv4Z=a21yf=_NXrWd4b5M3ROx=dLQ6MbNRFKt1dg@mail.gmail.com>
References: <CAF7PVPrex6sJMU+uvxQOSpB12qSTp2barTycow_-LZ8Ngbv7uQ@mail.gmail.com>
	<87fw7qhm31.fsf@thomas.inf.ethz.ch>
	<CAF7PVPqyaZQtca0KfWHirBY2Dvdtn2RT-_mxR8x5uUNsfbHmdQ@mail.gmail.com>
	<87vcgl999v.fsf@thomas.inf.ethz.ch>
	<CAF7PVPq0Wjck+53G4=Ofz0drMdx9NtpfgzMFR4j=32N-ez2xBg@mail.gmail.com>
	<87393pztk4.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 14 15:11:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1GuZ-0004sp-IW
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 15:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755385Ab2HNNLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 09:11:50 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:53441 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754206Ab2HNNLt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 09:11:49 -0400
Received: by qaas11 with SMTP id s11so1729291qaa.19
        for <git@vger.kernel.org>; Tue, 14 Aug 2012 06:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Fa6mkjPKftCpnvOZvzi8YV2su80FDp2AbNnv2Xu/ZXk=;
        b=dS+elO4do1KFjUTM+ztu1BI4r7DOYzWPgFeFs6IZCsuH85b+BFh3n4o/nhqbXgtEK8
         1o6SQ7Czpm4bB7ff5b7iFv+4mCoU8PQhF+PZIakNbtLge90Y83juwvQIkACULDc2JtYC
         0A2jVX6VOYV/dzZvZSQMIozh+svcyMxXxHIvwTfqEiNTmHLzUDrnIsTQX6eRdo3yKKUd
         aGohq7iuHvtBkJ8pIeFfpV/YSbSbfILzTGLe1EcKx+DIhyYlIdaAOrHLsajDXbid0tAx
         2EfKbjOF6qxc0Jh9GYGevVBA+IeQNWiQ18qaKHgANk5SHt0oOl/yKAWts3zZrSCM2pn7
         pFkg==
Received: by 10.60.169.75 with SMTP id ac11mr25165806oec.12.1344949906445;
 Tue, 14 Aug 2012 06:11:46 -0700 (PDT)
Received: by 10.182.46.165 with HTTP; Tue, 14 Aug 2012 06:11:46 -0700 (PDT)
In-Reply-To: <87393pztk4.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203399>

On Tue, Aug 14, 2012 at 11:55 AM, Thomas Rast <trast@student.ethz.ch> wrote:
> Fun stuff.  This will be very interesting to debug.  It's still
> possible, though perhaps not extremely likely, that git is writing
> garbage to the terminal and it just happens to work for xterm.
>
> Whatever you do next, *please* post the *exact* file contents *and*

Hmm, this really isn't about git anymore, as I've reduced this problem
to the following file:

0000000: 200a 200a 200a 200a 200a 200a 200a 200a   . . . . . . . .
0000010: 200a 200a 200a 200a 200a 200a 200a 200a   . . . . . . . .
0000020: 200a 200a 200a 200a 200a 200a 200a 200a   . . . . . . . .
0000030: 200a 200a 200a 200a 200a 200a 200a 200a   . . . . . . . .
0000040: 200a 200a 200a 200a 200a 200a 200a 200a   . . . . . . . .
0000050: 200a 200a 200a 200a 200a 200a 200a 200a   . . . . . . . .
0000060: 200a 200a 200a 200a 200a 200a 200a 200a   . . . . . . . .
0000070: 200a 200a 200a 200a 200a 200a             . . . . . .

berndj@capybara:~/gaf.git$ nl /tmp/g
     2	
     3	
     4	
     5	
     6	
     7
[snip]
    60	
    61	
    62	
berndj@capybara:~/gaf.git$

Anything shorter than that causes first the command line (what you
might call line 0, not the one you might call line 63, and yes, I do
not that this is close to a binary round number), and after that,
nothing to disappear.

strace confirms that gnome-terminal reads, but neglects to write, line 1.

I notice now that a second gnome-terminal tab in the same directory
running the same commands reliably displays the correct output. I must
have dumped an ELF file to the terminal at some point, or something
similarly daft like that, and forgotten to reset the terminal. Not
that I recall having done such a thing recently.

In any case, it's too late now; I ran reset(1) and the terminal is
back behaving itself.

Thanks for helping me get (close to) the bottom of this. If git were
to be guilty (which I very much doubt), the evidence is long gone now.
I'll chalk this up to cosmic rays or something.
