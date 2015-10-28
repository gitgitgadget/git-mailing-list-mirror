From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 6/9] clone: allow an explicit argument for parallel
 submodule clones
Date: Wed, 28 Oct 2015 13:50:43 -0700
Message-ID: <CAGZ79kauFzSKHnUyUPB29Lu59FODVXG5wxWfGK+v7UCAUuESJQ@mail.gmail.com>
References: <1445969753-418-1-git-send-email-sbeller@google.com>
	<1445969753-418-7-git-send-email-sbeller@google.com>
	<xmqqlhaoni6q.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 21:50:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrXgH-0000ww-CV
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 21:50:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756178AbbJ1Uup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 16:50:45 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:34868 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756015AbbJ1Uuo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 16:50:44 -0400
Received: by ykek133 with SMTP id k133so21737244yke.2
        for <git@vger.kernel.org>; Wed, 28 Oct 2015 13:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=a68nYSoYr52r+bCWeTeOgIxVyA+VIHVwKH9COvU+3/w=;
        b=SHjODCUlKHPOOjXZAuN5Z6W0hGbb6jyuV9nBs9V+6HDoe2K/yyWm8/3DKicjDUmnzt
         ZjRrKM/cVTvb7ryJTnR7sQTH0e86UtRGFEdb8jLsRtpugK47YkYaqbHzdZkjuDAExb5p
         OI+Hx6srC9wCgw5pJ+O/4W5hF9CWkbG43Eb85kD1F4L/Yo/aGXkPtTXdNq2Kvkqhu/OU
         6EXF5mLBaX/twiy2Pr7iKcC7s6JhvGrC2psQon/qHZiFeArEOgH/6h4GE67oRn3eYFBE
         4O5xgdluxDScaQlW3mogMS20w9As9svZJxYKGJHqW69eVyGC0I5M8EXxcNsdFcSNrUpY
         YqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=a68nYSoYr52r+bCWeTeOgIxVyA+VIHVwKH9COvU+3/w=;
        b=eDYGa0KY/dqGDhpJuK37bxBlSX9mYyHShpdSy6s8rrW1kWw+3gZXzkbObl7wb83Nlo
         3oYx8btt0B16G/tNV5jThl5EIG8a3mBMDFjOqL8HXfeaVEGgabjDzm3MHixeQDM4baFm
         c8eYgVSC/LtLpmSD79SXWcGQ30y9/cgJ4UJJzRG3WEKVkGNwNr8bExKxSLjM4DkEDlbs
         hiuqVNFvOP/KjDl7VxHtin9iunuaKzyklWwoKWePSqbGiiVj2lu6Idnyk1mjB2Q7Ouws
         RzBYR8BrhXGAN98EprKGwFwGoLol7mKUjyRMgqu2N69UAyNXGNGiO1GNmjF3pFoa70jP
         SUig==
X-Gm-Message-State: ALoCoQljOhMh47CYpHK6Bv1FpBSiL8VHMoOPRCjhhQsyHh7dAykbSne3bLCtPDO1XG7ZZ1tBrH+1
X-Received: by 10.129.29.8 with SMTP id d8mr24164461ywd.63.1446065443839; Wed,
 28 Oct 2015 13:50:43 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Wed, 28 Oct 2015 13:50:43 -0700 (PDT)
In-Reply-To: <xmqqlhaoni6q.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280394>

On Tue, Oct 27, 2015 at 1:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> +     The number of submodules fetched at the same time.
>
> Do we want to say "Defaults to submodule.jobs" somewhere?

Yes. :)

> I am tempted to suggest that you should not pay attention to
> "submodule.jobs" in this command at all and just pass through
> "--jobs=$max_jobs" that was specified from the command line, as the
> spawned "submodule update --init --recursive" would handle
> "submodule.jobs" itself.

makes sense.

>
> Once you start allowing "clone.jobs" as a more specific version of
> "submodule.jobs", then reading max_jobs first from "clone.jobs" and
> then from the command line starts to make sense.  When neither is
> specified, you would spawn "submodule update --init --recursive"
> without any explicit "-j N" and let it honor its more generic
> "submodule.jobs" setting; otherwise, you would run it with "-j N" to
> override that more generic "submodule.jobs" setting with either the
> value the command line -j given to "clone" or specified by a more
> specific "clone.jobs".

I see. Though I do not plan adding clone.jobs in the near future.
