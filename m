From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Using gitrevisions :/search style with other operators
Date: Wed, 10 Nov 2010 07:26:20 -0800 (PST)
Message-ID: <m3eiatfbg2.fsf@localhost.localdomain>
References: <20101109083023.783fad9b@chalon.bertin.fr>
	<13A8F1B3-39B0-4D11-8763-9C458F75487D@sb.org>
	<20101109102428.5ba8dc13@chalon.bertin.fr>
	<7vlj52jakh.fsf@alter.siamese.dyndns.org>
	<050F42EE-34FE-499F-B632-471597EB4881@sb.org>
	<20101110083209.6a1252ef@chalon.bertin.fr>
	<23523534-F7A7-4D61-A899-8B3B28566EA7@sb.org>
	<20101110084609.78f532a5@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Ballard <kevin@sb.org>, Junio C Hamano <gitster@pobox.com>,
	git list <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Wed Nov 10 16:26:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGCZD-0006AW-1q
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 16:26:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756690Ab0KJP0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 10:26:25 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:65012 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756582Ab0KJP0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 10:26:24 -0500
Received: by ewy7 with SMTP id 7so350770ewy.19
        for <git@vger.kernel.org>; Wed, 10 Nov 2010 07:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=OqTo6JalWo2l6XZw681zyyjG+hkS4UMC28l211nyYDw=;
        b=OM1fJSkvgsgNg3ZPDWebnSTcR3Pmah6hB5nrE91oR7vGuPMIglK5YIp2qsZSMTupYT
         t79BfJ2FaxuiETScZAILB6jxg4/NfMcbLcohbBBsLRIyawUkGbPgEn9VBTlbg+/bUQqm
         iw9XszEvw+3en+342rvl2v9pUaN+LDOw3DuAA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=MWWajgbj6NPOBAgfHIpqcZwCUEQ4kY34miVUtPsyeQM6mv/y8B8YoOhL9DqKJk8eCL
         4IdT5AZn03m4fZFI8zyhcCpokz5o9V2TLMvsP3okZTGPaaoZPIiEHC0OZ4TQvqPDKrmy
         1jN/kE5ocqu8Qts+92KA801vj1GSTTYtev2CQ=
Received: by 10.213.19.200 with SMTP id c8mr614381ebb.56.1289402782677;
        Wed, 10 Nov 2010 07:26:22 -0800 (PST)
Received: from localhost.localdomain (abvo97.neoplus.adsl.tpnet.pl [83.8.212.97])
        by mx.google.com with ESMTPS id v51sm794512eeh.16.2010.11.10.07.26.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Nov 2010 07:26:20 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oAAFPU6C026721;
	Wed, 10 Nov 2010 16:25:41 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oAAFP2n1026710;
	Wed, 10 Nov 2010 16:25:02 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20101110084609.78f532a5@chalon.bertin.fr>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161153>

Yann Dirson <dirson@bertin.fr> writes:
> On Tue, 09 Nov 2010 23:46:59 -0800
> Kevin Ballard <kevin@sb.org> wrote:
>> On Nov 9, 2010, at 11:32 PM, Yann Dirson wrote:
>> 
>>>> Another thing to consider - the current :/foo syntax searches for
>>>> the newest commit reachable from any ref. Using the ^{} syntax will
>>>> require specifying a ref first. I'm not sure this is a problem
>>>> though, as I'm not really sure why :/foo searches from all refs to
>>>> begin with.
>>> 
>>> The syntax could be extended so that ^{whatever} starts looking at
>>> current commit (ie. HEAD), somewhat like @{whatever} looks at
>>> reflog for current branch.

The <ref>@<sth> is about reflogs: <ref>@{<n>}, <ref>@{<aproxidate>},
@{-<n>}, <ref>@{upstream} / <ref>@{u}.  Because HEAD has separate
reflog, then @{<sth>} is about current branch reflog (@{-<n>} uses
HEAD reflog, though).  <ref> must be something that has reflog.

The <obj>^<sth> is about dereferencing: <tag>^{<objtype>} and <tag>^{},
which includes following parents <commit>^ and <commit>^<n>.  Then
there are odd <commit-ish>^! (returning range) and <commit-ish>^@
(all parents) but which nevertheless follow this rule.

The <obj>:<sth> is (with single exception of ':/<regexp>') about
selecting subitem (path): <tree-ish>:<path>, [:<stage>]:<path>

>> 
>> :/foo doesn't start from the current commit - it searches all refs.
>> However, making ^{} search all refs if not given one doesn't make
>> sense for any operator except :/foo, so I don't think it's worth doing
> 
> Yes, that's why I suggested to make it search from HEAD, not from all
> refs.

Perhaps '--all^{/foo}'?  Just kidding... I think ;-)


About n-th match: I think that ^{<n>/foo} or ^{:<n>/foo}... or
^{:nth(<n>)/foo} as generic form of e.g. ^{3rd/foo} a la Perl 6 :-)
Or perhaps even full form ^{m:nth(<n>)/foo}... well, perhaps not.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
