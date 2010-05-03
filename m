From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: RFD: Shipping GitBrowser.js for instaweb
Date: Mon, 3 May 2010 21:12:09 +0200
Message-ID: <201005032112.10682.jnareb@gmail.com>
References: <4BDDA780.7090500@drmicha.warpmail.net> <m3wrvmf4ei.fsf@localhost.localdomain> <4BDE81D8.8070505@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Jan Engelhardt <jengelh@computergmbh.de>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon May 03 21:12:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O914Y-0008MG-5U
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 21:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756573Ab0ECTMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 15:12:24 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:43017 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756559Ab0ECTMW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 15:12:22 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1202015fga.1
        for <git@vger.kernel.org>; Mon, 03 May 2010 12:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=t0l6V5f0fM/So1PPikesTcd0EUoNp1KruCgOKDxwTCQ=;
        b=HBz0rvnBjRC8l6x6WRigQsEH+OMvyHPMPl9hSwhha8u7k4PuMYqQ4VqfgyvZDDvXLr
         OnCc/YUR19KgrYVBX4ZJOW/DDtIsezyfd8LIrWlNE7sVeI2Sgzh3Q+/mWXSDJ7hl4jGO
         wZ6LTuSFCCmgbzHis0RpdSHUzC2YxmgvzZYno=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=xUG0ahObXCr3ZZCh+e+bEKMZtKRydYOnOcWf/FxQT0F4l92AaGpwv7SpxdGj+REsNi
         VGq5zhhtKYlFd1E5XeYpyXLUl/DVz0lFtOvi+4aefmi53CRUT9gm0/ICB9MxCLj4SRdE
         F2x4d/QbpJ+TgiWugymlKjXE5GVKIUv8XT/Qo=
Received: by 10.87.15.35 with SMTP id s35mr11018532fgi.12.1272913938547;
        Mon, 03 May 2010 12:12:18 -0700 (PDT)
Received: from [192.168.1.13] (abrz91.neoplus.adsl.tpnet.pl [83.8.119.91])
        by mx.google.com with ESMTPS id 13sm9601235fks.0.2010.05.03.12.12.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 May 2010 12:12:16 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4BDE81D8.8070505@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146251>

On Mon, 3 May 2010, Michael J Gruber wrote:
> Jakub Narebski venit, vidit, dixit 02.05.2010 22:14:
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>> 
>>> I was wondering whether it would make sense to ship GitBrowser.js with
>>> Git and how much it would take to do so.
>>>
>>> My personal answer to the 1st Q is Yes: instaweb as well as simple
>>> gitweb installs would benefit from a graphical DAG viewer.
>>>
>>> About the required effort I have no clue: I find it difficult to see
>>> through which repo contains current gitweb, current repo.or.cz mods, and
>>> especially the GitBrowser integration bits. Maybe we could ship the
>>> integration bits without the actual GitBrowser if that is more feasible?
>> 
>> The integration parts are actually present in gitweb, I think.  It is
>> a matter of configuration to enable 'graphiclog' link like in
>> http://repo.or.cz
>> 
>> GitBrowser.js is not, I think, the best solution for having graphical
>> history in gitweb, but would do...
> 
> After having a more thorough look at it I agree... We don't want to
> inflate $GIT_DIR/gitweb more than necessary.

Especially that GitBrowser.js (git-browser) does drawing in *JavaScript*,
and requires (included) extra wz_jsgraphics.js JavaScript library
(Walter Zorn's High Performance JavaScript Graphics Library).

> 
> But what are the alternatives? Something svg/canvas would be nice, I
> guess. The ruby frontends with graphlog don't convince me at all
> (neither performance-wise nor layout-wise).

1. Using SVG/canvas (probably with Flash as fallback for those web 
   browser that do not have support for canvas element and/or SVN)
   seems like overkill for gitk / qgit / "git log --graph" equivalent
   for gitweb... well, unless for something like interactive 'Network'
   graph on GitHub, see e.g. http://github.com/jquery/jquery/network

2. Gitweb could generate required images on-the-fly using one of graphics
   modules like GD (uses gd library), Imaginer, or Image::Imlib2 (uses
   imlib2 library).  GD is, I think, most commonly used and available.
   We would want to make it conditional on GD (and gd library) being
   available.

3. Gitweb could use some ready images, which would be composed to form
   graphical representation of history; it would probably use CSS to
   change color (and require support for opacity in CSS or transparent
   layer in PNG).  See also 4.

4. Gitweb could use Unicode characters for tree graphics like git-forest
   (http://dev.medozas.de/gitweb.cgi?p=hxtools;a=blob_plain;f=bin/git-forest)
   does (I think it uses box drawing characters U+2500-257F).  We could
   even borrow some code from git-forest, which is also in Perl 
   (by Jan Engelhardt).

5. Gitweb could use ASCII-art for drawing history, like "git log --graph"
   does... perhaps even by directly using (and probably postprocessing)
   git-log / git-rev-list output with the '--graph' option.  It could
   change (transform) ASCII-art to Unicode box drawing characters.

-- 
Jakub Narebski
Poland
