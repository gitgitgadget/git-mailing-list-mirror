From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: Re: [RTC/PATCH] Add 'update-branch' hook
Date: Mon, 21 Apr 2014 14:15:00 -0700
Message-ID: <53558A54.4060801@gmail.com>
References: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com> <5355793A.5020000@gmail.com> <53558476703cb_5c94d452ec4e@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 21 23:15:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcLYY-0001LE-6X
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 23:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754151AbaDUVPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 17:15:10 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:38571 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbaDUVPI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 17:15:08 -0400
Received: by mail-pb0-f51.google.com with SMTP id uo5so4155773pbc.10
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 14:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=xE3LBTvfBvd/UZxo55cNxXGxHoLadgFfo0WuoQ3hqWg=;
        b=Stvoo2NEkdcIi3yT71t7ulLcfl+vUKV4bd/ITpSmaRab/K17kQ6HYQA3Tvdzak08Ie
         +jlg/v79yUWAQyV7JJ018IFST7IdDRbOgmeHFaKBt9aKEdRnemN6J6GnD0ZCzZOAmAzC
         9xTYSkgUCWf5w/HGJNIHVHGPCKx4J/Ks2vska9tOSCFr9jWyH8v2++k4YsAa1V+0WeqB
         wNae1x8SC6z4wxr4fTMn1GukzNJdfJ1IIsJHqy0ht0P7ZGkQRv1rJ9ubUZQ/0ggesB9y
         4Dee1LXq+pipLiq0E7il8N5umI6CLiEv83y8Di+19PRNyJdhd1P3Uvv4/m/BxRAwNBtH
         k1gw==
X-Received: by 10.66.142.170 with SMTP id rx10mr5943181pab.117.1398114908272;
        Mon, 21 Apr 2014 14:15:08 -0700 (PDT)
Received: from [192.168.1.2] (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id xz7sm191431110pac.3.2014.04.21.14.15.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Apr 2014 14:15:07 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:28.0) Gecko/20100101 Thunderbird/28.0
In-Reply-To: <53558476703cb_5c94d452ec4e@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246640>

On 4/21/2014 1:49 PM, Felipe Contreras wrote:
> Ilya Bobyr wrote:
>> On 4/20/2014 7:23 PM, Felipe Contreras wrote:
>>> This hook is invoked whenever a branch is updated, either when a branch
>>> is created or updated with 'git branch', or when it's rebased with 'git
>>> rebase'. It receives two parameters; the name of the branch, and the
>>> SHA-1 of the latest commit, additionally, if there was a base commit the
>>> branch was rebased onto, a third parameter contains it.
>> And the old branch SHA could be found from in the reflog, correct?
> Actually the old branch SHA-1 is actually the current one, since the branch
> hasn't been updated at that point. Personally I don't see much value in adding
> something the script can easily find out.

I did not understand that from the description.  That was my next
comment that I did not send just yet.
All the other hooks describe in detail if they are run before or after
the operation, and if it is possible to cancel the operation.
Also, most have names that start with either "pre-" or "post-".
It seems reasonable for both "pre-update-branch" and
"post-update-branch" to exist.
This one would be "pre-update-branch", I guess.

I was also wondering about "git reset".  It could also change the branch
position, right?
