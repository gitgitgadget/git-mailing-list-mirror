From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: Gitweb caching: Google Summer of Code project
Date: Fri, 30 May 2008 17:27:59 +0200
Message-ID: <48401CFF.4020702@gmail.com>
References: <483C4CFF.2070101@gmail.com> <200805300127.10454.jnareb@gmail.com> <483FABB4.1010309@gmail.com> <200805301202.25368.jnareb@gmail.com> <4840166C.3030903@gmail.com> <20080530150713.GG593@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	John Hawley <warthog19@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	Lars Hjemli <hjemli@gmail.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri May 30 17:28:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K26X8-0000xy-GW
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 17:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243AbYE3P1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 11:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753151AbYE3P1y
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 11:27:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:1428 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093AbYE3P1x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 11:27:53 -0400
Received: by ug-out-1314.google.com with SMTP id h2so338629ugf.16
        for <git@vger.kernel.org>; Fri, 30 May 2008 08:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=eic2IMj8Wx5uXEW8tqIWU0afTE3yD+TfC8NIEM655j0=;
        b=lRyrmEP/SMC43eRSzX1WetgdCPRI5XjzsPSH0erATpt9CebfBMQiF/uey41K3MdVzDoEscv1Xc7Dpv2R8BsLkY7cPfsckV1OrI/pJKetMBu9HdtylXW6697ucr7xQWt+uda947neGxodx1QcRX2CayHazijG4SfztVadM6CbyGc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=EsfueEAFNUytcLrCFCbFG1Zb3h5NsqVG2DZgj2N2Pv7plFpB9Upy/F+oK6vjtuL7k2ieYbX/tgg3YX+KkBa8rIEwSChd2cyh6Ajls02PyxsPBygXG/ER6nLv9VrYUq1jfx48Y7SvuOsgR+vFiUu1ztaHJkSuZFy1PxhHnHpHp20=
Received: by 10.86.73.17 with SMTP id v17mr2369289fga.24.1212161271804;
        Fri, 30 May 2008 08:27:51 -0700 (PDT)
Received: from ?192.168.23.50? ( [91.33.213.54])
        by mx.google.com with ESMTPS id d4sm796435fga.4.2008.05.30.08.27.48
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 May 2008 08:27:51 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <20080530150713.GG593@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83308>

Petr Baudis wrote:
> please make [memcached] optional.

Oh, absolutely.  I was definitely planning to keep Gitweb runnable 
without having Cache::Memcached installed.

> print "<p>This page took ".tv_interval($t0, [gettimeofday])."s to generate.</p>";

Sure -- I'm not sure how useful bare timings are, though.  When I look 
at individual pages, the page cache is usually warm anyway, so the only 
thing I might be interested in is advanced statistics like the number of 
calls to git or number of cache hits/misses.  To find out how the cache 
performs timing-wise, you'll have to do larger benchmarks, individual 
page generation times won't help that much.

> I wonder what oldest Perl versions do we aim to support?

I'm thinking about 5.8 or 5.10.  Looking at Debian, Perl 5.10 is not in 
stable (etch), but it's in lenny, which is planned to become stable in 
Sept. 08.  So by the time the updated Gitweb/Git.pm has stabilized (and 
shows up as a package in Debian), Perl 5.10 will definitely be available 
widely enough.

-- Lea
