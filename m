From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH v3] Re: git-am: fix maildir support regression: accept
	email file as patch
Date: Thu, 16 Jul 2009 04:59:21 +0200
Message-ID: <20090716025921.GE12971@vidovic>
References: <1654b578a7e045b564c46df4abb6e2196422c2b2.1247696294.git.nicolas.s.dev@gmx.fr> <7v1voheevy.fsf@alter.siamese.dyndns.org> <7vfxcxcxg1.fsf@alter.siamese.dyndns.org> <20090716010001.GC12971@vidovic> <7vfxcxbbqw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 04:59:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRHC1-0003mT-BE
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 04:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757232AbZGPC71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 22:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757230AbZGPC71
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 22:59:27 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:44481 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757222AbZGPC70 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 22:59:26 -0400
Received: by ewy26 with SMTP id 26so4525078ewy.37
        for <git@vger.kernel.org>; Wed, 15 Jul 2009 19:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=xRfnHa7iHnor88iNwhUUUUbOpgTWg43CUb8bw9jgp64=;
        b=P9Cp7QSizuQTMOQsLNDM+26Rg3aaqEzcbEzAxVCIFte6gyXMfmMqxUjTdPOknic3gO
         Q6g8r/QqKfASnlvnttSG4TZN1An60CzqX80VOMLo/2M5bf+cZ+tAMeHXBVzT5q8taZxZ
         cSDv/IOCtxOFIgDW4unm98rN5W1Yc3nKGwo6A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=VmZNq0n6BU2syFJvoXp8CoUotCGT2KNoyhTO24hnw/eeGBN5ggmTObXRWuQv7tqRNT
         Q6JjKwDvgPgUFQU4tAncKcdoDy6hXxoqbEURd5r70PXswUKxEKvNhifH27CdeB0dIDwn
         6Rjx2iLXno1k0rQA/LAwzRV93Twlvse1Ooa/U=
Received: by 10.210.81.9 with SMTP id e9mr10229280ebb.42.1247713165085;
        Wed, 15 Jul 2009 19:59:25 -0700 (PDT)
Received: from @ (91-164-136-30.rev.libertysurf.net [91.164.136.30])
        by mx.google.com with ESMTPS id 23sm3074692eya.49.2009.07.15.19.59.23
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 15 Jul 2009 19:59:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vfxcxbbqw.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123358>

The 15/07/09, Junio C Hamano wrote:
> Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:
>
> So I do not think there is any breakage that rejects good input with his
> patch.

Exact. It broke my workflow (at least) and was able to do it because the
previous git-am was permiting it. Looking closer to the code made me
understand where I was wrong.

> I am not opposed to add support for individual pieces of e-mail without
> forcing them to be in Berkeley mbox format.  Not everybody uses mbox
> format, and it is a logical thing to do.  Also I do not think the amount
> of new code necessary to do so is excessive, nor such a change is risky
> even late in a cycle after -rc0.

Will do, then.

> I however _do_ have issues with labeling other's patch that did not break
> any documented behaviour as a regression, even if it is to get extra
> attention to the issue.  That's not how we do things.

Of course. As we was able to do more than documented, I did not see it
in first place. It's a wrong assumption coming from my initial
git-bisect, some "hidden" globbing shell, and my learning curve of the
current code.

It is _NOT_ in my intention to blame anyone.

-- 
Nicolas Sebrecht
