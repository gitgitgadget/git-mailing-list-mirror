From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Show containing branches in log?
Date: Wed, 2 Jul 2014 11:59:33 -0500
Message-ID: <CAHd499BpaT0UWWSQm-P09iPm_QKGwOpOZyeZtQCs-OtxVRmM8w@mail.gmail.com>
References: <CAHd499A78BRVawWSHNnzJcD1Ca7RfFeEnJf0SB7py1MD5qwL0g@mail.gmail.com>
	<20140702163451.GB14404@sigill.intra.peff.net>
	<6C120F968C534117BC278DD93D1F84A5@black>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Jason Pyeron <jpyeron@pdinc.us>
X-From: git-owner@vger.kernel.org Wed Jul 02 18:59:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2Nsm-0007We-Lt
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 18:59:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbaGBQ7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 12:59:35 -0400
Received: from mail-vc0-f173.google.com ([209.85.220.173]:36169 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964915AbaGBQ7e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 12:59:34 -0400
Received: by mail-vc0-f173.google.com with SMTP id lf12so10715726vcb.32
        for <git@vger.kernel.org>; Wed, 02 Jul 2014 09:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=bBtL0pBexHeOcrynyQroPA1ohsmZRic54S1vwwX8IfM=;
        b=eo0yNcvHt1ZeJ7hhLaFjWKDjKPpmgJmLprIbA1RUO7ADoVYUwtbiHXjWal2pUP0+DK
         6UOPMbuw+xTU4cDyBgVaewMZC08Gsm7wtv6nKEjck74cjZYGYM6m0CDZINYJMi/Rq9II
         g87FogE3HXcnkWr/RQtZ58GPUze8qgsBFo6JZfxC2b0yWT8CNeJZe/7enLn/erDVUpL/
         Ffz1RzHJI2BB6PN5kNSmJCBKtzPPK0LLz/AzgM4tnzE/OpBMUGAck9y+YZEs9Tv07SEj
         1j0oW8+aiVTUC1Xv8pdSyhise9DesiQRBtS2xU+lGGyrDz+0TR2BiG/LOesQUspr7p8T
         lToQ==
X-Received: by 10.220.167.2 with SMTP id o2mr50498346vcy.8.1404320373457; Wed,
 02 Jul 2014 09:59:33 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.220.102.204 with HTTP; Wed, 2 Jul 2014 09:59:33 -0700 (PDT)
In-Reply-To: <6C120F968C534117BC278DD93D1F84A5@black>
X-Google-Sender-Auth: zi3TAIOwMRnmtFSHCcjIvVsulZg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252797>

On Wed, Jul 2, 2014 at 11:52 AM, Jason Pyeron <jpyeron@pdinc.us> wrote:
>> -----Original Message-----
>> From: Jeff King
>> Sent: Wednesday, July 02, 2014 12:35
>>
>> On Wed, Jul 02, 2014 at 09:50:57AM -0500, Robert Dailey wrote:
>>
>> > I know that with the `git branch` command I can determine which
>> > branches contain a commit. Is there a way to represent this
>> > graphically with `git log`? Sometimes I just have a commit,
>> and I need
>> > to find out what branch contains that commit. The reason why `git
>> > branch --contains` doesn't solve this problem for me is
>> that it names
>> > almost all branches because of merge commits. Too much ancestry has
>> > been built since this commit, so there is no way to find
>> the "closest"
>> > branch that contains that commit.
>> >
>> > Is there a way to graphically see what is the "nearest" named ref to
>> > the specified commit in the logs?
>>
>> Have you tried "git describe --contains --all <commit>"?
>>
>> To some degree, I fear your question isn't something git can
>> answer. If
>> the branch containing the commit has been merged into other branches,
>> then they all "contain" the commit. There is not really any reason to
>> prefer one over the other ("describe --contains" will try to find the
>> "closest" branch, but that is based on heuristics and is not
>> necessarily
>> well-defined).
>
> Another way I answer this question is git log --oneline --graph --all and then
> search for the commit and follow the lines.

If that were a practical solution I wouldn't be here asking this
question. Unfortunately, in a repository with multiple parallel
release branches, it is impossible to just "eye-ball" the graph and
find what you're looking for. Especially when the last 4 weeks worth
of commits consumes over 10 pages of log graph.
