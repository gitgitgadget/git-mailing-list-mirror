From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH] log -g: ignore revision parameters that have no reflog
Date: Wed, 03 Feb 2016 13:35:58 +0100
Message-ID: <1454502958.2713.13.camel@kaarsemaker.net>
References: <1454241144.2822.7.camel@kaarsemaker.net>
	 <1454455961-10640-1-git-send-email-dennis@kaarsemaker.net>
	 <xmqqegcuprrw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 13:36:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQwfm-0006v3-VC
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 13:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755071AbcBCMga convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2016 07:36:30 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33514 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754795AbcBCMgB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 07:36:01 -0500
Received: by mail-wm0-f67.google.com with SMTP id r129so7213793wmr.0
        for <git@vger.kernel.org>; Wed, 03 Feb 2016 04:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-type:mime-version:content-transfer-encoding;
        bh=XEE4o1x6yPOy30W99q0iujA/Qau2zfOT2GsN2CSqRh0=;
        b=Rhn5/fVKYxxmONYqqq/Q6J44b7Z9XdDjqUKBKncNTiMBJyyVojSc4USoYRb6nSxWcL
         dhCCWTWa3MdIfFLlxj43P3G3VK0NgazDH6OBIUVTfwZmN4R+pAKqwSnj4nBGWu6b70qK
         4lq5g3yH9NLT00WQ3Ws0F/Z3zZCWF2xmYewWdp9VzZfj6xSRRUsBMdBBjDnXZaTmCKgo
         +oFwkv+T1DZZJilhetzbO90rZuh3PlYDP51qX1RpY10z14rETWHLLprd1eUir14Rc2qf
         R5su36chYVNI6YT/9fFIAwSdbE6umT8YGRm6DB7A0gDjFK7tWbsUKNdQhZskOmANdspb
         OzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=XEE4o1x6yPOy30W99q0iujA/Qau2zfOT2GsN2CSqRh0=;
        b=lR8r2I8w4+WkdFckYaF/tKmHtYHPm05mCVCimTBVcj+URLRcOXb5qCJvToC6ReAiP/
         ESHQ03TgC6O0sXsxmnLHmyDxz80SsMlbL0R0FCrDSDiElVCBrRc5lqB6brDc6Eq0kuZE
         gAw3P6IWtZF8dESqtwRuDPa4BttE2Hm5mpfIUFfPZuNdcFogxnNW9k5ZNuHgtTcTZjZA
         YWP59JfMxKt4ztTQeNckqI/4gw67RjIuFNiWCUSyY5PMNKzR1SFJ1UkgwBRBJuT6DFSq
         RXnQVIdQ46p4t8ORTUitIztgiIg41L5iJNV2avgMAHe4V4VAlfbATqSWF69JPnToeAOc
         pXUQ==
X-Gm-Message-State: AG10YOR22TDlI8f5VoY+KEA++hC7nvdkUWXtdMVsYjYSR5onsYGDsnMRurzZ+mtQ6fyTOA==
X-Received: by 10.28.222.68 with SMTP id v65mr3790419wmg.66.1454502959609;
        Wed, 03 Feb 2016 04:35:59 -0800 (PST)
Received: from spirit.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id u72sm7769381wmd.16.2016.02.03.04.35.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2016 04:35:58 -0800 (PST)
In-Reply-To: <xmqqegcuprrw.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.18.3-1ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285367>

On di, 2016-02-02 at 16:21 -0800, Junio C Hamano wrote:
> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
>=20
> > +	if (revs->reflog_info) {
> > +		/*
> > +		=C2=A0* The reflog iterator gets confused when fed
> > things that don't
> > +		=C2=A0* have reflogs. Help it along a bit
> > +		=C2=A0*/
> > +		if (strchr(arg, '@') !=3D arg &&
>=20
> Is this merely an expensive way to write *arg !=3D '@', or is there
> something else I am missing?

Doh. No, that's just my stupidity. I did the strchrnul bits below
first, then found out that it broke `git log -g @{0}` and came up with
the above.

> > +		=C2=A0=C2=A0=C2=A0=C2=A0!dwim_ref(arg, strchrnul(arg, '@')-arg, =
sha1,
> > &dotdot))
> > +			die("only refs can have reflogs");
>=20
> Is "foo@23" a forbidden branch name?

It is not, the code should look for @{, not @.

> Is this looking for a dotdot?=C2=A0=C2=A0If you are introducing a new=
 scope,
> you can afford to invent a variable with a name that reflects its
> purpose.

True. I just adhered to surrounding style (the dotdot variable is
abused below as well). Lame excuse, I know :)

> Style: a binary operation like '-' (subtract) have SP on both sides
> of it.
>=20
> > +		if(!reflog_exists(dotdot))
>=20
> Style: one SP between a syntactic keyword like 'if' and opening
> parenthesis is required.

Ack.

> I have a suspicion that in your final "fixed" code, it may be a
> better design not to let the command line argument for "-g"
> processing pass through this function at all.
>
> For example, what should "git log -g master next" do?=C2=A0=C2=A0Merg=
e two
> reflog entries in chronological order and show each of them as if
> they are thrown at "git show" one by one?=C2=A0=C2=A0Does that mesh w=
ell with
> other options like "--date-order/--topo-order"?

I agree that option parsing is not the right place in the end. When -g
is given, only one ref argument should be accepted, and --date-order
etc. should cause it to barf as they don't make sense.

> For another example, what should "git log -g master..next" do?
>=20
> Or "git log -g master^^^"?
>
> These are merely a few example inputs I can think of off in 5
> seconds and I think none of the above makes much sense, but parsing
> these is the primary purpose of this function.

With this patch they die with an error as they make no sense.

> So, I dunno.=C2=A0=C2=A0I gave a few "coding" comments, but I am not =
sure if
>=C2=A0you are touching the right codepath in the first place.

I was trying to go for a minimal change to fix a bug without
introducing regressions. It feels weird to do it in the option parsing
code, but I didn't want to make this behaviour fix wait for a rewrite
of the log -g functionality, as I have no idea when I'll be able to
finish that. It already took me a few hours to come up with this, as I
had not touched the related code at all before :)

--=20
Dennis Kaarsemaker
www.kaarsemaker.net
