From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] gitweb: recognize six digit abbreviated SHA1
Date: Tue, 13 Jan 2009 15:00:55 +1300
Message-ID: <496BF5D7.2090003@vilain.net>
References: <87mydw2hrb.fsf@cup.kalibalik.dk> <87mydw2hkb.fsf@cup.kalibalik.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jnareb@gmail.com, gitster@pobox.com
To: Anders Melchiorsen <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Tue Jan 13 03:02:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMYbt-000891-Oo
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 03:02:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511AbZAMCBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 21:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556AbZAMCBF
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 21:01:05 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:34449 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751480AbZAMCBE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 21:01:04 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 29CD021C779; Tue, 13 Jan 2009 15:01:02 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 8E46D21C55F;
	Tue, 13 Jan 2009 15:00:56 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <87mydw2hkb.fsf@cup.kalibalik.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105440>

Anders Melchiorsen wrote:
> Anders Melchiorsen <mail@cup.kalibalik.dk> writes:
>
>   
>> +	if ($line =~ m/([0-9a-fA-F]{7,40})/) {
>>     
>
> I could not make up my mind between the seven digits from "git
> rev-parse --short" and the six digits currently used by gitk.
>
> So I put one option in the patch, and the other one in the subject.
>   

I think if you're going to go so short as 6 digits, it's probably worth
making sure that the really short SHA1s check commits only. eg, if
you've got a commit 'fa023473' and a tree 'fa023421', then 'fa0234'
should match the commit and not the tree. But I don't think there's a
plumbing way to do a query like that at the moment.

Even git.git isn't unique over 6 digits, even restricting to commits.
Not since b0a3de ;-).

Sam
