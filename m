From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] git-prompt.sh: Show where rebase is at when interrupted
 by a merge conflict
Date: Wed, 24 Apr 2013 02:14:54 -0500
Message-ID: <CAMP44s2uOkNEfAE3mcDn2CTo4c-HqzoJ_bSJNfdiGRT60sDV0w@mail.gmail.com>
References: <1366720507-16504-1-git-send-email-zoltan.klinger@gmail.com>
	<7vk3ntl1x9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Zoltan Klinger <zoltan.klinger@gmail.com>, git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 09:15:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUtv0-0006Ru-C0
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 09:15:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757351Ab3DXHO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 03:14:58 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:54917 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754162Ab3DXHO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 03:14:57 -0400
Received: by mail-lb0-f170.google.com with SMTP id r10so834690lbi.29
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 00:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=TVWlEMVXIZAPFXNooMWZ1/PDdRYDZiDYAnMOsqg+Mnw=;
        b=tjXgYVea4CT6gM7hsrArGrByZwWO3vbePFuHiVopwNBCFFnjzr25RUWQYyhO/faiF3
         cY26REUs00eiZCqA0Y0km6S27ZdjITRMMWtVc/uuycBpbDzUaP5lepsraKGxNixNf52a
         DS8IbODFXE9nS5TA5qwDlwhG/CThxAE90Xw7HqO+cI08d0lw/OcBk5VQfGaxza/qH14E
         IH2d3bJ+ztReLuuJNOezQOVjXk2KDD1C/b1L1PyfJayIbySWqNoIPS+0JwGR76QZgL/O
         k6pXOLCuLxBDZsTGu4fOybR0KaleySb+3Mjym7F4PHGoFfYWCZfYQ0OVCSj/rIeUel2P
         gVJQ==
X-Received: by 10.112.146.133 with SMTP id tc5mr16898304lbb.88.1366787694364;
 Wed, 24 Apr 2013 00:14:54 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Wed, 24 Apr 2013 00:14:54 -0700 (PDT)
In-Reply-To: <7vk3ntl1x9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222227>

On Tue, Apr 23, 2013 at 10:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Zoltan Klinger <zoltan.klinger@gmail.com> writes:
>
>> When a rebase is interrupted by a merge conflict it could be useful to
>> know how far a rebase has progressed and how many commits in total this
>> rebase will apply. Teach the __git_ps1() command to display the number
>> of commits so far applied and the total number of commits to be applied.
>>
>> Below is a sample output of the improved __git_ps1() command:
>>   ((3ec0a6a...)|REBASE|2/5)
>>
>> In the example above the rebase has stopped at the second commit due to
>> a merge conflict and there are a total number of five commits to be
>> applied by this rebase.
>>
>> This information can be alredy obtained from the following files which are
>> being generated during the rebase:
>>     GIT_DIR/.git/rebase-merge/msgnum (git-rebase--merge.sh)
>>     GIT_DIR/.git/rebase-merge/end    (git-rebase--merge.sh)
>>     GIT_DIR/.git/rebase-apply/next   (git-am.sh)
>>     GIT_DIR/.git/rebase-apply/last   (git-am.sh)
>>
>> 1) Modify git-rebase--interactive.sh to also create
>>       GIT_DIR/.git/rebase-merge/msgnum
>>       GIT_DIR/.git/rebase-merge/end
>>    files for the number of commits so far applied and the total number of
>>    commits to be applied.
>> 2) Modify git-prompt.sh to read and display info from the above files
>> 3) Update test t9903-bash-prompt.sh to reflect changes introduced by
>>    this patch.
>>
>> Signed-off-by: Zoltan Klinger <zoltan.klinger@gmail.com>
>> ---
>
> Nicely explained.  Felipe?  Szeder?  Comments?

Looks good to me.

-- 
Felipe Contreras
