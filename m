From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 3/3] push: add separate 'downstream' branch
Date: Thu, 16 May 2013 15:36:22 +0530
Message-ID: <CALkWK0m+_AbCd305dU5p5bxwuPPCBKJH7a3e6rHgxxnySMz0pQ@mail.gmail.com>
References: <1368675828-27418-1-git-send-email-felipe.contreras@gmail.com>
 <1368675828-27418-4-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0nTS6Vh7GfnrLWAK5VeevQyGN5N7xT43c+uqBQ5oM5tww@mail.gmail.com>
 <CAMP44s3fPsGW_9aBbcsu8cJAagz8JEWV2HM=XRH3Rw4=SXdL7Q@mail.gmail.com>
 <CALkWK0nOywB5BtHnKZQ_+wsJNp82zk7-YJw_S15quqH+iU=jWg@mail.gmail.com> <CAMP44s2vsD2uwFoL5_79m05gtqyKLN9wHX8Yrhtn0kT4LVULxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 12:07:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucv5Z-0003CY-2D
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 12:07:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068Ab3EPKHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 06:07:05 -0400
Received: from mail-ia0-f178.google.com ([209.85.210.178]:55476 "EHLO
	mail-ia0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab3EPKHE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 06:07:04 -0400
Received: by mail-ia0-f178.google.com with SMTP id i9so3264255iad.37
        for <git@vger.kernel.org>; Thu, 16 May 2013 03:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=mP+T8wAuQsdgRqNSljVoAONWpsCa5GjIKP02eBsu5JM=;
        b=hHckLFbyVzam8lnyUOHD/quYAexdFuiSrPzjzNFTDkhUUUVbH9aZYwCw0MfRiUvZ/K
         W4NZBA0Q9elY46p2q87HsxTKpl3EM+9Dps7QD6LpgTzpelrUEe97XIzNL7P285JIk8sq
         i+LeGNXODfUTcgAt2pjOtn2eOKPMGgXC4dzPkXsE457eOFXaEpwKqwjS9riz84YsJjBY
         oI3EFNsnizWJSMIVDXCr7STmUV4e6Fb37UaPwnJ83Pq3HfhKbzPOi/GxYcXJGT2OWEB3
         Q5bXzFhYccqWUje8H8NbPd0DIvZPibu5XgHYcm9z4S6oq7WED/PFRwzs260kZuA9N584
         938A==
X-Received: by 10.50.33.19 with SMTP id n19mr8683215igi.44.1368698823543; Thu,
 16 May 2013 03:07:03 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 16 May 2013 03:06:22 -0700 (PDT)
In-Reply-To: <CAMP44s2vsD2uwFoL5_79m05gtqyKLN9wHX8Yrhtn0kT4LVULxQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224546>

Felipe Contreras wrote:
>> [remote "origin"]
>>     push = refs/heads/master:refs/heads/fc/master
>>
>> [remote "."]
>>     push = refs/heads/fc/old-remote/hg:refs/heads/fc/remote/hg

Major thinko.  It should be:

[remote "github"]
    push = refs/heads/master:refs/heads/fc/master
    push = refs/heads/fc/old-remote/hg:refs/heads/fc/remote/hg

>> Advantage being you can do:
>>
>> [remote "origin"]
>>     push = refs/heads/*:refs/for/*
>>
>> While you can't with branch.<name>.push.
>
> But I can do 'git push origin "refs/head/*:refs/heads/for/*"', not
> that I've ever had the need to do something like that, so I don't
> care.

Isn't the entire point of this exercise getting git to dwim without
being explicit?

I don't care about it personally either, which is why I haven't
written a patch yet.  However, there are users of Gerrit who would
appreciate this feature: in the remote.pushdefault thread, some people
requested this feature.
