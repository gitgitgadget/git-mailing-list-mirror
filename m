From: Eli Barzilay <eli-oSK4jVRJLyZg9hUCZPvPmw@public.gmane.org>
Subject: Re: Bug in git-stash(.sh) ?
Date: Sun, 29 Apr 2012 18:37:06 -0400
Message-ID: <20381.49810.943013.33117@winooski.ccs.neu.edu>
References: <20379.9312.943088.350379@winooski.ccs.neu.edu>
	<87wr4za9mr.fsf@gmail.com>
	<m2pqasb8mr.fsf@linux-m68k.org>
	<xmqqvckk93ta.fsf@junio.mtv.corp.google.com>
	<CALO-gut4csy5wef4iGPGD5jVPc1f0iFBfS3MUWrOwc2yczdviw@mail.gmail.com>
	<20380.33897.666338.766096@winooski.ccs.neu.edu>
	<7vlilexkcq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast-oe7qfRrRQfdfcPYw/2PL0g@public.gmane.org>, Yann Hodique <yann.hodique-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Andreas Schwab  <schwab-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
X-From: magit+bncCOHCzKWgHRCVhff8BBoE1C2aIw-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Mon Apr 30 00:37:13 2012
Return-path: <magit+bncCOHCzKWgHRCVhff8BBoE1C2aIw-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvgm-magit-3@m.gmane.org
Received: from mail-vx0-f186.google.com ([209.85.220.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <magit+bncCOHCzKWgHRCVhff8BBoE1C2aIw-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1SOcju-0007x7-WE
	for gcvgm-magit-3@m.gmane.org; Mon, 30 Apr 2012 00:37:11 +0200
Received: by vcbfo14 with SMTP id fo14sf2688223vcb.3
        for <gcvgm-magit-3@m.gmane.org>; Sun, 29 Apr 2012 15:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:from:mime-version:message-id:date:to:cc
         :subject:in-reply-to:references:x-mailer:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=CuuNLZB2pUZB35dBoe6BvvajZGg5eZYrHhpF1jykezk=;
        b=q1VjcqQcs9Z8l0zk/9GYpI95REyw6h68AyfmLKoNrhRvZsQl7SK5T+8nsNFvvr3Kql
         baJNt1MuKKW5YRbsyWufhGTThvLThGuYoUzdx88s4fDW5JDdntXovvOJ1iafVafTVic/
         pQqvucLLNamCvruuqN2o2et3iSdFB37Z8RjJI=
Received: by 10.50.220.194 with SMTP id py2mr883519igc.4.1335739029959;
        Sun, 29 Apr 2012 15:37:09 -0700 (PDT)
X-BeenThere: magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.50.181.201 with SMTP id dy9ls1925289igc.1.gmail; Sun, 29 Apr
 2012 15:37:09 -0700 (PDT)
Received: by 10.43.53.73 with SMTP id vp9mr15031352icb.0.1335739029585;
        Sun, 29 Apr 2012 15:37:09 -0700 (PDT)
Received: by 10.43.53.73 with SMTP id vp9mr15031351icb.0.1335739029575;
        Sun, 29 Apr 2012 15:37:09 -0700 (PDT)
Received: from winooski.ccs.neu.edu (winooski.ccs.neu.edu. [129.10.115.117])
        by gmr-mx.google.com with ESMTPS id md3si5229829igc.1.2012.04.29.15.37.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 29 Apr 2012 15:37:09 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of eli-a5nvgYPMCZcx/1z6v04GWfZ8FUJU4vz8@public.gmane.org designates 129.10.115.117 as permitted sender) client-ip=129.10.115.117;
Received: from winooski.ccs.neu.edu (localhost.localdomain [127.0.0.1])
	by winooski.ccs.neu.edu (8.14.4/8.14.4) with ESMTP id q3TMb80g032568;
	Sun, 29 Apr 2012 18:37:08 -0400
Received: (from eli@localhost)
	by winooski.ccs.neu.edu (8.14.4/8.14.4/Submit) id q3TMb765032565;
	Sun, 29 Apr 2012 18:37:07 -0400
In-Reply-To: <7vlilexkcq.fsf-s2KvWo2KEQL18tm6hw+yZpy9Z0UEorGK@public.gmane.org>
X-Mailer: VM 8.2.0a under 23.2.1 (x86_64-redhat-linux-gnu)
X-Original-Sender: eli-oSK4jVRJLyZg9hUCZPvPmw@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 best guess record for domain of eli-a5nvgYPMCZcx/1z6v04GWfZ8FUJU4vz8@public.gmane.org designates
 129.10.115.117 as permitted sender) smtp.mail=eli-a5nvgYPMCZcx/1z6v04GWfZ8FUJU4vz8@public.gmane.org
Precedence: list
Mailing-list: list magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; contact magit+owners-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-ID: <magit.googlegroups.com>
X-Google-Group-Id: 752745291123
List-Post: <http://groups.google.com/group/magit/post?hl=en_US>, <mailto:magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:magit+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/magit?hl=en_US>
Sender: magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/magit/subscribe?hl=en_US>, <mailto:magit+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/magit/subscribe?hl=en_US>, <mailto:googlegroups-manage+752745291123+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196519>

30 minutes ago, Junio C Hamano wrote:
> 
> I think the root cause of the bug is that there are three cases:
> 
>  - If we ask for "log -g ref@{0}", we should show them counted no
>    matter what.
> 
>  - If we ask for "log -g ref@{now}", we should show them timed no
>    matter what.
> 
>  - If we ask for "log -g ref" without specifier, we show them
>    counted by default, but we try to be nice and show them timed
>    when we can infer from other context that the user wanted to see
>    them timed.

Ah, I was unaware (unsurprisingly) that *that's* how an explict date
format is (supposed to?) requested -- but then what happens with

  git log --date iso -g "ref@{0}"

?

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
