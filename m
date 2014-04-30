From: "'Dave Borowitz' via msysGit" <msysgit@googlegroups.com>
Subject: Re: [PATCH/RFC] Makefile: do not depend on curl-config
Date: Wed, 30 Apr 2014 08:29:30 -0700
Message-ID: <CAD0k6qRcv9M+kvmma1YZaM9Oam33wW0Sk8xuCET8R-9U+R9Tpg@mail.gmail.com>
References: <1398702545-9860-1-git-send-email-kusmabite@gmail.com> <xmqqfvkuhm77.fsf@gitster.dls.corp.google.com>
Reply-To: Dave Borowitz <dborowitz@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git <git@vger.kernel.org>, 
	Pat Thoyts <patthoyts@gmail.com>, Marat Radchenko <marat@slonopotamus.org>, tuomas.silvola@knowit.fi, 
	msysGit <msysgit@googlegroups.com>, johannes.schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBC64RC4WYIKBB3VNQSNQKGQE4RJEEYI@googlegroups.com Wed Apr 30 17:29:52 2014
Return-path: <msysgit+bncBC64RC4WYIKBB3VNQSNQKGQE4RJEEYI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f190.google.com ([209.85.212.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBC64RC4WYIKBB3VNQSNQKGQE4RJEEYI@googlegroups.com>)
	id 1WfWSG-0001ys-0w
	for gcvm-msysgit@m.gmane.org; Wed, 30 Apr 2014 17:29:52 +0200
Received: by mail-wi0-f190.google.com with SMTP id q5sf12262wiv.27
        for <gcvm-msysgit@m.gmane.org>; Wed, 30 Apr 2014 08:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:reply-to:content-type;
        bh=DVtg6a0IQLuVN8QzbA6Q+FrdyMthKs5mZxk9mFXJNS0=;
        b=V2Ie9wY6wqxQY1WHLkwh1Dw0KXoZDwKnxI31+jBeOt5uVhSkcBsTqbWSQDKHiXq5aA
         WQ8OjxuerB5SP6Sk0pd8sULDW165tQEJO5eXsKccGOTisRJs2edKqWblmCEK6lsmb22+
         lrGuwE2ljHC70c+zoonpb2YTnRgOQxv6/Av/C+6zkg1EELIc44GMUz53QpjkiP7kJYOP
         fHmtlC+LwCU205G9czCIDhkniu8oiuE+oFxey2cP3yF34zQAewpYcY8J4Yo6opRS7kuw
         M9VIelpi+VXjU/Mu542XRA5mybAvnr5+rUt/JTY+BVIqEGdB/8wRW5cWuVl3GGlI5VZ+
         86lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:reply-to:content-type;
        bh=DVtg6a0IQLuVN8QzbA6Q+FrdyMthKs5mZxk9mFXJNS0=;
        b=Qeicgp4hzvXqNNZy8aynPXsvGZqpfhHp0UNJBqNFTiOon6qmC5RvnZiu7o3+vgWPf5
         Mc3+EBdGO56TCoETC7r6S5KN+hn0q6jf/sRFxEbKCP0TWtHYiBgXEK1HD3JmjUQElxSB
         dQ7HGzMbSxQaIL3j4iXMo7iAm4D0o7fOJMlLPnQBevRMyt1HyztML+ef4j3w/Ut9sS6C
         FfNzkAWYoiN34jvEudy306nR5e23dib2uG/SX04P3Cfeb7UEfzf8LluMvZgy2Jty4Inp
         M+1GO8x1CwTRFsoM2XIStIdgkDD2XThLcqm+vrqYeYXKFpftub2wYtgX8v49mglKL3D8
         /p8w==
X-Received: by 10.180.92.1 with SMTP id ci1mr23745wib.15.1398871791731;
        Wed, 30 Apr 2014 08:29:51 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.37.244 with SMTP id b20ls826808wik.51.canary; Wed, 30 Apr
 2014 08:29:50 -0700 (PDT)
X-Received: by 10.180.93.37 with SMTP id cr5mr538709wib.1.1398871790359;
        Wed, 30 Apr 2014 08:29:50 -0700 (PDT)
Received: from mail-la0-x22f.google.com (mail-la0-x22f.google.com [2a00:1450:4010:c03::22f])
        by gmr-mx.google.com with ESMTPS id m49si548572eeu.0.2014.04.30.08.29.50
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 30 Apr 2014 08:29:50 -0700 (PDT)
Received-SPF: pass (google.com: domain of dborowitz@google.com designates 2a00:1450:4010:c03::22f as permitted sender) client-ip=2a00:1450:4010:c03::22f;
Received: by mail-la0-x22f.google.com with SMTP id pn19so1336375lab.6
        for <msysgit@googlegroups.com>; Wed, 30 Apr 2014 08:29:50 -0700 (PDT)
X-Gm-Message-State: ALoCoQn3uH/haKzoLWNx1oDD4LTxsFALNG9ulMMkMPjE5ctv5pspzhPCNOH1DFpHfyIaEK9Wlu8wrKYuxlcvrIpbeOiQqJpcQ4I3ZQKQItZJAnwmVfywiTmb1UktGpcrdaRpoH2K6SlsenWnp72LakJvTAfz3K5oxKhqMl7xiLB0ZSybmX6W1/A7p1mbzi1fVURGcf34SWF6LV17vft1I30XTsLS1vqf+A==
X-Received: by 10.112.126.7 with SMTP id mu7mr3169988lbb.17.1398871790099;
 Wed, 30 Apr 2014 08:29:50 -0700 (PDT)
Received: by 10.112.184.227 with HTTP; Wed, 30 Apr 2014 08:29:30 -0700 (PDT)
In-Reply-To: <xmqqfvkuhm77.fsf@gitster.dls.corp.google.com>
X-Original-Sender: dborowitz@google.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of dborowitz@google.com designates 2a00:1450:4010:c03::22f
 as permitted sender) smtp.mail=dborowitz@google.com;       dkim=pass
 header.i=@google.com;       dmarc=pass (p=REJECT dis=NONE) header.from=google.com
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
X-Original-From: Dave Borowitz <dborowitz@google.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247721>

On Wed, Apr 30, 2014 at 8:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
> How old/battle tested is this change?  My inclination at this point
> is to revert the merge of Dave's series from 2.0 (yes, I know we
> have been looking at fixing it and I _think_ the issue of unpleasant
> error message you reported can be fixed, but at this rate we would
> not know if we eradicated all the issues for platforms and distros
> with confidence by the final), kick it back to 'next'/'pu', and
> queue this change also in 'next'/'pu' and cook them so that we can
> merge them early in the 2.1 cycle.

This is fine by me FWIW.

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
