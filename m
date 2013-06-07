From: "Constantine A. Murenin" <mureninc@gmail.com>
Subject: Re: is there a fast web-interface to git for huge repos?
Date: Fri, 7 Jun 2013 13:21:30 -0700
Message-ID: <CAPKkNb460fNJcwt6084xkuDa2sWMRnF+FBu+i_G01aJMMiRevA@mail.gmail.com>
References: <CAPKkNb4bYfBeqkBKqe-22iJsqjmvrYNSe4oWUnPo7QeghLK59Q@mail.gmail.com>
	<20130607063353.GB19771@paksenarrion.iveqy.com>
	<CAPKkNb5PyurX1eNsCsckdfiwgM3dqb5KpN9OS0NpLZw1+VsSdg@mail.gmail.com>
	<20130607175717.GA25127@paksenarrion.iveqy.com>
	<CAPKkNb4myh9MPNSgLqs5Mku-z1EOsHyWrgK2Qy_3_UOivXvcnw@mail.gmail.com>
	<51B23F01.5020608@brokenzipper.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Charles McGarvey <chazmcgarvey@brokenzipper.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 22:21:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul3AH-0003ZF-4e
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 22:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754831Ab3FGUVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 16:21:32 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:51416 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754898Ab3FGUVb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 16:21:31 -0400
Received: by mail-la0-f47.google.com with SMTP id fe20so4111511lab.34
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 13:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FCoBuNLBoLMJQxDRxPechM6Q6TQROnG/l/JyZhpkVkU=;
        b=Hp7V6zaUUXXN/00f+iWqtfHLfyT7uJYkLt4T+/2VYizfGUcTmuZdW8uxsRZDsqZzY3
         bBPV7SN3ppDr9Dh81JkHatCDZ3ubLQHW58FPSASRdL/EewlsCEz9kvwGp6kFRVeIILhI
         xC4YHS9/dmkPi+MRWUoe2u1I54ga1MFeRfiGso0o4kEBnMMYZOo9tWCeJ0M//Jk/VNAx
         VC4F/W4nwR2xcqD5dA/FnNh5yGePYCIErwWdpHKu/tj44r7rvsiK3+kc6BISfSNaJUGL
         BgdMOfUj4/itErfpY/x34B+/3/P4pYjoq31q5B854Ni/x/I9wLv/Hsqup4G6mTnKpNQl
         4Hfw==
X-Received: by 10.112.159.8 with SMTP id wy8mr1916935lbb.19.1370636490274;
 Fri, 07 Jun 2013 13:21:30 -0700 (PDT)
Received: by 10.114.77.1 with HTTP; Fri, 7 Jun 2013 13:21:30 -0700 (PDT)
In-Reply-To: <51B23F01.5020608@brokenzipper.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226694>

On 7 June 2013 13:13, Charles McGarvey <chazmcgarvey@brokenzipper.com> wrote:
> On 06/07/2013 01:02 PM, Constantine A. Murenin wrote:
>>> That's a one-time penalty. Why would that be a problem? And why is wget
>>> even mentioned? Did we misunderstood eachother?
>>
>> `wget` or `curl --head` would be used to trigger the caching.
>>
>> I don't understand how it's a one-time penalty.  Noone wants to look
>> at an old copy of the repository, so, pretty much, if, say, I want to
>> have a gitweb of all 4 BSDs, updated daily, then, pretty much, even
>> with lots of ram (e.g. to eliminate the cold-case 5s penalty, and
>> reduce each page to 0.5s), on a quad-core box, I'd be kinda be lucky
>> to complete a generation of all the pages within 12h or so, obviously
>> using the machine at, or above, 50% capacity just for the caching.  Or
>> several days or even a couple of weeks on an Intel Atom or VIA Nano
>> with 2GB of RAM or so.  Obviously not acceptable, there has to be a
>> better solution.
>>
>> One could, I guess, only regenerate the pages which have changed, but
>> it still sounds like an ugly solution, where you'd have to be
>> generating a list of files that have changed between one gen and the
>> next, and you'd still have to have a very high cpu, cache and storage
>> requirements.
>
> Have you already ruled out caching on a proxy?  Pages would only be generated
> on demand, so the first visitor would still experience the delay but the rest
> would be fast until the page expires.  Even expiring pages as often as five
> minutes or less would probably provide significant processing savings
> (depending on how many users you have), and that level of staleness and the
> occasional delays may be acceptable to your users.
>
> As you say, generating the entire cache upfront and continuously is wasteful
> and probably unrealistic, but any type of caching, by definition, is going to
> involve users seeing stale content, and I don't see that you have any other
> option but some type of caching.  Well, you could reproduce what git does in a
> bunch of distributed algorithms and run your app on a farm--which, I guess, is
> probably what GitHub is doing--but throwing up a caching reverse proxy is a
> lot quicker if you can accept the caveats.

I don't think GitHub / Gitorious / whatever have solved this problem
at all.  They're terribly slow on big repos, some pages don't even
generate the first time you click on the link.

I'm totally fine with daily updates; but I think there still has to be
some better way of doing this than wasting 0.5s of CPU time and 5s of
HDD time (if completely cold) for each blame / log, at the price of
more storage and some pre-caching, and (daily (in my use-case))
fine-grained incremental updates.

C.
