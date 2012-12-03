From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: does a successful 'git gc' imply 'git fsck'
Date: Mon, 3 Dec 2012 18:44:11 +0530
Message-ID: <CAMK1S_gNgQORT8XRSMn0OoKRGqosoEB3_Jv84s0fQ9cpsHqMDQ@mail.gmail.com>
References: <CAMK1S_iBq1ReGkjuy2UBENSQXOWyKj2ZzSCcg7Z89FVtVL2wMw@mail.gmail.com>
	<7vlidgls09.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 14:14:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfVqz-0006o6-Vn
	for gcvg-git-2@plane.gmane.org; Mon, 03 Dec 2012 14:14:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754619Ab2LCNOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2012 08:14:14 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:63093 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733Ab2LCNOM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2012 08:14:12 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so2237649lag.19
        for <git@vger.kernel.org>; Mon, 03 Dec 2012 05:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=N6LCWXQn6I9z2Qe11DBEGknR4S2cg+WKOuGB6d6POe4=;
        b=Prj5Op2BbK1p+RgEkKLq/RuJYDbH639udTDoMkuXU+eRmUIhqO+WxYGevnzmWl91Wp
         lBWXzql5PnoGyJMHkmozdJfCqD/aZqfquGl13dnKD3a/EuoUrEl3LN6Yo4MDeu/c92jR
         p+7VAQw3lly+oAL0arkeALzw4r15MndOOdFIiWZa4l/7LPpZz+STvhZzv/wFHmdniV4D
         8b5LdEaVeDJwHzV9qcVFoP6Y9k8nXv7yI7TdxBGve9odx72TWx0/QWp1wAp5xRNC5aDb
         AI5yHGrcM2lcTkO9MWOSVXTy0HjptKfwYKeYBLqOSSZpVrqmavo5UlwIQkT+DkEcflhf
         S3lg==
Received: by 10.112.41.202 with SMTP id h10mr4292648lbl.20.1354540451436; Mon,
 03 Dec 2012 05:14:11 -0800 (PST)
Received: by 10.112.113.103 with HTTP; Mon, 3 Dec 2012 05:14:11 -0800 (PST)
In-Reply-To: <7vlidgls09.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211036>

On Sun, Dec 2, 2012 at 3:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Sitaram Chamarty <sitaramc@gmail.com> writes:
>
>> If I could assume that a successful 'git gc' means an fsck is not
>> needed, I'd save a lot of time.  Hence my question.
>
> When it does "repack -a", it at least scans the whole history so you
> would be sure that all the commits and trees are readable for the
> purpose of enumerating the objects referred by them (and a bit flip
> in them will likely be noticed by zlib inflation).
>
> But a "gc" does not necessarily run "repack -a" when it does not see
> too many pack files, so it can end up scanning only the surface of
> the history to collect the recently created loose objects into a
> pack, and stop its traversal without going into existing packfiles.

Thanks; I'd missed this nuance as well...

-- 
Sitaram
