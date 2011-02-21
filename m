From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: The future of gitweb (long term goals)
Date: Mon, 21 Feb 2011 23:06:35 +0100
Message-ID: <201102212306.39084.jnareb@gmail.com>
References: <201102142039.59416.jnareb@gmail.com> <4D5A42B2.3090603@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Hawley <warthog9@kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 21 23:07:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrduO-0004tY-Ed
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 23:07:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332Ab1BUWGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 17:06:53 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:55737 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947Ab1BUWGw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 17:06:52 -0500
Received: by bwz10 with SMTP id 10so2582025bwz.10
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 14:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:x-priority:priority:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=akQkwuBPLIpjmL1O4lyuAtRPQCdYR2SHRhX4xqDRE+I=;
        b=iDavc24KU7rPbjIS02YYb/eAxfXPKTyzAu9I1uc+Hy+AE3eZhvdIJyyS4hbBW5ULfc
         i0xRFXf3HxMTLKdwK2F7Ka6h8wfm/AbQJ+IFhbhqzD8d+GSQPdnzfvgyTINlo8TIPDmN
         FQXz0Dvvn87wi1hCBzxtq64ZnQCAg1oPf+Hzc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :x-priority:priority:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=n/lm6KrFvZLezs4v+3vl7q2ldpWCt/6q5DmH0/2NQ1zu6QkmdTMG9ssuO99PwlQBA3
         doHNhznIdapXSwb7Wnx9l2MYR6gNOPW2XFG/F2s4h2U1pBRdO8nqnPYtEZG8SnObH02k
         H7oEACKeBAKPGkt2nNANPVlj/WZbsCzhQh9r0=
Received: by 10.204.152.220 with SMTP id h28mr1803378bkw.158.1298326010796;
        Mon, 21 Feb 2011 14:06:50 -0800 (PST)
Received: from [192.168.1.13] (abwn36.neoplus.adsl.tpnet.pl [83.8.237.36])
        by mx.google.com with ESMTPS id w3sm4062468bkt.17.2011.02.21.14.06.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Feb 2011 14:06:48 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4D5A42B2.3090603@drmicha.warpmail.net>
X-PRIORITY: 2 (High)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167506>

On Tue, 15 Feb 2011, Michael J Gruber wrote:
> Jakub Narebski venit, vidit, dixit 14.02.2011 20:39:

> > Now that we are talking about future of git, including breaking some
> > of backwards compatibility bugs / misdesigns for 1.8.0, perhaps it is
> > the time to discuss long term goals and the future of gitweb.
> ...
> > Current requirements are:
> > - Perl 5.8.x (for proper Unicode / UTF-8 support)
> > - core Perl modules: CGI, Encode, Fcntl, File::Find, File::Basename,...
> > - non-core Perl modules optional, needed for some of extra features
> > - backward compatibility (query params and path_info URLs)
> 
> I'd second that this is important for adaption by some main users.

You mean here backward compatibility of API (i.e. old links keep working),
isn't it?

> > - easy installation even without admin rights
> > - scanning for repositories (as an option)
> > - lightweight
> 
> All of these are important for instaweb also. 

Nowadays git-instaweb uses _installed_ gitweb, so neither easy 
installation, nor installing / running without admin rights is necessary
for use of gitweb in git-instaweb.  Strictly speaking neither is scanning
for repositories; I think git-isnatweb could generate file with list of
repositories (with repository) to show.

> I consider instaweb a very
> underrated feature! (It also needs some works of love, not just
> appreciation, of course.)

Beside adding support for new web servers (like recently added 'plackup'),
what do you thing needs to be done?

> > 1. Splitting gitweb into modules (packages), for better maintainability.
> 
> Also, this may help including other optional parts. The graph viewer as
> used on repo.or.cz sets gitweb apart from quite a few alternatives and
> would be used more widely if it were an optional module shipping with
> gitweb. Just imagine instaweb with graphs ;)
> Also, being part of gitweb, the viewer may attract a few coders.

Well, adding anything major (like e.g. write functionality, output caching;
perhaps graph of history is also in this category) really require split
gitweb.  It is getting hard to maintain gitweb as it is now.

-- 
Jakub Narebski
Poland
