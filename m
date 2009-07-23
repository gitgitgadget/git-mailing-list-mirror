From: Martin Pirker <git.collector@gmail.com>
Subject: Re: synchronizing 2 heterogenous branches by cherry-pick
Date: Thu, 23 Jul 2009 11:24:33 +0200
Message-ID: <8d53e6220907230224t1ceddf31ic69bfbed84c851f@mail.gmail.com>
References: <8d53e6220907210542p4c989f3av2b57202fdd2db1f5@mail.gmail.com>
	 <8d53e6220907230141l62dd1830g15ca811d5b009f2f@mail.gmail.com>
	 <20090723085125.GL4750@laphroaig.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@madism.org>
X-From: git-owner@vger.kernel.org Thu Jul 23 11:24:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTuXa-0000PD-OI
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 11:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbZGWJYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 05:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbZGWJYe
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 05:24:34 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:52089 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbZGWJYe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 05:24:34 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1425879rvb.5
        for <git@vger.kernel.org>; Thu, 23 Jul 2009 02:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lc9yVCUmZPhUQF89io9lrgUcyGVOqzG78AdgBiLCmvg=;
        b=IsBAUCplzjJxK2cbbe/BKqHL2l6yHqP/BMh/3P8HmEDH+d39jraWgLvW+926mjcCR3
         SufIHhpUli6jB8IIkPk0x+kHJfj3Rpy34cqk0ahQ6mt/UPV1m//Q9qgdCnTEPqXGZMZN
         UP1weDrmT9p5E5R135SjTk2eRH4gYND2P/G6g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uRgJ58OtnY6N0FfcGCCbnXYip7vxcTxi4/rCQUbPVdr/KAcJMG63wky6YRHOaAtP9W
         okDqNM6saV2ht5+Ci5BNVHL56jpxOz4++QEPHAj9SjM7xXZ1Uah76SD6Z5dj9AJatN1L
         cAiPkK+1mVf2GT0XOhu9iIvEVOW0lmp/yOZRQ=
Received: by 10.140.255.19 with SMTP id c19mr1298313rvi.24.1248341073294; Thu, 
	23 Jul 2009 02:24:33 -0700 (PDT)
In-Reply-To: <20090723085125.GL4750@laphroaig.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123862>

On Thu, Jul 23, 2009 at 10:51 AM, Pierre Habouzit<madcoder@madism.org> wrote:
> Or use git cherry

I tried, but I was under the impression git patch-id also hashes the commit
message - or I got something else typed wrong 'cause it didn't seem to work
:-/

You are right, the solution is:
 git cherry head1 head2 tag2
 git cherry head2 head1 tag1
and cherry-pick all lines prefixed with + to the other branch.

Thanks,
Martin
