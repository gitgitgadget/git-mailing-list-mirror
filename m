From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Why does "git config" output nothing instead of the default value
 for unset variables?
Date: Sun, 14 Apr 2013 21:05:21 +0200
Message-ID: <CAHGBnuOJFVahoUwcF6dZZUEmDtKU_zvWsKtTwufN7RqeNxkZ=w@mail.gmail.com>
References: <kke7o1$oo$1@ger.gmane.org>
	<CAH5451nL0cmTy+vwEsJnvX7OP1iSSgY9UMhvrrimk0zWM71YDw@mail.gmail.com>
	<20130414185619.GB1621@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 14 21:05:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URSEy-0003t0-5u
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 21:05:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299Ab3DNTFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 15:05:24 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:63969 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106Ab3DNTFX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 15:05:23 -0400
Received: by mail-la0-f48.google.com with SMTP id fq12so3756962lab.21
        for <git@vger.kernel.org>; Sun, 14 Apr 2013 12:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=NDw0af8VnWoK992Xu7sWAcNxCqnztaJjazN58aRhftc=;
        b=GvwG6ARb0gh6J4IbK+e6NkLk/ZYxv+pvuKqpszz9cubn8Tck1l6CX6wnToMgqt4jf5
         5JGmPMQ7f+8XtzFW15RNAGVHlejqXO+H7Mz+fBb//VbwyE0tQqPgfq30XXNQ07Su7dHR
         QoYIWTlh/yTKhFlDK45mmwDR9x2AeKfG3WJJvE1iYas/sKHeC5TclHqNgNeH4ri73WC9
         TEBCqIn59MQaoq0FBsgaJPwBYWv3ixdCJl0zvXpshEpab/RVgRg1m5UmWCpmLJcBxgkL
         8awqdtzqxh8B3VOcOqZJRX5xYHxPpG2S3nnqBGdTywv9sBIZXLoaFsTarXlg51A5jcHA
         m2Ug==
X-Received: by 10.112.151.34 with SMTP id un2mr8696502lbb.14.1365966321746;
 Sun, 14 Apr 2013 12:05:21 -0700 (PDT)
Received: by 10.114.84.33 with HTTP; Sun, 14 Apr 2013 12:05:21 -0700 (PDT)
In-Reply-To: <20130414185619.GB1621@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221153>

On Sun, Apr 14, 2013 at 8:56 PM, Jeff King <peff@peff.net> wrote:

>> More to the point, I can easily imagine many scripts relying on git
>> config returning a value to indicate that a config item has been set.
>> Your proposed change would break all those. For that reason, it might
>> be nicer to introduce a flag that returns the config if it is set or
>> the default otherwise. Something like git config --value perhaps.
>
> The expected output is certainly a problem, but the issue is more
> fundamental than that: git-config does not even _know_ what the default
> is for any given option.

Thanks for the explanation, I feared something like that. I.e. that
git config does not even know any of the options or values it manages,
but just is a "dumb" front-end to writing / reading whatever you pass
it to / from a file.

-- 
Sebastian Schuberth
