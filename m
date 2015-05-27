From: Stefan Beller <sbeller@google.com>
Subject: Re: Bug: .gitconfig folder
Date: Wed, 27 May 2015 15:24:47 -0700
Message-ID: <CAGZ79kbGyZLx=UYCi5JeSLj7keMhcX_eH3qtWs3O+PidRjye4w@mail.gmail.com>
References: <5565C6A7.60007@gmx.es>
	<xmqq7frtlq56.fsf@gitster.dls.corp.google.com>
	<20150527221813.GF23259@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jorge <griffin@gmx.es>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 28 00:24:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yxjkr-0000Kg-O2
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 00:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbbE0WYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 18:24:49 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:36681 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbbE0WYs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 18:24:48 -0400
Received: by qgf2 with SMTP id 2so9461346qgf.3
        for <git@vger.kernel.org>; Wed, 27 May 2015 15:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IIYs/Kh8s+R5AOQh89x+NWRkRUBABScvffAXRwko3Zg=;
        b=XLlxsbKApeboebn/+K92ZV7wUxgT5sgdmHeVzn+gIoEsrEVpE5HDUZ1KfGotoi4uo8
         S4vxg5f/n3Vu4jRT0fThG+ytCbdVsiO+6FpqyeLR70qt572kPQPgP/ui8ATKtZqzARGq
         dUGvCmaPmHOpFCK5dzOZk+Wl3p/c1oWLIivUvD3o3fMc9Y4GhiVCbGFqHxaZclJzdAb1
         WdqZbZ9taayHcSnWz73s3aPnT8e7ZDazJe67lpi2tgRNb0gtb2qczPkOMKAHyNqD7SOa
         HJ0Dxw74dvVRu62j3rJOjzzDZWs/I/pYRTuc7UWvtJWbpW0tEchVuLsCuJCxG3tKTUki
         xCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=IIYs/Kh8s+R5AOQh89x+NWRkRUBABScvffAXRwko3Zg=;
        b=AX+yTuODvTczBLI5UB4pDX48x20zfyvpz+WmM4Yzwug1NTvkDpR4ZgByOXwWcCFJrY
         8zbbZeT1E6i5t0W9vBe1VysXoeMRLX/m1p9FB5z39iVRHg8UR5pNVlfUjfG8109sjP2M
         v+qUKMeqTecJ7WrQIV/fDPn/EogYfL1QjX4+HXGro3etLWRHG+JEo128xbdqr7hMzNcN
         I9Hbd5Mj7/CUwLViveFb0IxyY+DtzgEu4cAcjIMnmEPanVaTbvIfBvxYeCWQxKtzr1An
         R+pqXl8tY0QKYoG8Z/GKzBGg4Zn4KF26gwgpTAGQfIsW9N0qXEu7zmKnqcEDy2XGbAlZ
         v9CQ==
X-Gm-Message-State: ALoCoQmXOpuxXnYqF1O7h6dOjZRbVE3yPL2z6dQH8ngGt3rkh7h+EoR5VKCXOAVu0gKUEtidwAPF
X-Received: by 10.140.96.202 with SMTP id k68mr42786280qge.102.1432765487578;
 Wed, 27 May 2015 15:24:47 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Wed, 27 May 2015 15:24:47 -0700 (PDT)
In-Reply-To: <20150527221813.GF23259@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270113>

On Wed, May 27, 2015 at 3:18 PM, Jeff King <peff@peff.net> wrote:
> On Wed, May 27, 2015 at 01:30:29PM -0700, Junio C Hamano wrote:
>
>> Jorge <griffin@gmx.es> writes:
>>
>> > If you have a folder named ~/.gitconfig instead of a file with that
>> > name, when you try to run some global config editing command it will
>> > fail with a wrong error message:
>> >
>> >     "fatal: Out of memory? mmap failed: No such device"
>>
>> That indeed is a funny error message.
>>
>> How about this patch?
>>
>> -- >8 --
>> We show that message with die_errno(), but the OS is ought to know
>> why mmap(2) failed much better than we do.  There is no reason for
>> us to say "Out of memory?" here.
>>
>> Note that mmap(2) fails with ENODEV when the file you specify is not
>> something that can be mmap'ed, so you still need to know that "No
>> such device" can include cases like having a directory when a
>> regular file is expected, but we can expect that a user who creates
>> a directory to a location where a regular file is expected to be
>> would know what s/he is doing, hopefully ;-)
>>
>>  sha1_file.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sha1_file.c b/sha1_file.c
>> index ccc6dac..551a9e9 100644
>> --- a/sha1_file.c
>> +++ b/sha1_file.c
>> @@ -720,7 +720,7 @@ void *xmmap(void *start, size_t length,
>>               release_pack_memory(length);
>>               ret = mmap(start, length, prot, flags, fd, offset);
>>               if (ret == MAP_FAILED)
>> -                     die_errno("Out of memory? mmap failed");
>> +                     die_errno("mmap failed");
>>       }
>
> This is definitely an improvement, but the real failing of that error
> message is that it does not tell us that "~/.gitconfig" is the culprit.
> I don't think we can do much from xmmap, though; it does not have the
> filename. It would be nice if we got EISDIR from open() in the first
> place, but I don't think we can implement that efficiently (if we added
> an "xopen" that checked that, it would have to stat() every file we
> opened).

What is our thinking for after-fact recovery attempts?
Like we try the mmap first, if that fails we just use open to get the
contents of
the file. And when open fails, we can still print a nice error message?

>
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
