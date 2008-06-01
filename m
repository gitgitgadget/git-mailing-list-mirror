From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH v3] perl/Git.pm: add parse_rev method
Date: Sun, 01 Jun 2008 19:38:00 +0200
Message-ID: <4842DE78.7000006@gmail.com>
References: <1212241932-28605-1-git-send-email-LeWiemann@gmail.com> <1212290243-19393-1-git-send-email-LeWiemann@gmail.com> <1212290243-19393-2-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 19:39:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2rWF-00016m-Uj
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 19:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbYFARiG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 13:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbYFARiF
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 13:38:05 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:31813 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbYFARiE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 13:38:04 -0400
Received: by fg-out-1718.google.com with SMTP id 19so549972fgg.17
        for <git@vger.kernel.org>; Sun, 01 Jun 2008 10:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=eUUSDEc2YrMu3fzbXItgplmH4yBjbU6svhZ25Qsayeg=;
        b=e9V97vG9imImXoEP4n9CWVSK0d82DxMmgVeWLHLIN2r4duCFYHs3xr/fqkDR8c9HZUDvS2mWquZlZjaNZcpOG7ccvVgZjT3Yu948UhbNukF8BjvPF1HQ8t1D3StvXAYbTc43SGV0pbrIPsG1jC4gyLNhkLFVxjWSUNopEdtjNa4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=uGi/3BPNSKLFine+/YI8SCclXNift/8YFCaDxIs39iqZjI0Ttb5ZFikpXdgU+xPCh8qcSAsFlSPMmN67ScYEqxv1JLFhEHvRS6KvzMM+P+A1Hi9/B/OCS8rDVroQbcNV4DcqwfLvXU+AvGd1CKknH7OX7eAy3S4o2ULGb/QCjM0=
Received: by 10.86.25.17 with SMTP id 17mr79859fgy.63.1212341882857;
        Sun, 01 Jun 2008 10:38:02 -0700 (PDT)
Received: from ?192.168.23.50? ( [91.33.205.25])
        by mx.google.com with ESMTPS id g28sm7844711fkg.1.2008.06.01.10.38.00
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 01 Jun 2008 10:38:01 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <1212290243-19393-2-git-send-email-LeWiemann@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83453>

Lea Wiemann wrote:
> Re: [PATCH v3] perl/Git.pm: add parse_rev method
>
> The parse_rev method takes a revision name and returns a SHA1 hash,
> like the git-rev-parse command.

I just discovered that you can also pass tree and blob identifiers to 
git-rev-parse, like <commit>:<path>.

Hence, perhaps this method would be more appropriately named get_hash 
(or get_sha1), given that you can pass in things other than revisions. 
I'll probably post new patch versions soon.

Terminology question: Is there *any* kind of agreed-on name for the 
identifiers you pass into git-rev-parse (like HEAD^2 or 
master:test/foo.txt)?  I called it "revision name" before, but that's 
wrong for the "...:<path>" syntaxes, and "object identifier" is reserved 
for hashes only (according to the glossary).  If there no better 
suggestions, I'll probably go for "extended identifiers", since 
rev-parse --help calls this the "extended SHA1 syntax", and it also 
seems to be an unused term.

-- Lea
