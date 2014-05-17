From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-helpers: point at their upstream repositories
Date: Sat, 17 May 2014 12:15:59 -0500
Message-ID: <5377994fe8dec_7a27d4b30438@nysa.notmuch>
References: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>
 <20140516084126.GB21468@sigill.intra.peff.net>
 <xmqq8uq1br9c.fsf@gitster.dls.corp.google.com>
 <20140516225228.GA3988@sigill.intra.peff.net>
 <5376f2ca5c90d_65b915db2f877@nysa.notmuch>
 <20140517062413.GA13003@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 17 19:27:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WliO7-0003pJ-VT
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 19:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbaEQR1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 13:27:07 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:49216 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964823AbaEQR1G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2014 13:27:06 -0400
Received: by mail-oa0-f43.google.com with SMTP id l6so4485393oag.2
        for <git@vger.kernel.org>; Sat, 17 May 2014 10:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=eb80fMSSZSjIB0P/tQaJntM1XiX3e549NDKB/AGthQI=;
        b=kKm2NVO2KQpxPB8yuwvhYlz2lluwNhvnFs9wsISuQT6ZYm2BlpAMyEQVj46kuGQXPp
         ZJitChrcf3kNFlnBuwrOVtRN09QS4JFKJAA+jnbKNLGm+9aiUWq9+DdI5gq3XYYnhpIE
         FwwuwVpgtfcI3zFWmNPGn6kJWid0ZBfMz0MRCX+Q/X1YynYIDo1K2i4/g0MWapKu9S4A
         BkjRdk8zBUXQNOjQ+Vw6FALB2S0CbPGhSPYFTlP92fJMx5DmRx624xxKeevFfsimRM/V
         mKThzIJdJaBLD5Fttgk/OOUtrNKxPgyyk6IW1tR9mLMEZWE6SujYIH+PW1kI1FPyvK8l
         D/Iw==
X-Received: by 10.60.83.232 with SMTP id t8mr24886103oey.16.1400347625750;
        Sat, 17 May 2014 10:27:05 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id zc8sm21554872obc.1.2014.05.17.10.27.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 May 2014 10:27:05 -0700 (PDT)
In-Reply-To: <20140517062413.GA13003@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249489>

Jeff King wrote:
> On Sat, May 17, 2014 at 12:25:30AM -0500, Felipe Contreras wrote:
> 
> > > I agree with the line of reasoning you laid out in your email,
> > > especially:
> > 
> > What a shock.
> 
> Please stop with these unproductive and rude comments.

I am sorry, but the fact of the matter is that you *always* agree with
Junio.

> > > I hadn't thought of the rename idea, and it would address the concerns I
> > > brought up. I do think "obsolete" is the wrong word, as it sends the
> > > wrong message. The helpers are not obsolete; it is our _copy_ of them
> > > that is.
> > 
> > Originally you said you would respect if I wanted the code out
> > for v2.0, I said I would like it out at some point, not necessarily in
> > v2.0. Junio said he was fine with that, but the proposals above don't do
> > that.
> > 
> > Now it seems you are changing your mind and you are OK with the code
> > remaining in.
> 
> My concerns were with people not noticing the README. Removing the code
> entirely is the way I thought of to address that. Junio suggested
> another way, which I would also be fine with. And it seems like a
> friendlier way than removal to handle it for v2.0, if we are going to
> remove the code entirely post-v2.0.

I don't see what is friendlier about this:

 % sudo pacman -Syu
 % cd ~/dev/my-hg-repo
 % git fetch
 fatal: Unable to find remote helper for 'hg'

The users will scratch their heads, wonder what's going on, investigate
themselves, and eventually they'll have to decide how to fix the issue
properly, and how to report it.

On the other hand:

 % git fetch
 WARNING: git-remote-hg is now maintained independently.
 WARNING: For more information visit https://github.com/felipec/git-remote-hg
 searching for changes
 no changes found

You think that's less friendly?

If you think so, I think you are totally biased towards whatever happens
to be the opinion of one person.

> As before, if your desire is to have the code out for v2.0, then say so.
> I think we should respect such a request.

As I said before, I do not wish the code to be removed for v2.0, I would
like to have only a warning. Either way, do whatever you want for v2.0,
it's your users you are hurting.

But if I do not hear *from Junio* that the code will be removed entirely
post-v2.0, hopefully replaced with stubs (which is obviously the most
user-friendly thing to do), I'll do what I said I'll do.

-- 
Felipe Contreras
