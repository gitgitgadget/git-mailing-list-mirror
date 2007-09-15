From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: STG, problem with pop/push of alternative versions of a patch
Date: Sat, 15 Sep 2007 10:25:39 -0400
Message-ID: <9e4733910709150725k73bec66bw753c4b3c01244cff@mail.gmail.com>
References: <9e4733910709142049k6dcec6acuf851c21ed6704287@mail.gmail.com>
	 <b0943d9e0709150107o27571446v9bef8e31517777e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 16:25:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWYaf-0003yc-KE
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 16:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbXIOOZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 10:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbXIOOZl
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 10:25:41 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:48344 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbXIOOZk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 10:25:40 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1335611wah
        for <git@vger.kernel.org>; Sat, 15 Sep 2007 07:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=6/JTKqlzJSMmVMuCJzC0NFvSMNNCqsT0cRRug2b2uwk=;
        b=T3sTFe9+VtErlsUHn4a6f6gOcIPlqgy994pIlV5AnSV3YNxzKjVwAROLF+0A49nI5t7f1m2uoqvxx2lIA7MVNowkXeEnNSNJZ1V6CLnpdcjHhnqj03hn9oRL5DmguG76M1fYgS/Cq5wsf8PoWvpM6CtPEiYVJREC+53rEbtSo6o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WYHa4n7VxAYFfHM2V0dFE6M9HNvTNXWUa6mTnFVIhaJozh/Y97+AF837MiTWBeAmCqnfR8EdobfAdyTOxzvG5Qn/bjRWBLQK3YXrXdDFL6Qu5YxUUTFKZnApW2C8BO3+VRS5YsVnmdCsABcgZkEVKzn6eNqAr+4dYBLqiHyaC1o=
Received: by 10.114.156.1 with SMTP id d1mr2903783wae.1189866339422;
        Sat, 15 Sep 2007 07:25:39 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Sat, 15 Sep 2007 07:25:39 -0700 (PDT)
In-Reply-To: <b0943d9e0709150107o27571446v9bef8e31517777e1@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58249>

On 9/15/07, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> On 15/09/2007, Jon Smirl <jonsmirl@gmail.com> wrote:
> > I trying to test two different versions of a patch that add files.
> > These patches create a new directory and add several files. When I pop
> > a version of the patch the directory and files and not getting
> > removed. This causes an error when I push the alternative version of
> > the patch.
>
> This shouldn't happen AFAICT (at least for the files, as GIT doesn't
> care much about directories). What GIT/StGIT version are you using?
> StGIT simply calls GIT to do the HEAD switch.

I have played around with some more. It is more complicated than the
simple case I described.  Earlier I noticed a message about applying a
patch that was empty that shouldn't have been. I checked and the patch
is indeed empty. The empty patch probably caused the files to be left.
I had been using hide/unide and reordering with on the patch and had
encountered a couple errors in stg. I'll try and track down the
sequence that caused the contents of the patch to be lost.


>
> Could you run 'stg patches drivers/net/fec_mpc52xx/Kconfig' with the
> initial series pushed? It should show which patches touch this file.
> If it doesn't show any, maybe the files weren't added to any patch and
> hence the error.
>
> Thanks.
>
> --
> Catalin
>


-- 
Jon Smirl
jonsmirl@gmail.com
