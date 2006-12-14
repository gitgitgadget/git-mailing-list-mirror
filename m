X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 09:27:25 +0000
Message-ID: <200612140927.27259.andyparkins@gmail.com>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> <200612132237.10051.andyparkins@gmail.com> <elpvro$rvj$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 09:27:47 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=sL5RNm4K+Ck+c1J2eMeds0lCnlFPiroe0Yt333cZxk+WoGcV+DHKODu6Z8HHd6fRr9yqCA9a6glM+gNCOV96tu9veCKPsVvN69EcKeDr7QVg5EW6wP6XX3SRtQoDunsPJDv6dmOJJVOLlGeJnH8rEvxL5xP6XGKu7wd9dO4PE+A=
User-Agent: KMail/1.9.5
In-Reply-To: <elpvro$rvj$1@sea.gmane.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34292>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GumsK-0006kA-LH for gcvg-git@gmane.org; Thu, 14 Dec
 2006 10:27:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932163AbWLNJ1e (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 04:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWLNJ1d
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 04:27:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:43714 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932163AbWLNJ1c (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 04:27:32 -0500
Received: by ug-out-1314.google.com with SMTP id 44so437653uga for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 01:27:31 -0800 (PST)
Received: by 10.67.22.2 with SMTP id z2mr1079018ugi.1166088451164; Thu, 14
 Dec 2006 01:27:31 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id x37sm1790019ugc.2006.12.14.01.27.30; Thu, 14 Dec 2006 01:27:30 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wednesday 2006 December 13 22:48, Jakub Narebski wrote:

> Nice list, although I'd rather add extra output only if command is used
> with -v/--verbose (or -V/--verbose) option; if not, then add -q/--quiet
> (or -s/--silent) option to be used in scripts. I'm partial to --verbose

I'd rather have the scripts requiring "--quiet"; because otherwise it's 
another switch for a newbie to guess at.  However, I don't think that 
switches is the answer.  Output for these porcelain-level commands is not 
structured enough to be used in scripts anyway (e.g. git-pull), but what it 
does output is a confusing lump.

> solution, as advanced users are not interested in any output; they know
> the commands, and want them to be fast. C.f GNU tar: it outputs something
> only with -v/--verbose option.

tar is doing a considerably less complicated sequence of operations than many 
of git's commands, so I don't think that's a fair comparison.

Also; I don't think "experts" should care about the extra output - I can't 
imagine that an extra few lines of text is going to slow git down.  Further, 
I think the problem in most cases is that git outputs _too much_.  Also, I'm 
not imagining that "git-add ." would list every file that it added - who is 
that going to help?  It should say "added X files to index" or similar.  You 
surely can't be arguing that that slows down your expert workflow?

I believe that a good set of output will be useful to both newbies and experts 
alike.  The idea that experts don't like to know what's going on is simply 
not true.  The idea that newbies want to see every file listed and every 
operation described is simply not true.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
