From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git-daemon --inetd
Date: Fri, 16 Sep 2005 09:44:13 +1200
Message-ID: <46a038f905091514447e13404d@mail.gmail.com>
References: <43290EFF.3070604@zytor.com>
	 <Pine.LNX.4.58.0509150829090.26803@g5.osdl.org>
	 <4329BDD9.4010507@zytor.com>
	 <Pine.LNX.4.58.0509151142570.26803@g5.osdl.org>
	 <4329C93D.2020701@zytor.com>
	 <Pine.LNX.4.58.0509151225410.26803@g5.osdl.org>
Reply-To: martin.langhoff@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>,
	Martin Langhoff <martin@catalyst.net.nz>,
	Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 23:44:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EG1Wl-0007pF-8P
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 23:44:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030507AbVIOVoR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 17:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030561AbVIOVoQ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 17:44:16 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:40829 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030507AbVIOVoQ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2005 17:44:16 -0400
Received: by rproxy.gmail.com with SMTP id i8so81410rne
        for <git@vger.kernel.org>; Thu, 15 Sep 2005 14:44:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SKY3nURpi8tDxLn/LYAaNKIdu6IVcKbYFJrlMYfpShtKSTsCUG9ZNUY42SHmNfBiVQT/YsH0Zl2iolQUv4jtG3GMzO3AJRpaPsOdrtL9MgnDsrICfY0ApaqAnc+BxGyIv0Arh/4Dvh0xtLCOrH3fCcn6eaYeEhZC+2FtBUsTyUQ=
Received: by 10.38.97.3 with SMTP id u3mr325187rnb;
        Thu, 15 Sep 2005 14:44:13 -0700 (PDT)
Received: by 10.38.101.53 with HTTP; Thu, 15 Sep 2005 14:44:13 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509151225410.26803@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8641>

On 9/16/05, Linus Torvalds <torvalds@osdl.org> wrote:
> Btw, I think --merge-order was cool, but its weaker cousin --topo-order is
> what is actually _used_. Maybe we should deprecate --merge-order? Right
> now the only real user is git-archimport, and I think that one too really
> only wants topo-order too. For example, right now I think git-archimport
> won't actually work if you build without openssl.
> 
> Jon? Martin?

I've used merge-order because it made sense... in that it gave me the
same history and order that walking the arch history would. Most of
the time, anyway, and decided that I'd rather trust GIT over Arch on
merging strategies...

If topo-order is sane, then I'll just change that. Let me run a couple
of tests with it first ;)

WRT SSL... archimport doesn't care a bit about SSL, and if it does,
it's a bug. It calls tla to perform all the "fetch stuff from the Arch
repo operations", because I was too lazy to implement native support
for reading the (trivial) repo format over all the transports. And
with Arch, access to the remote repos is _fast_ (unlike cvs).

cheers,



martin
