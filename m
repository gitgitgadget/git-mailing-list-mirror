From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC 10/10] gitweb: Create links leading to 'blame_incremental' using JavaScript
Date: Mon, 27 Jul 2009 21:06:56 +0200
Message-ID: <200907272106.57484.jnareb@gmail.com>
References: <1248475450-5668-1-git-send-email-jnareb@gmail.com> <200907261206.15646.jnareb@gmail.com> <20090727181046.GA30365@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Mon Jul 27 21:00:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVVRG-0003ht-5D
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 21:00:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752266AbZG0TAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 15:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751882AbZG0TAi
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 15:00:38 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:51760 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900AbZG0TAh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 15:00:37 -0400
Received: by fg-out-1718.google.com with SMTP id e12so548909fga.17
        for <git@vger.kernel.org>; Mon, 27 Jul 2009 12:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=iBXiHA4mfNDsZtFtP+GcytOJc1j5vjbGNBsUUoq+TP0=;
        b=DFq4xGdL5fXX2ZCxLd89Myn5GQD8aqCQ6LdUQWY8SyosSsMIn930+pDVz5FZfWp6Am
         DbYLTIStMvbultYf2JzCjjCZhJZopvsrwi1q6rAcXj01yFcO4lsUMgHleRoBV1Lqyvds
         oB3tb2CamEjf2zS3SiF4nDs+6Ehy18dnZR3ho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ZL6hZFOZn6TyKfDJCl14rZxyc+B8R0rVPiWw388VCx8SSRH49v2MT4hIZJiQJjYhwt
         TqowMNwu/Jtvi/nko06UGjG0Vf9mN4brMmmV0IKf4rrUvGp4Z4GfGiuqnZHC1WczQc34
         4xo1iKbwUUm69z4vK3sH3llpy0hz0d95vrT7c=
Received: by 10.86.98.19 with SMTP id v19mr943095fgb.29.1248721235355;
        Mon, 27 Jul 2009 12:00:35 -0700 (PDT)
Received: from ?192.168.1.13? (abvr226.neoplus.adsl.tpnet.pl [83.8.215.226])
        by mx.google.com with ESMTPS id l19sm19465992fgb.26.2009.07.27.12.00.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Jul 2009 12:00:34 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20090727181046.GA30365@auto.tuwien.ac.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124186>

On Mon, 27 July 2009, Martin Koegler wrote:
> On Sun, Jul 26, 2009 at 12:06:11PM +0200, Jakub Narebski wrote:
>> On Sat, 25 Jul 2009, Martin Koegler wrote:
>>> On Sat, Jul 25, 2009 at 12:44:10AM +0200, Jakub Narebski wrote:
>> 
>>>> TODO list:
>>>> * Perhaps put fixLinks() function in separate file gitweb.js.
>>>>   Should gitweb use single JavaScript file, or should it be split into
>>>>   more than one file?
>>> 
>>> The same question can be asked for gitweb itself:
>> 
>> Well, there is one important difference: gitweb itself is not send
>> over network to client.  JavaScript is.  (Although I'm not sure how
>> great it is of an issue, with browsers caching JavaScript.  Perhaps
>> one single file would be better idea.)
> 
> More files mean more request on the server. If the browser is
> configured to check at each request, it will issue a GET for each
> JavaScript file, which will be answered by a 304 after the first
> request. In the "automatic mode", the browser waits for some time
> (determined by a heuristic), before it will issue a GET for each file
> request again.
> 
> So in my option, on (bigger) file is better, as it means fewer request.

I didn't means splitting JavaScript file based on functionality, like
one would do with modules in C, for example.  I was wondering if it 
would be worth to keep gitweb.js with common utility functions and 
functions used in all or nearly all views separate from gitweb-blame.js
which would be loaded and used only for 'blame_incremental' view.

But I am not sure if it is worth complications with build procedure:
installation and configuration.  With single JavaScript file it is
enough to have GITWEB_JAVASCRIPT or GITWEB_JS build variable/option,
and that would be enough.  Not so if we have gitweb-blame.js and 
perhaps other such files.


BTW. we can minify JavaScript file during the build (for example using
JSMin, or one of its derivatives), and e.g. use "gitweb.min.js" in
HTML generated by gitweb.perl / gitweb.cgi.

>>> 
>>> Why is it a single perl file and not splited in many different
>>> modules?
>> 
>> 2. Having it all in single file make its easy to install and update.
>>    Well, it made more sense when only way to configure gitweb was to
>>    edit gitweb.cgi.  Now building gitweb.cgi is the task for build
>>    system, and the only thing left is to copy files in correct place
>>    (I think that there are distribution specific packages which makes
>>    installing gitweb as easy as "xxx install gitweb").
> 
> Yes, there are gitweb packages, which automaticially server
> repositories under a specific path (eg. /srv/git). For such packages,
> the js layout is irrelavant.
> 
> When manually installing, copying only one javascript file simplifies
> the deployment.

OTOH if we split Perl source of gitweb (it is second in size only to
gitk; fourth in size git-gui got already split into smaller modules)
then dealing with multiple JavaScript wouldn't be the problem in build.

> 
>> 3. You would have to decide _how_ to split it into many different 
>>    modules.  Do you know any good examples?
> 
> Javascript uses on global namespace. If it is one file, its implicitly
> clear, that everything (functions, variables) are in one scope.  If
> you split it into multiple files, you have to remember, what the other
> files contain.

True.  You can however use single global object and store what would
be global variables as properties (fields) of such object...

Besides I'm not advocating splitting into many small files.  Only that
much files as really necessary.

-- 
Jakub Narebski
Poland
