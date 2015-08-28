From: Namhyung Kim <namhyung@gmail.com>
Subject: Re: [PATCH] stash: Add stash.showFlag config variable
Date: Fri, 28 Aug 2015 10:54:33 +0900
Message-ID: <20150828015433.GB17656@sejong>
References: <1440683528-11725-1-git-send-email-namhyung@gmail.com>
 <xmqq614043u0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 04:10:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZV97n-0006L1-27
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 04:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbbH1CKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2015 22:10:34 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35115 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbbH1CKd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2015 22:10:33 -0400
Received: by pacdd16 with SMTP id dd16so44884657pac.2
        for <git@vger.kernel.org>; Thu, 27 Aug 2015 19:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=goLHAwjZHuH4fawBMGGxuSw7D2/F3R7V1B+7AyMYoC4=;
        b=WNpHIi2/PPNtSOmgCz+2tPmyyYJgS2ScxVHe34X8jQv2lrcoJAnkDjwILtCUHOp3EA
         RJPPKFzISmIPGnpL8GxDLpfBqVOwCrRFq1Xkg8uZRGtAwvTsLRCZOj3E7BR8o9AgdAzr
         94miDT2xaf7FE/P6W5/WzogO1eB9fANU+gjB5MEe4nxw+lI5ohVnxM2MF8VE/v7wbmMv
         XH+yT0/sgKi4ujo/EQ1E0Y9CXWhczON2zdnr7mheNqwGIkkCqd0rPHnJkFgnP5OGpmvE
         GI5aj00aQVdJGB9D5xTfb40MHwKYfzUeSI9IQ6Uo+3AHH45RJRmRmbWBFwiJT8fl9KAo
         9XmA==
X-Received: by 10.66.217.138 with SMTP id oy10mr11346727pac.83.1440727833343;
        Thu, 27 Aug 2015 19:10:33 -0700 (PDT)
Received: from sejong ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id cy10sm3834536pdb.13.2015.08.27.19.10.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2015 19:10:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqq614043u0.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23+102 (2ca89bed6448) (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276702>

Hi,

On Thu, Aug 27, 2015 at 06:08:39PM -0700, Junio C Hamano wrote:
> Namhyung Kim <namhyung@gmail.com> writes:
> 
> > +stash.showFlag::
> > +	The default option to pass to `git stash show` when no option is
> > +	given. The default is '--stat'.  See description of 'show' command
> > +	in linkgit:git-stash[1].
> 
> Doesn't the same discussion in $gmane/275752 apply here?  By
> designing the configuration variable in a sloppy way, this change
> will force us to spawn "git diff" via the shell forever, even after
> somebody ports "git stash" to C.
> 
> Which is not great.

I see.


> 
> Perhaps a pair of new booleans
> 
>  - stash.showStat (defaults to true but you can turn it off)
>  - stash.showPatch (defaults to false but you can turn it on)
> 
> or something along that line might be sufficient and more palatable.

Hmm.. I agree with you, but I don't know what we should do if both of
the options were off.  Just run 'git diff' with no option is ok to you?

> 
> I dunno.

:)

> 
> 
> [Footnote]
> 
> *1* Besides, showFlag is a strange configuration variable name.  I
> thought that by setting it to true, you are making "git stash"
> command to somehow show some kind of a flag when it does its
> operation ;-).

I admit that it's a bad name.  My naming sense is always horrible.. ;-p

Thanks for the review!
Namhyung
