From: Dan Aloni <alonid@gmail.com>
Subject: Re: [PATCH v7 2/2] ident: add user.useConfigOnly boolean for when
 ident shouldn't be guessed
Date: Sat, 6 Feb 2016 00:03:25 +0200
Message-ID: <20160205220325.GA19465@gmail.com>
References: <1454707746-18672-1-git-send-email-alonid@gmail.com>
 <1454707746-18672-3-git-send-email-alonid@gmail.com>
 <20160205214832.GA10052@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 05 23:03:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRoTb-0000xo-EF
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 23:03:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500AbcBEWDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 17:03:30 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35252 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107AbcBEWD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 17:03:29 -0500
Received: by mail-wm0-f47.google.com with SMTP id r129so44984712wmr.0
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 14:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=BZgqrfSctZrAxPOQg/FTMettyDIyBs6Z+/Ek/mdgQjI=;
        b=BjTmxn7NHAQB3VUSPMxTmJJfv111Qfz7tOHSP5jQ7QBbRfUVdalhdy3t10ML4qpu7p
         EG8XdE6YbedJOsv9LWsvjGA7+wScpFPiOkqTjrXbzuOXLAN6gDv/ZE+BX6unU+SkYt9U
         hCDBeeDB2Pn/swfzNbYBP5ebRox9orzZxIv5jAb1+ON9JL+Zu85hMQrOVTVZ8iytJM/3
         lA0iC8285HFiYkVYAUfMz3cayu1tQyGa/4KYJAw3bLB04T89dpeSYCzXhBZ5146o+upn
         qHG8ldj1Pegph4LtgxQLqT2wnLsPJ0haqq/2gNQACggFY4sLc93Jx2D4COqsRHDtrrbX
         KZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=BZgqrfSctZrAxPOQg/FTMettyDIyBs6Z+/Ek/mdgQjI=;
        b=mlOodzOWmf3g2ityRzm1dB+kCO/3VPD4zkKAqbMKYnE+8sivRaMXbx7ElcE9fUGjJs
         vtpGlzYwlwYB7G6Er+votTnZxGET1lCEOgkhLcB+QNwvk0E350adojKAdAsO8O93q9Gs
         xcHpRqFt5NjpM/EVb0g57n0wNmZiE30th8cy5zEnMf/G7QZujz6StVNBUZ5IM5nRaeES
         lGhXIvU+g71gjLcz90QVaeilHQo9IEXdo6ntf3uboj/BY2ke9XzSK8wZiiDB7CIzuPH/
         h4zxOT4IeRIBswBxy57mabRgaVg+nKsWVy/4QJ1hJL4stdZqHhPF5SzjeIUY/vHiveO0
         oJPg==
X-Gm-Message-State: AG10YORpUGVmrUb+kGlrTrohhz/W1hJ88+ELyxeRrQ7msWtIWbKs790dH6H3x4TnIBR3tg==
X-Received: by 10.28.47.23 with SMTP id v23mr19178740wmv.7.1454709807569;
        Fri, 05 Feb 2016 14:03:27 -0800 (PST)
Received: from localhost ([31.210.180.167])
        by smtp.gmail.com with ESMTPSA id i1sm2751146wjs.45.2016.02.05.14.03.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2016 14:03:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160205214832.GA10052@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285642>

On Fri, Feb 05, 2016 at 04:48:33PM -0500, Jeff King wrote:
> On Fri, Feb 05, 2016 at 11:29:06PM +0200, Dan Aloni wrote:
> 
> > diff --git a/t/t9904-per-repo-email.sh b/t/t9904-per-repo-email.sh
> > new file mode 100755
> > index 000000000000..f2b33881e46b
> > --- /dev/null
> > +++ b/t/t9904-per-repo-email.sh
> 
> Is t9904 the right place for this? Usually t99xx is for very separate
> components.
> 
> This is sort-of about "commit", which would put it in the t75xx range.
> But in some ways, it is even more fundamental than that. We don't seem
> to have a lot of tests for ident stuff. The closest is the strict ident
> stuff in t0007.

Will move to t7517. IMHO it's better to verify the commit operation
itself before running further tests that rely on its proper function.

>[..]
> > +reprepare () {
> > +	git reset --hard initial
> > +}
> 
> Do we need this reprepare stuff at all now? The tests don't care which
> commit we're at when they start.
> 
> > +test_expect_success setup '
> > +	# Initial repo state
> > +	echo "Initial" >foo &&
> > +	git add foo &&
> > +	git commit -m foo &&
> > +	git tag initial &&
> 
> A shorter way of saying this is "test_commit foo".
> 
> I almost thought we could get rid of this part entirely; the commit
> tests don't care. But we do still need _a_ commit for the clone test,
> since we want to make sure a reflog is written. It would be nice to push
> it down there, but our test environment doesn't allow creating commits,
> because of of useConfigOnly. So it's probably fine to leave it here.
> 
> Technically, the final "commit" test does make a commit for us to push,
> but we do generally try to avoid unnecessary dependencies between the
> individual tests.
> 
> So all together, maybe:
>[..]

Yes, shorted is better.

I'm squashing in these changes and adding you as Signed-off for v8.

-- 
Dan Aloni
