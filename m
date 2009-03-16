From: John Tapsell <johnflux@gmail.com>
Subject: Re: Generalised bisection
Date: Mon, 16 Mar 2009 10:37:45 +0000
Message-ID: <43d8ce650903160337p5a48c429nd9efd7f35e66248d@mail.gmail.com>
References: <efe2b6d70903081840v18e77aa7w2dac2bed553d0d6a@mail.gmail.com>
	 <43d8ce650903110235q5e2a59f6t201d5e65a4937476@mail.gmail.com>
	 <efe2b6d70903111515p2b9f656bp186d0b3cc7ae483d@mail.gmail.com>
	 <43d8ce650903112345x3d40b70ap7e4c0f8c7d0b6069@mail.gmail.com>
	 <alpine.DEB.1.00.0903121154560.10279@pacific.mpi-cbg.de>
	 <d9c1caea0903121102y5452603fua0e7a1b82e121b01@mail.gmail.com>
	 <efe2b6d70903130549m63ae9bdeg1cd3f24a43b3e66f@mail.gmail.com>
	 <d9c1caea0903130819u770686b1w867f074ffef8fabf@mail.gmail.com>
	 <efe2b6d70903151216q4a8881e5t797cf5d3bebc5697@mail.gmail.com>
	 <d9c1caea0903160329v3c1a1600m9913eafa00cc2f37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Ealdwulf Wuffinga <ealdwulf@googlemail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Git List <git@vger.kernel.org>
To: Steven Tweed <orthochronous@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 11:39:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjAE2-00010V-P5
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 11:39:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755071AbZCPKhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 06:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752073AbZCPKhs
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 06:37:48 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:52037 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754061AbZCPKhr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 06:37:47 -0400
Received: by wf-out-1314.google.com with SMTP id 28so1842997wfa.4
        for <git@vger.kernel.org>; Mon, 16 Mar 2009 03:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WotaHMhDdD0gclDy5Opq8A2RKXKKrN9ayja6vL8smyY=;
        b=hPa7paCHTbRX/8BP1wVWjMO7QPjEp4tubTeZA/fTcSYB70C77s8IZNjka5ZAglOg3M
         YIiL2+K9KTSoRg0BfgQ54qQYRohymsveUWoXO9OYcinQY9s4xSEcxJ+yC86bIw+CCTBd
         L8HlhJrCorqcKDlYw7i/kqtJ3lj8BUdtxyfFg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JOELqkXqHSAC7fWOG8HVF/akAchhIRSGc2eiodxtj2LqdbELC8wFoJe8hGjY08VHfT
         LlAmeXOwbX6pgxL37i5hOiL4WTQPOFEzDWECRrBHfqfRpmMvhi6w54lWlDopmqalp6T8
         1ZAlJJqOK+KmCUKaSvVzKNl4RG5kViPDtCeaQ=
Received: by 10.142.157.9 with SMTP id f9mr2069629wfe.341.1237199865511; Mon, 
	16 Mar 2009 03:37:45 -0700 (PDT)
In-Reply-To: <d9c1caea0903160329v3c1a1600m9913eafa00cc2f37@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113317>

2009/3/16 Steven Tweed <orthochronous@gmail.com>:
> On Sun, Mar 15, 2009 at 7:16 PM, Ealdwulf Wuffinga
> <ealdwulf@googlemail.com> wrote:
>> On Fri, Mar 13, 2009 at 3:19 PM, Steven Tweed <orthochronous@gmail.com> wrote:
>> It is not obvious how to perform this algorithm incrementally, because
>> of the need to
>> marginalise out the fault rate. As I understand it, marginalisation
>> has to be done after you
>> have incorporated all your information into the model, which means we
>> can't use the
>> usual bayesian updating.
>
> I had a look over the weekend, and got a bit sidetracked on one of
> your assumptions. You seem to be assuming that the bug is such that
> observing a single positive observation of the symptom at a position i
> in the linear history _does not_ completely rule out that the guilty
> commit occurs after that point. I would have thought the generally
> more applicable assumption is that, given that generally you don't
> have a bug ridden system where more than one bug causes the same
> symptom _within the history of interest_, that a single observation of
> the symptom does totally rule out the bug after that point (whilst
> intermittency clearly not having observed the bug before that point
> doesn't completely rule out the guilty commit being earlier, although
> it should increase the liklihood estimate of the bug being later).

I think it's reasonable to expect false-positives as well as
false-negatives.  e.g. you're looking for a commit that slows down the
frame rate.  But on one of the good commits the hard disk hits a bad
sector and takes a bit longer to retrieve data and so you get a
false-positive.

It's a bit contrived, but I'm sure you can think of better example

John
