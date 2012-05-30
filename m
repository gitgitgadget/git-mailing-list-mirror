From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: 'git merge tag' not working as before
Date: Thu, 31 May 2012 01:12:17 +0200
Message-ID: <CAMP44s0EQOgEKQ7x1as7HAi0UHcWmJwnuWNYQ9ifpThOLYx5MQ@mail.gmail.com>
References: <CAMP44s1bry3=W8hJPP9mJLzHmXFZug58aimGHhCSzwS9+Q-yWw@mail.gmail.com>
	<7vfwahxqhr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 31 01:12:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZs46-0003tM-OW
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 01:12:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755109Ab2E3XMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 19:12:21 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:43907 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754646Ab2E3XMT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 19:12:19 -0400
Received: by lbbgm6 with SMTP id gm6so412528lbb.19
        for <git@vger.kernel.org>; Wed, 30 May 2012 16:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qfPQ2GEk/PZLcShEWF2Ayk0T7WMPiIMvgZc7WOMcLhs=;
        b=S4bOcaiPGBXK52Utx+3hbYfuJzEPFnKOs4zXTu8W/kU+P57mianyPqtBZoKAgfCG1c
         5pdU3axSmTl//IUW5xBh3k5qtwXK2lf/MEvDS5edWT1UEOuUrMGSid9DFahCk3VlqSzz
         R8yURApOh2HMjd+UZQm+5MufuScEJ30sQxkY0lEpn2/3ZeC8YHq/PTV/QRpxpAlj55jI
         l2dshTmMTS99JV6yPz/j/LTpMjU0hUee5vpU0QbSK1W4mEA/BlVEV/IsuIZB8WaLFXZN
         pRVJwhqOvkmIVN3t45ZY25zrBvJk17vtnnSfF7KxTCmJ2aMnRnPtOZfzfdRah19zqst9
         pmhA==
Received: by 10.152.112.138 with SMTP id iq10mr17538920lab.13.1338419537532;
 Wed, 30 May 2012 16:12:17 -0700 (PDT)
Received: by 10.112.107.65 with HTTP; Wed, 30 May 2012 16:12:17 -0700 (PDT)
In-Reply-To: <7vfwahxqhr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198848>

On Thu, May 31, 2012 at 12:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> I used to do things like 'git merge v1.7.10.3' (from v1.7.10.2) but
>> even though it's ff it tries to create a merge commit.
>>
>> Seems like now I have to run 'git merge v1.7.10.3^0', I don't see why
>> that would be desirable.
>>
>> I think this is a bug and a regression.
>
> It was a deliberate feature enhancement a few releases back, IIRC.
>
> You should be able to say "git merge --ff-only v1.7.10.3" as well.

How is that an enhancement?

Basically:

  git merge branch # fast-forward
  git merge tag # fast-forward
  git merge annotated-tag # not fast-forward

Why should I do different actions depending on whether the tag is
annotated or not? 99% of users probably have never used annotated
tags, why complicate the interface for 99% of users, when the 1% of
users who actually want the messages of the annotated tag in their
merge message can just do --no-ff?

Cheers.

-- 
Felipe Contreras
