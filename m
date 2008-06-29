From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 1/2] Convert "stg refresh" to the new infrastructure
Date: Sun, 29 Jun 2008 12:07:42 +0100
Message-ID: <b0943d9e0806290407h5eecd27bg510dd09e0188abca@mail.gmail.com>
References: <20080625042337.6044.53357.stgit@yoghurt>
	 <b0943d9e0806290242q1bc8aa67qb3523221b3db70e2@mail.gmail.com>
	 <20080629102147.GA5098@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 13:08:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCuls-0003ep-Bv
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 13:08:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162AbYF2LHo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Jun 2008 07:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754428AbYF2LHn
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 07:07:43 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:18056 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053AbYF2LHn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jun 2008 07:07:43 -0400
Received: by wa-out-1112.google.com with SMTP id j37so856098waf.23
        for <git@vger.kernel.org>; Sun, 29 Jun 2008 04:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=MDcNN4ndNZarY85vExbrykg4ZR8NqI15GnIzdAXcIYc=;
        b=V9X+kGPuW2q8aQMo6j10hguZr4Ry8X8gjmfUNawR42FQxhqE7HqHJmW3ckf35ESSUb
         WoKC9kncDjyBcdz+sk6UtEbMjhb0/qi0gHgK0Tka88tx/t/vZ3bLxFjSSD0ZbHqv/LKr
         Wyk494MFl2j+AcXI6eEteZlm62GXV3ksnLJGc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Gdtma1euXcjM/tKCf2iH9yPsurLhvTq2RhX1aG21XjXLLy7SiTZKrXvu3sYOCN63cV
         byc0ALKjMCsZO5/52NOaJDTXFV2exkkDXKDP3gDTn/ZHvMY90ei6ljOp8NppRKrJw1wh
         X7QfiL5P0cxrEtphDsli2xBDIfUmewSG06/vg=
Received: by 10.114.156.1 with SMTP id d1mr3007200wae.171.1214737662420;
        Sun, 29 Jun 2008 04:07:42 -0700 (PDT)
Received: by 10.114.124.9 with HTTP; Sun, 29 Jun 2008 04:07:42 -0700 (PDT)
In-Reply-To: <20080629102147.GA5098@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86793>

2008/6/29 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-06-29 10:42:32 +0100, Catalin Marinas wrote:
>
>> 2008/6/25 Karl Hasselstr=F6m <kha@treskal.com>:
>>
>> > And in the process, make it more powerful: it will now first
>> > create a temp patch containing the updates, and then try to merge
>> > it into the patch to be updated. If that patch is applied, this is
>> > done by popping, pushing, and coalescing; if it is unapplied, it
>> > is done with an in-index merge.
>>
>> Does it make sense to refresh an unapplied patch? Maybe adding a new
>> file to the patch but I don't really see a need for this.
>
> A change in a different part of the same file should work as well, I
> believe.
>
> But no, I don't have a strong sense that this is super useful. It was
> just easy to allow, so I allowed it.

It seems harmless, unless someone finds some unusual behaviour. What
is the conflict behaviour? Is the refresh aborted? For unapplied
patches, it is more complicated to let the user solve the conflict.

--=20
Catalin
