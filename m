From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH 0/9] new git check-ignore sub-command
Date: Fri, 7 Sep 2012 11:03:38 +0100
Message-ID: <CAOkDyE8mEQ5XkH5TBsrVkAZOqoT+DVoggeGawH=cqU6E6=hv=g@mail.gmail.com>
References: <1346544731-938-1-git-send-email-git@adamspiers.org>
	<7v7gscgnnr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 12:03:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9vPf-0007ku-4k
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 12:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215Ab2IGKDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 06:03:40 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:48337 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932109Ab2IGKDj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 06:03:39 -0400
Received: by bkwj10 with SMTP id j10so1275897bkw.19
        for <git@vger.kernel.org>; Fri, 07 Sep 2012 03:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=jgz5YY52GuEsjy0ZlA/NpP8yafJBlvkfpQQ0ccnZ3Ik=;
        b=UVXfjzZkwwyauvDtg9/6WHgp1ALZrTewlKaDqDDp3c8Oa3pAnA6KDTh1Z+dbi5qqoq
         Q+J4VFoAgK7CiaiCme/eYxkx1scBe+Pu3NQMnp9wwenxsUgKA0I1khOXgkB4C+Aagila
         xkpAmPPiFFl5Z537SRUWkUjDc91BX+EyG4y6D/X0HYKfI8Vsf9isOoe2XIf7uLNllgyH
         51lrdzzkIBRq3yH5n2qy1MGcyjX9NEj4CW7y7nBsbxPAOZyHlAt5GPEvv7NnwaxuExMx
         1PIpCRAA6fOc2SdUcG5M0B6/ZpmsPrkU+lewf0m3bFQ0woKgrp70OFKbej0poBVYI+Il
         tpNA==
Received: by 10.204.152.207 with SMTP id h15mr2322053bkw.5.1347012218392; Fri,
 07 Sep 2012 03:03:38 -0700 (PDT)
Received: by 10.205.81.80 with HTTP; Fri, 7 Sep 2012 03:03:38 -0700 (PDT)
In-Reply-To: <7v7gscgnnr.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: IaiTNMLxHk11e1bnK37w-5EDpqg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204957>

On Sun, Sep 2, 2012 at 9:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
>  * avoid unnnecessary braces {} around single statement blocks, e.g.
>
>     -if (exclude) {
>     +if (exclude)
>         return exclude;
>     -}
>
>  * else should follow close brace '}' of if clause, e.g.
>
>      if (...) {
>          ...
>     -}
>     -else {
>     +} else {
>          ...

What about when the if clause requires braces but the else clause
doesn't?  Should it be

	if (...) {
		...;
		...;
	} else
		...;

or

	if (...) {
		...;
		...;
	}
	else
		...;

?
