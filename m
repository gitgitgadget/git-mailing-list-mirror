From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 0/3] Towards a useable git-branch
Date: Sat, 25 May 2013 13:26:01 +0700
Message-ID: <CACsJy8Av8LmiefR5XFuFadZERmivZAAB9TbysFjeUSb2hzgWBw@mail.gmail.com>
References: <1369405177-7855-1-git-send-email-artagnon@gmail.com> <CACsJy8AEkmiWP46tOBkXRkWDGO+k5YW+GJB-ak8HfTpghQP5eQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 25 08:26:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug7wF-0002iG-NF
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 08:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024Ab3EYG0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 02:26:32 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:63360 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862Ab3EYG0c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 May 2013 02:26:32 -0400
Received: by mail-oa0-f44.google.com with SMTP id n12so7130358oag.3
        for <git@vger.kernel.org>; Fri, 24 May 2013 23:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VgusLD2/f3ygl4GvK/ChGyH1JSD7s7MGh9irkubgaXI=;
        b=eXQRPHSoZhFhncXZxQiPkNygWmE+w8BuqinBo1tmY45SNXk2ryhSu0DpjyaOe4duk6
         bGrrRyL815sh74B2Vn6icTWPPs4Bl6LeBHtFdGBS6ALyNgKB61OLg/QliwUZK96gzXek
         T4srECpR2AU4kDu7SpSLjpPKIXHnQaKPHntC06FzT8Sn0K2nYWqRI8Zcgj23H+zW7W76
         1M5W4+hh9qomHTBa3eejcuG2sXDPAXwGogGhdOdLao1lIeZ10veWYoREzWzCCZ1qKYxY
         XIsbPQikaEzMO0ID2wtd6fBeBCCo9U17gCew6zsd/5UGKTwpX9moqV4Uk9wEovcdHIbS
         W8kw==
X-Received: by 10.60.150.146 with SMTP id ui18mr13574379oeb.101.1369463191836;
 Fri, 24 May 2013 23:26:31 -0700 (PDT)
Received: by 10.76.141.232 with HTTP; Fri, 24 May 2013 23:26:01 -0700 (PDT)
In-Reply-To: <CACsJy8AEkmiWP46tOBkXRkWDGO+k5YW+GJB-ak8HfTpghQP5eQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225488>

On Sat, May 25, 2013 at 5:51 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> I just had an idea that might bring pretty stuff to for-each-ref with
> probably reasonable effort, making for-each-ref format a superset of
> pretty. But I need to clean up my backlog first. Give me a few days, I
> will show you something (or give up ;)

And I can't get it out of my head. Might as well write it down. Check out

https://github.com/pclouds/git.git for-each-ref-pretty

It opens a hook in format_commit_message() to plug f-e-r's atom syntax
in. I didn't do extensive test or anything, just t6300. The %xx syntax
in for-each-ref might override some placeholders in pretty, I did not
check. You can add extra %(xx) on top as you have done. I still need
one more hook to support %>(*) with automatic width detection. After
that I'm quite confident we can kill -v/-vv code.
--
Duy
