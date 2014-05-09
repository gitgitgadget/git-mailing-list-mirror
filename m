From: David Turner <dturner@twopensource.com>
Subject: Re: Watchman support for git
Date: Fri, 09 May 2014 10:17:38 -0700
Organization: Twitter
Message-ID: <1399655858.11843.119.camel@stross>
References: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
	 <536428224adfb_200c12912f010@nysa.notmuch> <1399083897.5310.0.camel@stross>
	 <5364654088dc4_4d2010fb2ec7d@nysa.notmuch> <536BD864.5090804@gmail.com>
	 <alpine.DEB.2.02.1405090002000.17457@nftneq.ynat.uz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Fri May 09 19:17:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WioQe-0007CL-AL
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 19:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756922AbaEIRRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 13:17:44 -0400
Received: from mail-qc0-f171.google.com ([209.85.216.171]:58573 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756779AbaEIRRn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 13:17:43 -0400
Received: by mail-qc0-f171.google.com with SMTP id x13so4881920qcv.16
        for <git@vger.kernel.org>; Fri, 09 May 2014 10:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=OluC6LExqrszYdnSRUlWd1PbB7ljHI4n8/PHTT/oONU=;
        b=OMjro1A3QOvhUta1E2qgnaIXVF5P/ECT32MM0SIqUzBOp0pewN0TaUZ6Z1deI4Qt+m
         krWCVe7hpx0cER0b3yL8JtUix6Z5Vmxl0TkFBIpbdPMM0L1MIEOXb+J1+tMGyhXwvjMi
         pDHbsWkiQbd4C6zkOridXNUcVR4gYknxk601h2GlDnsLhrauhksLYiby8/CZzf2JXv/7
         qM6Nqyz/DLz0VBHb5+ZvBMN2jiBwi6/IhljL4xTJJONQPn011fV6eprSx90zx+joIXhS
         kV8PhdZneB1aJMvBTk33A/lhHitd2cwqbnXYGwhCQys+F5IarhoVHM/cgMOnoG1fhYrj
         ye1Q==
X-Gm-Message-State: ALoCoQm/kUPYju54shILx68O2A3sxCAVzslWOEVCIRr4PZJ6mOkFt6Wz2WTh+Xq/o0Ch8wERroda
X-Received: by 10.140.28.3 with SMTP id 3mr15853805qgy.71.1399655862615;
        Fri, 09 May 2014 10:17:42 -0700 (PDT)
Received: from [172.25.144.67] ([8.25.197.27])
        by mx.google.com with ESMTPSA id r4sm7461130qad.49.2014.05.09.10.17.40
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Fri, 09 May 2014 10:17:41 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1405090002000.17457@nftneq.ynat.uz>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248592>

On Fri, 2014-05-09 at 00:08 -0700, David Lang wrote:
> On Thu, 8 May 2014, Sebastian Schuberth wrote:
> 
> > On 03.05.2014 05:40, Felipe Contreras wrote:
> >
> >>>> That's very interesting. Do you get similar improvements when doing
> >>>> something similar in Merurial (watchman vs . no watchman).
> >>>
> >>> I have not tried it.  My understanding is that this is why Facebook
> >>> wrote Watchman and added support for it to Mercurial, so I would assume
> >>> that the improvements are at least this good.
> >>
> >> Yeah, my bet is that they are actually much better (because Mercurial
> >> can't be so optimized as Git).
> >>
> >> I'm interested in this number because if watchman in Git is improving it
> >> by 30%, but in Mercurial it's improving it by 100% (made up number),
> >> therefore it makes sens that you might want it more if you are using hg,
> >> but not so much if you are using git.
> >>
> >> Also, if similar repositories with Mercurial+watchman are actually
> >> faster than Git+watchman, that means that there's room for improvement
> >> in your implementation. This is not a big issue at this point of the
> >> process, just something nice to know.
> >
> > The article at [1] has some details, they claim "For our repository, enabling Watchman integration has made Mercurial's status command more than 5x faster than Git's status command".
> >
> > [1] https://code.facebook.com/posts/218678814984400/scaling-mercurial-at-facebook/
> 
> a lot of that speed comparison is going to depend on your storage system and the 
> size of your repository.
> 
> if you have a high-end enterprise storage system that tracks metadata very 
> differently from the file contents (I've seen some that have rackes worth of 
> SATA drives for contents and then 'small' arrays of a few dozen flash drives for 
> the metadata), and then you have very large repositories (Facebook has 
> everything in a single repo), then you have a perfect storm where something like 
> watchman that talks the proprietary protocol of the storage array can be FAR 
> faster than anything that needs to operate with the standard POSIX calls.
> 
> That can easily account for the difference between the facebook announcement and 
> the results presented for normal disks that show an improvement, but with even 
> stock git being faster than improved mercurial.

As I recall from Facebook's presentation[1] on this (as well as from the
discussion on the git mailing list[2]), Facebook's test respository is
much larger than any known git repository.  In particular, it is larger
than WebKit. These performance improvements are not for server-side
tasks, but for client-side (e.g. git/hg status).  Facebook also made
other improvements for the client-server communication, and for
log/blame, but these are not relevant to watchman.

It is entirely possible that, as repo size grows, Mercurial with
watchman is faster than git without.

With my patches, git status isn't constant-time; it's merely a roughly
constant factor faster. My initial design was to make git status
constant-time by caching the results of the wt_status_collect calls.
But there were so many cases with the various options that I got a bit
lost in the wilderness and made a big mess. Maybe I would do better if I
tried it again today.  And maybe if I just build on top of the
untracked-cache code, I would be able to get to constant-time; I'll have
to try that at some point.  

[1] http://www.youtube.com/watch?v=Dlguc63cRXg
[2] http://comments.gmane.org/gmane.comp.version-control.git/189776
