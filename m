From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Pull is Evil
Date: Wed, 30 Apr 2014 14:32:05 -0500
Message-ID: <53614fb5e204_2aa5fa32f0df@nysa.notmuch>
References: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com>
 <xmqqoazlqot4.fsf@gitster.dls.corp.google.com>
 <536106EA.5090204@xiplink.com>
 <536129068cc28_1404fdd310fd@nysa.notmuch>
 <vpqha5akamh.fsf@anie.imag.fr>
 <5361416a172fe_f9b15012ec7e@nysa.notmuch>
 <xmqq38gufxbm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 21:42:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfaP4-00031Y-1i
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 21:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965083AbaD3Tmq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 15:42:46 -0400
Received: from mail-yh0-f49.google.com ([209.85.213.49]:60532 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964955AbaD3Tmo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 15:42:44 -0400
Received: by mail-yh0-f49.google.com with SMTP id t59so2132308yho.8
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 12:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=fEfQ+tCTHlPMVdIAwIMjls/tnmjDqOHaTMgszNWHfw4=;
        b=Uad6zSqjipOI2XQJXBTv7SudizgdHKf806khgrxiFbeqwuj0ti+oy3SCY52TLsRUlb
         TkZ2AS4KqD4L87BM9ukpOg8wd64ysr8FNPRNNlLVqURgafXIKDZ1xbkY/ihqU49K8pHY
         aOZs69vW9Gn19CTfGeMXBVD5nHmKKYTTmDDlSewm6Wb5BEB7oK/kF9JJibeRqG/ohdy6
         K+m7Ldvt6r7FIPRaTtm+DHaG8E4xchfEmEylyZh3ULK/Fjxhuw/KwqPqLeImhIczFE7u
         9fRa8fiTZp6szFINaRdzp2qoeczeO4KmgZ/A8mg1PVl07m5l/N27a+Am/BRD+66ldW76
         UgIQ==
X-Received: by 10.236.43.227 with SMTP id l63mr4897349yhb.144.1398886963706;
        Wed, 30 Apr 2014 12:42:43 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id h23sm44566327yhf.34.2014.04.30.12.42.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Apr 2014 12:42:42 -0700 (PDT)
In-Reply-To: <xmqq38gufxbm.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247763>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> > Matthieu Moy wrote:
> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
> >> ...
> >> > Yes, this has been discussed many times in the past, and everyone agrees
> >> > the default behavior is not correct.
> >> 
> >> You definitely have a strange notion of "everyone".

> While I do not quite see the previous discussion as deciding the
> particular implementation is good without further tweaks, I would
> say that everybody agrees that the default behaviour is not good for
> everybody and therefore should (or for Linus, "it is OK to") change.

Yes. The only aspect I didn't see consensus is whether
'git pull $remote' should reject non-ff merges by default as well. I
argued that 'git pull $remote' shouldn't behave differently than
'git pull', but I got no responses.

> > Rational people don't think in absolute terms, "everyone" means
> > virtually everyone, which is the case.
> 
> True for "should change", not virtually everyone for "should change
> with that particular solution".

I said 'everyone agrees the default behavior is not correct', which is
true.

> But after re-reading the series description 0/n this round in the
> other thread, I think the overall direction is good (just like Peff
> said in the previous thread), especially if there is a warning not
> error period.
> 
> The step (I am not sure you have it in your series or not, but I
> would strongly recommend adding one if it doesn't yet) that gives a
> "will change the default, and here is how to configure" warning when
> we see an actual merge made (or rebased) after "git pull" without
> "--merge/--rebase" is not just a way to prepare existing users, but
> is a good way to bring new goodness to newbies.  The session might
> go like this:
> 
> 	$ git pull
>         ... fetching ...
>         ... merging ...
>         ... diffstat ...
>         warning: you merged the $branch from $remote into your
>         warning: work, which may not be what you wanted to do unless
>         warning: you are acting as a project integrator.  If that is
>         warning: the case, "git config --set pull.mode ff-only" to
>         warning: cause "git pull" to refuse working when it does not
>         warning: fast-forward.  Use pull.mode=merge if you did mean
>         warning: it, to squelch this message.
> 
> I am not advocating the exact wording above, but am illustrating
> that there is a place for us to tell the new people to live in a
> better future before the switchover happens.

As I said, I already sent a patch similar to that, but I dropped it
since this was for v2.0, and since I excepted this series to be ignored
like so many.

I'll resend.

-- 
Felipe Contreras
