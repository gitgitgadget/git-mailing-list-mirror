From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 2/2] commit/status: show the index-worktree diff with
 -v -v
Date: Wed, 04 Mar 2015 12:11:59 +0100
Message-ID: <54F6E87F.2010605@drmicha.warpmail.net>
References: <54B8C82E.8000707@drmicha.warpmail.net>	<33591b47a7ea8cfa23a3bee05fbf8c0ce4a00b3d.1425390756.git.git@drmicha.warpmail.net> <xmqqmw3tai1q.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ivo Anjo <ivo.anjo@ist.utl.pt>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 12:12:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT7Dl-0000bt-TX
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 12:12:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758557AbbCDLME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 06:12:04 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:55877 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758553AbbCDLMC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Mar 2015 06:12:02 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 5B180209E6
	for <git@vger.kernel.org>; Wed,  4 Mar 2015 06:12:00 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Wed, 04 Mar 2015 06:12:01 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=b9Kt64+Wgs3fuGqi5EP+wE
	TO8FM=; b=Lguyo3tIXsupNjOAgk4GmbnvY0pBrwlD5Fpjlg6hkf5nb8kneIJB5n
	5HlOU0MW4is/rV4Zf+7+vc/igqZse2b6YSJSw7ENk4FHwISAmCBf+fEcM9cOPgEP
	SYLkKM6ygxP534BT7UtVP6nOHLQNEzKYh5+ouZAVqOLtynpkKHrX0=
X-Sasl-enc: gUie+V0tfvfqfeUjOoRgAqlvIyYszuyCd8BV/dcLZuQp 1425467521
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id BB4F768017E;
	Wed,  4 Mar 2015 06:12:00 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <xmqqmw3tai1q.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264751>

Junio C Hamano venit, vidit, dixit 03.03.2015 22:26:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> +diff --git INDEX=staged-for-commit/dir1/modified WORKTREE=not-staged-for-commit/dir1/modified
>> +index e69de29..d00491f 100644
>> +--- INDEX=staged-for-commit/dir1/modified
>> ++++ WORKTREE=not-staged-for-commit/dir1/modified
> 
> This might be OK for a project like Git itself, but I suspect people
> with long pathnames (like, eh, those in Java land) would not
> appreciate it.
> 
> Wouldn't mnemonic prefix, which the users are already familiar with,
> be the most suitable tool for this disambiguation?  After all that
> was what it was invented for 8 years ago.

Well...:

> or it may want to even be like this:
> 
> 	diff --git a/A b/A
>         ...
>         diff --git to-be-committed/A left-out-of-the-commit/A
>         ...
>         diff --git a/B b/B
>         ...
> 
> by using a custom, unusual and easy-to-notice prefixes.

Your idea was to use these verbous prefixes so that one recognizes the
different types of diffs, and so that we don't need to sort them by file.

I'm happy with c/,i/ and i/,w/ and without sorting. Maybe we would need
headings between the two diffs then?

HEAD/,INDEX/ resp. INDEX/,WORKTREE/ would be a shorter alternativ that
is inline with the short acronyms execept for c/, because COMMIT/
(withiut "base") would be misleading during commit -v, I'm afraid.

Michael
