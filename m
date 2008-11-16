From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 05/11] gitweb: git_split_heads_body function.
Date: Sun, 16 Nov 2008 15:21:53 +0100
Message-ID: <200811161521.53993.jnareb@gmail.com>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com> <200811161312.50090.jnareb@gmail.com> <cb7bb73a0811160426g1e56faa7ia9b1f398fea039a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Petr Baudis" <pasky@suse.cz>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 15:23:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1iX0-0007pl-2L
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 15:23:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbYKPOWF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 09:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752016AbYKPOWE
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 09:22:04 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:10648 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001AbYKPOWB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 09:22:01 -0500
Received: by ug-out-1314.google.com with SMTP id 39so224234ugf.37
        for <git@vger.kernel.org>; Sun, 16 Nov 2008 06:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=bWWyqI4/NeYFvmnLuKbKSh6ShN//HkOzSsrAOg5cRkc=;
        b=t5qNj8LwIlzDjZ/CoH4q3IXKoYXeIFteNlmGNldO8bhoaKnAFrzsRwvp+1x68deJeW
         wFspHNF3vhMCq+oOJ0EFc4aEt6IMbKEozOFCo2sHLMiAVTXI7scc/ZNe1B7Hd7RtbxKe
         oI7TAdPAJcOotVsUzCmSZJM0mtJ8xOqwcE8uM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=f+SkgOtDhVDGN1H1HBm86uGbOr2mWfYV9GdKf8zvsljJzHbdxAM4mXf7OSBkoSZ5YT
         Cje8u+GAZ6Q/Krw8UQ6KTWRA7BjPSRqqKMJrTAdx18tRokm8SHFA7UH9I1AZkYewVDXM
         pBf2HtiH/S5KpU9QCEBieL+uQQkZoI+9byzIE=
Received: by 10.210.70.14 with SMTP id s14mr2982652eba.197.1226845319171;
        Sun, 16 Nov 2008 06:21:59 -0800 (PST)
Received: from ?192.168.1.11? (abwa41.neoplus.adsl.tpnet.pl [83.8.224.41])
        by mx.google.com with ESMTPS id 5sm2613352eyf.8.2008.11.16.06.21.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 16 Nov 2008 06:21:58 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0811160426g1e56faa7ia9b1f398fea039a8@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101133>

Giuseppe Bilotta wrote:
> On Sun, Nov 16, 2008 at 1:12 PM, Jakub Narebski <jnareb@gmail.com> wrote:

>> The problems with nesting is those pesky remotes with only single
>> tracked branch to them; they are I think quote common... well, unless
>> you do one-shot pull, directly into local branch.
> 
> My idea with this would be to only create a group if it has at least
> N > 1 (probably N=2) entries.

A bit of complication is that you would have then series of
'uncategorized' (not in any subsection) entries / remote-tracking
branches.

>> All that said, splitting 'remotes' section is difficult; using first
>> dirname as section is probably easiest, and good enough in most cases.
>> That is why I think this part should be put into separate series, to
>> not hinder rest of patches.
> 
> Yes, I will resend the 'remote_heads' feature as a new (reduced)
> patchset, then add (separate patchset) grouping for ref lists, and
> then add (yet another patchset) detached head.

That is I think a good idea.

P.S. I think that sending this patch series for review, even if it was
not perfect was a very good idea... well, perhaps some patches could
be marked as RFC.

It is hard work to prepare good patches, then wait for review, then
wait a bit that there is no further review, working on the patches,
resend and wait for review, or for Ack and merge-in... Keep up good
work.

-- 
Jakub Narebski
Poland
