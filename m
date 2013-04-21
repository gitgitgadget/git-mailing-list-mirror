From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [QUERY] Why do we have git-completion.zsh?
Date: Sun, 21 Apr 2013 12:26:20 +0530
Message-ID: <CALkWK0khqsPurJpeXjsBGbXi--1T+88w9edbSRCFSO75nUcUZw@mail.gmail.com>
References: <CALkWK0=NrJ-9mxSkOBw=kJ0CTJLUFNWBoGdqGcHEU6YqR-foFg@mail.gmail.com>
 <20130420184539.GA8586@elie.Belkin> <20130420185329.GB8586@elie.Belkin>
 <CAMP44s3yCW-pHVHc9WfL1BC7BKmnXxZ1WQyPRAMnx967=74_Kg@mail.gmail.com>
 <CALkWK0=ay452TbW-O+uBwqqMjLgeYw0V-j67vvzMqtVO-PnrXw@mail.gmail.com> <CAMP44s0e=RTC_-JeFXxrdQ9Zhe8riqWKwdeae6rgwJccr_=7iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 08:57:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UToD9-0005v7-Vv
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 08:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948Ab3DUG5C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 02:57:02 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:57184 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935Ab3DUG5B (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 02:57:01 -0400
Received: by mail-ie0-f172.google.com with SMTP id c12so2061551ieb.17
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 23:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=doII7kfrdwYXRsPygi9sJ7C9PqvNVYhuzM2Pb67z/tY=;
        b=0wOgPi2BGZPto2j/kTw+q67Igv/BxDi0xYGxmf0K1cxH7CxczgAZP4B5mtkxHbFOeX
         r52k/arDEwctF9KFXWSC/3c9pIRbIB87A3IezzMd62xyMJeL7p1VY/2fLtjOIAkoBv9t
         ezuxe8mv1jL4LARot1glKMcZtDr0y0mvP3Lp3s/j+83xWEJSIHQzBasiXkSr0qdce/HL
         iSZ86eZrggTOEhjDcM8jLlg8zz86Dh4Do8Kb7T9WsYpPGl4/iWZUp3TcCv4LPIC/QgLz
         3TfP9qo0bZcM0qvV5XreAKfRlsi9HE4dcxACFSRCDcdGhXnQmla4/eCQBOdgVjxBzW4U
         2nCA==
X-Received: by 10.50.50.71 with SMTP id a7mr18723163igo.14.1366527420705; Sat,
 20 Apr 2013 23:57:00 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Sat, 20 Apr 2013 23:56:20 -0700 (PDT)
In-Reply-To: <CAMP44s0e=RTC_-JeFXxrdQ9Zhe8riqWKwdeae6rgwJccr_=7iA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221899>

Felipe Contreras wrote:
> First of all, 'gitfast' is just the name I gave to the oh-my-zsh
> plugin that uses git.git's completion stuff. The zsh support in git's
> bash completion has been working for years, I just copied the stuff to
> oh-my-zsh so those guys can use it easily.

Yeah, I know.  I just used the name.

> Secondly, I don't see what "features" zsh's git completer might have
> that we don't. Yes, some specific argument behaviors are nice, like
> adding a '=' after --git-dir, and then complete only directories, and
> completion descriptions, along with tag groupings, but all those
> things are cosmetic, and they could be added relatively easy to my
> thin wrapper (which wouldn't be so thin after all). It's mostly grunt
> work, not something that requires a great mind.
>
> Functionally I don't see any value.

> Are these minor features worth all this slowness and complicated code?
> I don't think so.

Moved to using git.git's completer, and I see that you're absolutely
right about the "minor features" missing part.  I just assumed that
zsh's completer must be more complete because it's so much larger than
git.git's bash/zsh completer.  Working backwards from zsh's completer
would've been a nightmare.

> The reason why I prefer git.git's bash completion is that it has taken
> years to develop, and using good development practices, borrowed from
> the mainline git process. Many more people use them, have debugged
> them through the years, and optimized them. It's relatively small
> (compared to zsh's version), much more readable, and it even has tests
> (which I helped to start), and it's much less buggy. It's basically
> rock solid.

Great!  I'll stop working on zsh's completer immediately, and try to
redirect my attention on improving git.git's completer instead.

Thanks for the information.
