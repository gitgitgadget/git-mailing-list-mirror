From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: How to use path limiting (using a glob)?
Date: Thu, 12 Feb 2009 06:09:00 +0900
Message-ID: <20090212060900.6117@nanako3.lavabit.com>
References: <20090211191432.GC27232@m62s10.vlinux.de> <7v1vu4eouz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 11 22:11:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXMMJ-0005hq-PV
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 22:11:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756557AbZBKVJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 16:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756368AbZBKVJe
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 16:09:34 -0500
Received: from karen.lavabit.com ([72.249.41.33]:36350 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756136AbZBKVJd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 16:09:33 -0500
Received: from h.earth.lavabit.com (h.earth.lavabit.com [192.168.111.17])
	by karen.lavabit.com (Postfix) with ESMTP id C160B11BABB;
	Wed, 11 Feb 2009 15:09:32 -0600 (CST)
Received: from 5660.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id 46235AG5MEDS; Wed, 11 Feb 2009 15:09:32 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=pnB37v0uOqPpPGu2f32I7wFwMiKUPaMLsvitNMiGcn4gdPFLOxBtkCi+G5lSrsjqM8QofCrH1k9HUxXPgCiMGCsL6tsgucMzp6CU/Try8ODwdCdkWNAEE88VqXrDmpjrU6pSlkRLU8sF2tXMHJ6IRFbUdJbBwrlp2HKw7eF3Wvs=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7v1vu4eouz.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109529>

Quoting Junio C Hamano <gitster@pobox.com>:
> Peter Baumann <waste.manager@gmx.de> writes:
>> Hallo,
>>
>> after reading Junio's nice blog today where he explained how to use git grep
>> efficiently, I saw him using a glob to match for the interesting files:
>>
>> 	 $ git grep -e ';;' -- '*.c'
>>
>> Is it possible to have the same feature in git diff and the revision
>> machinery? Because I tried
>>
>> 	$ cd $path_to_your_git_src_dir
>> 	$ git log master -p -- '*.h'
>> 	.... No commit shown 
>>
>> 	$ git diff --name-only v1.5.0  v1.6.0 -- '*.c'
>>
>> and both don't return anything.
> There was a recent discussion on this.  The index family uses glob, the
> tree family uses leading-path only.  The one implemented for grep can do
> both, and attempts to unify both by providing possibly reusable interface
> so that the other two families can be ported to, but we haven't managed to
> trick anybody to take up the task ;-).

The list archive has nicely written summaries on the issues and suggestions on how to make this possible:

    http://article.gmane.org/gmane.comp.version-control.git/94628
    http://thread.gmane.org/gmane.comp.version-control.git/105638/focus=105679

-- 
Nanako Shiraishi, the unofficial project secratary of the git project
http://ivory.ap.teacup.com/nanako3/
