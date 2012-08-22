From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: [Q] Comparing differences introduced by two commits?
Date: Wed, 22 Aug 2012 18:55:29 +0100
Message-ID: <CAF5DW8J8JL-jGexh+CmmCafFAREjAJrb8zzOwP8b9fEuqUB56w@mail.gmail.com>
References: <2794881.R5SsgFdXjR@laclwks004> <CAF5DW8L=6wn6wumzwJuC=QMkb3ggZoPxOJrZf=FQEdArwNzzdw@mail.gmail.com>
 <7vharuamok.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Brian Foster <brian.foster@maxim-ic.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 19:55:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4F9q-0008HS-AQ
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 19:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756065Ab2HVRzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 13:55:53 -0400
Received: from gardner.asmallorange.com ([184.173.73.186]:36034 "EHLO
	gardner.asmallorange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755571Ab2HVRzv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 13:55:51 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44080)
	by gardner.asmallorange.com with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.77)
	(envelope-from <maillist@steelskies.com>)
	id 1T4F9i-0018Ug-KJ
	for git@vger.kernel.org; Wed, 22 Aug 2012 13:55:50 -0400
Received: by ialo24 with SMTP id o24so1060425ial.19
        for <git@vger.kernel.org>; Wed, 22 Aug 2012 10:55:50 -0700 (PDT)
Received: by 10.50.161.131 with SMTP id xs3mr3137059igb.46.1345658149923; Wed,
 22 Aug 2012 10:55:49 -0700 (PDT)
Received: by 10.43.56.79 with HTTP; Wed, 22 Aug 2012 10:55:29 -0700 (PDT)
In-Reply-To: <7vharuamok.fsf@alter.siamese.dyndns.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gardner.asmallorange.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - steelskies.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204050>

On 22 August 2012 17:58, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan del Strother <maillist@steelskies.com> writes:
>
>> On 22 August 2012 13:10, Brian Foster <brian.foster@maxim-ic.com> wrote:
>> ...
>>>  In the past I've done:
>>>
>>>     diff <(git show A) <(git show B)
>>>
>>>  which produces rather messy output but is Ok when dealing
>>>  with just one or two sets of A/B commits.  I now have a
>>>  large-ist set of A/B commits, and the above is impractical.
>
> Isn't this what interdiff is for?
>
>>>  Some searching hasn't found any suggestions I'm too happy
>>>  with, albeit I've very possibly overlooked something.
>>
>> What about cherry picking B onto A, then showing the cherry-picked commit?
>>
>> Off the top of my head :
>>
>> git checkout A
>> git cherry-pick B
>> git show HEAD
>
> Wouldn't you see a lot of needless conflicts while doing such a cherry-pick?
>
> I often do
>
>         git checkout A^
>         git cherry-pick B
>         git diff A
>
> when queuing an updated patch.
>

True.  That sounds a better solution.
