From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] t9350: point out that refs are not updated correctly
Date: Thu, 25 Oct 2012 08:39:08 +0200
Message-ID: <CAMP44s2bNZLiyinu3wgmw4gaRM9XUvA857-8fOGebhKYFmDesw@mail.gmail.com>
References: <1320535407-4933-2-git-send-email-srabbelier@gmail.com>
	<CAMP44s1hdZb_7Lv8SEe+MsfC_q-nXsnjJobABFq6eFR_er4TaA@mail.gmail.com>
	<20121024180807.GA3338@elie.Belkin>
	<CAMP44s2RspCrRXZbRTsVwezyU9X=+8RF=_9Q+3zX75LBJkdoPA@mail.gmail.com>
	<20121024191149.GA3120@elie.Belkin>
	<CAMP44s2kjv9fHbruXv7NyVm9m+FjFnYDryuPZQ-RQXN9Nj6MAw@mail.gmail.com>
	<20121025042731.GA11243@elie.Belkin>
	<CAMP44s1Pe8Ef6-GRbmSs7rY7gWyaPCN+jWGysyttZp3drSDoZg@mail.gmail.com>
	<20121025052823.GB11243@elie.Belkin>
	<CAMP44s3Xwt5+J_yGte_HC3hG+MhMkWnJQ7mtuB_Y+sOLB1b1+A@mail.gmail.com>
	<20121025055343.GA13729@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Eric Herman <eric@freesa.org>,
	Fernando Vezzosi <buccia@repnz.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 08:39:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRH6A-0001OQ-K4
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 08:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236Ab2JYGjK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 02:39:10 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:44642 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976Ab2JYGjI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 02:39:08 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so1270585oag.19
        for <git@vger.kernel.org>; Wed, 24 Oct 2012 23:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/ylpo+CR56qaOEuD8S5lKPcmHEJPjRLHCDmuskaYsaA=;
        b=racAAiCvbTix1KI5slvNluUc3i9+/9u9uVH6OvC6Ne/C2uVxW29lKzzDUYh+P3LoWD
         1hTkRjQwbHiqS7kVRVAFYsrF9Tep5Sej3qtmm6iBqyXWVgzvuj4yo1M7mOFFRVLVTM9i
         N5Zsj2+Lzid7maj3sgaFgiNcsBcmCUUsHsE7sg4bFwR6u1WaAvagAGHkcjwEm0xV8YeI
         DKJRRDRF1kfOImk5iJMQ3GWivvSchXs+iaujM5RXy8bLxA+h3muk4yMgpIqcNJn0ANI/
         2p6PxBhneotRK3osO1y9zZmjsuTOzBG7iO2Df5HNatRuYCfFWIQDFh37WLSt+jxU4xA1
         9b/g==
Received: by 10.182.116.6 with SMTP id js6mr14650015obb.82.1351147148305; Wed,
 24 Oct 2012 23:39:08 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Wed, 24 Oct 2012 23:39:08 -0700 (PDT)
In-Reply-To: <20121025055343.GA13729@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208352>

On Thu, Oct 25, 2012 at 7:53 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Felipe Contreras wrote:
>
>> All right, so I run this and get this:
>>
>> % git fast-export master..master
>> reset refs/heads/master
>> from 8c7a786b6c8eae8eac91083cdc9a6e337bc133b0
>>
>> As an user of fast-export, what do I do with that now?
>
> You passed "master.." on the command line, indicating that your
> repository already has commit 8c7a786b6c8eae8eac91083cdc9a6e337bc133b0.

No I didn't.

Maybe I'm not interested in all the old history and I just want to
create a repository from that point forward. For example 'git
fast-export v1.5.0..master. I don't want no references to objects I
don't have, there's no way I can do anything sensible with that SHA-1.

% git fast-export master..master | git --git-dir=/tmp/git/.git fast-import
fatal: Not a valid commit: 8c7a786b6c8eae8eac91083cdc9a6e337bc133b0
fast-import: dumping crash report to /tmp/git/.git/fast_import_crash_32498

Does it make sense to you that the output of fast-export doesn't work
with fast-import?

> Now you can update the "master" branch to point to that commit,
> as the fast-export output indicates.

I don't have that commit, I don't even know what 8c7a786 means.

Show me a single remote helper that manually stores SHA-1's and I
might believe you, but I doubt that, marks are too convenient. Or show
me a script. I doubt there will be any, because otherwise somebody
would have pushed for this patch, and there doesn't seem to be too
many people.

But fine, lets assume it's a valid use-case and people need this... it
still has absolutely nothing to do with the original intent of the
patch series. The series is in fact doing two things:

1) Use SHA-1's when a mark can't be found
2) Update refs that have been already visited (through marks)

These two things are orthogonal to each other, we should have two
tests, and in fact, two separate patch series. One will be useful for
remote helpers, the other one will be useful to nobody IMO, but that's
something that can be discussed there, and I particularly don't care.

My test and my patch are good for 2), and so far I haven't seen
anybody saying otherwise.

Cheers.

-- 
Felipe Contreras
