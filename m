From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: GSoC 2016 | Proposal | Incremental Rewrite of git bisect
Date: Fri, 25 Mar 2016 15:28:01 +0530
Message-ID: <CAFZEwPN7HhjiQ=WdJUvK-4c1XL1X=27m8xF7MZab92v+aK-9ww@mail.gmail.com>
References: <CAFZEwPNXKo5YN9OPPCkO90bSPD3ittU+y8eDxh-JLxnihBznuw@mail.gmail.com>
	<CAP8UFD0muBUEp9XknmcTWqg==ChzWP3m-p-v6vXyC09OC88U7w@mail.gmail.com>
	<vpqbn62vrza.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Eric Sunshine <ericsunshine@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Mar 25 10:58:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajOVQ-0005vG-3h
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 10:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbcCYJ6F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 05:58:05 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35079 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091AbcCYJ6C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 05:58:02 -0400
Received: by mail-yw0-f194.google.com with SMTP id u8so788979ywa.2
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 02:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=8XXPkFBx6DFBLkNDSH81txZpN7Use31iVesIKeeyOoc=;
        b=0aXQCnxfQOlriVCvQl84ORxU75hiaPSqvn11Jo8DdWW7UHTgpyFxxCO5UoimOKhgr9
         OjFWG4pLZUUvpO4tjZkg7t8Kwuq98r3VhpGmDrFdb3pmkfy1UEVaJQ+T9YAy813bmxo7
         4eRkvj9S8RDmNynN8stMUq5mmZPch6Cicy9gSRpq7CKMbTP9Op0JZwjuoGJ70mtwDP3o
         XcTz0wfHmnzCx/Sz06gBlZk+6EVWRZKr9KuXYU7AFP/5qPHsABjuURnB75NfFqXJsbw2
         fJab3HKayMkiMCfOTzpHPuVHcuEFtW13SCvw0A5JenHPYnznsQcOd03t9EK5nOhpEg8d
         6Fdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=8XXPkFBx6DFBLkNDSH81txZpN7Use31iVesIKeeyOoc=;
        b=FumJ6rUcUxLHWeUT3kat4Kq8t1dSu+55KlJVQtCM29MYJ5l74XV4rqkr2iyZRJAnU8
         YOKADN5hINfUPkX72gE+F/0KCW6E1mv9qQHV4h+szzR3PARfzX6UBvnqiJLcMGIbSihX
         4voM82n8lVLdxJFQI4Tn9AJQgEL/GzSY9FCvmkpkTxERfHwJFSQR73+J9lK0VpHpjO3m
         cNIgSd4gAlXJSmc/tz1rLV0Iv75z6WFGfNK6nrsgs++AVoVnV5FEd+HWZP9emIioOwcA
         Pq1/QTNsoOPeuCP8sbHqnWA6fFRefqt7GgM+lqQNcFmOdk9cLdd2vk4E5VA2vXDbHcga
         21KQ==
X-Gm-Message-State: AD7BkJLamA5c5ikNb1hOedhSDqOIpeJox89lq8ZfZOVYJ/HlcuQ9hGxds91bB2rwdaCZhfMSJch0tF84y+FnoQ==
X-Received: by 10.129.155.81 with SMTP id s78mr6735990ywg.24.1458899881124;
 Fri, 25 Mar 2016 02:58:01 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Fri, 25 Mar 2016 02:58:01 -0700 (PDT)
In-Reply-To: <vpqbn62vrza.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289869>

On Fri, Mar 25, 2016 at 2:45 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> On Thu, Mar 24, 2016 at 12:27 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>
>>> Unification of bisect.c and bisect--helper.c
>>>
>>> This will unify the algorithmic and non-algorithmic parts of bisect
>>> bringing them under one heading to make the code clean.
>>
>> I am not sure this is needed and a good idea. Maybe you will rename
>> "builtin/bisect--helper.c" to "builtin/bisect.c" and remove
>> git-bisect.sh at the same time to complete the shell to C move. But
>> the actual bisect.{c,h} might be useful as they are for other
>> purposes.
>
> Yes. My view on this is that builtin/*.c should be just user-interface,
> and actual stuff should be outside builtin, ideally in a well-designed
> and reusable library (typically re-usable by libgit2 or others to
> provide another UI for the same feature). Not all commands work this
> way, but I think this is a good direction to take.

Okay. I didn't know about this. Thanks for completing Christian's point.

>> When you have sent one patch series, even a small one, then your main
>> goal should be to have this patch series merged.
>
> I'd add: to get a patch series merged, two things take time:
>
> 1) latency: let time to other people to read and comment on your code.
>
> 2) extra-work required by reviewers.
>
> You want to send series early because of 1) (then you can work on the
> next series while waiting for reviews on the current one), and you need
> to prioritize 2) over working on the next series to minimize in-flight
> topics.

I had planned to work this way. I will include this in the proposal.
Though it creates some confusion for me and I tend to mix some things
up but I will maintain a hard copy to jot down the discussions and my
thoughts.
