From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] rev-list: heed --abbrev-commit option
Date: Sat, 27 Mar 2010 14:30:28 +0100
Message-ID: <4BAE0874.6090603@drmicha.warpmail.net>
References: <4BA76BDF.6060106@drmicha.warpmail.net> <b1b0f22cf3dc6d67f6094e761a1b7402b1471e97.1269264868.git.git@drmicha.warpmail.net> <7vk4sylvzj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eli Barzilay <eli@barzilay.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 27 14:30:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvW5i-0006iE-2o
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 14:30:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240Ab0C0NaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 09:30:11 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:43445 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753087Ab0C0NaK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Mar 2010 09:30:10 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 16CDEE91A0;
	Sat, 27 Mar 2010 09:30:09 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Sat, 27 Mar 2010 09:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=NbiqNxCvOfxQ976By/WDevNiZoI=; b=Y7P08Jn+Cx6MGa+c53Za4fMZ3lakoY/jYYPucg1D9669OTapRdlZVyOFnn1hFA5UkH9freUUyums0hkKXLjhks1r1QJCTECdJgrd6eXsmFYa2/HRzl9R4MkPpgXkzi4BfH7LFn80FPW/Dw+Op68uDsCF/BnnXLhY7eZzhY2I87A=
X-Sasl-enc: rscmKMEVgfiR1SsugvbTSMXbvjIAtkTLw0v6G8Uy9arl 1269696608
Received: from localhost.localdomain (p3EE29A92.dip0.t-ipconnect.de [62.226.154.146])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2DBF8AD5D;
	Sat, 27 Mar 2010 09:30:08 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10pre) Gecko/20100319 Lightning/1.0b2pre Shredder/3.0.5pre
In-Reply-To: <7vk4sylvzj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143330>

Junio C Hamano venit, vidit, dixit 26.03.2010 20:32:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Currently, rev-list has a default of "0" for abbrev which means that
>> switching on abbreviations with --abbrev-commit has no visible effect,
>> even though the option is documented.
> 
> Hmm, I actually think this was deliberate.  rev-list is designed to be a
> low level machinery for getting full object names, and in that context,
> setting the default abbreviation length to "don't abbreviate" gave us some
> safety, with additional safety of requiring a separate --abbrev-commit
> option to affect the main "show the commit object names" codepath (the
> latter of which would not likely to change).  The caller sets explicitly
> how long an output it wants (see git-rebase--interactive for an example).

My thinking was that unless --abbrev-commit is specified, nothing is
abbreviated, so that one has reproducible (plumbing) behaviour.

I learned that --abbrev= implies --abbrev-commit, but again, this means
explicitly requiring non-plumbing behavior.

> 
> Having said that, I don't think this would break existing scripts, so
> let's queue it and see what happens.

OK!
Michael
