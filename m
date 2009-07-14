From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Weird behavior of git rev-parse
Date: Tue, 14 Jul 2009 04:34:42 -0700 (PDT)
Message-ID: <m3iqhvv6ph.fsf@localhost.localdomain>
References: <4A5C31CF.2090204@ubicom.com>
	<7vvdlvhbtg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yakup Akbay <yakbay@ubicom.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 14 13:34:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQgHf-0004Q2-SQ
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 13:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbZGNLeq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 07:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbZGNLeq
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 07:34:46 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:25582 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbZGNLep (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2009 07:34:45 -0400
Received: by ey-out-2122.google.com with SMTP id 9so601177eyd.37
        for <git@vger.kernel.org>; Tue, 14 Jul 2009 04:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=0WtryHhOayUj8T5Ujq3IHgaN7saDaB6RRW1JcVgUh30=;
        b=pH3iDrQbSViPKMJqqd04xqHo6uunnoN8/VJ3+D+L0LpiP0a6x7yKP4MrwGSoMQBjca
         0Xu9vJxvVONwhmMEi8IsOp9qPmr2F6n577CeyhGaQUrpCYohj6jXSHFTxpkAJeMDQ0BQ
         VFM2MNvwVCXVs69aNcbXMMwC7d5R57u0PuQs8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=N9EtUbqf750NFjHS0zYOF0ArpDjPUVhxoeBHF1fWOigv6UydRwUrFqyUjqqmvtf9hn
         CyPcHKI0jZCHlc3rR5KjWbFDBcsVRb0NywACrhVpQW7opjAVRiK2NuP7TC6NFJa1q9Zb
         bgOan8bimHIT6hvLOteYP3/3JhvJFCxcnyZo8=
Received: by 10.210.35.10 with SMTP id i10mr6494567ebi.22.1247571283805;
        Tue, 14 Jul 2009 04:34:43 -0700 (PDT)
Received: from localhost.localdomain (abvk144.neoplus.adsl.tpnet.pl [83.8.208.144])
        by mx.google.com with ESMTPS id 5sm1384021eyf.8.2009.07.14.04.34.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 14 Jul 2009 04:34:42 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n6EBYdO1017829;
	Tue, 14 Jul 2009 13:34:40 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n6EBYbTf017826;
	Tue, 14 Jul 2009 13:34:37 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vvdlvhbtg.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123237>

Junio C Hamano <gitster@pobox.com> writes:

> Yakup Akbay <yakbay@ubicom.com> writes:
> 
> > Then I've tried
> >
> >    $ git rev-parse -'hi, this is a test!'
> >
> > the output is:
> >
> >    -hi, this is a test!
> >
> > Is this an expected behavior?
> 
> Absolutely.  rev-parse was originally written as a way for Porcelain
> scripts to sift parameters into four different categories.
> 
>  * options and non-options (that's two)
> 
>  * args meant for rev-list and others (that's another two)
> 
> Multiplying two x two gives you four combinations.
> 
> Because you are not giving options like --revs-only, --no-revs, --flags,
> nor --no-flags, rev-parse outputs everything.

git-rev-parse can also be used to bring parseopt to shell scripts.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
