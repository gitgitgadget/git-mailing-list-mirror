From: Andrew Wong <andrew.w@sohovfx.com>
Subject: How to manage multiple repos using submodules?
Date: Sat, 16 Apr 2011 12:45:27 -0400
Message-ID: <4DA9C7A7.4010503@sohovfx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 18:45:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QB8d1-0003Ua-N2
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 18:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997Ab1DPQpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2011 12:45:35 -0400
Received: from smtp03.beanfield.com ([76.9.193.172]:52565 "EHLO
	smtp03.beanfield.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472Ab1DPQpe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 12:45:34 -0400
X-Spam-Status: No
X-beanfield-mta03-MailScanner-From: andrew.w@sohovfx.com
X-beanfield-mta03-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-2.9, required 6, autolearn=not spam, ALL_TRUSTED -1.00,
	BAYES_00 -1.90)
X-beanfield-mta03-MailScanner: Found to be clean
X-beanfield-mta03-MailScanner-ID: 1QB8ch-000FZr-V5
Received: from [99.231.190.188] (helo=ZanarkandMac.local)
	by mta03.beanfield.com with esmtpsa (TLSv1:CAMELLIA256-SHA:256)
	(Exim 4.72)
	(envelope-from <andrew.w@sohovfx.com>)
	id 1QB8ch-000FZr-V5
	for git@vger.kernel.org; Sat, 16 Apr 2011 12:45:28 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171679>

It seems like submodule isn't meant for this, but many people seems to 
use submodule to link many smaller repos together. With this setup, I 
imagine whenever someone pushed a small repo, they're /supposed/ to push 
the big repo as well. This way, if I simply update the big repo and do a 
"git status", git will tell me that which of the smaller repos are out 
of date. However, this is only reliable if everyone remembers to push 
the big repo. If someone pushed a smaller repo, but forgot to push the 
big repo, then I won't be aware that some of the smaller repos are 
out-of-date until I push.

I suppose one way is to do a check/auto-update with pre/post commit 
script to enforce that the big repo is always up-to-date. Another way is 
to use the "submodule foreach" to do a fetch and status on smaller ones, 
but this doesn't seem very elegant.

So, I'm wondering how do people who use submodules this way manage all 
their repos? Or how to (reliably) get a good sense of the state of the 
small repos? Or maybe I shouldn't be using submodules this way at all?
