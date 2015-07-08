From: Colin Walters <walters@verbum.org>
Subject: Re: weaning distributions off tarballs: extended verification of git
 tags
Date: Wed, 08 Jul 2015 00:00:49 -0400
Message-ID: <1436328049.1937003.317969577.6CBA24A0@webmail.messagingengine.com>
References: <1425134885.3150003.233627665.2E48E28B@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 08 06:00:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCgXY-0002x3-0f
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 06:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbbGHEAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 00:00:51 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:60553 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750713AbbGHEAu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jul 2015 00:00:50 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id A32A620737
	for <git@vger.kernel.org>; Wed,  8 Jul 2015 00:00:49 -0400 (EDT)
Received: from web2 ([10.202.2.212])
  by compute1.internal (MEProxy); Wed, 08 Jul 2015 00:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=Cc53Kv/bfz+ymkc
	watzQb06Pkww=; b=qHrI3qeTSlDt6VRLWOMsz84shtWvI7AfUojiTyMfUEQJZzG
	skGYz3y2xnX/Hrh8jlyLVMfw6O87gPawX+kws50uO4NPl1M4OFeKlv0hNx/oKYbg
	9B6o34mJBwF34XVhiQx/31yEtyqwrQzg0veA3EZE7/+Y69FIKapF7QLi5b5Y=
Received: by web2.nyi.internal (Postfix, from userid 99)
	id 648B25400BC; Wed,  8 Jul 2015 00:00:49 -0400 (EDT)
X-Sasl-Enc: r9jDAGAs+ACe4vUJppPnqiYgf57saJrYlsxrpWv7yKHo 1436328049
X-Mailer: MessagingEngine.com Webmail Interface - ajax-bfc056ae
In-Reply-To: <1425134885.3150003.233627665.2E48E28B@webmail.messagingengine.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273633>



On Sat, Feb 28, 2015, at 10:48 AM, Colin Walters wrote:
> Hi, 
> 
> TL;DR: Let's define a standard for embedding stronger checksums in tags and commit messages:
> https://github.com/cgwalters/homegit/blob/master/bin/git-evtag

[time passes]

I finally had a bit of time to pick this back up again in:

https://github.com/cgwalters/git-evtag

It should address the core concern here about stability of `git archive`.

I prototyped it out with libgit2 because it was easier, and I'd like actually to be able to use this with older versions of git.

But I think the next steps here are:

- Validate the core design
  * Tree walking order
  * Submodule recursion
  * Use of SHA512
- Standardize it
  (Would like to see at least a stupid slow shell script implementation to cross-validate)
- Add it as an option to `git tag`?

Longer term:
- Support adding `Git-EVTag` as a git note, so I can retroactively add stronger
  checksums to older git repositories
- Anything else?
