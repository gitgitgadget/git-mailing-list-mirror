From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 01/11] ref-filter: add "%(objectname:size=X)" option
Date: Wed, 29 Jul 2015 21:32:19 +0530
Message-ID: <CAOLa=ZSj-7Gr-QPC8bNJU9+FDkxmw-bhQhzUs91PSFJJQnZNtQ@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438066594-5620-1-git-send-email-Karthik.188@gmail.com> <xmqqvbd4fe5w.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 18:02:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKTok-0001hb-4c
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 18:02:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752605AbbG2QCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 12:02:50 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:34290 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbbG2QCt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 12:02:49 -0400
Received: by obre1 with SMTP id e1so10569269obr.1
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 09:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4W3S7H+6V1lhCL6J6vS147KXgyrP+lVI1Pttr8vzKmU=;
        b=T47Ev+dknC52ffS6RiNQ9HPrjTl04sBGOiupdITHUaUYiqhw72ttGTyDYans1AMume
         73Vy76l0+egEiPcFnzJ6MeRuJkup/66xx+AohS2PxScHAOI6fWilSMddTk9j7PvWnwwv
         ZQ2dwvskew3P53hkBw9H9NcKTXK0AV/Ka5kNeqVIu9vI89M6vZAFSzj0kIyw3nt1SEM+
         RGJwYTcZPBQgQ4tqcALUA7sHxnWBhNRKMFmfQw447jqfsF0eK1+n+MSqHjENq+54sPgd
         XBxHfM+2A1hzkeHxE147AtKymfZIXF9q/mcSdB1n2TYvWoK2T2z1wztvZe5wySrePOjy
         J8/Q==
X-Received: by 10.60.177.195 with SMTP id cs3mr40611839oec.37.1438185769104;
 Wed, 29 Jul 2015 09:02:49 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Wed, 29 Jul 2015 09:02:19 -0700 (PDT)
In-Reply-To: <xmqqvbd4fe5w.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274912>

On Tue, Jul 28, 2015 at 9:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> From: Karthik Nayak <karthik.188@gmail.com>
>>
>> Add support for %(objectname:size=X) where X is a number.
>> This will print the first X characters of an objectname.
>> The minimum value for X is 5. Hence any value lesser than
>> 5 will default to 5 characters.
>
> Where does this hardcoded 5 come from?
>
> I'd agree that we would want some minimum for sanity (not safety),
> but I do not think we want random callers of find-unique-abbrev
> arbitrarily imposing their own minimum, making different codepaths
> behave inconsistently without a good reason.
>
> It seems that the minimum we use for sanity at the core level is
> MINIMUM_ABBREV.  Is there a reason why that value is inappropriate
> for this codepath?
>

I don't quite remember, This is definitely wrong. Thanks
Will use MINIMUM_ABBREV.

-- 
Regards,
Karthik Nayak
