From: Dario Rodriguez <soft.d4rio@gmail.com>
Subject: Re: Checkout first version of each file?
Date: Tue, 8 Nov 2011 15:49:15 -0300
Message-ID: <CABLeVKG+2O4dQSOZ9NEiiLSse75skt0qH9zLXU3wkGzjSBz8YQ@mail.gmail.com>
References: <CABLeVKF5P_sWwNX+OR_FX4+SPCN+SovZ2QuMmGGvJ-EskK7=YQ@mail.gmail.com>
 <20111108140243.GA4866@kolya> <CABLeVKFkSP=2-kwsN4N+oLrPnijkpvV8Ki=Si4dpYXdzc+8ibQ@mail.gmail.com>
 <20111108150007.GA5261@kolya> <m239dypjkd.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Nov 08 19:49:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNqjw-0001h5-AF
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 19:49:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754270Ab1KHSti convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Nov 2011 13:49:38 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:52410 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644Ab1KHSth convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Nov 2011 13:49:37 -0500
Received: by qao25 with SMTP id 25so788177qao.19
        for <git@vger.kernel.org>; Tue, 08 Nov 2011 10:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=KYsXBxs0VP8tNperHcOlT80Lo7n3XUVT9owQD6O2VZQ=;
        b=BeXdFAZpB+8z/JVA4qG/UkFxRS73+euACVdoXGyqcjHtuL+WOa1jgI4bRXu1vTAxr4
         t66X0Jg1NBfm4LuzMPdNp8PUXfpER9g5N9g1RdmwR3LoQK2JIcQ8bl7wOAOQosdHxuOe
         ICgd08vER/Uk4k7lTH3WgfwBNph86xtbcfOgM=
Received: by 10.68.9.2 with SMTP id v2mr2712737pba.101.1320778176115; Tue, 08
 Nov 2011 10:49:36 -0800 (PST)
Received: by 10.142.253.7 with HTTP; Tue, 8 Nov 2011 10:49:15 -0800 (PST)
In-Reply-To: <m239dypjkd.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185105>

On Tue, Nov 8, 2011 at 3:15 PM, Andreas Schwab <schwab@linux-m68k.org> =
wrote:
> Fredrik Gustafsson <iveqy@iveqy.com> writes:
>
>> #!/bin/sh
>> git reset --hard HEAD
>> for f in `find`
> =A0 =A0 =A0 =A0 =A0 =A0git ls-files
>> do
>> =A0 =A0 =A0 commit=3D`git log $f | grep commit | tail -1`
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0git rev-list HEAD -- $f | tail -1
>> =A0 =A0 =A0 git checkout $commit $f
>> done
>
> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756 =A001D3 44D5 214B 82=
76 4ED5
> "And now for something completely different."
>

Thank you again guys,

Junio, as part of the options applicable to diff-* commands, git-log
can take '--name-only' as argument. As the functionality of git log is
to show commit logs (the user way) I wonder if we have some similar,
parallel way to show a list of blobs. I mean, maybe the user (as in my
case) doesn't want the list of files, but the list of blobs, and the
raw format is not a clean, friendly output.
I can just: 'git log --oneline --name-only --diff-filter=3DA', but i
cannot list blobs for each commit the same simple way.

Just a suggestion, I think a little script fits better for me now.

Thank you,
Dario
