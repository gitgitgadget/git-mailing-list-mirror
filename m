From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 6/6] pull: trivial cleanup
Date: Sat, 31 Aug 2013 02:56:08 -0500
Message-ID: <CAMP44s3X6au7iG3O31HZn_kvcjU-AJa+pnMci+FQ0vaDPvjOsA@mail.gmail.com>
References: <1377899810-1818-1-git-send-email-felipe.contreras@gmail.com>
	<1377899810-1818-7-git-send-email-felipe.contreras@gmail.com>
	<xmqq38pqwlyl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 31 09:56:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFg2Y-0005k9-Nm
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 09:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753689Ab3HaH4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 03:56:11 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:43389 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990Ab3HaH4K (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 03:56:10 -0400
Received: by mail-lb0-f172.google.com with SMTP id x18so2556129lbi.17
        for <git@vger.kernel.org>; Sat, 31 Aug 2013 00:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=a9fbFS5qRaMUUyoyI6/8SxtaN/zKvQF3/9pQabCVPLI=;
        b=XDw4xKUZ5xb0On1pGVRvUZrWQSmcCVAz2H1rwXbaCGyOt/16Jc7g6NsTvzkxnmqqcB
         31FuSY694r7tt3KMRQnXcNhxvWea/JUvsXUj8xqwDG4vl4Gv6NiLbYqwDIGULHMVTpVG
         UdqTRxgAbVFuWXlsBVIKEKJ3MP/WD9LFwUn7o2jMAOhJcJ08oNoQFlHFLOhETdmfaghf
         jwYg/ysfFwcGsYnvD3JC521JliEKFvzOi7Fy+obiVHXUgrBo70Gz6qvjnZyDgTZM0oIB
         atW8Ng9n3kbV5sUy2QKBSiNidFnB0f3kE6+QlIxw0o3vQiZm2z+FTLpN4N7js26OEwtd
         qkQg==
X-Received: by 10.112.60.104 with SMTP id g8mr476513lbr.32.1377935768723; Sat,
 31 Aug 2013 00:56:08 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sat, 31 Aug 2013 00:56:08 -0700 (PDT)
In-Reply-To: <xmqq38pqwlyl.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233508>

On Fri, Aug 30, 2013 at 10:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> There's no need to remove 'refs/heads/' yet again.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  git-pull.sh | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/git-pull.sh b/git-pull.sh
>> index f0df41c..3bdcbfd 100755
>> --- a/git-pull.sh
>> +++ b/git-pull.sh
>> @@ -166,7 +166,6 @@ error_on_no_merge_candidates () {
>>               op_prep=with
>>       fi
>>
>> -     curr_branch=${curr_branch#refs/heads/}
>
> The code assumes that at this point $curr_branch has the result of
> git symbolic-ref -q HEAD it did at the beginning, before it entered
> in the command line parsing loop.  But immediately after it, the
> code sets up $curr_branch_short for the value this code computes.
>
>>       upstream=$(git config "branch.$curr_branch.merge")
>>       remote=$(git config "branch.$curr_branch.remote")
>
> So it appears to me that the above two lines that are not updated
> would introduce a regression.  Am I missing something trivial?

Yes, I'm not exactly sure where from which branch I got this change,
but those lines were removed. They should be updated.

-- 
Felipe Contreras
