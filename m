From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Thu, 18 Apr 2013 13:20:31 +0530
Message-ID: <CALkWK0nb0Z2Uf7XJHgEiQ5rM7EVVA7-ZMhMOjMewmKKGYziw2w@mail.gmail.com>
References: <CALkWK0kSF_q0o1V6BhO6X2jKAJQxNQ0c6MCi5o=jZdMwrba48g@mail.gmail.com>
 <20130407170201.GH2222@serenity.lan> <CALkWK0nSxfEzP7KHZxGjmBYD7pX5aa3CbMt1qAGrz4tonrtHhA@mail.gmail.com>
 <20130407175210.GI2222@serenity.lan> <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
 <20130407182112.GJ2222@serenity.lan> <5161BC33.8060707@web.de>
 <CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com>
 <5161D3C5.9060804@web.de> <CALkWK0k_vmXZr-x8=ZctouWbuVgv-1sptC0WX2aJ+yYD-T8cxA@mail.gmail.com>
 <20130407212342.GA19857@elie.Belkin> <CACsJy8BoWfng7p=kHbiF9s6XYH1mPMtAGW6BRz54uYM5454O0w@mail.gmail.com>
 <CALkWK0mcnA8Qss3uxRXhfHst65RLkv43wje9xdFxmFKi7MtZvA@mail.gmail.com>
 <CACsJy8Bz+yNefiiwEivaaUgRymHTmUUKEFs8_uuonhmRfT3UGg@mail.gmail.com>
 <CALkWK0m9QmZaSDruY=+2F-Kkw+fd6E1TYCTBpVQHRJrzq2VjCQ@mail.gmail.com> <BCD944518C304D7D9809346DD899B68F@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Apr 18 09:51:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USjcj-0006oZ-8Z
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 09:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965631Ab3DRHvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 03:51:13 -0400
Received: from mail-ia0-f173.google.com ([209.85.210.173]:50827 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965398Ab3DRHvM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 03:51:12 -0400
Received: by mail-ia0-f173.google.com with SMTP id j5so2223503iaf.32
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 00:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=HUecKuTXR2qg1xEW9DMZ7Zk2v+6fMCpA3r6/j4Cf0gg=;
        b=QAIXX3BGNO3awgxw4agAqja1VmG/6DEbmvXo8Sr6L+ZkqvhpGR1ah2EIrHA1+gvvWg
         KhVADcAimzRvMDv4yEAbwgYCcV5lHq4IJKDnuNnTiPkqhD3Yz6MUm94637tiRGwNoE3a
         m1GFM9ErVEfJRPxG/R4A5GVT0/nsamC4iTHpYBvSlx7UysABe7N8/RqvORrN73bfN3ZM
         eSKsDR9aH6u7PzjA8AR15D70881o6NdLzCI2U5OFkXZ/zrcv9gJ7zO5rdK1Y+1bBUuTX
         MAah7B0Frdu5dXRU3G9mmMAe5w01FvbudZuENLF4DqBxy4TQ0qPITu0G31C8vrH+0cym
         nkcg==
X-Received: by 10.43.9.68 with SMTP id ov4mr5384244icb.22.1366271472052; Thu,
 18 Apr 2013 00:51:12 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Thu, 18 Apr 2013 00:50:31 -0700 (PDT)
In-Reply-To: <BCD944518C304D7D9809346DD899B68F@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221622>

Philip Oakley wrote:
> Would it be possible to summarise the key points and proposals of where the
> subject is now?

Sure.

If you want an update from the current approach, wait for a v2; I'm
cooking it for some time, and getting some resulting ideas merged into
upstream early (look for clone.submoduleGitDir on the list, for
instance).  When upstream is in better shape to ease in a better
fundamental design, I'll post my v2 to the list.  I'll refrain from
posting any updates now, because I don't think the resulting
discussion will generate any value.

If you want to know what this thread was about, I think [1] and [2]
summarize my arguments quite well.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/220047/focus=220436
[2]: http://thread.gmane.org/gmane.comp.version-control.git/220047/focus=220495
