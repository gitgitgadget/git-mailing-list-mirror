From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Gitweb caching: Google Summer of Code project
Date: Sat, 31 May 2008 12:15:34 +0200
Message-ID: <200805311215.37233.jnareb@gmail.com>
References: <483C4CFF.2070101@gmail.com> <20080530150713.GG593@machine.or.cz> <48401CFF.4020702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Hawley <warthog19@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	Lars Hjemli <hjemli@gmail.com>
To: Lea Wiemann <lewiemann@gmail.com>, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat May 31 12:16:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2O8c-0004OA-L9
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 12:16:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbYEaKPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 06:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbYEaKPq
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 06:15:46 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:37712 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbYEaKPp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 06:15:45 -0400
Received: by fg-out-1718.google.com with SMTP id 19so290581fgg.17
        for <git@vger.kernel.org>; Sat, 31 May 2008 03:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=wXzJyXBwo09WXARUPKsB7/QvRyaWikNf3m3Muh5hW2M=;
        b=ppOX6TLAMGYxYrN+qFK7Uo2CioLRf37iunbvnYkDg1+LgHBypj62k/ahCEYSIg/U0Dr5LeuAzi6n2g4hky2/vRCrdpAxe04K+DgdgLrUdq15ESHfKJ/lmz04T4sx+sMOveRQIPL+2Bq7Zx1u63QB5i9VO8StfhxNo4u5uKHEg40=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=XrtrtAeH5u/pr2CII82bbJJ9rA28NQf2FpKLATf9KaFDAPsnyRFgfBVfWck2PX2HDndJhshkKRAXvBATqhADyQspYwz3/hJ29EVXzXzoHedjHNnSBnuMv21zWvwkn5hL5XeSb/VOaGCXU0qtSr4H4px4Z0Io7kwNj/Rt8wZEpw0=
Received: by 10.86.23.17 with SMTP id 17mr261939fgw.32.1212228944315;
        Sat, 31 May 2008 03:15:44 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.238.103])
        by mx.google.com with ESMTPS id 4sm929026fgg.9.2008.05.31.03.15.41
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 31 May 2008 03:15:42 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <48401CFF.4020702@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83372>

On Fri, 30 May 2008, Lea Wiemann wrote:
> Petr Baudis wrote:
> >
> > please make [memcached] optional.
> 
> Oh, absolutely.  I was definitely planning to keep Gitweb runnable 
> without having Cache::Memcached installed.

I think the idea was to have the following options:
 * cache using memcached (Cache::Memcached installed, and memcached on)
 * cache using filesystem, perhaps size aware (with limited cache size)
 * no caching

It is quite possible that one would want/need gitweb caching, but
either does not want hassle with memcached, or memcached is not
feasible (for example memory starved machine).

> > print "<p>This page took ".tv_interval($t0, [gettimeofday])."s to generate.</p>";
> 
> Sure -- I'm not sure how useful bare timings are, though.  When I look 
> at individual pages, the page cache is usually warm anyway, so the only 
> thing I might be interested in is advanced statistics like the number of 
> calls to git

This should be fairly easy, just modify git_cmd() to count number of
calls.

> or number of cache hits/misses.

And this I don't think it would be easy.

-- 
Jakub Narebski
Poland
