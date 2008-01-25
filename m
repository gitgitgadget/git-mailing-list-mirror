From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Add support for host aliases in config files
Date: Fri, 25 Jan 2008 22:51:42 +0100
Message-ID: <200801252251.42760.jnareb@gmail.com>
References: <alpine.LNX.1.00.0801251336080.13593@iabervon.org> <200801252033.13142.jnareb@gmail.com> <alpine.LNX.1.00.0801251436060.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Jan 25 22:52:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIWTF-0006K1-Oy
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 22:52:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760900AbYAYVvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 16:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754745AbYAYVvw
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 16:51:52 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:38244 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760875AbYAYVvv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 16:51:51 -0500
Received: by fg-out-1718.google.com with SMTP id e21so787349fga.17
        for <git@vger.kernel.org>; Fri, 25 Jan 2008 13:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=/5MTWMGvf0TIabTJgIKpgARqdgBtQB64a8FxjJIN8Ck=;
        b=sDLvT09enHyNT3BA3slfauiB1PDZLD4gxTkQBEkLdE0abKLKHH99NS1UXoOuIKYNWqFlnYcETYY3+ZF5uVQ6Ez3UyllHqnfje/A1xCXSaMZlcJEkLK8IBIoC65VCvg8R68PWUPzXzZ2+dpzuRW/41ieT9b4hTs6rzA2GC8/Zue8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=eSWj0LnHsxCCfuuK/NnDDCrUj2roBdJlIaSw5Jze1nsLjkwgK3PwkoPD+1LReafBiCeLb0S7VltoR4Zfw0Q/VeHv+fy4bN5/H/luRLfnrd+h+zLqWg9Gko4wLaTcOog8Imap3c8eAjQtd3B7MCombRqBIkMUJOiNmytkCRlPOn8=
Received: by 10.82.174.20 with SMTP id w20mr4488651bue.21.1201297909294;
        Fri, 25 Jan 2008 13:51:49 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.250.186])
        by mx.google.com with ESMTPS id x6sm3620526gvf.0.2008.01.25.13.51.47
        (version=SSLv3 cipher=OTHER);
        Fri, 25 Jan 2008 13:51:48 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LNX.1.00.0801251436060.13593@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71742>

On Fri, 25 Jan 2008, Daniel Barkalow wrote:
> On Fri, 25 Jan 2008, Jakub Narebski wrote:
> 
>>
>> So this config variable is actually about _rewriting_ URLs, rather than
>> having multiple _alternate_ URLs to fetch from. IMHO either the
>> documentation above should be (re)written better (there is time, as we
>> are in feature freeze), or the example mentioned above should be added
>> (but where?).
> 
> Maybe we should have a "host.<name>.*" section that explains the 
> collection of configuration options as a group? Like:
> 
> ----------
> host.<name>.*::
> 	These options provide a way to rewrite URLs when there is a
> 	pattern of URLs with a common prefix which should be replaced
> 	with a different prefix. For every 'alias' prefix given, any
> 	URL git receives that starts with that prefix will be
> 	rewritten to have the 'base' prefix instead. In cases where
> 	some site serves a large number of repositories, and serves
> 	them with multiple access methods, and some users need to use
> 	different access methods, this feature allows people to
> 	specify any of the equivalent URLs and have git automatically
> 	rewrite the URL to the best alternative for the particular
> 	user, even for a never-before-seen repository on the site.
> 
> host.<name>.base::
> 	The base URL which should be used for this particular
> 	host.
> 
> host.<name>.alias::
> 	Additional base URLs which refer to this host. If a URL
> 	matches this, any access to it will use the URL formed with
> 	the corresponding base URL instead of the given URL.

Good idea. IMVHO it reads better than previous version. Together with
explanation and example usage in Documentation/urls.txt (or somewhere
else) it would be enough and easy to understand.

BTW. shouldn't it be rather host.<name>.rewritebase (a la mod_rewrite)?
I think it is better name for this configuration variable.

-- 
Jakub Narebski
Poland
