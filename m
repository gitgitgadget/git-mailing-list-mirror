From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Regular Rebase Failure
Date: Wed, 29 Apr 2015 11:14:28 -0400
Message-ID: <CABURp0rkkpP_EuWA0O=gF=O=pyLGbh0Vzvp+yC-ckpJM4wU0gQ@mail.gmail.com>
References: <553685E0.8010304@gmail.com> <CAGZ79kadXgsdCLH-YFQ5RhyKbRv9-qmUOQo-9QkKM2=8p17j+g@mail.gmail.com>
 <55369509.2080200@gmail.com> <CAGZ79kY0pbC6qH+Refm8Py0PyF2xNMLfSarhA+3-7eaU==RK7w@mail.gmail.com>
 <CAF72XQfVfjMLe2VqNWHkGXq75DLMPU6VVqLeGzgh9rZNC0qp3Q@mail.gmail.com> <CAGZ79kY7kLF=uNm13xuqETMB1S+uwnB09_NzgU32bpODJHg8tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>
To: Adam Steel <adamgsteel@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 17:14:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnThP-0007Yu-5A
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 17:14:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933243AbbD2POu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 11:14:50 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:36784 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932903AbbD2POt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 11:14:49 -0400
Received: by iebrs15 with SMTP id rs15so44677494ieb.3
        for <git@vger.kernel.org>; Wed, 29 Apr 2015 08:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=UbmIkGN5L3LCXc6+/YxflgQTyiR2aTXNIt5X9JK2fb8=;
        b=Ghxoaf1H2GmT0P535Bmx3t4S9NhIkMGXzoID9DYbJoQ+ENEZXoJoB2pz37GtZ3DtVE
         6tJUGDuxe1rW2DlzdjrbeStH/eB59gwNaWtkdOUYACYiJLXi4/uPscWT/fTNHyVgdnEO
         iqTVECP17TPBUEQp59Sq1rO96r5AfabfBFUUZWwPzKvN8IHGEb43WV4DaMuIMfr+7/6p
         jB8lcD9VuywEvmbnjvRLytloj0CVCS0gii0RW0/y4cfloDNt7toMb04bOiCl9t/rRv91
         RaCXf+JeTLaeFzA6U0s2bX0htcm1zLb6iLLsrF2XMY2PRSHpDXEtY9Stx924JQJ3N4E7
         tJlA==
X-Received: by 10.43.55.12 with SMTP id vw12mr4062190icb.30.1430320488807;
 Wed, 29 Apr 2015 08:14:48 -0700 (PDT)
Received: by 10.107.139.202 with HTTP; Wed, 29 Apr 2015 08:14:28 -0700 (PDT)
In-Reply-To: <CAGZ79kY7kLF=uNm13xuqETMB1S+uwnB09_NzgU32bpODJHg8tg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267970>

> On Mon, Apr 27, 2015 at 10:07 AM, Adam Steel <adamgsteel@gmail.com> wrote:
>> Stefan,
>>
>> So I switched git versions.
>>
>> $ git --version
>> git version 2.3.1
>>
>> I'm still getting the same regular rebase failures.
>>
>> ---
>>
>> fatal: Unable to create
>> '/Users/asteel/Repositories/rails-teespring/.git/index.lock': File
>> exists.

Is the repository located on a mounted network share, or could other
users be accessing it via a network mount?  We had a similar problem
recently on a new Jenkins VM instance which had only NFS-mounted
storage available. I don't remember if it was Git that was failing on
there, and I wasn't directly involved in solving the problem.  But
while researching the issue I found ominous warnings about the dangers
of file-locking on remote shares [1]. Which is to say, I don't know
much, but I heard a rumor...  :-)

Perhaps this is old news and already well covered in Git.  But I am curious...


[1] http://0pointer.de/blog/projects/locking.html
