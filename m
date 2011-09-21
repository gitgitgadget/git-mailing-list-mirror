From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 3/3] git-read-tree.txt: correct sparse-checkout and skip-worktree
 description
Date: Wed, 21 Sep 2011 11:33:11 +0200
Message-ID: <4E79AF57.3010300@drmicha.warpmail.net>
References: <cover.1316590874.git.git@drmicha.warpmail.net> <4E7996AA.4040909@drmicha.warpmail.net> <31152a2ddb83e37be1efce1d0cd742b71ea3efdd.1316590874.git.git@drmicha.warpmail.net> <CACsJy8BrBsBM-DwC_CkYrrpFU6aTqpcohWDPxTnRhMEX+w3Nug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Joshua Jensen <jjensen@workspacewhiz.com>,
	Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 21 11:33:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6JBV-0003eq-Vy
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 11:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427Ab1IUJdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 05:33:15 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:37916 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753374Ab1IUJdO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2011 05:33:14 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway2.nyi.mail.srv.osa (Postfix) with ESMTP id 055B8298EC;
	Wed, 21 Sep 2011 05:33:14 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute6.internal (MEProxy); Wed, 21 Sep 2011 05:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=6BU4pkTNISPrH1vmYpBgsn
	rMUKM=; b=jwEr65HAi11DoCA6JTL154VgqZ7ad3XqClnWqUhrGntxJSyTn1tHE8
	7Uola07NObB0Tx6ZqrLiKYKES76/+m5sfMaYN4Ag7rRaolx7prSFGE/ng6Q39RHq
	5E6yynes2EdgOfXDmJUKzbFjKHe8670WY70Zr9V3wIixVKWR9ZqTw=
X-Sasl-enc: 1pFDPtE1OuFN0bXDOiDHMnQgcrGT2J3QvxAs9SQt1ejT 1316597593
Received: from localhost.localdomain (p548594C9.dip0.t-ipconnect.de [84.133.148.201])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2049D7C0733;
	Wed, 21 Sep 2011 05:33:12 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0.2) Gecko/20110906 Thunderbird/6.0.2
In-Reply-To: <CACsJy8BrBsBM-DwC_CkYrrpFU6aTqpcohWDPxTnRhMEX+w3Nug@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181831>

Nguyen Thai Ngoc Duy venit, vidit, dixit 21.09.2011 11:26:
> On Wed, Sep 21, 2011 at 5:48 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> The description of .git/info/sparse-checkout and
>> skip-worktree is exactly the opposite of what is true, which is:
>>
>> If a file matches a pattern in sparse-checkout, then (it is to be
>> checked out and therefore) skip-worktree is unset for that file;
>> otherwise, it is set (so that it is not checked out).
>>
>> Currently, the opposite is documented, and (consistently) read-tree's
>> behavior with respect to bit flips is descibed incorrectly.
>>
>> Fix it.
> 
> Ack.
> 
>> In hindsight, it would have been much better to have a "sparse-ignore"
>> or "sparse-skip" file so that an empty file would mean a full checkout,
>> and the file logic would be analogous to that of .gitignore, excludes
>> and skip-worktree.
> 
> .gitignore works towards excluding files. No rule means no excluding.
> sparse-checkout file works towards including files, no rule means no
> inclusion.

Sure, but with a "sparse-skip" rather than "sparse-checkout", we would
not even need an additional config variable, and the skip-worktree
centered explanations would follow the same logic (no need for the
additional negation) as the ignore files and the new sparse-skip file.
Also, I'm not sure whether more sparse users say "I want only that
subdir." than "I don't want that subdir."

But it's there to stay, of course.

Cheers,
Michael
