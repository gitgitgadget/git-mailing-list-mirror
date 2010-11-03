From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [RFC/PATCH 1/2] Documentation: suggest "reset --merge" more often
Date: Wed, 03 Nov 2010 02:32:12 -0700
Message-ID: <4CD12C1C.2020507@gmail.com>
References: <20101029083516.GA26290@burratino> <20101029083836.GB26290@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, srabbelier@gmail.com,
	Thomas Rast <trast@student.ethz.ch>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Johan Herland <johan@herland.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 03 10:32:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDZhi-0003Iq-B2
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 10:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753996Ab0KCJcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 05:32:21 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57008 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940Ab0KCJcT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 05:32:19 -0400
Received: by gyh4 with SMTP id 4so276796gyh.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 02:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=zm4Jiuqg9ebIkcOlIqT0A5tnk34iwDh6GT8vkgqnfeo=;
        b=WAFIoiRH3o6RF1HbZCB2q6VqTPIk+u6FP9FzdFBEEDAL+1PLXev//FE/c7/yvuZKr5
         840RiIWC2ph+t3v0ZPof95rKTgwCoE3KoRWZwjk5avvgOJYKWGCTK4/sAgAd+ExTZRw8
         S3fEjAgtH7PWg4ciOi072DQ82f47ChCaKuTF0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=WGwy8uvvHbGAfEGHi4AwjCQ97X8frjM3/z/MDpHCerq/w2QA6ILiawq1g4zE8Gh5I8
         KVMRpspQO277mildFVRsM362mGx1uTwT/QUXz2IJZpvfGqlOqncW7qsDfBoKk9MXFu2h
         abtnN74XtVCClCNNrYjgSKDDrQRK7YS937Bao=
Received: by 10.42.211.16 with SMTP id gm16mr6085231icb.326.1288776738446;
        Wed, 03 Nov 2010 02:32:18 -0700 (PDT)
Received: from [192.168.1.105] ([75.85.182.25])
        by mx.google.com with ESMTPS id d21sm7850063ibg.15.2010.11.03.02.32.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 02:32:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.11) Gecko/20101025 Lightning/1.0b3pre Thunderbird/3.1.5
In-Reply-To: <20101029083836.GB26290@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160592>

On 10/29/10 01:38, Jonathan Nieder wrote:
> With its new semantics, "git reset --merge" is more suitable for
> undoing a failed merge than "git reset --hard" is.  It is especially
> nice if you forget that you are in a merge and make a change or two:
> 
>   git merge something-complicated
>   ... notice conflicts, walk away ...
>   vi foo.c
>   git commit; # fails because the index has unmerged entries
>   git reset --merge
> 
> The modern (post-1.7.0) semantics of git reset --merge ensure that
> the changes to foo.c will be preserved by this sequence of commands,
> unless foo.c was one of the files with conflicts.
> 
> So in the spirit of ed4a6baa (Documentation: suggest `reset --merge`
> in How Merge Works section, 2010-01-23), recommend it in place of
> "reset --hard".
> 
> One caveat: for habitual adders-to-index, "git reset --merge" is
> no better than "git reset --hard" (though still no worse).
> 
>   vi foo.c
>   git add -u
>   git diff --cached --check; # fails because conflict markers are present
>   git reset --merge; # equivalent to git reset --hard
> 

Would it also be a good idea to fill in the hint in git status for the
in_merge case with similar information?
