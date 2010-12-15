From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH v3 3/8] mingw: make failures to unlink or
 move raise a question
Date: Wed, 15 Dec 2010 08:48:32 +0100
Message-ID: <20101215074832.GC14646@book.hvoigt.net>
References: <20101214220604.GA4084@sandbox> <20101214222122.GD4084@sandbox> <AANLkTi=cHb2kV2MaYu72nXVOksO7O9HhJLEo-fU0sV5N@mail.gmail.com> <7vk4jbrjxn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kusmabite@gmail.com, Johannes Sixt <j6t@kdbg.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Albert Dvornik <dvornik+git@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncCOrwtbejChDS5aHoBBoEP16f3Q@googlegroups.com Wed Dec 15 08:49:00 2010
Return-path: <msysgit+bncCOrwtbejChDS5aHoBBoEP16f3Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-fx0-f58.google.com ([209.85.161.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOrwtbejChDS5aHoBBoEP16f3Q@googlegroups.com>)
	id 1PSm6c-0005q9-9N
	for gcvm-msysgit@m.gmane.org; Wed, 15 Dec 2010 08:48:58 +0100
Received: by fxm13 with SMTP id 13sf425005fxm.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 14 Dec 2010 23:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:in-reply-to:user-agent
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition;
        bh=cUjVx44Ovy/F76bmc7ozK+uIuZ9yJmdbNEL1iDX5hqk=;
        b=CQqMgNHr37pqUEeaPUVAKnQ+/Uq3xrJSMrNCBR+AMyXsjMD5Jv78tfvC8o/nwho44d
         wfL43zodh+xTDVEBE/Fwo0MGGigZTgYzzOC6MsPtmX5OBAEhZ1dvmphbv+mnkSKTUTL3
         WoUQbUK6YpDlqzfZt4E0TuLKNqTSmA9hw1zo8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        b=zQyf5QmbAkplvwbo9KHAjpNtNg70C0JljQJqBQPzKtYsO6gZXtn7MuFbaFo3CxOa/N
         aXL0yt7HP4NRMMUhbihLOkLlwHkGop29VtwolYTGJEsqMWpQIwsNn/uI0GikP7SCGRMH
         70H7c6Os0J7cyqGn0jzTXSYQnRIb8fRDcZV5c=
Received: by 10.223.74.202 with SMTP id v10mr573077faj.38.1292399314028;
        Tue, 14 Dec 2010 23:48:34 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.204.24.81 with SMTP id u17ls750432bkb.3.p; Tue, 14 Dec 2010
 23:48:33 -0800 (PST)
Received: by 10.204.4.81 with SMTP id 17mr568250bkq.1.1292399313390;
        Tue, 14 Dec 2010 23:48:33 -0800 (PST)
Received: by 10.204.4.81 with SMTP id 17mr568249bkq.1.1292399313362;
        Tue, 14 Dec 2010 23:48:33 -0800 (PST)
Received: from darksea.de (darksea.de [83.133.111.250])
        by gmr-mx.google.com with SMTP id dd11si31464bkb.0.2010.12.14.23.48.33;
        Tue, 14 Dec 2010 23:48:33 -0800 (PST)
Received-SPF: neutral (google.com: 83.133.111.250 is neither permitted nor denied by best guess record for domain of hvoigt@hvoigt.net) client-ip=83.133.111.250;
Received: (qmail 26036 invoked from network); 15 Dec 2010 08:48:32 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 15 Dec 2010 08:48:32 +0100
In-Reply-To: <7vk4jbrjxn.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Original-Sender: hvoigt@hvoigt.net
X-Original-Authentication-Results: gmr-mx.google.com; spf=neutral (google.com:
 83.133.111.250 is neither permitted nor denied by best guess record for
 domain of hvoigt@hvoigt.net) smtp.mail=hvoigt@hvoigt.net
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163739>

Hi,

On Tue, Dec 14, 2010 at 03:52:52PM -0800, Junio C Hamano wrote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
> 
> > Since you're doing case insensitive checks for "yes" and "no", perhaps
> > it'd make sense to allow upper case 'Y' and 'N' also? Something like:
> >
> > -       if (answer[0] == 'n' && strlen(answer) == 1)
> > +       if (tolower(answer[0]) == 'n' && strlen(answer) == 1)
> >
> > hm?
> 
> Why not
> 
> 	if (tolower(answer[0]) == 'n' && !answer[1])
> 
> think of the case answer[] is very long ;-)

Will change as stated in the previous email but of course using this
code for efficiency ;) Can anybody estimate how fast the user would need
to type to actually make this noticeable and how much heat that would
produce on the keyboard?

> >> +       if (!isatty(_fileno(stdin)) || !isatty(_fileno(stderr)))
> >> +               return 0;
> >
> > I'm wondering, doesn't this make the semantics a bit wrong? The
> > function is called "ask_user_yes_no", but it might end up not asking
> > after all.
> 
> I don't think that is such a big issue.
> 
> Imagine you had only getenv("GIT_ASK_YESNO") codepath, and no fallback
> "tty" codepath.  And you ship with a separate program as a default
> "asker".
> 
> The implementation of that asker happens to read yes/no from the tty, but
> it defauts to "no" if there is no tty interaction available.
> 
> If you view it that way, the code we see above is just an optimization to
> avoid spawning that default "asker" as a separate process.

I do not mind to change this function name to make it more match what
its doing. Since code is read way more often than written I think this
makes sense. See my other email about the suggestion.

> I was more puzzled by the code to formulate question[]; why doesn't it
> build the same question for both codepaths and spit that out to stderr
> with fputs() in the fallvack asker?

Do you mean that I append " (y/n)? " ? For the (y/n) you can think of it
as the tui implementation of the yes/no button. I can see that the ?
might need to go into the question string itself. Is it that what you
meant?

Cheers Heiko
