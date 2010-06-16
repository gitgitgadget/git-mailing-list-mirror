From: Aneurin Price <aneurin.price@gmail.com>
Subject: Re: How to prevent changes to repository by root
Date: Wed, 16 Jun 2010 17:09:52 +0100
Message-ID: <AANLkTikPNH1ueb5m8JpiB2hU4afd3hv-4qYqSO3QPujl@mail.gmail.com>
References: <AANLkTikLixhYITdJKMFb3Hw2hZvaas1DtiV3x9ThCTZz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 16 18:10:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOvBm-00019M-7y
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 18:10:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759217Ab0FPQJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jun 2010 12:09:55 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:48992 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754987Ab0FPQJy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jun 2010 12:09:54 -0400
Received: by wwb18 with SMTP id 18so5821313wwb.19
        for <git@vger.kernel.org>; Wed, 16 Jun 2010 09:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=gYdFc1MY45dDe0ulxbrV5h3nFSNGXh5RHeTwvbxLO2k=;
        b=pWX5xCdCKGONl6i64TEG3R8VYElI7GqVqYSAj65uVXvnGzWsVqQl9Gfks+kZG+HYPd
         m2ZUoh9BNtc1O1/ZLyrUXZRDhe4cla1TvjGTrJtj45zkCUes/bCMH/Lx+clyV+ZRWKL1
         //91hEIcSLOuJYJevob60m3+J6UDXSFRLi5/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=FwmkhhxGzn2njD+BgvpmN5aLI4t/sdqNVMBVzo6gWO/U9e1bmkEp8Kh9Doc7CvF6js
         jQJmT0WpZYXJMeLrxfWj1hk8bXNPK9jdjvBsZ9RgZkZR9sPO2aWWgDARiRsJqC+Xp7FY
         ICdcRdPE81d8iX90Xsd0kNjZKpOR8zvFYjcsg=
Received: by 10.216.153.140 with SMTP id f12mr896978wek.72.1276704592934; Wed, 
	16 Jun 2010 09:09:52 -0700 (PDT)
Received: by 10.216.45.135 with HTTP; Wed, 16 Jun 2010 09:09:52 -0700 (PDT)
In-Reply-To: <AANLkTikLixhYITdJKMFb3Hw2hZvaas1DtiV3x9ThCTZz@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149264>

On Mon, Jun 14, 2010 at 04:12, Nazri Ramliy <ayiehere@gmail.com> wrote:
> I have a git repository owned by a non-privileged user account on a
> machine that is logged into (via ssh) by multiple users. These multiple users,
> all of them (not at at the same time) do "git pull" on this repository.
>
> Everything is fine as long as they don't do the "git pull" as root.
>

Is there ever any requirement for them to run git as root?

How are they becoming root? If they are using sudo you could forbid
running git as root. If they are using su or logging in directly maybe
you can get away with some trivial thing like putting 'alias
git=/bin/false' in /root/.bashrc - or some wrapper which does
something helpful rather than silently fail :-).

Nye
