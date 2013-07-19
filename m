From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH 1/3] treewalk.c: Rename variable ret to cb_bits and remove
 some dead lines.
Date: Fri, 19 Jul 2013 22:25:52 +0200
Message-ID: <51E9A0D0.3090701@googlemail.com>
References: <1374183327-14939-1-git-send-email-stefanbeller@googlemail.com> <7vli52wh8n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 19 22:25:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0HFV-0006wU-Kl
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 22:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412Ab3GSUZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 16:25:53 -0400
Received: from mail-ea0-f181.google.com ([209.85.215.181]:53584 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992Ab3GSUZw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 16:25:52 -0400
Received: by mail-ea0-f181.google.com with SMTP id a15so2639533eae.40
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 13:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=d/Aeq10K3ycTOxJv2ZZ9KyAlCzVMZxz5t+tr1DPxClY=;
        b=Pw3zI9SNeTb9ljoRD7zUdNtXtOix9cn5ca0p8o1+xBVxc/Xr8O3FAipzFADbUh4uSB
         3GaGKPm1hTXHf0TYktNEjIp5oy2aTR6MPYNZTz5o8++/xosg/ZM/GUY6FcH/qBxd/WDt
         +CUouTv0guifq4DTZYSgZuFNVpUxXC5W+B+SpK+gL/CDcbICBC5PYzldZspHBgi2gu3t
         zDUXdegRQRAMtJ4roOtGbUDbvOrvqsaE+WshGJpgyJXXGmwP0811/o65H8fPK5Fe+BZH
         gz6KN4usoJeNi2h8hH6BS+2nWwTne6HiC7NApWK8kVR9FsdIuH3hN9E90koCFUN43z9B
         fBNQ==
X-Received: by 10.14.47.73 with SMTP id s49mr17652196eeb.71.1374265551360;
        Fri, 19 Jul 2013 13:25:51 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id b7sm30013215eef.16.2013.07.19.13.25.49
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 19 Jul 2013 13:25:50 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <7vli52wh8n.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230846>

On 07/19/2013 08:13 PM, Junio C Hamano wrote:
> The "ret" was meant to mean "the return value we got from the
> callback function", not "the return value we would give our caller".

Thanks for clarifying.
I assumed the "ret" was meant as the return value of that function
as it was the case before e6c111b4c. In other projects I am using 
ret as "the return value we would give our caller" as it's such a 
convenient name for that if you cannot come up with a better name.

> 
> This rename is a bit misleading in that "cb_bits == -1" does not
> mean "full bits set", and it does not tell us much what these "bits"
> signify.
> 
> They are used to answer this question: which one of the trees in
> t[0..n] did the callback function consumed (hence needs their
> pointers updated).
> 
> So perhaps call it "trees_used" or something?

Sounds indeed way better. I'll rename it.

> 
> By the way, our log message usually do not Capitalize the subject
> after the "<area>:", i.e. do something like this instead:
> 
>     Subject: [PATCH 1/3] traverse_trees(): clarify return value of the callback
> 
> Thanks.
> 

Thanks for pointing out.

As a general question: I was mostly doing micro-optimisations or 
the mailmap file, which are rather small fixups, which I think are
ok for beginners. Is there a tasklist for beginners, other than that?
Such as porting shell commands to C or other larger tasks?
I used git://github.com/gitster/git.git as remote/origin. There the todo
branch has the last commit as of 2012/04, so I also found
git://git.kernel.org/pub/scm/git/git.git, where the todo branch seems
more up-to-date, but the TODO file there also seems a little dated to
me.
So is there any up-to-date task list for beginning contributors?

Stefan
