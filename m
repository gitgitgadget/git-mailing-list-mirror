From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 2/2] wincred: avoid overwriting configured variables
Date: Wed, 14 May 2014 10:49:27 +0200
Message-ID: <CABPQNSYcWrK08Gx=eXWWYLmezx-hLQgrgGyGnuZ4nxVqh=UAnQ@mail.gmail.com>
References: <20140430064610.GA22094@camelia.ucw.cz> <CABPQNSZsviaGqFeKZE4ofF6HoUQrPvNPuowar4YDjk_Mbu5iCQ@mail.gmail.com>
 <20140430112724.GA22929@camelia.ucw.cz> <CABPQNSafKXDLyBj5OYW-PPWdxfxQtC23vKQsQ-_Pa1empU=n8g@mail.gmail.com>
 <20140513055953.GA28182@camelia.ucw.cz> <20140513060144.GC28182@camelia.ucw.cz>
 <CABPQNSYU5haMzdy2cDn=KF2+j_aFK19Ju+x+LTeex6JqWJMncQ@mail.gmail.com>
 <20140513065335.GA28417@camelia.ucw.cz> <CABPQNSbb-rdTjCDYoC7uApfcMH8Q0Y-w4Tm9UiN6PhEeD-Gv6Q@mail.gmail.com>
 <20140514084509.GA3134@camelia.ucw.cz>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>, Pat Thoyts <patthoyts@users.sourceforge.net>, 
	msysGit <msysgit@googlegroups.com>
To: Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBDR53PPJ7YHRBP64ZSNQKGQEXDKYLDI@googlegroups.com Wed May 14 10:50:09 2014
Return-path: <msysgit+bncBDR53PPJ7YHRBP64ZSNQKGQEXDKYLDI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ig0-f184.google.com ([209.85.213.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBP64ZSNQKGQEXDKYLDI@googlegroups.com>)
	id 1WkUt7-0006yC-Gr
	for gcvm-msysgit@m.gmane.org; Wed, 14 May 2014 10:50:09 +0200
Received: by mail-ig0-f184.google.com with SMTP id r2sf147171igi.11
        for <gcvm-msysgit@m.gmane.org>; Wed, 14 May 2014 01:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=XdTM+aJgEy1b+2oHj41cHmCULWON2nJJSz04MXrdoAk=;
        b=GZ0P4S8l29ooEiYM/MAoHygp5mQ1DnPeguhbi9UDIXZKyXQoAbM1j57zOkCe4+D0k7
         6GAVww0E93bat4TnDcCITFxPGGKD9s1td8QPBwfLNNkxmYvUMgTB/uHPhiU9Ji9xckN/
         UUJOe4Je+RpjE+Nq6q/2NxOa3A5xZqINjitXSHxtwGiZm70a1fMPj67DSZhpoeTH8WP5
         5icn10FxE5OghKsans+Ow4D1vX+XeT1LQ/fymlSlpMqz0/w4sjC6KEhHRQ1vxQx0U2ct
         i2nzBbJVpcmSa1doOj674/tNmxr1oor38GEtBUo7l5Yyw3P/liLqOIx6dV8vNBiIzo8i
         hnow==
X-Received: by 10.50.108.6 with SMTP id hg6mr796155igb.9.1400057408409;
        Wed, 14 May 2014 01:50:08 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.43.225 with SMTP id z1ls2691482igl.43.gmail; Wed, 14 May
 2014 01:50:07 -0700 (PDT)
X-Received: by 10.66.173.75 with SMTP id bi11mr1205083pac.4.1400057407772;
        Wed, 14 May 2014 01:50:07 -0700 (PDT)
Received: from mail-ie0-x22e.google.com (mail-ie0-x22e.google.com [2607:f8b0:4001:c03::22e])
        by gmr-mx.google.com with ESMTPS id jj2si1184394igb.3.2014.05.14.01.50.07
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 14 May 2014 01:50:07 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::22e as permitted sender) client-ip=2607:f8b0:4001:c03::22e;
Received: by mail-ie0-x22e.google.com with SMTP id at1so1538337iec.19
        for <msysgit@googlegroups.com>; Wed, 14 May 2014 01:50:07 -0700 (PDT)
X-Received: by 10.42.161.69 with SMTP id s5mr1147965icx.70.1400057407671; Wed,
 14 May 2014 01:50:07 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Wed, 14 May 2014 01:49:27 -0700 (PDT)
In-Reply-To: <20140514084509.GA3134@camelia.ucw.cz>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::22e
 as permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248899>

On Wed, May 14, 2014 at 10:45 AM, Stepan Kasal <kasal@ucw.cz> wrote:
> Hello kusma,
>
> On Tue, May 13, 2014 at 08:56:54AM +0200, Erik Faye-Lund wrote:
>> > --- a/contrib/credential/wincred/Makefile
>> > +++ b/contrib/credential/wincred/Makefile
>> > @@ -1,12 +1,12 @@
>> >  all: git-credential-wincred.exe
>> >
>> > -CC = gcc
>> > -RM = rm -f
>> > -CFLAGS = -O2 -Wall
>> > -
>> >  -include ../../../config.mak.autogen
>> >  -include ../../../config.mak
>> >
>> > +CC ?= gcc
>> > +RM ?= rm -f
>> > +CFLAGS ?= -O2 -Wall
>> > +
>> >  prefix ?= /usr/local
>> >  libexecdir ?= $(prefix)/libexec/git-core
>> >
>>
>> Yeah, looks good to me.
>
> thanks, but it looks you replied only to my personal mail.  Was it
> intentional?

No, sorry about that.

Consider the patches

Acked-by: Erik Faye-Lund <kusmabite@gmail.com>

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
