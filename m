From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] usage.c: remove unused functions
Date: Mon, 29 Sep 2008 08:35:44 +0200
Message-ID: <8c5c35580809282335q7eb828eei1fd545d308d9e5ca@mail.gmail.com>
References: <20080925184104.6117@nanako3.lavabit.com>
	 <200809251348.42789.trast@student.ethz.ch>
	 <20080925124836.GI10360@machine.or.cz>
	 <20080925145134.GL3669@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>, "Jonas Fonseca" <fonseca@diku.dk>,
	"Thomas Rast" <trast@student.ethz.ch>,
	"Nanako Shiraishi" <nanako3@lavabit.com>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Sep 29 08:36:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkCNM-0007ds-17
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 08:36:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbYI2Gfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 02:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbYI2Gfq
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 02:35:46 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:28699 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbYI2Gfp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 02:35:45 -0400
Received: by wa-out-1112.google.com with SMTP id v27so916588wah.21
        for <git@vger.kernel.org>; Sun, 28 Sep 2008 23:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=e89cDmFNoX9AZfNfidQhI2Z8BHpL+e0u8thurxeh1NI=;
        b=G/y73b3LiVKfGkzpxl5uKn3hs7nexMakFzgzhi3f7bZhiWB7X03h3jzi4fRQMxv1tx
         UUrUiiC4QD2PaZytzUd0dfPHobJpXAi3BILuvKv81l3cH2G+q2T68MQp96SEUAX7GTa5
         15Murvvc851U2tv2Y6qJuRgj+ZIKauqAHl0/4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=N2A96Tenb1QCpLVHEbNIaMiO2BnwbLLqpZo4fwJWnh4Q4uWiHqaWorR+hjCzDrE4X1
         B4H2TToewcWWCpkz3ASaaj2yeauRAdH+cTEIYkWALXGW+sGNRHlB3b/XfysGtIx3vHu5
         lYqDk07nt4zLuytPslXtChZH36NuwBh6Ntyv0=
Received: by 10.115.76.5 with SMTP id d5mr5157693wal.224.1222670144344;
        Sun, 28 Sep 2008 23:35:44 -0700 (PDT)
Received: by 10.114.166.20 with HTTP; Sun, 28 Sep 2008 23:35:44 -0700 (PDT)
In-Reply-To: <20080925145134.GL3669@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96998>

On Thu, Sep 25, 2008 at 4:51 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Petr Baudis <pasky@suse.cz> wrote:
>> On Thu, Sep 25, 2008 at 01:48:37PM +0200, Thomas Rast wrote:
>> > Nanako Shiraishi wrote:
>> > > This removes three functions that are not used anywhere.
>> > [...]
>> > > -void set_usage_routine(void (*routine)(const char *err) NORETURN)
>> > > -void set_error_routine(void (*routine)(const char *err, va_list params))
>> > > -void set_warn_routine(void (*routine)(const char *warn, va_list params))
>> >
>> > These blame to the following commit:
>> >
>> >   commit 39a3f5ea7c0352a530338d30d4e618f6b4db84e4
>> >   Author: Petr Baudis <pasky@suse.cz>
>> >
>> >       Customizable error handlers
> ...
>> > So apparently the intent was that they would only be used from outside
>> > Git.  I don't know whether anyone still plans to do that, but they're
>> > certainly not "just" unused.
>>
>> I don't think it will be a big deal to remove these functions, though it
>> does feel like a little bit of a step backwards in the libgit efforts.
>> There are some programs that already link to Git, like CGit - I wonder
>> if some of them don't use them (CGit itself doesn't).
>
> IMHO these are useless for a "libgit".  However both tig and
> cgit link to the non-existant libgit.a, so they may be using
> these routines.  I've CC'd their authors and am not applying this
> particular change without an ACK from them.

Sorry for the late reply. And no, cgit doesn't use these functions and
I don't think that's going to change, so

Acked-by: Lars Hjemli <hjemli@gmail.com>

--
larsh
