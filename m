From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [Discuss] soften warning message after cloning "void"
Date: Wed, 18 Feb 2015 16:46:57 -0800
Message-ID: <CAJo=hJuoshE7UOVzz2WYLYFjcbiOuHu_+sfkRTbEc7-7C5cDMA@mail.gmail.com>
References: <xmqqh9ui2481.fsf@gitster.dls.corp.google.com> <CAGZ79kYu1k=iKRWTxVD9Q=C9F5J0d653czeR0NCy04wGobB=Vw@mail.gmail.com>
 <CAPc5daUzdiS0HkVbqZvQvSm_49FhQj++hicmDTb717Cd7hg8hA@mail.gmail.com> <CAJo=hJt4qVd_dybSn9Wy2UPpvm1+Kg0pE=vyB_fr0eHqQEXdVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 01:47:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOFH9-0007GY-S3
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 01:47:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754695AbbBSArW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 19:47:22 -0500
Received: from mail-yh0-f49.google.com ([209.85.213.49]:35552 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046AbbBSArS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 19:47:18 -0500
Received: by yhoc41 with SMTP id c41so3268980yho.2
        for <git@vger.kernel.org>; Wed, 18 Feb 2015 16:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HOvmhbb8vTwGyFTtqIgIdQNHCKAeakeBgSXwnoZTjqs=;
        b=f8jgMxL3EKG+XjC/35B/jpHEHu5szOSOC2y3qV58alkOf/pyzFZUbrhaVR88d9JdfF
         TFozStsfPFiHBvvoUbYEyS3qVxmC5rHnRGe2vBpTar+dFJJdHljlyS7fp7sffKK3I4BT
         sqCJpCiKJPfke9xPv+USdmISuVqlcIYts4Pw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=HOvmhbb8vTwGyFTtqIgIdQNHCKAeakeBgSXwnoZTjqs=;
        b=cEZ5g90coW5VEZZytdRbs1HB8IzMAQp5wxtwFcxj/DGt9jxgTm+oKzWdEtbpTyChCy
         ZIDYwSlNOmlUZ8qTvG8QClT8o7haZ8LLmeF2C8rgUGqp+PqQDvlDbC7tZKFskhmIP1Cn
         hVVAUq/Jrkw3iIPW9/rVkenbREfv/AJLmEQS2G9sFukfUqdQ0zk+7nqHjqPOigAXtEV7
         AN8Su+7FggsTcndKb5q3+NYOrW51sxBahlb9y43OukDNanjqX8SA8MeVZtA6DYuiRVem
         XY8T5WBxNc6Xe8LeloDifkqGFQm8TS3eI9OGqXOOq0aOpqQGqzlJxgMmHLXBi1Yd8sUD
         VP3w==
X-Gm-Message-State: ALoCoQmXPb8pU2GmEziY4B7GEVmfPyMjzVDj2cwvDpXj/MxdkVoaYXT75AHJ1x1aO5zIvrAnYOBE
X-Received: by 10.170.45.81 with SMTP id 78mr1743245ykn.100.1424306838057;
 Wed, 18 Feb 2015 16:47:18 -0800 (PST)
Received: by 10.170.39.19 with HTTP; Wed, 18 Feb 2015 16:46:57 -0800 (PST)
In-Reply-To: <CAJo=hJt4qVd_dybSn9Wy2UPpvm1+Kg0pE=vyB_fr0eHqQEXdVg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264078>

On Wed, Feb 18, 2015 at 4:43 PM, Shawn Pearce <spearce@spearce.org> wrote:
> On Wed, Feb 18, 2015 at 4:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Checking out a random branch is absolutely the worst thing you can
>> do. Personally, I would think that the best thing you can do is to
>> educate your users not to clone from a void. Create some history
>> that is worth sharing, and then push into an empty repository.
>
> Users are dumb.
>
> Consider a website like GitHub where you create a repository on a a
> remote server. It is initialized as an empty repo. They now want to
> clone that empty repo to work with it:
>
>   git clone https://example.com/foo
>   cd foo
>   .... hack hack
>   git commit -a -m "Foo is awesome!"
>   git push
>
> This works from git-core servers because the ref advertisement tells
> the client its an empty repo and its OK to checkout HEAD from nothing
> and its all fine.
>
> This fails from a JGit server because the ref advertisement for an
> empty repository differs and disagrees with the format used by
> git-core. The result is a confused client spewing an odd checkout
> message.

The difference in JGit is intentional. Our cross data center
consistency system at $DAY_JOB depends on being able to fetch from one
empty repository to another empty repository using the want any object
capability, and side-band-64k. The JGit client and server code that
speaks the wire protocol needs to send and see the capability lines
for that to work, but with no refs there are no lines to send.

So we send capabilities^{} like receive-pack does. But git-core hates
all over that during clone of an empty repo.
