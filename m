From: "Pavel Raiskup" <xraisk00@gmail.com>
Subject: Re: Histogram diff, libgit2 enhancement, libgit2 => git merge (GSOC)
Date: Tue, 22 Mar 2011 18:32:54 +0100
Message-ID: <op.vsq9o4mz2m56ex@localhost.localdomain>
References: <op.vsm1yszq2m56ex@localhost.localdomain>
 <AANLkTi=Fu5v-5E2dSAA74f0juUQNjNjus5XFWqMb9v9k@mail.gmail.com>
 <20110320234420.GA1919@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Vicent Marti" <vicent@github.com>, "Jeff King" <peff@github.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 18:33:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q25SV-0006v3-6b
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 18:33:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755205Ab1CVRd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 13:33:27 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48909 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615Ab1CVRdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 13:33:25 -0400
Received: by bwz15 with SMTP id 15so6033948bwz.19
        for <git@vger.kernel.org>; Tue, 22 Mar 2011 10:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:content-type:to:cc:subject:references:date
         :mime-version:content-transfer-encoding:from:message-id:in-reply-to
         :user-agent;
        bh=Ls7D/hnOo4QRTLdVrtptOj0snviuME8r6qGqtnbNZso=;
        b=B4vmhSKuM8+XPeYXZYbHN295NH3aodGsdRVYy37s7XpNKIUYCFUaZTa2MDQ3HUm0BP
         dgs0AjhDgz0TF2Soop4bX15uJt1IzGakxPxbgCaQU2IGNiMr+hkhF5V8hhWJ9l4Zc8n/
         rDstn/wt44XjQwCskUyKRB/FUU/umvr2JHQpo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=content-type:to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        b=CXLAL4K1is36nTE4d2GD3x2cO0Z0U1A9Tang+znHzst9kYJfkxgMendV50BG85XJOr
         Ppu1qCZRsf4rb7UiiMk0GtuJxSUEIHYUNKHVpv4SbPSIOtGwiwHDOSz3JKlwTdsKBNU+
         K34NZ1b9ZRWXoJ4PZ2u7K116DOnKNej9dIHwc=
Received: by 10.204.148.69 with SMTP id o5mr23766bkv.193.1300815204375;
        Tue, 22 Mar 2011 10:33:24 -0700 (PDT)
Received: from localhost.localdomain (ip-89-103-132-159.net.upcbroadband.cz [89.103.132.159])
        by mx.google.com with ESMTPS id b6sm5299114bkb.10.2011.03.22.10.33.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 Mar 2011 10:33:21 -0700 (PDT)
In-Reply-To: <20110320234420.GA1919@sigill.intra.peff.net>
User-Agent: Opera Mail/11.01 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169751>

Hi again!

This sounds probably like the most exciting task for me:

>> b) Write a minimal Git client using libgit2. Peff keeps bringing this
>> up and I think it's a bangin' good idea. Write something small and
>> 100% self contained in a C executable that runs everywhere with 0
>> dependencies -- don't aim for full feature completion, just the basic
>> stuff to interoperate with a Git repository. Clone, checkout, branch,
>> commit, push, pull, log. I would totally use that shit on my Windows
>> boxes. And since it'll be externally compatible with the original Git
>> client, we can reuse the Git unit tests to test libgit2. HA. Awesome!
>
> Yeah, I would be happy to mentor or co-mentor with Vicent on a project
> like that. Not only might it be useful to actually _use_, but my secret
> motive is that I'd like to start testing libgit2 using some of the
> regular git tests, both for interoperability and for performance.

Do you mean git tests in directory "/t"?

Could you give me a list of possible reusable unit tests? After a quick
overview of test suite in git it looks quite complex to reuse. I haven't
spent a lot of time studying test-suite, but calling:

test_expect_success 'plain' 'command && command && ..'

reinterprets chain of commands given in (2nd) string and in this
commands is often called git as utility with arguments. Even in this
very easy test feature is expected some command-line-interface behavior
 from tested utility.. Is this the way how do you want to test this new
libgit2-like tool? So this standalone utility is going to have the
same interface as git has -- kind of substitution of git with "git2"
inside test suite?

This probably will lead to some test suite changes, is it truth?
