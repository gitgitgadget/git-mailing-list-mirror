From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/3] fast-export: add new --refspec option
Date: Thu, 9 May 2013 19:44:24 -0500
Message-ID: <CAMP44s101dmokgjwYxhtRsWWjhSZKxWFgnbkeDFHw+svDmTy9w@mail.gmail.com>
References: <1368063095-22861-1-git-send-email-felipe.contreras@gmail.com>
	<1368063095-22861-3-git-send-email-felipe.contreras@gmail.com>
	<7vvc6r7pii.fsf@alter.siamese.dyndns.org>
	<CAMP44s2yoBFZU+LzHWT30ijbQ2rknmV1ZoB9qDDYvvme2chB7g@mail.gmail.com>
	<7v38tv7n5y.fsf@alter.siamese.dyndns.org>
	<CAMP44s1d_9iT7nqtu3gTy=kX-Kapnf0AUZJ-Z-MpLkBuWxBgSw@mail.gmail.com>
	<7vobcj65wp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 10 02:44:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UabRy-0005UU-6i
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 02:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757164Ab3EJAo0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 20:44:26 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:64780 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755790Ab3EJAo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 20:44:26 -0400
Received: by mail-lb0-f177.google.com with SMTP id 13so3691652lba.36
        for <git@vger.kernel.org>; Thu, 09 May 2013 17:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=axAWQfMScztSeWvY62J1kZ6N76hECRGEVmbNGUCXITA=;
        b=Q3Rxe0wpTbzsaH03oSEktaFeorj4VKbYHL4dgMp75LidhWmxF109CoIeytq5y8F35n
         Z8/50CyDkVQ8Ie/zXCFuffRKJI94cqG3CK+nuIG3ULwhHYYTFaHeTKZ934YUGV316ovv
         ghuuSi8VKo3T1OLc57SI4EUg/tlBC0Gu/lKUxCx3uA/6wtrhgWKMWf+Qke3GSeDQPYN8
         UfhO+5T32OPDL/xcE++9dVAXdVRc7B4sfcX/0VrSMHaMKsDiVidbZFiykpL9UhXHucM5
         10pbX4DLovVAWUJ8oRoIVtKK55zoTf2XCOS2NDZ6gFS+17vPTJkFrvGgGQtvyXoiDAee
         QyrQ==
X-Received: by 10.112.146.133 with SMTP id tc5mr6467464lbb.88.1368146664545;
 Thu, 09 May 2013 17:44:24 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 9 May 2013 17:44:24 -0700 (PDT)
In-Reply-To: <7vobcj65wp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223808>

On Thu, May 9, 2013 at 7:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Thu, May 9, 2013 at 6:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Simple.  You treat everything as refspecs and form revision ranges
>>> out of them.  Note that that is exactly the reason why "git push"
>>> can take "master" as a short-hand for "master:master" [*1*].
>> ...
>>> So I would imagine you would be spelling that as:
>>>
>>>     git fast-export master:new-master --not next refs/tags/*
>>>
>>> or something, no?
>>
>> rev-list doesn't accept 'refs/tags/*'.
>
> I think you misunderstood.  That is meant to illustrate what your
> end users feed "fast-export". "fast-export" in turn expands that
> into a revision range, which needs to happen anyway when it strips
> :new-master from the positive end of the range to make the range
> into
>
>         master ^next ^refs/tags/v1.0 ^refs/tags/v1.1 ...

'git fast-export' accepts rev-list arguments, to make it do something
else would not only break existing users, but would require massive
work. I'm not interested in doing that.

Cheers.

-- 
Felipe Contreras
