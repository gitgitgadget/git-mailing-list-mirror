From: Evgeniy Ivanov <lolkaantimat@gmail.com>
Subject: Re: [git-p4] Can't submit: Something I do in a wrong way.
Date: Thu, 20 Nov 2008 01:16:40 +0300
Message-ID: <49249048.5030504@gmail.com>
References: <49247E5D.7070601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Wed Nov 19 23:19:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2vNz-0003zD-Oj
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 23:19:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbYKSWRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 17:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbYKSWRo
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 17:17:44 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:9243 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbYKSWRo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 17:17:44 -0500
Received: by fg-out-1718.google.com with SMTP id 19so131849fgg.17
        for <git@vger.kernel.org>; Wed, 19 Nov 2008 14:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=kn25rzVNIfZpsaR/+2taaDxXwb1WTRCwUokhZtCgURg=;
        b=faUrTvhu2JGfekt2Dt4Owc3rDJXZQwTKV0ZF7AZt3S/tkTFPdbYycgbmWId0JtkbBZ
         y6lQMw2DtR8WxqNNkcz4rEMzn8Ednyqd9Y7VoEF9lJ1hVy5OJUO7S/vYMuljvhv8Syz9
         rlVfgnmUEod7Lz/pS608hWxjbKZKHRQU7yG4s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:cc:subject:references
         :in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=F+FP6CK1psfRwSaWb/q3TCJ0anKk5jFCc/7Dq9m1y5SIelLGj3c7mu3Wop/UAJ5IMw
         g+k14etSfFJmEbG635GTM5CpndR7ty5yLrBnTQs4BKq9RP64uxTpc6ZVLIEo4QWP03kf
         YoRWG8HyJg8OzA/5ra/CVXyYM4HPtdrbs4Wzw=
Received: by 10.181.149.19 with SMTP id b19mr475763bko.82.1227133061355;
        Wed, 19 Nov 2008 14:17:41 -0800 (PST)
Received: from ?93.81.248.228? ([93.81.248.228])
        by mx.google.com with ESMTPS id e17sm188872fke.10.2008.11.19.14.17.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Nov 2008 14:17:40 -0800 (PST)
User-Agent: Thunderbird 2.0.0.17 (X11/20080922)
In-Reply-To: <49247E5D.7070601@gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101378>

Retried and noticed that if I do:
/dir1/1> git-p4 submit --git-dir=../../git/1/ --origin=master
Then everything works fine. Strange, but docs say:
"This requires a Perforce checkout separate to your git
repository. To submit all changes that are in the current git branch but
not in
the "p4" branch (or "origin" if "p4" doesn't exist) simply call

    git-p4 submit

in your git repository."
And my approach is a bit vice versa.
Any suggestions? I can go with it, but I want almost forget about thing
that I have perforce :)


Evgeniy Ivanov wrote:
> Hi list,
> I need a help with git-p4.
> 
> There are //1, //2, //3 in perforce's depot, and /dir1 is a client's root.
> So:
> Root:   /dir1/
> //1/... //client/1... etc
> I've checkouted //1, //2 and //3.
> 
> In /git I did "git clone //1; git clone //2", So I have /git/1, /git/2.
> Now I run in /git/1 "git-p4 submit commitBr" and choose 'y' to sync,
> where comitBr has one more commit than master.
> I get "Path /git/1/... is not under client's root /dir1/". Without
> syncing it says I have opened files, but when I do in /dir1/1 "p4 -a
> revert" I get: "file(s) not opened on this client".
> Looks like "git-p4 rebase" works fine.
> 
> Also I tried to keep git in the same dir as perforce workspace: I did 1
> commit and then failed to do anything, because got strange conflicts.
> 
> 
> P.S. Please don't forget to keep me in CC :)
> 
> 


-- 
Cheers, Evgeniy.
Key fingerprint: F316 B5A1 F6D2 054F CD18 B74A 9540 0ABB 1FE5 67A3
