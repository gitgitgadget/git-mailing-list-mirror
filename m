From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Some help on gitweb project.
Date: Tue, 15 May 2012 02:17:50 +0200
Message-ID: <201205150217.51844.jnareb@gmail.com>
References: <CAH-tXsAFMyrkAD1FWZKimbJt-gzmcyyXqt7gymtKozwfFt_aSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>,
	Andrew Sayers <andrew-git@pileofstuff.org>
To: jaseem abid <jaseemabid@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 15 02:17:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SU5Sg-0006Rp-8S
	for gcvg-git-2@plane.gmane.org; Tue, 15 May 2012 02:17:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932762Ab2EOARx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 20:17:53 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:56062 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932755Ab2EOARw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 20:17:52 -0400
Received: by weyu7 with SMTP id u7so2142252wey.19
        for <git@vger.kernel.org>; Mon, 14 May 2012 17:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=6+gnyZTM9x+kfZWF8zQKD8vxFsmpDVl2WT6aBfOsDzc=;
        b=dPY4gi68sfuRtBDlNpb6iMWfysvH1Te1DNMa6iPmH1j7b1AqLBhUceOYKLOjC7+QGL
         oyw5ie2BLZxWv/lQ0xYQKPPSmRitxqn3obC+U5iJR7mmPKv/SCf4/AHM7iEDk+td5ICE
         9+L7Hct9zw3S5bDcwI4r/bp++Bz7aezcIWD024Bwjuwl/fGT9tpy8kQ9iW9gdBaDeWRu
         UqG/GvRHSXrpGVUmHpnCqeIQEjs+MiEEzyNHsparzr/VoHbD7sii8YpzjpDJc69nvkx7
         dm2A8RhuGpZhWOJ38s/lcKVXxONgcHWCuNSdSgh2u0vpLbLT2gTTbl7hwnCiGMvhmuZ0
         4Ldg==
Received: by 10.180.81.36 with SMTP id w4mr2812719wix.16.1337041071596;
        Mon, 14 May 2012 17:17:51 -0700 (PDT)
Received: from [192.168.1.13] (acsn207.neoplus.adsl.tpnet.pl. [83.11.41.207])
        by mx.google.com with ESMTPS id ez4sm38600202wid.3.2012.05.14.17.17.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 May 2012 17:17:50 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <CAH-tXsAFMyrkAD1FWZKimbJt-gzmcyyXqt7gymtKozwfFt_aSA@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197816>

On Sun, 13 May 2012, jaseem abid wrote:

> Dear all,
> 
> I have been working on gitweb for a couple of days as part of a
> rejected GSoC proposal. I would love to get some help on this and if
> somebody can, that would be thankful.
> 
> 1. How is code tested after some change? I am not talking about unit
> testing but about making sure that application is doing what it is
> actually intended to do. Do you have to re - install git/gitweb with
> every version of code you commit and make sure that it works well and
> as expected? Or, is there some other way? Sorry but I am a newbie when
> it comes to FOSS contribution and as well working on a project of this
> magnitude.
> 
> As far as I understand, gitweb by default is looking for files from
> `/usr/share/gitweb/` (I work on Debian Sid if that helps). If I edit
> the perl or some JavaScript code, how should I test it? *Install* my
> version from source as mentioned in "gitweb/INSTALL" ?

One possibility is to install gitweb with "make -C gitweb install"
or "make install-gitweb".

The other is to set up config file in such way that gitweb.perl
would work with it; see the config file for t950x tests, the one
inside t/gitweb-lib.sh.

Though in latter case you can miss some errors...
 
> 2. How I should be committing ?
> 
> Personally I commit on *very* small changes, so that I can easily get
> back to any point and do bisects well and good, but I see the patches
> in the mailing list to be polished and fine tuned. Commit somehow
> comfortably and then polish it in another branch with rebase and
> squashes and then submit it for comments on mailing list?
> 
> Refer please: 
http://sethrobertson.github.com/GitBestPractices/#sausage

First, I alway use [interactive] rebase or equivalen (like patch 
management interfaces: StGit, Guilt, TopGit) to clean up patches
prior to submission.

Second, please do not think that the first attemt must be perfect.
The usual workflow is that one send RFC patches, people comment,
corrected version is sent, etc., etc... until the patch series is
polished to first get out RFC status then (if possible) get accepted.

> 3. How will I submit a commit like "Adding jQuery library"? Mail a
> whole minimized JavaScript library to the mailing list? How can
> somebody crosscheck the contents of a minimized JavaScript library ?
> 
> Earlier Jakub mentioned about adding CDN support for the library,
> which I think is a very good feature. How should I do this? Add an
> extra config/build variable to select b/w local and CDN version ?

I think that it would be simpler to start with CDN support in the form
of (for example) $jquery_url gitweb config variable and JQUERY_LINK
build-time configuration variable.

In the case the Internet access is lacking or intermittent, $jquery_url
might be to static file not to CDN.

And of course if ultimately we decide that we need to support providing 
out own work-tested version of gitweb, it can be done iff $jquery_url
is undefined or empty string -- fallback to in-repo copy, perhaps 
outdated but tested that it works.

> 4. At what stage is code to be submitted? After the full project is
> done or in a modular manner? Can I ask for some review and help from
> if I push the code to github and share the link, or do I have to mail
> that also? I don't want to repeat this :
> https://github.com/torvalds/linux/pull/17

Git development is based on git mailing list, not GitHub web interface.
In early stages you can send pull requests by private email (to mentors)
or to git mailing list; in final stages you better send patch series,
unless series is long and with large patches -- then pull request via 
email would be suitable.
 
> 5. What should be my base commit/branch for starting the work ?

Add include for jQuery (Makefile, gitweb.cgi, gitweb.txt) and check it.

-- 
Jakub Narebski
Poland
