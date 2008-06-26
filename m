From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [q] git-diff --reverse 7def2be1..7def2be1^
Date: Thu, 26 Jun 2008 13:02:02 +0200
Message-ID: <200806261302.03952.jnareb@gmail.com>
References: <20080620082034.GA24913@elte.hu> <m34p7ombie.fsf@localhost.localdomain> <20080626093726.GA24577@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Thu Jun 26 13:03:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBpG2-0000ZJ-Bx
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 13:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755035AbYFZLCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 07:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754896AbYFZLCN
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 07:02:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:49646 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753389AbYFZLCK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 07:02:10 -0400
Received: by nf-out-0910.google.com with SMTP id d3so235972nfc.21
        for <git@vger.kernel.org>; Thu, 26 Jun 2008 04:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=COV+4cxDQIFxIAwqM/pL+zHEGgxDvHMESFEx2Qg8iI4=;
        b=cRI0Xipp8vl2UREiMKOerh9zi3h4a0WAf4OQICWfV1/f5WEnZSGCjy2hu7x1EeCkZP
         r2K79VRGWDBhYrcBTZw8Ip6WciffS+wfzzYWWpAXww2sfQWDvll1ynq6LZwIqU2wbFMH
         ZXuM6AhTjWb4p4hjAxf0wwkomzNVRTvXbMjgc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=gvshZkfWkPLEEleFtBo9J/XYKM76FM5PArsUbQEg9gXVSIWtTWlMvETagZxHBf7N1P
         xnHJ/h1gnfU2vy1Hfwre5yz53+qIKxGW3/6dIOXBNbOnmw0pjf8wWeEI5ndrhB0yuYUf
         nqMkK/2iul0GirllZV0nCtya68BeSOv/7gu8g=
Received: by 10.210.125.7 with SMTP id x7mr2638430ebc.45.1214478129343;
        Thu, 26 Jun 2008 04:02:09 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.220.164])
        by mx.google.com with ESMTPS id g12sm2516061nfb.28.2008.06.26.04.02.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Jun 2008 04:02:08 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080626093726.GA24577@elte.hu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86429>

On Thu, 26. Jun 2008, Ingo Molnar wrote:
> * Jakub Narebski <jnareb@gmail.com> wrote:
>> Ingo Molnar <mingo@elte.hu> writes:
>>> * Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
>>> 
>>>> (BTW, git-foo is being obsoleted in favor of "git foo")
>>> 
>>> hm, can Bash be taught to do command completion on 'git rer<tab>', like 
>>> it is able to do on git-rer<tab> ?
>> 
>> contrib/completion/git-completion.bash in git repository.  
> 
> btw., i had to turn this off - it made certain types of file completions 
> almost unusable, by adding a 2-3 seconds delay (during which bash would 
> just spin around burning CPU time calculating its completion guesses).

Perhaps it would be better when "ceiling dir" feature in git, and
configured, so git don't waste time searching for git repositories
where there aren't any.

> and that was on a 3 GHz dual-core box ...

I think this might depend more on filesystem used, and file hierarchy.
And also probably on the number of branches... 

That said, I'm not fully happy with git bash completion[*1*] either:
one of complaints is that when completing "filename." on filename with
extension (for example to "filename.h") it sometimes treats "filename."
as beiginning of "<rev1>..<rev2>", and completes to "filename..", 
even if there no 'filename' ref in repository.

> so please do not remove the git-* commands, they are really useful.

Well, they are not removed, just moved aside (to address complaints
of cluttering $PATH with 130+ programs), and I think that you can
always install everything into /usr/bin/, as usual.  Although it would
be nice to be able to move aside only internal (*--*) commands, or
perhaps even internal and plumbing.

Footnotes:
==========
[*1*] I wonder how zsh git completion fares in comparison.
-- 
Jakub Narebski
Poland
