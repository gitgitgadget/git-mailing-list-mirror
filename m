From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] tests: test terminal output to both stdout and stderr
Date: Wed, 13 Oct 2010 22:27:34 -0500
Message-ID: <20101014032734.GC14664@burratino>
References: <20101014030220.GB20685@sigill.intra.peff.net>
 <20101014030443.GB5626@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Chase Brammer <cbrammer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 14 05:32:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6EYf-00071Z-Pf
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 05:32:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754473Ab0JNDci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 23:32:38 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64528 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754451Ab0JNDci (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 23:32:38 -0400
Received: by gyg13 with SMTP id 13so494585gyg.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 20:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=+qiq/agTnOXl8ePr4+o0VZ1N5/xwxiKJ+TKTUHvCAqk=;
        b=kIHEXzNdX5CmOeyg8a5FZTK40uxS4NrNIkU8IZxz/Xfkk3UOQy9hLdFtc5Rp130p3Z
         AW5A1nc72bBjJyy2gawYNbcZprcv4fXZmFBes0XjjTaWHnooS8cUE1GKmC1qRr8d9DOn
         CxjGOxQqEIzMrD1mvZVeH5O8iWQkvo7D5eRzY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=IZqjD8nygklTN5ZoWfXMP82KLiBfuO7qsI7f6CKKYYT4GhUJ5wG1xrk17HFZ0BDFZW
         8wZQ7xP9NDoWvmJhxVRD3UmFuz40tqpc1GQeKPy6I7L31SkB4RMeekQL0dODvvporiYU
         i9qceEJU/W/0pDxqnXK9RlpxKJbtLCzpkv97o=
Received: by 10.150.49.18 with SMTP id w18mr2381036ybw.246.1287027058230;
        Wed, 13 Oct 2010 20:30:58 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id k8sm2862924yha.9.2010.10.13.20.30.56
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 20:30:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101014030443.GB5626@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159021>

Jeff King wrote:

> Some outputs (like the pager) care whether stdout is a
> terminal. Others (like progress meters) care about stderr.
> 
> This patch sets up both. Technically speaking, we could go
> further and set up just one (because either the other goes
> to a terminal, or because our tests are only interested in
> one).

This makes test_terminal more realistic, too: the usual case is for
stdout and stderr to go to a terminal (unless explicitly captured or
redirected).

Tests can use 'test_terminal sh -c "foo >/dev/null"' to test that a
command correctly handles being run with stderr a terminal and
stdout not.

And I doubt this would make test_terminal much slower.

So for what it's worth:
Acked-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
