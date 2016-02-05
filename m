From: Dan Aloni <alonid@gmail.com>
Subject: Re: [PATCH v6 3/3] ident: cleanup wrt ident's source
Date: Fri, 5 Feb 2016 23:03:30 +0200
Message-ID: <20160205210330.GA7245@gmail.com>
References: <1454658148-3031-1-git-send-email-alonid@gmail.com>
 <1454658148-3031-4-git-send-email-alonid@gmail.com>
 <xmqqsi17c70w.fsf@gitster.mtv.corp.google.com>
 <20160205192413.GB7245@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 05 22:03:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRnXX-0004tN-3a
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 22:03:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756885AbcBEVDf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 16:03:35 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36230 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755275AbcBEVDe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 16:03:34 -0500
Received: by mail-wm0-f45.google.com with SMTP id p63so43219450wmp.1
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 13:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=NABeJ0545JL9NZPDH0qO6qs4g5LVFPS/I1eTyd9T634=;
        b=S9TUc8ApXAyWzwOxeRHYV7qmdH6T7TpXC8AuU4tfHnJUKJMM7hVgJEN6AqlG9pq24X
         9TmkLZCAtRF9dyiyY3fsm+4rp8eA4Z4qe5inqr5YFQThc2T/udWDroP81URrZDz+c74l
         4nNGVRz3/zwkMvzqALEnWipVikJ5MtpZnyz4Q6R9j7gruMc5VkA/Y+AH5TvtT+qh966f
         vUK230hnV4GO0AqNMMdtTH2osUSUpYN/OXu68q3aFzSXE5doVUA04fDFmorSXHxpke5l
         vkIvGPTGW9zunAjfwU16iq303NK/ZofgDuXK06RrjP7QQUXuJQuN5ZZKjYy/CjqCkDsT
         DN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=NABeJ0545JL9NZPDH0qO6qs4g5LVFPS/I1eTyd9T634=;
        b=bciHRaE4gAsOFPjluIEtm/y1lCQUVP+kh9KL1du96C/cn8o2qqoyZU6Y32i9Tvqbdh
         sQ70B9zMWmrX023bFUGdFKCVEStxXeKTCDhp6ETlX1mZj9MJWLHh97qM0mwFCGJKjkC/
         BcWwQFjVL61RPZFAi/g5GB/rE5tJThhmd7jVrE2KDUWkOez2bPvqvXn/TFtS8tz71GgG
         cscwPu4vaW9Hcgs+5qGxQtkOOD25lAN4Re7gUIXuwxoUBLZJYOj1dEwU6JMXKDyBZXlG
         cZGPBB/ItSzm/h5+/7Ofuh5Kgg8AUHrwj2HD6tg3IMEmLQx5M98g0vVepjT/nokOdPLe
         Utmw==
X-Gm-Message-State: AG10YOTbsQi7cTnRusao+a6BotflKfNshAH0Qv/BP6SlAxvgnNBzpQi/ItVHHvIQFM8w/w==
X-Received: by 10.194.119.68 with SMTP id ks4mr15689881wjb.45.1454706213491;
        Fri, 05 Feb 2016 13:03:33 -0800 (PST)
Received: from localhost ([31.210.180.167])
        by smtp.gmail.com with ESMTPSA id os7sm17533335wjc.18.2016.02.05.13.03.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2016 13:03:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160205192413.GB7245@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285632>

On Fri, Feb 05, 2016 at 02:24:13PM -0500, Jeff King wrote:
> On Fri, Feb 05, 2016 at 11:05:19AM -0800, Junio C Hamano wrote:
> 
> > Dan Aloni <alonid@gmail.com> writes:
> > 
> > > This change condenses the variables that tells where we got the user's
> > > ident into single enum, instead of a collection of booleans.
> > >
> > > In addtion, also have {committer,author}_ident_sufficiently_given
> > > directly probe the environment and the afformentioned enum instead of
> > > relying on git_{committer,author}_info to do so.
> > >
> > > Signed-off-by: Dan Aloni <alonid@gmail.com>
> > > Helped-by: Jeff King <peff@peff.net>
> > > Helped-by: Junio C Hamano <gitster@pobox.com>
> > > ---
> > >  ident.c | 126 ++++++++++++++++++++++++++++++++++++++++------------------------
> > >  1 file changed, 80 insertions(+), 46 deletions(-)
> > 
> > Peff what do you think?  I am asking you because personally I do not
> > find this particularly easier to read than the original, but since
> > you stared at the code around here recently much longer than I did
> > when doing the 1/3, I thought you may be a better judge than I am.
> 
> I'm not sure it is really worth it unless we are going to expose this to
> the user, and let them say "I am OK with IDENT_SOURCE_GUESSED, but not
> IDENT_SOURCE_GUESSED_BOGUS" or similar.
> 
> Without that, I think it is probably just making things a bit more
> brittle.

Okay, will drop it now.

-- 
Dan Aloni
