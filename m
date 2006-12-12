X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Tracking a repository for content instead of history
Date: Wed, 13 Dec 2006 04:46:10 +0700
Message-ID: <fcaeb9bf0612121346s3c82bcdbh522c17f4ae9f279b@mail.gmail.com>
References: <200612121235.09984.andyparkins@gmail.com>
	 <200612121326.24508.andyparkins@gmail.com>
	 <Pine.LNX.4.63.0612121527070.2807@wbgn013.biozentrum.uni-wuerzburg.de>
	 <200612121538.41197.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 21:46:23 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dxm7vzTbigJmVr0+gPdxt0O/oqsaY9O7qfkvji5KYqx9ZN0YpNq0mpWtsDojipCi9l3jR+O4EGiNQDzSdRoRbhLJGNEBzcM/XfNS+to4vNddd7PfQCtRUCosb2hcpL99UhLVE/Iit4rX9y18puhnBNh3uLFUN2eoUHnIrtXfU8E=
In-Reply-To: <200612121538.41197.andyparkins@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34147>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuFS4-0006Az-Aa for gcvg-git@gmane.org; Tue, 12 Dec
 2006 22:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932442AbWLLVqN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 16:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWLLVqN
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 16:46:13 -0500
Received: from an-out-0708.google.com ([209.85.132.243]:17857 "EHLO
 an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932442AbWLLVqM (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec
 2006 16:46:12 -0500
Received: by an-out-0708.google.com with SMTP id b33so465067ana for
 <git@vger.kernel.org>; Tue, 12 Dec 2006 13:46:12 -0800 (PST)
Received: by 10.78.158.11 with SMTP id g11mr37812hue.1165959970942; Tue, 12
 Dec 2006 13:46:10 -0800 (PST)
Received: by 10.78.100.8 with HTTP; Tue, 12 Dec 2006 13:46:10 -0800 (PST)
To: "Andy Parkins" <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

On 12/12/06, Andy Parkins <andyparkins@gmail.com> wrote:
> I suppose so; but I was thinking more an automated way of getting the data
> that is supplied for the kernel anyway.  So:
>
> base-v1.0.0.tar.gz
> patch-v1.0.1.gz
> patch-v1.0.2.gz
> etc
>
> Each patch is obviously smaller than "base".  Git could easily make the
> patches, and each of those patches could be fed by hand into a repository
> with git-apply.  It doesn't seem like something that would require support on
> the other side, because it isn't so much a shallow clone (which /would/
> preserve history, making it available if wanted); it is pulling just, say,
> tagged commits out of an existing repository.
>
> Given a list of tags it is almost:
>
> git-archive <get me base>
> ssh remote git-diff v1.0.0..v1.0.1 | git-apply; git commit
> ssh remote git-diff v1.0.1..v1.0.2 | git-apply; git commit
>
> If that makes sense?  Obviously though it would be possible to use git rather
> than ssh to do this.

Hm.. I'm no git:// expert. But is it possible doing as follow?
1. git-archive <base>
2. reconstruct commit, blobs and trees from the archive
3. tell git server that you have one commit, you need another commit
(maybe heads only, i'm not sure here)
4. get the pack from git server, create new commit and a diff
-- 
