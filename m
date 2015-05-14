From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: Show all branches and ahead/behind states
Date: Thu, 14 May 2015 19:29:47 +0200
Message-ID: <1431624587.31573.5.camel@kaarsemaker.net>
References: <CAHd499AyEDNM7mDstFugD0Ah46=gAS=BRocDmpmOK-1k+qMCmw@mail.gmail.com>
	 <1431618938.31573.3.camel@kaarsemaker.net>
	 <CAHd499CQTW0J6ms+XYUBbyfT6gGKuiFFCiP57i8-eTwng+UzNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 19:30:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YswxP-0003Gw-6Y
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 19:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933104AbbENR3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 13:29:51 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:38218 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932759AbbENR3u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 13:29:50 -0400
Received: by wicnf17 with SMTP id nf17so102879202wic.1
        for <git@vger.kernel.org>; Thu, 14 May 2015 10:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=nE8yHBup3A7R+fj+uuGQDOZXJ8uC3Hn2nVxNNt777pA=;
        b=PDaJk6wIrPqWi8pHnJE1eTxLXEK1kg2Cwty8k/XXrCDHXLRK6QAr+2mIY0pdL8XqoQ
         TaeUE2+z9pcxdFxq6Vi2ILZ3b5X5o+oGK1eB3hlB3XksqGF39m9t0XI9wk0VyhQvNWDL
         UJPvN1D5f5XSxr2v+A1N2e0YLgX/9h/Zp3+yplrN4ycE2WzdYiNuh4qKbWkg6Q+Uqxsy
         BNbq0lpZky/YRKKmoXhL8BWlYDy/VBrUe30h3sh1dN+r+3mwP8jeJZ+F468KWql2vvMb
         fhrkgaTSOfzdEGOOkwOA/MtPeQ5BvPIq8tZujSuJUeC2EKVidoj2cPQisYwSxUtbUS06
         9mbg==
X-Gm-Message-State: ALoCoQlMF11X1G/BD2V4ousTj06UFxVLw/NuRfqJEanNOJ1TMFR/Iw++7MGN1GcXCB5So+ra88RM
X-Received: by 10.181.29.36 with SMTP id jt4mr4922088wid.21.1431624589644;
        Thu, 14 May 2015 10:29:49 -0700 (PDT)
Received: from spirit.home.kaarsemaker.net (82-171-80-33.ip.telfort.nl. [82.171.80.33])
        by mx.google.com with ESMTPSA id gy8sm14273003wib.13.2015.05.14.10.29.48
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2015 10:29:48 -0700 (PDT)
In-Reply-To: <CAHd499CQTW0J6ms+XYUBbyfT6gGKuiFFCiP57i8-eTwng+UzNQ@mail.gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269053>

On do, 2015-05-14 at 12:18 -0500, Robert Dailey wrote:
> On Thu, May 14, 2015 at 10:55 AM, Dennis Kaarsemaker
> <dennis@kaarsemaker.net> wrote:
> > On do, 2015-05-14 at 09:57 -0500, Robert Dailey wrote:
> >> Is there a script or built-in functionality in git 2.4.1 that will
> >> allow me to list all local branches with the ahead and behind status
> >> of each? Basically the first line of:
> >>
> >> $ git status -sb
> >>
> >> But for every branch would be roughly what I'm looking for. Any ideas? Thanks.
> >
> > git branch -v (or -vv) is what you're after.
> > --
> > Dennis Kaarsemaker
> > www.kaarsemaker.net
> >
> 
> Nice, I never noticed that -v showed ahead/behind status. Would be
> nice if branch had a --format option to customize the coloring of the
> "ahead" / "behind" text so that there was more contrast. It's a lot of
> information to consume especially with a lot of local branches;
> coloring would bring some sanity.

Fortunately for you, git for-each-ref lets you do just this. For
example, this gives you what branch -vv does, minus coloration and
padding:

git for-each-ref --format '%(HEAD) %(refname:short) %(upstream:short) %(upstream:track) %(subject)' refs/heads

-- 
Dennis Kaarsemaker
www.kaarsemaker.net
