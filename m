From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git User's Survey 2009 - trial run
Date: Fri, 26 Jun 2009 19:00:47 +0200
Message-ID: <200906261900.48310.jnareb@gmail.com>
References: <200906252122.51737.jnareb@gmail.com> <665CFE02-78DC-49E5-A9F2-9A614691FBAE@kace.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Graham Perks <graham@kace.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 19:01:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKEnb-0003Iy-RB
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 19:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757602AbZFZRA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 13:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756807AbZFZRAz
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 13:00:55 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:64460 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbZFZRAy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 13:00:54 -0400
Received: by fxm9 with SMTP id 9so2225025fxm.37
        for <git@vger.kernel.org>; Fri, 26 Jun 2009 10:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ExMctAKSeRuEOh7fx3FQraNjc6hgfabL3vR2nncGcJU=;
        b=a4aMb6eN002BVBXd5ep7/OYxtADfQ8ymCSlGqlw31z5AXrwXBAEK6VumKqpDWjHV87
         NpdilJc1JTa5jh3UG9zIhGlrUw9S1xtgI/ye5EXG0tYVM6Ic1xEAjiS/UoXWGnQBJWLV
         QOm5gNh3vOoPeIAb9AMknNk1UWnDE5t+yaT4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=jxwWBbuoU+Z0d3Pqrt03g5EN/+TxieVU/3O71OicqSQxXm45Mou09DEqLxRk98s5DG
         LvsuUM+MClGC+WEwPVnOzdLJEgcmXDPJaf2cTrIaSxZkYItZM7n11IaF8Jxqotx1fEos
         5qKRVAXOk1oSN69ULYR/otUFLdzfcc8I5cLf0=
Received: by 10.103.217.7 with SMTP id u7mr2412952muq.11.1246035656285;
        Fri, 26 Jun 2009 10:00:56 -0700 (PDT)
Received: from ?192.168.1.13? (abwa104.neoplus.adsl.tpnet.pl [83.8.224.104])
        by mx.google.com with ESMTPS id j10sm17529356mue.29.2009.06.26.10.00.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Jun 2009 10:00:55 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <665CFE02-78DC-49E5-A9F2-9A614691FBAE@kace.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122307>

On Fri, 26 June 2009, Graham Perks wrote:

> Some comments on the survey:
> 
> Q14. I got confused on. "How do you fetch from <an> upstream  
> repository?"
> 
> Firstly, the word "an" is missing from the question.

Actually originally it was only "How do you fetch from upstream?", 
and it should be "How do you fetch from upstream repositories?".
One can follow more than one git repository.

> Secondly, the first two options are "git protocol" and "ssh". We use  
> git:// over ssh. So I don't know how to answer this.

"git protocol" was meant to be about connecting to git-daemon 
(anonymous, unauthenticated, port 9418), i.e. using URL like
"git://git.example.com/repo.git" for fetch/clone.

"ssh" was meant to be about running git-upload-pack via SSH, 
which means connecting to sshd/ssh daemon (authenticated, 
usually port 22).  This means URL like "ssh://example.com/srv/git/repo.git"
or "user@example.com:/srv/git/repo.git" (or ssh+git:// or git+ssh://).
Tunneling connection to git-daemon over SSH is not "ssh" in this
sense.

I'll try to explain this in 'footnotes' for this question, and use
example URLs to make it more clear how should one answer this question.

> 
> Q15, How do you publish?
>
> We sometimes use git format-patch and email out. Since we're on  
> Exchange, we can't use git am to pull directly from the email. We have  
> to save the patch files and "git am < 0001.change.patch". I don't see  
> an option that separates this usage out from how git am was  
> (seemingly) designed to work, directly against the mail server.

If you use git-format-patch (or equivalent) and send patches via email,
you should tick 'git format-patch + email' answer. It does not matter
how it is applied on the other side; only what you as sender do is
important.

I''l try to come with some explanation about this.


Thank you very much for your help in improving this survey!
-- 
Jakub Narebski
Poland
