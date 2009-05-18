From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: Merging a branch when I don't want conflicts
Date: Mon, 18 May 2009 19:45:48 +0900
Message-ID: <20090518194548.6117@nanako3.lavabit.com>
References: <93c3eada0905171930m36765d4fued9c2efdc57e51a4@mail.gmail.com>
	<4A10FDC6.2040706@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: geoffrey.russell@gmail.com, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon May 18 12:46:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M60Md-0001iu-WB
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 12:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756039AbZERKqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 06:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755770AbZERKqW
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 06:46:22 -0400
Received: from karen.lavabit.com ([72.249.41.33]:39830 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755902AbZERKqV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 06:46:21 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id CDB8C11B882;
	Mon, 18 May 2009 05:46:21 -0500 (CDT)
Received: from 8269.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id VN85UDN7J15P; Mon, 18 May 2009 05:46:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=T+5lgXRXWXk8+gwRFv6ylLzSh9X9ZzmNiSOD2zKUYWw8n4nH2Nw/OHHJvm6UCq8J2tE1bVRxMABdvmLDtF6gheSbGhXLrM0rjkt6ygMkPNGzajd2rOL7Plk6lPHx4DYElTnu1GTkuVkLWB4oW8AUPvNMCUQYrAC/bmbC/s/DfL8=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <4A10FDC6.2040706@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119437>

Quoting Johannes Sixt <j.sixt@viscovery.net>:

> Geoff Russell schrieb:
>> How do I merge a branch X into my master and tell git that whenever there
>> is a conflict, the file on X should prevail?  This is for a scripted
>> application.
>
> I assume you talk about file-level (content) merges.
>
> There is no such tool, and the reason is that what you try to do here does
> not make sense *in general*. It must be a very special kind of project
> where you can blindly trust one side over the other if there are
> conflicts, and that you can additionally trust non-conflicting content merges.
>
> The best you can do is perhaps to pipe conflicting files through
>
>     sed -e '/^<<<<<<</,/^=======/d' -e '/^>>>>>>>/d'
>
> -- Hannes

I think -Xours enhancement that was developed long time ago

    http://thread.gmane.org/gmane.comp.version-control.git/76650/focus=89021

should help Geoff's use case.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
