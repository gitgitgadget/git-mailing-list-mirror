From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git fails on large repo clone on intermittent, or intermittently-high-latency, connections
Date: Wed, 5 Jan 2011 21:00:48 +0100
Message-ID: <201101052100.49506.jnareb@gmail.com>
References: <AANLkTinkhmHpAQjraviKjqFAczThR5GtT_qdyf6Sb3nm@mail.gmail.com> <m3tyhnbcf7.fsf@localhost.localdomain> <20110105175412.GA21863@burratino>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Zenaan Harkness <zen@freedbms.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 05 21:01:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaZYD-0002BG-H1
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 21:01:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701Ab1AEUB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 15:01:27 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62078 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655Ab1AEUB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 15:01:27 -0500
Received: by fxm20 with SMTP id 20so15397686fxm.19
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 12:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=KBINlyP12NiCPiOOm8bJekRvvXJkbNcS9J2Y13dn0fc=;
        b=dDktrVB66PLr9xNVaVWin2F+1enGyiIOPZBlwfsm8ufviDSGQYz78jvpL661bQr3ya
         hR5A9DglbICsxLxoHaz7vkMN9PHbBAceOPxMKPGUzXy3NVFTpkaVTAgU97H4dBRQjow0
         BkP9fXqBRmmwV91C9jpM46U//Pi1mBKfI53Mc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Dn987Q4Sy4tpYGh4b1Bbl+Pkta1e2bYy0c+QqRmyOgzk5E6nB500qAtEnq7aI3nQQK
         QwKAkfgP+NUFZ087y72bMCkj7QL+8URBvEHCSxZ9xLTf2tMG3IYpOrwtxrIUF3MKbWqA
         KGPLq4kUKexrBTi491WgUPx0znVkZ2Y1VsIUM=
Received: by 10.223.108.83 with SMTP id e19mr1093483fap.54.1294257685839;
        Wed, 05 Jan 2011 12:01:25 -0800 (PST)
Received: from [192.168.1.13] (abwm104.neoplus.adsl.tpnet.pl [83.8.236.104])
        by mx.google.com with ESMTPS id e6sm5621374fav.8.2011.01.05.12.01.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 Jan 2011 12:01:24 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20110105175412.GA21863@burratino>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164588>

On Wed, 5 Jan 2011, Jonathan Nieder wrote:
> Jakub Narebski wrote:
> > Zenaan Harkness <zen@freedbms.net> writes:
> 
> > > How hard would it be to add a wget-like mode to git, for the initial
> > > repo download?
> >
> > Very hard; tthough "resumable clone" was often requested (25%
> > responders in "Git User's Survey 2010", see [1]), and there was even
> > some discussion about possible implementation, it was not implemented
> > yet, even as proof of concept.
> >
> > The trouble is that packfile is *generated for a client*, and
> > bit-for-bit representation of said pack can vary (e.g. if
> > multithreaded packing is enabled; usually a good idea).
> 
> That said, one possible partial solution would be to automate
> generation of a seed bundle for huge repositories (with a script or
> a special parameter to "git gc", maybe) and to document serving such a
> seed bundle over HTTP as part of the standard setup.  If this could be
> made simple enough that e.g. all large repos on repo.or.cz had such a
> seed bundle then I would call it a success. :)

I wonder if adding support for per-project _bundle_ link and 'bundle'
action support to gitweb (perhaps only if caching is turned on) would
help there... though I am not sure if doenloading fron gitweb is
resumable.

-- 
Jakub Narebski
Poland
