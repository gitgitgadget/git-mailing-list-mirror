From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Git ~unusable on slow lines :,'C
Date: Tue, 9 Oct 2012 08:58:03 -0700
Message-ID: <CAJo=hJv+CtEcGFPhe2xPsfrPmdfOuakMovbk8-cJmFjOnwKWnQ@mail.gmail.com>
References: <50731B2A.6040104@gmx.net> <87lifgct3j.fsf@centaur.cmartin.tk> <50742F53.3050205@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	git@vger.kernel.org
To: Marcel Partap <mpartap@gmx.net>
X-From: git-owner@vger.kernel.org Tue Oct 09 17:58:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLcCb-0007Tx-Dg
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 17:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756294Ab2JIP60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 11:58:26 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:42959 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756235Ab2JIP6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 11:58:25 -0400
Received: by mail-qa0-f53.google.com with SMTP id s11so3093200qaa.19
        for <git@vger.kernel.org>; Tue, 09 Oct 2012 08:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=KaLfrFvHAikUNaSLzNREdLwFvX1CpZ8/xV/VJovbgrs=;
        b=bzsucYEHogYF7/6He+YX2Q6cbE+96L+sxLNidOlTjVQE0Q2zfDVPPFhJ5gRi1uMjWO
         NhlzNrq4HSFflPV8xENM90p8oI0Hg8v4zyaENMO4QUqWTR63D2sLCu3jWljYFUtGJCCN
         QdXpLhaI68L1S4wZw9yPJVRuabrvI9mSUGu0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=KaLfrFvHAikUNaSLzNREdLwFvX1CpZ8/xV/VJovbgrs=;
        b=bUBO4FVwEEa31qfCln0kK/PS4u5ADs4SeLBbEa8M2xgzVGx6u1i3du2ceNOBiOyCpX
         PlUDVaTH/dIShM7bha+r3qj+SSfzv1tWdxgw/ArzAfN/tvDeFCVy2Sy4K+a2LRHQyC5U
         DjHQdBDUH9LwjZqYpHHKs6EVYqir4bZcykh+MS56Bf3F5TZaUmOCz+iUZeDdQW+WiTrP
         uWM7nxLWtARrn0Q8hIUxhz3+n1d9jgp80FTd6roc5eEbvsGEKTJfMcBh572lk5QdGdYA
         eyW8NbcOSWDutmhS61RPvYCF/KT1autTcjziFCSJIjPoUv22HMNe0uJhkShXaMKVBqhY
         mlhw==
Received: by 10.224.175.204 with SMTP id bb12mr35599097qab.14.1349798304183;
 Tue, 09 Oct 2012 08:58:24 -0700 (PDT)
Received: by 10.49.35.75 with HTTP; Tue, 9 Oct 2012 08:58:03 -0700 (PDT)
In-Reply-To: <50742F53.3050205@gmx.net>
X-Gm-Message-State: ALoCoQnJXXAilL7xhcWSjrsxTHO5p5ZurJkOfVM4UoOK+HAFGWW4tQT7Kpbsz0Ow2Eo0UO3yTGZv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207323>

On Tue, Oct 9, 2012 at 7:06 AM, Marcel Partap <mpartap@gmx.net> wrote:
>>> Bam, the server kicked me off after taking to long to sync my copy.
>> This is unrelated to git. The HTTP server's configuration is too
>> impatient.
> Yes. How does that mean it is unrelated to git?

It means its out of our control, we cannot modify the HTTP server's
configuration to have a longer timeout. We can recommend that the
timeout be increased, but as you point out the admins may not do that.

>>> - git fetch should show the total amount of data it is about to
>>> transfer!
>> It can't, because it doesn't know.
> The server side doesn't know at how much the objects *it just repacked
> for transfer* weigh in?

Actually it does. Its just not used here. What value is that to you?
You asked for the repository. If you know its size is going to be ~105
MiB you have two choices... continue to get the repository you asked
for, or disconnect and give up. Either way the size doesn't help you.
It would require a protocol modification to send a size estimate down
to the client before the data in order to give the client a better
progress meter than the object count (allowing it instead to track by
bytes received). But this has been seen as not very useful or
worthwhile since it doesn't really help anyone do anything better. So
why change the protocol?

>> You asked for the current state of the repository, and that's what its
>> giving you.
> And instead, I would rather like to ask for the next 500 commits. No way
> to do it.

No, there isn't. Git assumes that once it has commit X, all versions
that predate X are already on the local workstation. This is a
fundamental assumption that the entire protocol relies on. It is not
trivial to change. We have been through this many times on the mailing
list, please search the archives for "resumable clone".

>> The timeout has nothing to do with git, if you can't
>> convince the admins to increase it, you can try using another transport
>> which doesn't suffer from HTTP, as it's most likely an anti-DoS measure.
> See, I probably can't convince the admins to drop their anti-dos measures.
> And they (drupal.org admins) probably will not change their allowed
> protocol policies.

Then if they are hosting really big repositories that are hard for
their contributors to obtain, they should take the time to write a
script that periodically creates a bundle file for each repository
using `git bundle create repo.bundle --all`. They can host these
bundle files in any file transport service like HTTP or BitTorrent,
and users can download and resume these using normal HTTP download
tools. Once you have a bundle file locally, you can clone from it with
modern Git with `git clone $(pwd)/repo.bundle` to initialize the
repository.

This is currently the best way to support resumable clone. The repo
will be stale by whatever time has elapsed since the bundle file was
created. But then Git can do an incremental fetch to catch up, and
this transfer size should be limited to the progress made since the
bundle was made. If bundles are made once per month or after each
major release its usually a manageable delta.

> It is not only a configuration issue for one particular server. Git in
> general is hardly usable on slow lines because
> - it doesn't show the volume of data that is to be downloaded!

If it did show you, what would you do? Declare defeat before it even
starts to download and give up and start a thread about how Git
requires too much bandwidth?

Have you tried to shallow clone the repository in question?

> - it doesn't allow the user to sync up in steps the circumstances will
> allow to succeed.

Sadly, this is quite true. :-(
