From: Junio C Hamano <gitster@pobox.com>
Subject: Re: please strip MIME-Version and Content-T{ype,ransfer-Encoding} in git am --scissors
Date: Thu, 08 Oct 2015 13:04:01 -0700
Message-ID: <xmqqio6hqg9a.fsf@gitster.mtv.corp.google.com>
References: <1444162070-22034-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1444162070-22034-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<5614CDAE.6070604@ti.com> <20151007075338.GH3982@pengutronix.de>
	<20151007102822.GT23801@atomide.com>
	<20151008071728.GO3982@pengutronix.de>
	<xmqqvbahqhw1.fsf@gitster.mtv.corp.google.com>
	<20151008193707.GT3982@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Thu Oct 08 22:08:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkHQ9-0001Xc-M0
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 22:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755667AbbJHUEE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Oct 2015 16:04:04 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:32807 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753349AbbJHUEC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 16:04:02 -0400
Received: by pacex6 with SMTP id ex6so63760871pac.0
        for <git@vger.kernel.org>; Thu, 08 Oct 2015 13:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=a3hi0vRIPHAH7uZ+8Smns631wrRBt2bVE4Vy9C6eUeM=;
        b=Kytwynh/NBSNmP+1BWhFw0alRILmRR86RHNUh6jbe35Em5+SudX0oAVNjttBqT0+tE
         QisLD5S1i5cmWxzLM8mi4ylojVZaurH5hZd9y2k0oy/J8Uhkrsomhg89pDMBqN+e8elK
         iugByESam/5MeHUbRJsnaDKEjQJ6z+XskaknFC3WeZS/JjTwTAqsMfD2vap3Hrv2s5eu
         Y00H23+NJ29RrKo4xoMoNte8XIXNYnNcQHHAl9G7q6Le+AIizUa6tzutFDTQG4dTs9wG
         5s/vrb3C6Ke5nJb2DmPozMziQQAPFQt7DaJvY4+Obeb4MAe9mbhMn5G3PI+CGcT//KCD
         VUWg==
X-Received: by 10.66.101.39 with SMTP id fd7mr9887753pab.3.1444334642466;
        Thu, 08 Oct 2015 13:04:02 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:8f0:649c:42a6:426d])
        by smtp.gmail.com with ESMTPSA id rx10sm27175283pab.21.2015.10.08.13.04.01
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Thu, 08 Oct 2015 13:04:01 -0700 (PDT)
In-Reply-To: <20151008193707.GT3982@pengutronix.de> ("Uwe =?utf-8?Q?Kleine?=
 =?utf-8?Q?-K=C3=B6nig=22's?=
	message of "Thu, 8 Oct 2015 21:37:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279271>

Uwe Kleine-K=C3=B6nig  <u.kleine-koenig@pengutronix.de> writes:

>> Does this have anything to do with scissors, though?  If you remove
>> everything before "8< ---" in the body of Tony's message (i.e. keep
>> the in-body headers starting with "From:" and ending with CTE) and
>> try again, I would suspect that you will get the same result.
> No, you're wrong here:
>
> ukl@dude.ptx:~/gsrc/linux$ head ~/tmp/1444332661.3982_89.ptx\:2\,RS=20
> From: Tony Lindgren <tony@atomide.com>
> Date: Tue, 6 Oct 2015 05:36:17 -0700
> Subject: [PATCH] memory: omap-gpmc: Fix unselectable debug option for=
 GPMC
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> Commit 63aa945b1013 ("memory: omap-gpmc: Add Kconfig option for debug=
")
> added a debug option for GPMC, but somehow managed to keep it unselec=
table.

I think you are the one who misread my question.  I said "keep the
in-body headers", didn't I?  If you did the "head", then you would
see something like this:


> ukl@dude.ptx:~/gsrc/linux$ head ~/tmp/1444332661.3982_89.ptx\:2\,RS=20
> From: Tony Lindgren <tony@atomide.com>
> Date: Tue, 6 Oct 2015 05:36:17 -0700
> Subject: [PATCH] memory: omap-gpmc: Fix unselectable debug option for=
 GPMC
> ... probably Received: and all other junk from your mailbox ...
>
> From: Tony Lindgren <tony@atomide.com>
> Date: Tue, 6 Oct 2015 05:36:17 -0700
> Subject: [PATCH] memory: omap-gpmc: Fix unselectable debug option for=
 GPMC
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> Commit 63aa945b1013 ("memory: omap-gpmc: Add Kconfig option for debug=
")
> added a debug option for GPMC, but somehow managed to keep it unselec=
table.

>> I also think that the "MIME-Version" thing is what gives this;
>> mailinfo and am do not really use it, and consider that the in-body
>> header ends there.
>
> I failed to follow you here.

I think if you tried the example with in-body header, you will see
what I meant.

>
>> The right approach to tweak mailinfo to cope with this better would
>> be to keep a bit more state inside mailinfo.c::handle_commit_msg()
>> so that if we are (1) using in-body headers, (2) have already seen
>> _some_ valid in-body header like "Subject:" and "From: ", and (3)
>> have not seen a blank line, discard lines that we do not care about
>> (e.g. "MIME-VERSION: 1.0").
>
> That sound's right.
