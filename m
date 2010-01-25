From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH 10/10] gitweb: Show appropriate "Generating..." page when regenerating cache (WIP)
Date: Mon, 25 Jan 2010 01:03:37 +0100
Message-ID: <201001250103.38703.jnareb@gmail.com>
References: <cover.1264198194.git.jnareb@gmail.com> <f4660e9c7ffdb4a62da0c56703de002c9df3b598.1264198194.git.jnareb@gmail.com> <20100124222417.GC9553@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jan 25 01:05:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZCQo-0008Ik-Ob
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 01:03:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754029Ab0AYADq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 19:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753193Ab0AYADq
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 19:03:46 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:44783 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122Ab0AYADp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 19:03:45 -0500
Received: by bwz19 with SMTP id 19so2313044bwz.28
        for <git@vger.kernel.org>; Sun, 24 Jan 2010 16:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Jza6ZPEGTjehVVyxO9PjiEyPwY1+QtY8zFyRZI0IM54=;
        b=TAtTVZbjDxvCxFp9Ztsixojos4Al0HVqgCOoekLiPHY7nlAMFNTJsYdRhkpF0GL4wo
         32R2RoFY5G9aXiIFsDyk+K8ya+sEOSrsGgKAlJeSiDKA5M92QcpA0LkPDE/dBN4F0ixD
         31JUzie4kve0n+51EM5nNz1EWP+xQBYLvkgTE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=jUNtq9dyYPCqujc2/6mQGn774F65TS3nROt3BOgFYItQkP3fCRZpUkXPp53FnntGtw
         arSra9D55Ar1MGlEHEtYSP+MLjkY2ZzaOyk+cJi/y5LCvZAR5gKV7Dx2Nehg2Y4ka+x/
         TDU2zeVWTm8WDGiC2fGFW8E5hl+fJRlMEeeIc=
Received: by 10.204.48.198 with SMTP id s6mr330961bkf.8.1264377823568;
        Sun, 24 Jan 2010 16:03:43 -0800 (PST)
Received: from ?192.168.1.13? (abvk247.neoplus.adsl.tpnet.pl [83.8.208.247])
        by mx.google.com with ESMTPS id 14sm1942505bwz.1.2010.01.24.16.03.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Jan 2010 16:03:42 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20100124222417.GC9553@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137929>

On Sun, 24 Jan 2010, Petr Baudis wrote:

>   I have stupid question, common to both the original patch and this
> RFC.
> 
> > [RFC PATCH 10/10] gitweb: Show appropriate "Generating..." page when
> > regenerating cache (WIP)
> 
>   Just why is a "Generating..." page appropriate?
> 
>   I have to admit I hate it; can you please at least make it
> configurable? Why is it needed at all? It generates unnecessary
> redirects, clears my previous page in the browser by a useless
> placeholder, confuses non-interactive HTTP clients and I just can't
> see the real purpose.
> 
>   What's the gain?

Don't ask me, I am just following original patch by John 'Warthog9' 
Hawley (J.H.) here, splitting it into smaller and hopefully easier to 
review parts, with each separate feature in a separate patch (so that 
features like this one are more visible).  I _think_ that in original 
patch by J.H. this feature was configurable (at least to some extent).  
As this series is more proof of concept than ready to apply patches, 
some of configurability is missing currently.

I think that adding the "Generating..." page follows behavior of other 
well known web applications, such as for example GMail.  Currently
if caching is enabled, and there is no appropriate entry in cache (not
even [slightly] stale entry) the page is shown only when it is generated
in full: there is no streaming (although I planned to add it).  So for
example for 'blame' view or for pickaxe search you could wait quite
a bit for a page to be shown.  The "Generating..." page is a kind of 
activity indicator here.

Note that the JavaScript-using Ajax-y version from the following patch 
'[RFC PATCH 11/10] gitweb: Ajax-y "Generating..." page when 
regenerating cache (WIP)'
  http://permalink.gmane.org/gmane.comp.version-control.git/137896
is not visible in browser history, as it simply replaces "Generating..."
page with the result.  So there is no 'unnecessary redirect', and there
is no 'useless placeholder' in browser history.

-- 
Jakub Narebski
Poland
