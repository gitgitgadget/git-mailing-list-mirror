From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2] pull: handle --log=<n>
Date: Tue, 19 May 2015 23:24:50 +0200
Message-ID: <1432070690.14498.4.camel@kaarsemaker.net>
References: <1431956396-21788-1-git-send-email-pyokagan@gmail.com>
	 <5661061272076a1883cfde1087be4a42@www.dscho.org>
	 <xmqq617pda0r.fsf@gitster.dls.corp.google.com>
	 <6b905c01c9b57abc05fb49117c28c10e@www.dscho.org>
	 <CAPc5daVze4+8aLGPpZgxDnvKSwvQiaR=kRdwfAHXFYA7HChmMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 19 23:25:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yup0W-0002OQ-7f
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 23:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbbESVYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 17:24:55 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:35139 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbbESVYy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 17:24:54 -0400
Received: by wicmx19 with SMTP id mx19so132990094wic.0
        for <git@vger.kernel.org>; Tue, 19 May 2015 14:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=JuADM6TIIVPxrWP4+wfF36Nffx1hrkE1R+PVYst3GaA=;
        b=e9c4mOaZjb/R2JhspzSfnvjcEZEP5G8EHzOGOB9r4/4XP5rrr+Oe/jBC04mW741DdF
         aR4dZl4dyCbHLWx9Lc0rLee9/Cg+XHdZZlpaMrUXrbdwnVEU7uEJ3xu4QrTDh1YJ38Hf
         iw9rZvLyqxNZkxTzblz6+3SgH3SZXCp1eH25v5+ksVYpr/Za40VaGLuj8UhQh5YTxcn4
         gt6xiANbB4NloKZjYBaf9Vn+jbfeVl5N44DSVeMYeTesbhoXXMhu1l+qkSbp12FzG85e
         /vjsMlSiO8rX9nDs/7MsaoU6ASLXNhAbYwaEuKbr9jkJLTJrUx02dOQ6NZQmVylneg5O
         /ZKw==
X-Gm-Message-State: ALoCoQm22oxfE9QQXMSw31qCbOKZY8fOi0QuuO4mo1rYyNzAx0lSEVqGTliJsVxaBHQCcCBCU7G+
X-Received: by 10.181.13.198 with SMTP id fa6mr2926996wid.41.1432070693580;
        Tue, 19 May 2015 14:24:53 -0700 (PDT)
Received: from spirit.home.kaarsemaker.net (82-171-80-33.ip.telfort.nl. [82.171.80.33])
        by mx.google.com with ESMTPSA id pj5sm23531644wjb.40.2015.05.19.14.24.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2015 14:24:52 -0700 (PDT)
In-Reply-To: <CAPc5daVze4+8aLGPpZgxDnvKSwvQiaR=kRdwfAHXFYA7HChmMg@mail.gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269403>

On di, 2015-05-19 at 06:57 -0700, Junio C Hamano wrote:
> On Tue, May 19, 2015 at 6:35 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> >
> > On 2015-05-18 20:18, Junio C Hamano wrote:
> >>
> >> So I dunno.  I really wish test_commit didn't create tags and either
> >> left the tagging to the calling script.
> >
> > Or maybe just add a --tag flag to `test_commit` and use that in all cases where the tags were actually needed. Yeah, I think I like that option best.
> 
> Thanks for inferring what I wanted to say but left unsaid due to my
> stupidity and
> lack of proofreading. I meant to follow "either left to the caller"
> with "or with an
> option" ;-)

I took a stab at this, adding a --tag option to test_commit and adding
the option to the test_commit calls that need it (or removing tests'
reliance on these tags where appropriate, or removing tests' workarounds
for dealing with these tags when they don't want them), and the result
is 59 files changed, 280 insertions(+), 281 deletions(-)

A test run on master with GIT_TEST_LONG set causes 1138 calls to
test_commit on my system, of which 255 now use the --tag option
(measured with a really crude hack that INCR's some keys in redis at
appropriate points in test_commit).

Is this interesting enough to turn into a proper patch series?
-- 
Dennis Kaarsemaker
www.kaarsemaker.net
