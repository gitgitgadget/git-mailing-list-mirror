From: "Denis Bueno" <dbueno@gmail.com>
Subject: Re: Recovering from repository corruption
Date: Tue, 10 Jun 2008 18:09:20 -0400
Message-ID: <6dbd4d000806101509l516cf467me06fadee6ead0964@mail.gmail.com>
References: <6dbd4d000806101026m458513ecqa8141f509bad7602@mail.gmail.com>
	 <m3abhtp42o.fsf@localhost.localdomain>
	 <6dbd4d000806101238v2bb975abqd39916e45d4bf866@mail.gmail.com>
	 <200806102159.02875.jnareb@gmail.com>
	 <6dbd4d000806101303j4b2032ajc6e004e0a82e4db5@mail.gmail.com>
	 <alpine.LFD.1.10.0806101317100.3101@woody.linux-foundation.org>
	 <6dbd4d000806101328k1fc913f2ia55c3e44273ec5ad@mail.gmail.com>
	 <alpine.LFD.1.10.0806101403080.3101@woody.linux-foundation.org>
	 <6dbd4d000806101422j39709906x1b4b03b82b504e62@mail.gmail.com>
	 <alpine.LFD.1.10.0806101431410.3101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 11 00:11:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6C3m-00036y-NN
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 00:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759952AbYFJWJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 18:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759481AbYFJWJY
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 18:09:24 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:56963 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759551AbYFJWJW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 18:09:22 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1930377fgg.17
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 15:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=89IaYpE6830CawsJCCCFyW21eSbrMV5x8uk3dLMmkwY=;
        b=nm3iSfpZYD04Ldb0Zm3SyM1ihFYXBsovPquQw5gof2REvcmO9GlRvAMgTwjhd5FYPe
         AkKqj5LvrJ5Pjwj6Mhk6I7xI8pCw8Ky9zKMfRdhxGRMd8aQnZwN5d8TtdIDRPmnpThcq
         M6dcUTM+xJ8HTGm8iZ+MYi8TfSzypcfdO1SXI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ZnIZLwYV4P9COvCoAhkVm2tJcvuBODKjVK92vFEslWx5K2ZMpjb9QPTCcgGkbiic9X
         /HZ6xVisq9utSmObwvlQODhrlb+DI46zoF/KIeB+RQTIGMDG701RaGwZ3EiF2Cq1hiF/
         qy34FZYiyFqawjcoYIZ/UV3gJfd7Jt56cES1U=
Received: by 10.86.72.3 with SMTP id u3mr1260064fga.35.1213135760923;
        Tue, 10 Jun 2008 15:09:20 -0700 (PDT)
Received: by 10.86.59.7 with HTTP; Tue, 10 Jun 2008 15:09:20 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0806101431410.3101@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84552>

On Tue, Jun 10, 2008 at 17:48, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> On Tue, 10 Jun 2008, Denis Bueno wrote:
>> >
>> > then *if* you have the files
>> >
>> >        .git/objects/32/0bd6e82267b71dd2ca7043ea3f61dbbca16109
>> >        .git/objects/4d/0be2816d5eea5ae2b40990235e2225c1715927
>> >
>> > then those two files are interesting in themselves (most likely they are
>> > not there at all, or are zero-sized, but if you have them, please post
>> > them).
>>
>> They are attached, and they are not zero-sized.
>
> Very interesting.
>
> Both of them look fairly sane as objects (ie random - it's supposed to eb
> zlib-compressed), but both of them have the first 512 bytes *identically*
> corrupted:
>
>        0000000 6564 626e 6575 406e 6f64 6f72 6874 2e79
>                  d   e   n   b   u   e   n   @   d   o   r   o   t   h   y   .
>        0000020 6f6c 6163 2e6c 3634 0033 0000 0000 0000
>                  l   o   c   a   l   .   4   6   3  \0  \0  \0  \0  \0  \0  \0
>        0000040 0000 0000 0000 0000 0000 0000 0000 0000
>                 \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
>        *
>
> ie it's an all-zero block, except for that email-looking thing at the
> head.

Right --- that's my username and computer's hostname... for some
reason.  [You are not expected to understand this.  My computer's name
mysteriously changed.  It should not be "dorothy.local" but it is.  I
will have to find out why....]

> One thign that strikes me is that you seem to be really prone to this
> problem, since it happened to you a year ago too. I cannot swear to this,
> but I literally suspect your last case (July-2007) was the previous time
> we had a corruption issue. Why does it seem to happen to you, but not
> others?

It is the same computer on which the problem occurred last time.  It's
an OS X 10.4 macbook pro.  I haven't noticed corruption in other
places, but it's fair to assume it's occurring.  I'll have to boot off
my install disk and fsck the drive....

> Do you have some odd filesystem in play? Was the current corruption in a
> similar environment as the old one? IOW, I'm trying to find a pattern
> here, to see if there might be something we can do about it..

I can't remember if the old one happened after a panic or not, but I'd
bet it did.  The filesystem is HFS+, as indeed most OS X 10.4
installations are.  Maybe the HD has been going south?  However, that
doesn't seem likely, since when I got the computer it was new, and
that was around Jun 2007.

> But it *sounds* like the objects you lost were literally old ones, no? Ie
> the lost stuff wasn't something you had committed in the last five minutes
> or so? If so, then you really do seem to have a filesystem that corrupts
> *old* files when it crashes. That's fairly scary. What FS is it?

No, in fact I had just committed those changes not 10 minutes before
the panic.  Last time they were also fresh changes, although perhaps
older than 10 minutes.  I can't remember.


-- 
 Denis
