From: Raman Gupta <rocketraman@fastmail.fm>
Subject: Re: [PATCHv3] Add branch management for releases to gitworkflows
Date: Fri, 13 Nov 2009 17:56:33 -0500
Message-ID: <4AFDE421.5050307@fastmail.fm>
References: <1258055164-11876-1-git-send-email-rocketraman@fastmail.fm>	<1258055164-11876-2-git-send-email-rocketraman@fastmail.fm> <20091114071946.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, trast@student.ethz.ch, gitster@pobox.com
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Nov 13 23:56:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N954T-0002RD-7u
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 23:56:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbZKMW4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 17:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbZKMW4h
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 17:56:37 -0500
Received: from smtp116.rog.mail.re2.yahoo.com ([68.142.225.232]:30902 "HELO
	smtp116.rog.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932224AbZKMW4g (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Nov 2009 17:56:36 -0500
Received: (qmail 4411 invoked from network); 13 Nov 2009 22:56:41 -0000
Received: from CPE000db9166236-CM00186845d2ae.cpe.net.cable.rogers.com (rocketraman@99.224.155.40 with login)
        by smtp116.rog.mail.re2.yahoo.com with SMTP; 13 Nov 2009 14:56:41 -0800 PST
X-Yahoo-SMTP: 5CKRlKeswBAtrcX.EVB04BFKSgZiN0yKOK0iylIm064Zdzo-
X-YMail-OSG: G85FyV0VM1loJRr3z_Vix2dbkpqRGD6T9QC1w2TxwOtN8OOd_G7D_vz6bQGMvk8fww--
X-Yahoo-Newman-Property: ymail-3
Received: from localhost (localhost.localdomain [127.0.0.1])
	by apollo.rocketraman.com (Postfix) with ESMTP id F02AD21C05CC;
	Fri, 13 Nov 2009 17:56:40 -0500 (EST)
X-Virus-Scanned: amavisd-new at rocketraman.com
Received: from apollo.rocketraman.com ([127.0.0.1])
	by localhost (apollo.rocketraman.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AKpE754byopW; Fri, 13 Nov 2009 17:56:34 -0500 (EST)
Received: from [192.168.1.5] (zeus.rocketraman.com [192.168.1.5])
	by apollo.rocketraman.com (Postfix) with ESMTP id EECFD21C0538;
	Fri, 13 Nov 2009 17:56:33 -0500 (EST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090825)
In-Reply-To: <20091114071946.6117@nanako3.lavabit.com>
X-Enigmail-Version: 0.95.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132848>

Nanako Shiraishi wrote:
>  .Update maint to new release
>  [caption="Recipe: "]
>  =====================================
> -* `git checkout maint`
> -* `git merge master`
> +* `git checkout maint`
> +* `git merge --ff-only master`
>  =====================================
>  
> -This 'should' fast forward 'maint' from 'master'. If it is not a fast
> -forward, then 'maint' contained some commits that were not included on
> +This should fast-forward 'maint' from 'master'. If it is not a
> +fast-forward, then 'maint' contained some commits that were not included on
>  'master', which means that the recent feature release could be missing
> -some fixes made on 'maint'. The exception is if there were any commits
> -that were cherry-picked to 'maint' as described above in "Merging
> -upwards". In this case, the merge will not be a fast forward.

I noticed you removed the discussion I added about the situation in
which maint will *not* be a subset of master i.e. when the user has
cherry-picked commits from other branches. This type of cherry-pick is
described as a valid operation, though one to generally be avoided
earlier in the man page. If we tell users that the occasional
cherry-pick to maint is ok, then shouldn't we explain how that affects
the release process?

Cheers,
Raman
