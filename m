From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] t/test-lib.sh: do not trust $SHELL
Date: Sat, 22 Sep 2012 03:04:50 +0530
Message-ID: <CALkWK0nLLEF7wnUhF0JUAZVP6GG3KHmuYSDZLPS7uGCZPfhV3w@mail.gmail.com>
References: <505CCA55.6030609@gmail.com> <1348260766-25287-1-git-send-email-artagnon@gmail.com>
 <20120921205834.GC22977@sigill.intra.peff.net> <CALkWK0kRzN_yQZ1JqJogBs6Z1nLhofBijHzeWR5YfQYHOtpaBA@mail.gmail.com>
 <20120921211217.GA24134@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 21 23:35:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFAsd-00036t-U3
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 23:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376Ab2IUVfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 17:35:12 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:47952 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757950Ab2IUVfL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 17:35:11 -0400
Received: by qaas11 with SMTP id s11so1630627qaa.19
        for <git@vger.kernel.org>; Fri, 21 Sep 2012 14:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9M30iMBfzM268CeBFPYb/pRdOxQBI6npJIh8uUqwKfc=;
        b=TowBt85bBnm0mLZlCD9myyOBGRd8ucOaQFy2NeQAbEGdS0JRHJ/b6QTJ8rbA8/5rI/
         9pbSPW93mc7UpYj7W2+JPOZ8rmhsD0yLOPPV4hH2sJAyunsbjI5dwtrByGMDMTMOuoSx
         DeBPGJI1cAi6cRhhtM0CnWXrlstTqpXzQyL8EmpO/qrPzsU4tUx3f00iTweICp3625nX
         vKZ3wNT5+jDNZpvmFe3zfN3iE+QymLMf0LGMPQ2I1sFvdGzgoUWh2hsHekfG+SBGRWpy
         nm5V1v3iNb3rzUdQ8nsOwbiLTWEme0Z8v35Cd8Vv7u8Fovbj3KoKJ0fEKek090cT4O3g
         F2VA==
Received: by 10.229.111.70 with SMTP id r6mr4254161qcp.120.1348263310751; Fri,
 21 Sep 2012 14:35:10 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Fri, 21 Sep 2012 14:34:50 -0700 (PDT)
In-Reply-To: <20120921211217.GA24134@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206171>

Hi Peff,

Jeff King wrote:
> On Sat, Sep 22, 2012 at 02:37:38AM +0530, Ramkumar Ramachandra wrote:
>
>> > I don't think that is the right thing to do. The point of SHELL is to
>> > point at a bourne-compatible shell. On some systems, the main reason to
>> > set it is that /bin/sh is _broken_, and we are trying to avoid it.
>>
>> But you're only avoiding it in the --tee/ --va* codepath.  In the
>> normal codepath, you're stuck with /bin/sh anyway.
>
> No, the #!-header is only information. When you run "make test" we
> actually invoke the shell ourselves using $SHELL_PATH.

My SHELL_PATH is not set, and I can see SHELL_PATH ?= $(SHELL) in the
Makefile.  Which shell is it supposed to point to?  If you're
proposing to use a variable that's only set in the Makefile in the
test, you're not allowing users to run the test as a standalone-
that's not a good change, is it?

Ram
