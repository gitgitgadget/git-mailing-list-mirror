From: Gavin Guo <tuffkidtt@gmail.com>
Subject: Re: git stash and manually edited chunks
Date: Wed, 3 Nov 2010 11:06:30 +0800
Message-ID: <AANLkTi=O8oPjcPN1j8513Kp+OtY7Cs5WgdiVhHnyzX=C@mail.gmail.com>
References: <AANLkTik6esqP2EkA6SFmfS0zdokG1iTKXqivA2wnpq=9@mail.gmail.com>
	<vpqfwvlkmkv.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Olivier Verdier <zelbier@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Nov 03 04:06:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDTgL-0005Lx-FZ
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 04:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752993Ab0KCDGd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Nov 2010 23:06:33 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39245 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851Ab0KCDGc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Nov 2010 23:06:32 -0400
Received: by bwz11 with SMTP id 11so180609bwz.19
        for <git@vger.kernel.org>; Tue, 02 Nov 2010 20:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=T+NvAqlhri+u+/Z0Hg7t3CiiEWCvRRZehpF75GllJzQ=;
        b=NyF+bEq09ZBEsTTQ92RwgBD26HZRaouFCNPlFJ0gGaLyG/v/od7CRviKYHHtLzA7K4
         vWmh1e16p1KtiIoWnYUZA4iqZc1DierR7xDyjHPx8mugMHSIr7xqwcbmztA8wLDby7Ax
         oJEzAdlu0KEjCCsd8TS0SJZYfB89sAYjoVH8k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XoeBUY+v1HLcPdM2AgG5tTqkQkDpSoGmv8uO1vW4w0fwLgYbDj4eqVxeUax0OKWA2S
         AkGZo5zaeJET8JpxbpIrsCBc+x7mt8ZnriE0iKV/yb4S85b5Yxsl5A+PmWwV4UdEGFUm
         WhoSQ1lIaQL02PJQUSsx+wwmIyy2qL/beMM64=
Received: by 10.204.113.148 with SMTP id a20mr5408642bkq.103.1288753590656;
 Tue, 02 Nov 2010 20:06:30 -0700 (PDT)
Received: by 10.204.65.200 with HTTP; Tue, 2 Nov 2010 20:06:30 -0700 (PDT)
In-Reply-To: <vpqfwvlkmkv.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160570>

> Let's say the state of your working tree here is A (and last commit i=
s
> HEAD).
>
>> * git add -p my_file
>> * I=A0edit a chunk *manually*=A0(using=A0e)
>
> Here, the index contains a state which is neither in the working tree
> nor in the last commit. Let's call this state B.
>
>> * git stash --keep-index
>
> Here, the working tree takes state B.
>
>> * git stash pop
>
> Here, you're trying to apply the stash, which is somehow a diff
> between HEAD and A, on your tree which is in state B. Hence the
> conflicts.

I am confusing about the description here. Git stash --keep-index
exist after editing the hunk, so why stash will save the difference
between HEAD and A, I think it should be the state which is modified
by git add -p(using e), and as a result of no conflict.

Gavin Guo
