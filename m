From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Issues with cc-cmd
Date: Mon, 15 Feb 2016 15:39:43 +0530
Message-ID: <20160215100943.GU6334@vireshk-i7>
References: <20160215082746.GH6334@vireshk-i7>
 <xmqqh9haqody.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Joe Perches <joe@perches.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 11:09:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVG6O-0006zg-17
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 11:09:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbcBOKJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 05:09:52 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34696 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbcBOKJv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 05:09:51 -0500
Received: by mail-pf0-f181.google.com with SMTP id x65so85289695pfb.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 02:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=uCB+VzSR4htlW/+qthap8GMyBRLBRYf/T2eFIjG8Obs=;
        b=cwtyMWYuaQSgoNEiBO0sRKMZhPws7Ef+i9CalOJey8+EEW68QR7ZVrtMX356McTrNm
         Kw32yrcR7Zw2xcCJjU3SRQ02AurgNCMp0rwDLKSr4H/bStzKalPyq87f5fOFFhJvZEiC
         PMvoppk0dbc5MiPU71MkMm0D87hu603hCsHq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=uCB+VzSR4htlW/+qthap8GMyBRLBRYf/T2eFIjG8Obs=;
        b=ADl9f0c87/5d1IRvwB/JkIO/plvmfHTmDcUqTsy7GmIUqIII5n14vMmjf9cfANkfyk
         0TgNyTPc1IHth/xAfu8IZhZQkI/ekABAy0rPyT1aR4VZRVCY3w4g+PB2mOCufC5ButzV
         9MxHuZ+TvV/8eNjJLESKmY9MypiVNCoTGCpxYdTyxxfn2qbK+Qa54v121kNSNNjQuBJZ
         Mw73GUJ7nIyWt+MG9UEasYMHxdpOR/JZZ4+xRGgAb8Pl6wXDJUg9yqvvPK3Uab34eu1X
         psTiV5zBVMS2dDgJVxD6tzE/khBynVkTFUliX8L9dmpWOqB634aRbUk1yIzOWCTpMwtP
         /I8w==
X-Gm-Message-State: AG10YORfMMeFSbelVs1b6Jgjo9kH7IMx2BviH90acL7E7kmTcnjPhstE+RV7Pbr5ZU5wqcwW
X-Received: by 10.98.76.80 with SMTP id z77mr22223904pfa.121.1455530991381;
        Mon, 15 Feb 2016 02:09:51 -0800 (PST)
Received: from localhost ([122.172.89.184])
        by smtp.gmail.com with ESMTPSA id z7sm37288457pfi.19.2016.02.15.02.09.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Feb 2016 02:09:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqh9haqody.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286196>

On 15-02-16, 02:06, Junio C Hamano wrote:
> Viresh Kumar <viresh.kumar@linaro.org> writes:
> 
> > linux-pm@vger.kernel.org) (open list:OPERATING PERFORMANCE POINTS
> > (OPP),
> 
> Hmm
> 
> http://lists.kernelnewbies.org/pipermail/kernelnewbies/2014-July/011343.html
> 
> comes to mind.  It tells you not to blindly automate this process.
> 
> I do not offhand know if it was even designed to be directly used
> (and usable) as a cccmd, but anyway, I see this mention in its
> "Notes:" section:
> 
>   Using "--roles" or "--rolestats" with git send-email --cc-cmd or any
>       other automated tools that expect only ["name"] <email address>
>       may not work because of additional output after <email address>.
> 
> I suspect that what you are showing is the "additional output after
> address" the above talks about.
> 
> In any case, this command is maintained as part of the kernel, no?
> I see Joe Perches signed at the beginning of file in 2007; I do not
> know if he still maintains this script, or somebody else is
> primarily enhancing it these days (ehh, I probably could use the
> script on itself, but I am way too lazy late at night), but asking
> him would be a good starting point, instead of asking here.

Yeah, he told me this sometime back and that solved the issues I was
facing, and in fact it looks far better now. Thanks Junio.

git send-email requires a simple list of names and addresses
without decorations like roles, commit stats or section names.

You are supposed to use something like:

tocmd = "scripts/get_maintainer.pl --nogit --nogit-fallback --norolestats --pattern-depth=1 --nol"
cccmd = "scripts/get_maintainer.pl --nogit --nogit-fallback --norolestats --nom --nor"

-- 
viresh
