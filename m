From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH/alternative/raw and rough] setup.c: denote repo wide pathspecs
 by ':'
Date: Tue, 01 Mar 2011 12:49:03 +0100
Message-ID: <4D6CDD2F.5070107@drmicha.warpmail.net>
References: <AANLkTi=xrnxUtkayyW1Merh49N6uHy5p-GMrYe6+p==t@mail.gmail.com> <bc49592f5e524a0d12aa55eeca1c5ca659b6525f.1298974647.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Tue Mar 01 12:52:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuO81-0007hn-OK
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 12:52:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756250Ab1CALw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 06:52:29 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:41459 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751011Ab1CALw2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Mar 2011 06:52:28 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 28F6E202D5;
	Tue,  1 Mar 2011 06:52:28 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 01 Mar 2011 06:52:28 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=e1KJb0TWM6Y1ciah4zXcGuljGm0=; b=FcwrJ+xsrERtoUsSPrTVpT6WwUy6gEj4ekdKyTxCIIISjh8JL7uMcin8pbatP8Z+t82foUrO6BHdNsug2Xm81/YiCq5tqMei1tiCa3Q8rshY2sMRUrbtrbGQ6M/HxfCYc8AVZJuriSqtQt+5Cji2B3Opoj54NpGZ5vmWpT6T+jQ=
X-Sasl-enc: 1iBLovGjUkTninR4bXFclyF+QeiavOfRnsToMVDlG3yX 1298980347
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 86AED4002AE;
	Tue,  1 Mar 2011 06:52:27 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <bc49592f5e524a0d12aa55eeca1c5ca659b6525f.1298974647.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168213>

Michael J Gruber venit, vidit, dixit 01.03.2011 11:21:
> Introduce a leading ':' as the notation for repo-wide pathspecs.
> 
> This is in line with our treeish:path notation which defaults to
> repowide paths.
> 
> Heck: Even ':./path' works for pathspecs, and I have no clue why!
> 
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> I have not tested this for adverse side effects, only for the intended ones
> with "git grep".

To follow up:

Of all callers of get_pathspec() (add, checkout, clean, commit, grep,
ls-files, ls-tree, mv, rerere, reset, rm), all work perfectly, except:

ls-tree seems to be special not only in this respect.

rerere I'm too dumb to test.

Even things like

git mv :Makefile Makefile

work and mv Makefile from the root to your current work dir!

This may even provide an alternative to switching some defaults to "repo
wide".

Michael
