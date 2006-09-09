From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
Subject: Re: [PATCH 1/4] Add git-archive
Date: Sat, 9 Sep 2006 16:31:06 +0200
Message-ID: <cda58cb80609090731w7c66dcfbrbababb6c38d29bf6@mail.gmail.com>
References: <450019C3.4030001@innova-card.com>
	 <11576347251776-git-send-email-vagabon.xyz@gmail.com>
	 <7vodtrnl0f.fsf@assigned-by-dhcp.cox.net>
	 <45013114.1070808@innova-card.com> <4501D0C5.702@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 09 16:31:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GM3rZ-0000tP-JU
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 16:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWIIObK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Sep 2006 10:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbWIIObK
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 10:31:10 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:6744 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932205AbWIIObI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Sep 2006 10:31:08 -0400
Received: by wx-out-0506.google.com with SMTP id s14so972818wxc
        for <git@vger.kernel.org>; Sat, 09 Sep 2006 07:31:07 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m591bkpnye8mudLu+U3MtMstjbqRvvelmlIL90oSmvfuy8wqtJBJqEf35qzHPYdsYfXwkl+eSwJuwsjJkRPqQZq1BGo5vkrALS6lj+oO+rldts6Ki27LB58fYnjHm7iRlnmUjF2xWt/jEmHw7RW48btQ1ZKHwhCCUYWdQEFFPec=
Received: by 10.70.109.6 with SMTP id h6mr2282926wxc;
        Sat, 09 Sep 2006 07:31:07 -0700 (PDT)
Received: by 10.70.72.5 with HTTP; Sat, 9 Sep 2006 07:31:06 -0700 (PDT)
To: "Rene Scharfe" <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <4501D0C5.702@lsrfire.ath.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26748>

2006/9/8, Rene Scharfe <rene.scharfe@lsrfire.ath.cx>:
> Only a few trivial comments, as I managed to catch a cold somehow and
> can't think straight for longer than three seconds.
>
> >  .gitignore                    |    1
> >  Documentation/git-archive.txt |  100 ++++++++++++++++++
> >  Makefile                      |    3 -

[snip]

> > +
> > +     url = strdup(ar->remote);
>
> xstrdup()
>

ok, but need to rebase...

> > +     pid = git_connect(fd, url, buf);
> > +     if (pid < 0)
> > +             return pid;
> > +

[snip]

> > +     int extra_argc = 0;
> > +     const char *format = NULL; /* some default values */
>
> This comment does not convey any information.
>

OK, I'll remove it

> > +     const char *remote = NULL;
> > +     const char *base = "";

[snip]

> > +             }
> > +             if (arg[0] == '-') {
> > +                     extra_argv[extra_argc++] = arg;
>
> Overrun is not checked.
>

Indeed, I'll fix it.

> > +                     continue;
> > +             }
> > +             break;
> > +     }
> > +     if (list) {
> > +             if (!remote) {
> > +                     for (i = 0; i < ARRAY_SIZE(archivers); i++)
> > +                             printf("%s\n", archivers[i].name);
> > +                     exit(0);
> > +             }
> > +             die("--list and --remote are mutually exclusive");
> > +     }
>
> Not sure if we really need a list option.  I guess it only really
> makes sense if we have more than five formats.  I have no _strong_
> feelings against it, though. *shrug*
>

well it's almost free to add it, and no need any maintenance if we add
a new archiver backend, so I would say let it.

> > +     if (argc - i < 1) {
> > +             die("%s", archive_usage);
>
> usage()
>

ok

-- 
               Franck
