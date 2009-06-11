From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH 1/2] http.c: prompt for SSL client certificate password
Date: Fri, 12 Jun 2009 08:42:09 +0900
Message-ID: <20090612084209.6117@nanako3.lavabit.com>
References: <1243480563-5954-1-git-send-email-lodatom@gmail.com>
	<ca433830906111600n2d45b5bdg3fb6e7c0a537ec78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 01:43:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEtvE-0000fM-Ct
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 01:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758805AbZFKXmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 19:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758497AbZFKXmy
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 19:42:54 -0400
Received: from karen.lavabit.com ([72.249.41.33]:41368 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757455AbZFKXmy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 19:42:54 -0400
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id E87A911B840;
	Thu, 11 Jun 2009 18:42:56 -0500 (CDT)
Received: from 5042.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id RH7D6UNQCPH0; Thu, 11 Jun 2009 18:42:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=5Ww72ynN5u1STrNWEjkaHVdDK+LScUu/rd5K+ap1E29wBY1WHaHLPSl9iJdHxfo2/YnE8XXU8UnZjGa68KV2ERTJL3ZsODbgf50jFNrNqqSO+Y4cNZRgvSZy/gKjvJshZcIORtCaFadeUlEXs9wblvwbLtBNakusDjleLQ3Rn6M=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <ca433830906111600n2d45b5bdg3fb6e7c0a537ec78@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121376>

Quoting Mark Lodato <lodatom@gmail.com>:

> Any other thoughts, one way or the other?  Adding proper SSL/PKI
> support would really help git adoption in the corporate world.  I am
> willing to make any changes necessary to get this into git.git.

Somebody mentioned that your patch forces people to type password even when the certificate isn't encrypted. How was this issue addressed?

It would be ideal if you can inspect the certificate and decide if you need to ask for decrypting password before using it (and otherwise you don't ask). If you can't do that, probably you can introduce a config var that says "this certificate is encrypted", and bypass your new code if that config var isn't set.

That way, people who are used to the old behavior don't have to change anything in their set-up.

If people didn't have to type password at all, and after your patch if they are forced to do something else to keep the old set-up working, that isn't nice.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
