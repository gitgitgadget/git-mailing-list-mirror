From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/7] remote-hg: don't decode UTF-8 paths into Unicode objects
Date: Mon, 11 Nov 2013 13:10:50 -0600
Message-ID: <CAMP44s2BcmuLeLOgA592g7F117LU--uhWVFNq1W6gn+uvURmvA@mail.gmail.com>
References: <1384142712-2936-1-git-send-email-rhansen@bbn.com>
	<1384142712-2936-2-git-send-email-rhansen@bbn.com>
	<5280b9d87f92c_6841541e786f@nysa.notmuch>
	<52812258.1060109@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Mon Nov 11 20:10:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vfwsy-0001BL-HC
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 20:10:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754744Ab3KKTKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 14:10:53 -0500
Received: from mail-lb0-f179.google.com ([209.85.217.179]:36088 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754161Ab3KKTKv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 14:10:51 -0500
Received: by mail-lb0-f179.google.com with SMTP id w6so3742768lbh.38
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 11:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=n+bklr+20fM4QFx8b4tvaW7QpZL5YB7VOmjc7F6VOnc=;
        b=wPILj3fx4cku1dgo+h3LYjhiALpauBpEmrOny32DR1XOntI7uJz+koK53ijk0KOnEJ
         PR43YmWs2BxOJgQ18Lm+6rh4aNyNVjxwLoNdhyBJg6ANXPjUAtbAvnPaILsenkWUpunH
         OHVCDqeIJGvmIXRG5q52VlQEjux6h2f5JRj5rPquDIeDeOJWv0L1xnFqIRNtNg3twizg
         KxH7tsW3ug4ORkcyfzh0VnNLeGAneoiLY49ZDogxnzfWbGgXXwxl4G/gBMN88ZzoYooS
         QnBKVfCkFqOTzyTsR3Yy8IU7LwSGtGQ9/+IvG5U94hj7+ViwPjAWe8T6CKCtmA0Ubyrx
         IozQ==
X-Received: by 10.112.205.164 with SMTP id lh4mr22904919lbc.15.1384197050253;
 Mon, 11 Nov 2013 11:10:50 -0800 (PST)
Received: by 10.114.201.69 with HTTP; Mon, 11 Nov 2013 11:10:50 -0800 (PST)
In-Reply-To: <52812258.1060109@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237633>

On Mon, Nov 11, 2013 at 12:30 PM, Richard Hansen <rhansen@bbn.com> wrote:
> On 2013-11-11 06:04, Felipe Contreras wrote:
>> Richard Hansen wrote:
>>> The internal mercurial API expects ordinary 8-bit string objects, not
>>> Unicode string objects.  With this change, the test-hg.sh unit tests
>>> pass again.
>>
>> This makes sense to me, but the tests are already passing for me. How are they
>> failing for you?
>
> $ hg --version | head -n 1
> Mercurial Distributed SCM (version 2.2.2)
> $ cd ~/git/t
> $ ../contrib/remote-helpers/test-hg.sh --verbose --immediate

Ah, I see they are failing now (v 2.8). I don't know what I was testing.

FWIW my tree doesn't have this problem [1].

> I can put the above in the commit message if people would like it there.

Personally I think it's overkill. You mentioned the tests failed,
that's enough explanation. I just wanted to see if that was actually
the case.

[1] https://travis-ci.org/felipec/git-travis

-- 
Felipe Contreras
