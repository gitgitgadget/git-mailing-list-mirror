From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Command-line interface thoughts
Date: Fri, 10 Jun 2011 18:44:14 +0200
Message-ID: <201106101844.16146.jnareb@gmail.com>
References: <201106051311.00951.jnareb@gmail.com> <201106082056.38774.jnareb@gmail.com> <4DF0B4B2.7080007@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Jun 10 18:44:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QV4oy-0006a6-Sx
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 18:44:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754167Ab1FJQo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2011 12:44:27 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39598 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327Ab1FJQo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2011 12:44:26 -0400
Received: by bwz15 with SMTP id 15so2332622bwz.19
        for <git@vger.kernel.org>; Fri, 10 Jun 2011 09:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=lyt5CjoZHbhHLVCsz0hFR4aYn9mhxVachoDHN75l7YM=;
        b=kG7tGV+NtYMk9qauL746FZeY3/KJKEQkytNFWGHXBA4wU27zZuTxtGjTNm7pfMHucb
         gjpL3et02TH2fiy6VxTC+ugvoFQ7leHsy3lxuEXf2ShEQQdhFnI3ylHh9rAPQrVAvtmF
         +6SLgd9dK16ePuY9Pm7A2+b8/InZX8m04Axk8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=uZwrseChqZI7RvOTAy64KcSYit6m1yERlbNUuBZDIgb5RT5XT606pM7BTJgTN4o9Wu
         X9Jv2N79t3fS+z9sLB4tb+1X0L6YVPZaLoOEgUmvqFs0RWO/mOegKF+Z8lqpx6z6K+Lb
         Nrkibu0iMB21Mh2k+8c/mSo4wcQDrqP0Q7GbI=
Received: by 10.204.84.166 with SMTP id j38mr2051345bkl.84.1307724265309;
        Fri, 10 Jun 2011 09:44:25 -0700 (PDT)
Received: from [192.168.1.15] (abvz126.neoplus.adsl.tpnet.pl [83.8.223.126])
        by mx.google.com with ESMTPS id t23sm2739196bkf.16.2011.06.10.09.44.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Jun 2011 09:44:24 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4DF0B4B2.7080007@ira.uka.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175611>

On Thu, 9 Jun 2011, Holger Hellmuth wrote:
> On 08.06.2011 20:56, Jakub Narebski wrote:

[...]
> >> But I can't make it explicit which two targets I want to compare with
> >> 'git diff'.
> >
> > For me it looks XY problem; instead of wanting to compare two explicit
> > targets, you should specify what you want to see ;-).
> 
> Then don't call the command 'diff' (... I proclaim in the knowledge that 
> that isn't possible). 'diff' is the short form of 'difference' which 
> means literally a comparison between *two* things.

Blame CVS (I think) on that.  It introduced no arguments "cvs diff" to
get current changes, and other version control systems picked this
convention up, including Git.
 
"diff" is 'are there any differences', or 'are there any changes'.
Implicit rules (targets) are very useful.

> If someone wants to 
> see something he would pick the words 'show' or 'list'. So user 
> expectation is different from what you want diff to be.

There is always "git status"...

> Also there are no good words for what someone wants to see in this case. 
> At least I would assume the git project would have found them if they 
> existed. '--cached' is definitely not one of them. But we have fitting 
> and widely known names for the targets, i.e 'working tree', 'index' and 
> 'head'.

"I want to see if there are any remiaining changes", "I want to see what
'git commit' would bring", "I want to see what 'git commit -a' would bring".
Neither of those is about targets for diff.

[...]
> > The "git diff NEXT WTREE" looks like training wheels to me.  And like
> > training wheels they could become obstacles and not help to learning
> > git.  Neverthemind they can snag on sharp corners^W corner-cases. ;-)))
> 
> If your goal is that anyone who uses git is a git expert, they may be a 
> hindrance (as are all the porcelain commands really). If you also want 
> to make git friendly to people who will never get past intermediate or 
> beginner stage or will only use a small part of git or use git seldomly, 
> training wheels are good.

Those "training wheels" are useless for beginner, and might be not very
useful to middle expert user either, depending on corner cases.

-- 
Jakub Narebski
Poland
