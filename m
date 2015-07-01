From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/PATCH] worktree: replace "checkout --to" with "worktree new"
Date: Wed, 1 Jul 2015 13:16:33 -0400
Message-ID: <CAPig+cR67ngGVSA_gSB2ydRJHT5ihf7nJzxmHKSzzQ94BMPAig@mail.gmail.com>
References: <1435640202-95945-1-git-send-email-sunshine@sunshineco.com>
	<xmqqr3orakex.fsf@gitster.dls.corp.google.com>
	<CAPig+cRLpJK-C7MApH1vigZS=gmHNeo6RL3S2wXv4B-TFfnq4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 19:16:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZALcl-0001bu-57
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 19:16:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbbGARQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 13:16:34 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:35125 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbbGARQe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 13:16:34 -0400
Received: by ykdy1 with SMTP id y1so45203102ykd.2
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 10:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=hOj0izNi2LZdLJ1KnHe0Vm498zTW5J/Hr95M2nr7NqU=;
        b=RiAhVjXcXbv01q8z+AymAu7MaInRA3MrKXnlzs0Vc64GtTVIxlfNWHYEFCv3DhmiKh
         /FJNz/hP9euRPB2VRGf6GRTlfW5hJufBnCr/9iJC1NM75iwIRJ3ikei5Xp8TKdYOR2iZ
         Y8pgC/0PV4Ikoyxbf5o9MGpxb9Nu6Dh/8oI6O/vCXO/k4b3OClCp4Y0MVOIc1++zcej6
         5UNxml35WvzQjrr7LNmCtW+WamtUr+7QtLQyJAFHv+AOIsKn9Cy60zsUYBWfcl/3D3Nu
         p3yLy7+sNnhPUEb5ChjLgxHpTzbdrlLcJZCSJvBmCP0TP0D3OdiQkpVyMxUeR+g5Xr4h
         g2CQ==
X-Received: by 10.170.63.196 with SMTP id f187mr33378364ykf.82.1435770993449;
 Wed, 01 Jul 2015 10:16:33 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Wed, 1 Jul 2015 10:16:33 -0700 (PDT)
In-Reply-To: <CAPig+cRLpJK-C7MApH1vigZS=gmHNeo6RL3S2wXv4B-TFfnq4g@mail.gmail.com>
X-Google-Sender-Auth: QAgRRyvRqNrukJaHC7khlwJMqHU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273166>

On Wed, Jul 1, 2015 at 1:13 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Jul 1, 2015 at 12:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> From: Eric Sunshine <sunshine@sunshineco.com>
>>
>> The command "git checkout --to <path>" is something of an anachronism,
>> encompassing functionality somewhere between "checkout" and "clone".
>> The introduction of the git-worktree command, however, provides a proper
>> and intuitive place to house such functionality. Consequently,
>> re-implement "git checkout --to" as "git worktree add".
>> ---
>>
>>  * Duy seems to think "worktree add" is coming, too, so here is a
>>    trivial tweak of your patch from the last month, with test
>>    adjustments to 7410 I sent earlier squashed in.
>
> Thanks. I was planning on re-rolling...

I forgot to mention that the subject needs a slight update: "worktree
add" rather than "worktree new".
