From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Amending merge commits?
Date: Mon, 28 Jul 2014 13:00:37 -0700
Message-ID: <20140728200037.GN12427@google.com>
References: <22F01493C523F940B4B5E53BB6D0F5352275F207@G5W2738.americas.hpqcorp.net>
 <20140725221911.GL12427@google.com>
 <22F01493C523F940B4B5E53BB6D0F5352275F25B@G5W2738.americas.hpqcorp.net>
 <20140725223146.GM12427@google.com>
 <87vbqhb7g9.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Besen, David" <david.besen@hp.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 22:00:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBr6H-0005UF-OA
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 22:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbaG1UAm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 16:00:42 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:47017 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960AbaG1UAl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 16:00:41 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so10346382pde.23
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 13:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4LWDvqyv1wJJyrQLu2EW1ZKPzSubaG5KgyACUFuWehI=;
        b=Vhxg8M/c0jEATsRbEQNh7vnVcjAr/DaiCQaILWzAk3ScVraEOgqbCECBJ+yCx0aVR/
         qm1hcqpLSyZC77vSzkprCTY2xsbWsKhqqup/RDnJ11sDnu1bd6q64bU3dLLeQMZxge3E
         wGyTDE+fUWcuvY56hDFycCgIcb/1lsKLgdJUwTSwoxaPjO/lO/DK4oU9nnzmMvkAqZt2
         +QJdaWZCFoZq7UxnYKTLeP/Aem2kJQzTFY8PrhSnklsFS9+kb72NBp4pG2rZXrlQeLZF
         DwRl2H5gIbhtsQxJP0tgtazn4/YbAMRbvS8Xvm4qBjjoQTqNB0cx5Ej+kR+0auGhuftW
         pm6Q==
X-Received: by 10.66.65.169 with SMTP id y9mr5018547pas.145.1406577640695;
        Mon, 28 Jul 2014 13:00:40 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:1859:a465:7f93:46c5])
        by mx.google.com with ESMTPSA id wd7sm69791123pab.47.2014.07.28.13.00.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Jul 2014 13:00:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87vbqhb7g9.fsf@osv.gnss.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254353>

Sergei Organov wrote:

> Is there any scenario at all where pull --rebase=true wins over
> preserve?

Basically always in my book. ;-)

When people turn on 'pull --rebase', they are asking for a clean,
simplified history where their changes are small discrete patches in a
clump on top of upstream.

When someone has made a merge by mistake (with 'git pull' before
remembering to do an autosetuprebase, or with 'git merge' instead of
cherry-picking some patches they needed), the current --rebase=true
behavior can be a good way of cleaning up.

That said, in some specific workflows, --rebase=preserve may work
better than --rebase=true.  My hunch is that even those workflows are
not currently handled well with --rebase=preserve, alas.

A clearer explanation of --rebase (maybe with sub-headings for each
choice *true*, *false*, and *preserve*?) sounds useful.  An
illustration in the EXAMPLES section of git-pull(1) of the difference
between these three modes and when to use them would be even more
helpful.

Thanks,
Jonathan
