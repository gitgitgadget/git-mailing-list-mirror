From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: [PATCH 0/7] block-sha1: improved SHA1 hashing
Date: Sat, 08 Aug 2009 20:12:36 +0200
Message-ID: <4A7DC014.1030904@gmail.com>
References: <alpine.LFD.2.01.0908060803140.3390@localhost.localdomain> <4A7B1166.8020507@gmail.com> <alpine.LFD.2.01.0908061052320.3390@localhost.localdomain> <4A7B2A88.2040602@gmail.com> <alpine.LFD.2.01.0908061233360.3390@localhost.localdomain> <4A7B384C.2020407@gmail.com> <alpine.LFD.2.01.0908061329320.3390@localhost.localdomain> <4A7B4D84.80906@gmail.com> <4A7B509A.5010405@gmail.com> <alpine.LFD.2.01.0908061502570.3390@localhost.localdomain> <alpine.LFD.2.01.0908061909310.3390@localhost.localdomain> <alpine.LFD.2.01.0908071614310.3288@localhost.localdomain> <4A7CBD28.6070306@gmail.com> <4A7CBF47.9000903@gmail.com> <alpine.LFD.2.01.0908071700290.3288@localhost.localdomain> <4A7CC380.3070008@gmail.com> <alpine.LFD.2.01.0908072107170.3288@localhost.localdomain> <4A7D0E7B.3030601@gmail.com
 > <alpine.LFD.2.01.0908081004560.3288@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 08 20:12:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZqPZ-0004NH-9x
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 20:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679AbZHHSMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 14:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752596AbZHHSMi
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 14:12:38 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:44677 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930AbZHHSMi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 14:12:38 -0400
Received: by fg-out-1718.google.com with SMTP id e12so250831fga.17
        for <git@vger.kernel.org>; Sat, 08 Aug 2009 11:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=HFnOnjoUnUtYcfSylH0sh2DpvaL5I7YAj70JDeYxMBk=;
        b=Ti2LQ8ouoxVWHbgt5R11YNwtl0kPK5qAXCFwDKQLbq/XZV4+nDN+B5m4btmzHXLRtM
         YE0LA7zRF49rTtFpvDzm0fzwv+2cjMzezjynq7cil9jSSlH3w2OLyipBiWHDysbh8c6H
         7vl9j7pHXzVsLuek0L0BZa3+4ZPJCYrE+Dt2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=DB+o1np+KNkWfxqXLE/2O1FMfMk0ACv+zwpB+RhW2k29Go/DVR/X53LmJzFdCh5xv6
         CjqUX+mGqRNZBOs0d81zFn2IHY2xaF2V7Otf/sSKmZLeaizR15H2KiGkkSLGaUnIe0ZR
         RZdrjZtcMnaZZ09GYFbe0F2bf9uPRRjHd8PMU=
Received: by 10.86.68.18 with SMTP id q18mr1921250fga.68.1249755158318;
        Sat, 08 Aug 2009 11:12:38 -0700 (PDT)
Received: from ?172.19.43.221? (ip-89-174-123-58.multimo.pl [89.174.123.58])
        by mx.google.com with ESMTPS id l12sm6342871fgb.18.2009.08.08.11.12.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 Aug 2009 11:12:37 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22pre (X11/20090422)
In-Reply-To: <alpine.LFD.2.01.0908081004560.3288@localhost.localdomain>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125294>

Linus Torvalds wrote:
> 
> On Sat, 8 Aug 2009, Artur Skawina wrote:
>> I've inlined the byteswapping in 'opensslb', maybe that one will
>> do a bit better.
> Hmm. Testing on my atom, the inlined bswap is worse, but the asm versions 
> are generally superior to any C one:

It loses on atom, but is the best one on both P3 and P4 here.
Based on your other numbers I was expecting it to win on 32-bit
nehalem too. gcc doing a better job of scheduling w/ 'linusv'
wouldn't surprise though (since there are no spills, the data reads
are about the only other thing that could make a difference. And, yes,
they show up in the profiles; if x86 only had one more register...)

artur
