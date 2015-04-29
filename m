From: Adam Steel <adamgsteel@gmail.com>
Subject: Re: Regular Rebase Failure
Date: Wed, 29 Apr 2015 09:22:49 -0600
Message-ID: <CAF72XQfySo7S7hYwzTeMZQSj5Ko0Czarikd6TbBiJpFPj+aGiQ@mail.gmail.com>
References: <553685E0.8010304@gmail.com>
	<CAGZ79kadXgsdCLH-YFQ5RhyKbRv9-qmUOQo-9QkKM2=8p17j+g@mail.gmail.com>
	<55369509.2080200@gmail.com>
	<CAGZ79kY0pbC6qH+Refm8Py0PyF2xNMLfSarhA+3-7eaU==RK7w@mail.gmail.com>
	<CAF72XQfVfjMLe2VqNWHkGXq75DLMPU6VVqLeGzgh9rZNC0qp3Q@mail.gmail.com>
	<CAGZ79kY7kLF=uNm13xuqETMB1S+uwnB09_NzgU32bpODJHg8tg@mail.gmail.com>
	<CABURp0rkkpP_EuWA0O=gF=O=pyLGbh0Vzvp+yC-ckpJM4wU0gQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 17:22:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnTp9-0005iP-To
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 17:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965666AbbD2PWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 11:22:51 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:38074 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965589AbbD2PWu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 11:22:50 -0400
Received: by wiun10 with SMTP id n10so70051257wiu.1
        for <git@vger.kernel.org>; Wed, 29 Apr 2015 08:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oV0GsfUYL4B/2TKQgMXRRlZFQvnVNc0rwZZLiXIogAw=;
        b=dFhu1QcbEh/dqlu4XkWZDw+OWZBBZ1RA8yNVXGhQvkC71miaZztqj5FsqpTW9i1R0M
         o2QyhVq1JcyUPoWjVh1pb7fMnsw7/WSJKnNGxbu0ZYoNFeGP/wPWT1MbsNaSO5cYiVDj
         7FYkCJJSwVvO3pOOyZR4WL4j7yLxnHBnGK/cCtTWHoA+8oxkf527Ae+/TzJYZ5ZoIHDh
         Ttiq8hCPwggzF5SGyk2QXapa6MDzR91BQhiIyYhKHu32SITcJofLdwBPqPsPmbd+Is/k
         +OcYLukxNjEJTb5Y1JaOvMMVyGWLLlRsc0hha+eHBf9ahmBV8e0Y/gqGb+924ufPmO0V
         0vaw==
X-Received: by 10.194.61.171 with SMTP id q11mr41986041wjr.110.1430320969379;
 Wed, 29 Apr 2015 08:22:49 -0700 (PDT)
Received: by 10.28.212.144 with HTTP; Wed, 29 Apr 2015 08:22:49 -0700 (PDT)
In-Reply-To: <CABURp0rkkpP_EuWA0O=gF=O=pyLGbh0Vzvp+yC-ckpJM4wU0gQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267971>

Nope, this is local on an OSX system with only one user, no local
network. This happens about every third interactive rebase.

On Wed, Apr 29, 2015 at 9:14 AM, Phil Hord <phil.hord@gmail.com> wrote:
>> On Mon, Apr 27, 2015 at 10:07 AM, Adam Steel <adamgsteel@gmail.com> wrote:
>>> Stefan,
>>>
>>> So I switched git versions.
>>>
>>> $ git --version
>>> git version 2.3.1
>>>
>>> I'm still getting the same regular rebase failures.
>>>
>>> ---
>>>
>>> fatal: Unable to create
>>> '/Users/asteel/Repositories/rails-teespring/.git/index.lock': File
>>> exists.
>
> Is the repository located on a mounted network share, or could other
> users be accessing it via a network mount?  We had a similar problem
> recently on a new Jenkins VM instance which had only NFS-mounted
> storage available. I don't remember if it was Git that was failing on
> there, and I wasn't directly involved in solving the problem.  But
> while researching the issue I found ominous warnings about the dangers
> of file-locking on remote shares [1]. Which is to say, I don't know
> much, but I heard a rumor...  :-)
>
> Perhaps this is old news and already well covered in Git.  But I am curious...
>
>
> [1] http://0pointer.de/blog/projects/locking.html
