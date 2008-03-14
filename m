From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: About detached heads
Date: Fri, 14 Mar 2008 12:11:33 -0700 (PDT)
Message-ID: <m34pb9xgrp.fsf@localhost.localdomain>
References: <93c3eada0803140246k53408c74m21f9dc277857202d@mail.gmail.com>
	<alpine.LFD.1.00.0803141041080.3557@woody.linux-foundation.org>
	<20080314183731.GA2994@atjola.homenet>
	<alpine.LFD.1.00.0803141150070.3557@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bj?rn Steinbrink <B.Steinbrink@gmx.de>,
	Geoff Russell <geoffrey.russell@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 14 20:12:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaFKB-0002iT-Nj
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 20:12:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753362AbYCNTLg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 15:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753132AbYCNTLg
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 15:11:36 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:27727 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752529AbYCNTLf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 15:11:35 -0400
Received: by wf-out-1314.google.com with SMTP id 28so4167400wff.4
        for <git@vger.kernel.org>; Fri, 14 Mar 2008 12:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=Cd1vt0mnrngzG13UuUpFZAzOAi8LfHEHDS4No9bUVnc=;
        b=ZCTb/NPVnIV9EIHswyh03uR8YhIt8UMz5RLdF7W0tIou4GJp9nEb3FRvoUeEhizhfOwerqdskHFzYt6taEz1Ph1mxbU4MGIxFCWEYNUOck9RXeKma2fE90kgy/ADhqbh6Azz2V3FY6Sv/C22L0paoOH6GtwKfsP8PUk2aYXEcWg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=eBJQ91P+T2BFza1DKFiXxtCSH5RYKJKzNufdrs/J185QSooOjuf1DeVyw01BBpw9QNVRsFRzpEWMECL4IKi5MpNJszrrfz7OnrM2CqZqL4fvV979pVZaW0J43NEACbwB8z9UPeDQiJXo49JcDepFRBixdUME/RojdirJla5cWBE=
Received: by 10.142.125.5 with SMTP id x5mr5337126wfc.124.1205521894624;
        Fri, 14 Mar 2008 12:11:34 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.191.199])
        by mx.google.com with ESMTPS id m38sm784033ugd.44.2008.03.14.12.11.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Mar 2008 12:11:33 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m2EJBP5N030287;
	Fri, 14 Mar 2008 20:11:26 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m2EJBNkG030284;
	Fri, 14 Mar 2008 20:11:23 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.LFD.1.00.0803141150070.3557@woody.linux-foundation.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77274>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, 14 Mar 2008, Bjorn Steinbrink wrote:
>> On 2008.03.14 10:53:25 -0700, Linus Torvalds wrote:
>>> 
>>> So the "core git" way to do it is to literally just do
>>> 
>>> 	git read-tree -u -m 3
>>> 	git commit
>>> 
>>> (or use "--reset" instead of "-m" if you want to do it even in the 
>>> presense unmerged entries).
>>> 
>> 
>> Hm, that's just squashing revert commit. Squashing can be done via:
>> git reset --soft HEAD~5    # Or wherever your squashed commit should start
>> git commit -m "Squashed from HEAD~5 onwards"
>> 
>> Now the "revert" version of that:
>> git reset --hard HEAD~5      # Go back to the state that we want
>> git reset --soft ORIG_HEAD   # Move HEAD back, but keep the index as is
>> git commit -m "Back at the state of HEAD~5"
>> 
>> AFAICT that should have the same advantages as using read-tree, but
>> doesn't feel so low-level :-)
> 
> Umm. The low-level one is a *lot* easier to understand than your 
> "high-level" one, wouldn't you say?
> 
> And when the low-level plumbing commands are easier, are they not then 
> better porcelain?

AFAIK the porcelain equivalent to plumbing

  git read-tree -u -m 3

is just

  git checkout 3 -- .

-- 
Jakub Narebski
Poland
ShadeHawk on #git
