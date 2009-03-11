From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH 1/3] bash completion: fix completion issues with fetch, pull, and push
Date: Wed, 11 Mar 2009 19:02:27 +0900
Message-ID: <20090311190227.6117@nanako3.lavabit.com>
References: <cover.1236314073.git.jaysoffian@gmail.com>
 <07bd381f7984117681504ce57c1f6c40aecafed3.1236314073.git.jaysoffian@gmail.com>
 <20090306155814.GG16213@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 11 11:04:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhLIs-00065L-SU
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 11:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755189AbZCKKC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 06:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755180AbZCKKC6
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 06:02:58 -0400
Received: from karen.lavabit.com ([72.249.41.33]:51673 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755166AbZCKKC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 06:02:57 -0400
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id 1295211B8BC;
	Wed, 11 Mar 2009 05:02:56 -0500 (CDT)
Received: from 1522.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id 6C7AJEOCPXFY; Wed, 11 Mar 2009 05:02:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=WNBIWtYm7jROk1bz6nr7xBXR+BvmIhkyFIvucDsLSbvI66SvM/ScPrBLb8EDDjrKmlYymTStmd1g2wuYEYmrvUWhE8tmy6Gz6n0o/r9F7tNJMWtuDOcYbuPHBF/Q3tqIgdf7gfrX5tDRkvlwK5gsHH04ItLnDfklOkQaClxBzyY=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <20090306155814.GG16213@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112902>

Quoting Shawn O. Pearce <spearce@spearce.org>:

> Jay Soffian <jaysoffian@gmail.com> wrote:
>> Sverre Rabbelier noticed a completion issue with push:
>> 
>>  $ git push ori<tab>
>>  git push origin
>> 
>>  $ git push -f ori<tab>
>>  git push -f origin/
>> 
>> Markus Heidelberg pointed out that the issue extends to fetch and pull.
>> 
>> The reason is that the current code naively assumes that if
>> COMP_CWORD=2, it should complete a remote name, otherwise it should
>> complete a refspec. This assumption fails if there are any --options.
>> 
>> This patch fixes that issue by instead scanning COMP_CWORDS to see if
>> the remote has been completed yet (we now assume the first non-dashed
>> argument is the remote). The new logic is factored into a function,
>> shared by fetch, pull, and push.
>> 
>> The new function also properly handles '.' as the remote.
>> 
>> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
>
> Acked-by: Shawn O. Pearce <spearce@spearce.org>

While people's attention is on the completion, there is one case I wish the completion worked better.
"git log origin..mas[TAB]" and "git log origin...mas[TAB]" work as expected, but the same completion does not work for "git diff". I don't miss the two-dot format but it's often useful to say "git diff origin...master".

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
