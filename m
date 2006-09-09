From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
Subject: Re: [PATCH 1/4] Add git-archive
Date: Sat, 9 Sep 2006 17:25:20 +0200
Message-ID: <cda58cb80609090825o32d9f1a8jee62153b96877bd0@mail.gmail.com>
References: <450019C3.4030001@innova-card.com>
	 <11576347251776-git-send-email-vagabon.xyz@gmail.com>
	 <7vodtrnl0f.fsf@assigned-by-dhcp.cox.net>
	 <45013114.1070808@innova-card.com> <4501D0C5.702@lsrfire.ath.cx>
	 <cda58cb80609090731w7c66dcfbrbababb6c38d29bf6@mail.gmail.com>
	 <4502D78B.6000905@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 09 17:25:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GM4hx-0002VG-Kh
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 17:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964769AbWIIPZW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Sep 2006 11:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWIIPZW
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 11:25:22 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:30387 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932251AbWIIPZV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Sep 2006 11:25:21 -0400
Received: by wx-out-0506.google.com with SMTP id i29so971092wxd
        for <git@vger.kernel.org>; Sat, 09 Sep 2006 08:25:20 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n6CPs97wWsFc+aIuNO65N9tNWa88UcLA67v+nogBX7pfZhaxFs9GckRv86xBQ64jEkRYP+g2vnvRpwBVKvJdzPxxeQE98ZejDyoxI8QNxTJ5DSRspjVJ7BpSeHIQMI4hpNI3uLSitlaPDDgvTgoMXPxBYBJpjimJ4xcqJa21jW0=
Received: by 10.70.33.10 with SMTP id g10mr2392063wxg;
        Sat, 09 Sep 2006 08:25:20 -0700 (PDT)
Received: by 10.70.72.5 with HTTP; Sat, 9 Sep 2006 08:25:20 -0700 (PDT)
To: "Rene Scharfe" <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <4502D78B.6000905@lsrfire.ath.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26757>

2006/9/9, Rene Scharfe <rene.scharfe@lsrfire.ath.cx>:
> Franck Bui-Huu schrieb:
> > 2006/9/8, Rene Scharfe <rene.scharfe@lsrfire.ath.cx>:
> >> > +     url = strdup(ar->remote);
> >>
> >> xstrdup()
> >>
> >
> > ok, but need to rebase...
>
> Why?  On a similar note , can we use Junio's pu branch (and soon his
> next branch) as our base for further work?
>

Yes. I just noticed Junio's post right after my reply.

> >> > +     if (list) {
> >> > +             if (!remote) {
> >> > +                     for (i = 0; i < ARRAY_SIZE(archivers); i++)
> >> > +                             printf("%s\n", archivers[i].name);
> >> > +                     exit(0);
> >> > +             }
> >> > +             die("--list and --remote are mutually exclusive");
> >> > +     }
> >>
> >> Not sure if we really need a list option.  I guess it only really
> >> makes sense if we have more than five formats.  I have no _strong_
> >> feelings against it, though. *shrug*
> >>
> >
> > well it's almost free to add it, and no need any maintenance if we add
> > a new archiver backend, so I would say let it.
>
> I thought a bit about it, and I can now see a good use case for --list:
> checking the capabilities of a remote site.  Unfortunately this is
> currently forbidden.  Why?  git-archive --list writes to stdout, so the
> result can be transported the same way an archive would.
>

Yes that was the main goal for this option. But then we talked about
enable/disable formats on the server side, and adding side band
support...all that points are still dark for me and I don't know how
'--list --remote' will interact with them. So I prefered to make this
option simple for now and not make the user to believe that doing

git archive --list --remote=...

list the capabilites of the remote side.

-- 
               Franck
