From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/5] strbuf: Introduce strbuf_fwrite corresponding to
 strbuf_fread
Date: Wed, 30 Mar 2011 21:15:14 -0500
Message-ID: <20110331021451.GA31090@elie>
References: <1301422392-21177-1-git-send-email-artagnon@gmail.com>
 <1301422392-21177-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Peter Baumann <waste.manager@gmx.de>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 04:15:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q57Q0-0005yG-20
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 04:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755562Ab1CaCPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 22:15:22 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40474 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755418Ab1CaCPW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 22:15:22 -0400
Received: by yxs7 with SMTP id 7so799511yxs.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 19:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=0f0xKrnTH6xRjPP4Rkdfo1ZAHusetvFevSuvN/ayg1c=;
        b=f9Q4U0+skjqNHXpBsrhg5H6zoIVy6P7kKeCiDrbpv6YYOFhUU9PFD4Mx4mU0EwFVhC
         20ilZuc344tsJtaQUiY5VZE13ibEeBcrTo8YksGCtupxWLRc+TQRxvHrZfdtpghf/bpq
         sYL/ENkcpbmz5Lbhjf4E2hDHGiKqC7NWeq4LI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=cYlAULJQIZKF7sUIzOKgGycA4XIN7xmtNg6yDf+ZLIqH4PeNkhYDBYowMcATbemoqw
         FxRF9YnFw9qVppFUHAk65hBjfNXDGLBVNQNPuGBZUOx4bwocTm2fBoaYvQA9ItAASZiN
         Heiv7Li7I/IhPcAs+6cKPXfauYjwBLiUdo7Sg=
Received: by 10.236.168.41 with SMTP id j29mr2751896yhl.321.1301537721515;
        Wed, 30 Mar 2011 19:15:21 -0700 (PDT)
Received: from elie (adsl-68-255-107-98.dsl.chcgil.ameritech.net [68.255.107.98])
        by mx.google.com with ESMTPS id x76sm367773yhn.94.2011.03.30.19.15.19
        (version=SSLv3 cipher=OTHER);
        Wed, 30 Mar 2011 19:15:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1301422392-21177-4-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170448>

Ramkumar Ramachandra wrote:

> [Subject: strbuf: Introduce strbuf_fwrite corresponding to strbuf_fread]
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

And why?  FWIW strbuf_fread takes care of (1) setting the size of sb
to accomodate the input, (2) starting reading at the end of the
current strbuf, and (3) freeing the buffer if nothing could be read,
so symmetry doesn't seem like a strong justification.

Which is not to say this is a bad change.  Just that it's hard to see
how it lives up to its goals without knowing what those goals are.
