From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] test-lib.sh - cygwin does not have usable FIFOs
Date: Sat, 13 Jul 2013 17:57:30 -0700
Message-ID: <20130714005730.GA21033@google.com>
References: <1372975470-13573-1-git-send-email-mlevedahl@gmail.com>
 <20130707005558.GI30132@google.com>
 <51DB3A9F.6020504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 14 02:58:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyAdX-0007T6-Ab
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 02:58:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089Ab3GNA5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jul 2013 20:57:49 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:47661 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748Ab3GNA5h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jul 2013 20:57:37 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so9732263pdj.0
        for <git@vger.kernel.org>; Sat, 13 Jul 2013 17:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xMtc108ygSSvR8bPFNSi5UGVsaELfInjlxoZw859ZJc=;
        b=TIgnDR98MsPZgWrT1ZAoR6/oQLtr4B3Iyg9WeR+iZFlDsgw0BqB41mThjL4zcPdadd
         y/v2d4KILCpI1k3hk9gnjVJoOb1rO8A11nOeF24UL17jr/TXOsyLazYph+UuTw+XJdAJ
         DG+j6750FDd1byUyT3t6M2tpLTEYa2wHuqyvbzgvSZ8PqR+7YSASmjWgRRGeB/QJFzCm
         nzMmipsLS8iqyx3iKOFAlLRJIzpw+jryfdDPTpgD+b4+tnRfnMKaMRijKIOYWwSrUfah
         rWGSwmpLbDhljUUCPtApYsYAbU/GD71otgL5zbloaFiPa8VUrVeGFWmtaplm7G7FEkUv
         apcg==
X-Received: by 10.66.25.10 with SMTP id y10mr48910537paf.96.1373763457063;
        Sat, 13 Jul 2013 17:57:37 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id il4sm20691726pbb.36.2013.07.13.17.57.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 13 Jul 2013 17:57:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51DB3A9F.6020504@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230296>

Mark Levedahl wrote:

> However, I don't understand why git would need to consume its own
> output - If named pipes are really needed to use git-svn because
> git-svn depends upon git feeding the same git process, then that
> package should not be available on cygwin or any other platform that
> does not support fifos.

This isn't about git-svn but about the svn remote helper.  The same
considerations would apply to any other foreign repository importer
that uses "git fast-import --cat-blob-fd".  So I would like to make
sure it is at least possible to support such a thing in the Cygwin
and mingw ports.

>                          If not, then I don't think the test suite
> should require fifos or any other construct with the same git
> process feeding itself either, it just blurs the line about what is
> actually being tested.

I'm not sure I follow.  Are you saying Windows users would never want
to access Subversion repositories?

Thanks,
Jonathan
