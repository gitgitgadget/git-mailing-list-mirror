From: Kyle McKay <mackyle@gmail.com>
Subject: Re: repo.or.cz being not well???
Date: Mon, 1 Jul 2013 15:39:22 -0700
Message-ID: <CB8FBC9A-B24D-4EAC-820F-A40472387FD9@gmail.com>
References: <7vli5q9ba2.fsf@alter.siamese.dyndns.org> <7va9m5apl8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, admin@repo.or.cz
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 00:39:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Utmkt-0003T2-BV
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 00:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755756Ab3GAWj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 18:39:26 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:50717 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755601Ab3GAWjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 18:39:25 -0400
Received: by mail-pd0-f173.google.com with SMTP id v14so3008973pde.32
        for <git@vger.kernel.org>; Mon, 01 Jul 2013 15:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mailer;
        bh=Ik9dSnbeJ7wkug81DtBWRigOsupgF5skQOcVrdIHTV8=;
        b=RrBJCDvWEN+xl4rN38vxXZbXpZKs2CUqVZHHm5JembzKVCFozT+FMAp4cvAh9UKYm2
         cEKUFi3BkJab5ITRHQ8fPtLTdy3oHGZ74Xoa/qKF2VL/GIyn2v0iEzYjzRU2IOqflxTK
         rm4LbHFJhVsYJfYrfcW9ECzbVuPz3XA6DPnBUfT4RL4JD4S4+FVzkrLxgNkDsBrkYNDh
         2t7bOcV125tQnbDV6UTQHcVmq6dteLD6jfON5aDZB8vSn6N7XGODimSg3NdY5dReODnu
         4H4539I7wfuTa+9NCKdHuchih7fhxvHeJapgk2tOtTSCYv88+QVCiakzhVxrowt4UpOt
         YT9A==
X-Received: by 10.68.163.165 with SMTP id yj5mr25986710pbb.141.1372718365444;
        Mon, 01 Jul 2013 15:39:25 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id at1sm24193834pbc.10.2013.07.01.15.39.23
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jul 2013 15:39:24 -0700 (PDT)
In-Reply-To: <7va9m5apl8.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229345>

My apologies.

repo.or.cz recently had some updates to support:

1) smart HTTP fetch
2) smart HTTP push (over https)
3) user removal of projects

Along with those updates it started doing more validation on paths.

I believe all the paths listed on http://repo.or.cz/w/alt-git.git are  
accepted as shown.

I was not previously aware that URLs not shown on that page were  
accepted, thank you for bringing it to my attention.

Do you feel that it's important to accept these alternate URL versions  
that are not listed on the project page:

1) Optional trailing '/'
2) For the ssh scp form, optional leading '/'

Regards,
Kyle

On Jul 1, 2013, at 15:21, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Has something changed recently at repo.or.cz, accepting pushes over
>> ssh, in the past few days?  I am getting this:
>>
>>    $ git push -n -v repo.or.cz:srv/git/alt-git.git/
>>    403 forbidden
>>    fatal: Could not read from remote repository.
>>
>>    Please make sure you have the correct access rights
>>    and the repository exists.
>
> Nevermind, I figured it out.
>
> 	$ git push repo.or.cz:/srv/git/alt-git.git
>
> seems to be the new way to spell the scp style push.
>
> Two points to note, just in case it would help other users, are
>
> (1) The repository hierarchy is no longer under your initial
>     directory and you have to explicitly ask for /srv/$path; and
>
> (2) You used to be able to, but no longer are allowed, to have a
>     trailing slash in your repository URL.
