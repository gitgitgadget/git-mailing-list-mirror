From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 11/11] walker.c: use ref transaction for ref updates
Date: Mon, 21 Apr 2014 15:29:22 -0700
Message-ID: <CAL=YDW=A_L3J6bD+ZXMGoZ0piuQbdGmS1nmTpuCD0yZEnj2BOw@mail.gmail.com>
References: <1397763987-4453-1-git-send-email-sahlberg@google.com>
	<1397763987-4453-12-git-send-email-sahlberg@google.com>
	<5352D31A.6000107@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 22 00:30:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcMj4-00032R-U7
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 00:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754502AbaDUW3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 18:29:24 -0400
Received: from mail-ve0-f179.google.com ([209.85.128.179]:51003 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754027AbaDUW3X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 18:29:23 -0400
Received: by mail-ve0-f179.google.com with SMTP id db12so8510981veb.38
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 15:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=RUqMJ6zuRBY3UHfxNfUKcTivSeroQqmKP/S19i/Ax7w=;
        b=NWOlTpfTjawaV40ZEH3U6H4lmDvJGKSkGR41ZbhKsMU2bblOUP+ECSbYYev0njdzf5
         ifqDbrlUrSq704OyBH7SgzQub1kZQkeE8Nu9z3f9fGol5zgzlimk1zMooSXeqC7IYvTO
         qnXtSbD5PkbGZVGQx+BbswkY9MTqUEQGuU4CcSqVK92Exc2iGCxpEs/Ne24a7tvvXaCH
         q14KVWKqA6pDN48FM1U4YvfBGiVzvKh+PK9sLaFfs2P2MpB6Y2uccuZmbUUjnPPZTqtP
         AhXSMoIRxaFIz/DxCeAn7cSXtK8UG66/tQuawRJ2uJ7eESUnXae0H1sqaEW47AIJ7lwk
         E/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=RUqMJ6zuRBY3UHfxNfUKcTivSeroQqmKP/S19i/Ax7w=;
        b=msvHRFtmFWKPXVqDGGhZq4FwUOoIO3bhgbVBSvcvbMIbS0fsMR6ZewKJF60s5DVyM/
         JqVfGo3RWfdEVIwR5p30DfhRRib8fp9wCRJFYmeM6yzo0mDcofcLD/NFkyOqnwsK+4+r
         Ka5TVbkezv/U1Z0hNU7kKQh4WF8pSdnqWSW8nwrzzuz2AFqZoMcuyRyS8MJf8VzJ1fg5
         RFJBdo8+KEsbH7pL7obZ5vKKckwStsftoqotyv057uNObd3aMbTY6WL7eF8FvoCpDnKJ
         CkVq+gcGs1AdutmJAikawoCnBnzvAIdFbadPtWBqSKqZNonwhwEPu/got8Y76UGbY2bG
         hkTw==
X-Gm-Message-State: ALoCoQlUNFmMGXCjAgZNd+q6wcs0aYwkyC6BWtD4qHqd3lzLZ9+hDbHWevLN+uYNGwM4o4yenlxOTB4JEshxcf1j48l+dpUrhH136FWqcBuBB2Sfyseu5ewFiDSQEcUXBNkGEcgUUoCmCVaBIb6uek0Kw5p/9DC7RA1C+bOodmOfmoq9C2vBEHAwXsTcNDFX60tCn7JKhSps
X-Received: by 10.52.164.237 with SMTP id yt13mr27881747vdb.18.1398119362604;
 Mon, 21 Apr 2014 15:29:22 -0700 (PDT)
Received: by 10.52.141.13 with HTTP; Mon, 21 Apr 2014 15:29:22 -0700 (PDT)
In-Reply-To: <5352D31A.6000107@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246658>

I have updated the commit message with some text why I do not think
this change is critical for this case.
I will resend v2 of the patch series in a little while.

On Sat, Apr 19, 2014 at 12:48 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 04/17/2014 09:46 PM, Ronnie Sahlberg wrote:
>> Switch to using ref transactions in walker_fetch(). As part of the refactoring
>> to use ref transactions we also fix a potential memory leak where in the
>> original code if write_ref_sha1() would fail we would end up returning from
>> the function without free()ing the msg string.
>
> I don't have time to review this last patch this evening, but one thing
> struck me.  It seems like the old code went to extra effort to lock all
> the write_ref references early in the function, whereas your modified
> version doesn't lock them until later.  Have you verified that you are
> not opening a possible race condition?  If so, your commit message
> should justify that it isn't a problem.  In other words, what does the
> code do between the old time of locking and the new time of locking and
> why doesn't it care whether the references are locked?
>
> Aside from my other comments, patches 01-10 in the series looked fine.
> Thanks!
>
> Michael
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
