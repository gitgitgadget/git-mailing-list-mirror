From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: How to manage multiple repos using submodules?
Date: Sat, 16 Apr 2011 13:20:54 -0500
Message-ID: <20110416182053.GA11017@elie>
References: <4DA9C7A7.4010503@sohovfx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Andrew Wong <andrew.w@sohovfx.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 20:21:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBA7J-0006Eq-Ip
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 20:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474Ab1DPSVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2011 14:21:04 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59101 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002Ab1DPSVC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 14:21:02 -0400
Received: by iwn34 with SMTP id 34so2889660iwn.19
        for <git@vger.kernel.org>; Sat, 16 Apr 2011 11:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=D5NepZSVoaZE6zRLNI4rzIzcRQhg6Tdm5n/rm/oADsU=;
        b=hBAtDBAyOOb0KBpWs6VNlskZRv6am5zN0adPs8ntHOtyIza5nw9xdzq5XT9SM0+0AK
         aMEuQHcpYJn81l+lZFVCtChmNFtywo5NtnL+jLPjnsqTxxJGpmuv24Tl1u+kCeBX3LAK
         87Njc6qhuZcgYKxBfdpez5doDFNjukLd5m11c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Ah2cpAfLZA9VYp1ExRPCILCSdpnRuPlmFM1zdDLRNv8KrdV6OZUqyn2AL5Kgqb7wSy
         xHviaJ5qUhNWRPeOCGAkJfOjoeDOhqZeku4mV3kisOODW27Y7yNjFvB2HoP+ApimiEmM
         eWX4uYDm84w1JXg/aB5+Q4nZDqPOGyapihD7U=
Received: by 10.42.28.137 with SMTP id n9mr2542087icc.287.1302978061747;
        Sat, 16 Apr 2011 11:21:01 -0700 (PDT)
Received: from elie (adsl-69-209-51-5.dsl.chcgil.ameritech.net [69.209.51.5])
        by mx.google.com with ESMTPS id d9sm2131546ibb.2.2011.04.16.11.20.59
        (version=SSLv3 cipher=OTHER);
        Sat, 16 Apr 2011 11:21:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4DA9C7A7.4010503@sohovfx.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171689>

Hi Andrew,

Andrew Wong wrote:

> It seems like submodule isn't meant for this, but many people seems
> to use submodule to link many smaller repos together. With this
> setup, I imagine whenever someone pushed a small repo, they're
> /supposed/ to push the big repo as well. This way, if I simply
> update the big repo and do a "git status", git will tell me that
> which of the smaller repos are out of date.

Yep, if you want to keep track of the state of a bunch of repos over
time, submodules are not so bad[*].  In practice, often one instead
wants to keep a bunch of repos up-to-date, and all this meta-history
tracking is overkill.

I'd suggest using the mr tool.  Some projects (e.g., the
debian-installer project) are using it to help people keep all their
repos up to date.

http://kitenet.net/~joey/code/mr/

Hope that helps,
Jonathan
