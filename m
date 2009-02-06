From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Fri, 06 Feb 2009 14:53:02 -0800 (PST)
Message-ID: <m3r62buqiv.fsf@localhost.localdomain>
References: <20090205204436.GA6072@diku.dk>
	<20090206191511.GD19494@coredump.intra.peff.net>
	<2c6b72b30902061410l64c98c33g19b97f656d347c83@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Fri Feb 06 23:54:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVZb1-0003dN-1V
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 23:54:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbZBFWxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 17:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753633AbZBFWxJ
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 17:53:09 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:14152 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065AbZBFWxH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 17:53:07 -0500
Received: by fg-out-1718.google.com with SMTP id 16so640786fgg.17
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 14:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=9AaXUovfJ79ZHSgkxZSB6JqhZv6ZaHyexbCHfUs7mSM=;
        b=jRHEhqjn3PBYPpWMEB4yfYzlHF4nnrVC6lmyc5OfxDnddMm6Z+LFpduwF0wqsp5rAF
         S/EhTgqRS7NGa8qkQYbNenx29sKKPHUb3SIm5YilwW9ahdNDGC8EzEUitk1tllWPQCtX
         4HkE+vnh0ExRpHF1ilV6KehIqIcd08smlWemY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=G2D38gZY9bXg2kbzITzADb/xsRtmAjabBfqVeh+EjEwqsm3xeW/aD7qKproMNrVqfi
         kwMkRmUlwaT0BgrwkKkkO4SiZpTCYvClGCKNmjEa5HpUB9Q8UPADjK88V5Zq7GUSRVwB
         0yScei4fvS+DDfHImipit497iIqMx6mUeQPAs=
Received: by 10.86.99.9 with SMTP id w9mr1270119fgb.12.1233960783855;
        Fri, 06 Feb 2009 14:53:03 -0800 (PST)
Received: from localhost.localdomain (abwn77.neoplus.adsl.tpnet.pl [83.8.237.77])
        by mx.google.com with ESMTPS id d6sm5482605fga.59.2009.02.06.14.52.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Feb 2009 14:53:02 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n16Mqkav022321;
	Fri, 6 Feb 2009 23:52:47 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n16Mqgh7022317;
	Fri, 6 Feb 2009 23:52:42 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <2c6b72b30902061410l64c98c33g19b97f656d347c83@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108797>

Jonas Fonseca <fonseca@diku.dk> writes:

> On Fri, Feb 6, 2009 at 20:15, Jeff King <peff@peff.net> wrote:
> > On Thu, Feb 05, 2009 at 09:44:36PM +0100, Jonas Fonseca wrote:
>>
>>>  - Blame view: load blame for parent commit. For merge commits the parent
>>>    is queried. Bound to ',' by default via the existing "parent" action.

>> It looks like you just keep the view on the same line number when moving
>> to the new blame output. In practice, this has very mixed results. Most
>> of the time it does exactly what I want, but if the file changes
>> significantly, you get dumped at a totally unrelated part of the file.
>> I'm not sure if there is a more clever solution, though.
> 
> Yes, it is a bit easy to get lost. It should be possible to find the
> original line number either by making git-blame also honor
> --show-number for the --incremental output or by using the "porcelain"
> version:
> 
>   git blame --show-number -L <line>,<line> <rev> <file>

Errr... you are wrong.  There are three line numbers when browsing
blame output.  Original line number, line number in _blamed_ commit
(shown with --show-number, --porcelain, --incremental), and line
number in _parent_ of blamed commit... which we don't know, and
which I don't think it is easy to find...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
