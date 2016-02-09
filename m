From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1] travis-ci: override CFLAGS properly, add -Wdeclaration-after-statement
Date: Tue, 9 Feb 2016 11:06:17 +0100
Message-ID: <9FBB5AFB-D44C-43A1-A0C5-A5A45675A122@gmail.com>
References: <1454921958-53129-1-git-send-email-larsxschneider@gmail.com> <20160208122551.GD24217@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Users <git@vger.kernel.org>, linux.mdb@gmail.com,
	Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 09 11:06:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aT5Bl-0004z2-R5
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 11:06:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756004AbcBIKG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 05:06:26 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37332 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754751AbcBIKGW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 05:06:22 -0500
Received: by mail-wm0-f49.google.com with SMTP id g62so16048218wme.0
        for <git@vger.kernel.org>; Tue, 09 Feb 2016 02:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DhO8K25dwgLs2xJti2NwVZC3tEuxw70KsoKZwFMwmlM=;
        b=Mg37M7veoVb2ZeamzCBMxAGR24Jz0MfgSVMNI03Zb/l5LrmkndAqUa9xiuC4du6R+A
         bAFB0/CUSOQ3VvdSfy9oon8dRPpqJH4cPGDSrMrXcegGoNwHmDH+3ECSzRzspaUXRizp
         I+l0GDRE5pVnoo6MdhvwgCcrrV/wBlXFMswqYL9+s6TmHhYZKmuL9KQF1PA0fZoh9dOi
         FLfHgAKJbtyC8i2yxb/rDsMf0SYKZZqpUyoCIBhAXgxmd6wrJUJm/CiHsQGuRl1qAp9Q
         mgDANbgyvHTvib9DatTImrIwgjpH9DkJcIWMT2te0ISbe1g9NuZTcoX0WwkFSFt2uogN
         ufcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=DhO8K25dwgLs2xJti2NwVZC3tEuxw70KsoKZwFMwmlM=;
        b=mJTmmYDkN0TwcMg6rgNa1mS1EpKb8H1DMNKcD6PiqFTIGcEtqZTeclNBrR/zkFB26+
         yNc323bL5QkGv3h04rfgacei39Qu0UF5FduDq+WzozHBDYhJYp1GOnTLry9i3kEhp1Kf
         mzBTiWO8zbqROunvC32h1LwxdB6+nHmnfkh5+1/+D4DOj4A/LEgZfFf8g5WMQKQjKXPv
         B18BDUzNYyclfhBtM9hsT7LVrjs20WfEbho0AYALQuLApb0CKXdVx3gqX1eHgunsTGTG
         +3IGfP1yTkuHoxl4jtiSNCvIyEwwr2qPs8zrZB3HbgnBHASk7aTqqoBliEEpdCETyXQS
         /T0Q==
X-Gm-Message-State: AG10YOTBwtfwOyhwBuHAyYWdeiM3SzFgldVUDu9Em6Jni5wEpM6k8vBAOTNM5ZiIs6KkVA==
X-Received: by 10.28.180.193 with SMTP id d184mr3677797wmf.64.1455012381190;
        Tue, 09 Feb 2016 02:06:21 -0800 (PST)
Received: from slxbook3.fritz.box (p508BABD1.dip0.t-ipconnect.de. [80.139.171.209])
        by smtp.gmail.com with ESMTPSA id k4sm16737541wmc.12.2016.02.09.02.06.19
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 02:06:20 -0800 (PST)
In-Reply-To: <20160208122551.GD24217@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285834>


On 08 Feb 2016, at 13:25, Jeff King <peff@peff.net> wrote:

> On Mon, Feb 08, 2016 at 09:59:18AM +0100, larsxschneider@gmail.com wrote:
> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> The global Travis-CI environment variable CFLAGS did not override the
>> CFLAGS variable in the makefile. Pass CFLAGS as make variable to
>> override it properly.
> 
> Makes sense.
> 
>> In addition to that, add '-Wdeclaration-after-statement' to make a
>> Travis-CI build fail (because of '-Werror') if the code does not adhere
>> to the Git coding style.
> 
> I think this is a good step, but is probably the tip of the iceberg. I
> typically use:
> 
>  -Wall -Werror -Wdeclaration-after-statement
>  -Wpointer-arith -Wstrict-prototypes -Wvla
>  -Wold-style-declaration -Wold-style-definition
> 
> Junio does his integration testing with a similar set, which I think you
> can find in one of the scripts in his "todo" branch.

I collected the warnings from Junio's Make [1] script and merged them with 
yours. This is the resulting warning list for clang and gcc:

-Wdeclaration-after-statement -Wno-format-zero-length -Wold-style-definition 
-Woverflow -Wpointer-arith -Wstrict-prototypes -Wunused -Wvla

Gcc processes one extra warning that clang doesn't like:
-Wold-style-declaration

The build runs clean with all these checks enabled.

[1] https://github.com/git/git/blob/todo/Make


>> I made this patch because Peff pointed out to me that "git style doesn't
>> allow declaration-after-statement" [1]. I wonder if it would make sense
>> to add this check even in the makefile [2]?
> 
> I think we keep the default CFLAGS to a pretty tame set, so that we
> build out of the box on a large number of compilers. I know I have run
> into problems with -Wold-style-* on clang (though perhaps that is no
> longer the case, as I haven't tried recently), let alone truly antique
> compilers.
> 
> I have, however, wondered if it would make sense to codify this
> knowledge in the Makefile with an optional knob. E.g., let DEVELOPER=1
> roughly mean "you are a git dev, you have a reasonably modern compiler,
> and want to be as careful as possible before sending your patches".

That make sense. However, in "development mode" I don't like Werror.
How about two knobs? One called DEVELOPER which enables all the warnings
above and one called CONTINUOUS_INTEGRATION that enables Werror
in addition?


>> I am no make expert, but I
>> also wonder why we don't use the override directive [3] for the CFLAGS?
>> AFAIK this would allow a make invocation like this:
>> 
>> make target CFLAGS+=-Wdeclaration-after-statement
> 
> I think it is rather the opposite. If we used:
> 
>  override CFLAGS+= ...
> 
> in the Makefile, then if a user did:
> 
>  make CFLAGS=...
> 
> we would add to their CFLAGS (whereas without the override, our
> appending is ignored). Our Makefile solves that in a different way,
> though. We pass $(ALL_CFLAGS) to the compiler, and that in turn is made
> up of $(CFLAGS) and $(BASIC_CFLAGS). We assume the user tweaks the
> former, and we set the latter based on Makefile knobs (e.g., NO_CURL,
> etc).
I see. Thanks for the explanation.

Regarding CI checks:

Jeff Merkey made me aware of http://kernelnewbies.org/FirstKernelPatch [2]
where I found checkpatch.pl [3]. Would it make sense to check all commits
that are not in next/master/maint with this script on Travis-CI?

Stefan Beller recently mentioned "Adhere to the common coding style of 
Git" [4] where he removed explicit NULL checks. This kind of stuff could be
checked automatically with checkpatch.pl as far as I can see.

[2] http://www.spinics.net/lists/git/msg267445.html
[3] https://github.com/torvalds/linux/blob/master/scripts/checkpatch.pl
[4] http://permalink.gmane.org/gmane.comp.version-control.git/280842

Thanks,
Lars
