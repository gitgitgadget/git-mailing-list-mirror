From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: Gitweb caching: Google Summer of Code project
Date: Fri, 30 May 2008 23:32:55 +0200
Message-ID: <48407287.7050900@gmail.com>
References: <483C4CFF.2070101@gmail.com> <200805300127.10454.jnareb@gmail.com> <483FABB4.1010309@gmail.com> <200805301202.25368.jnareb@gmail.com> <4840166C.3030903@gmail.com> <20080530150713.GG593@machine.or.cz> <48401CFF.4020702@gmail.com> <20080530153822.GH593@machine.or.cz> <b77c1dce0805300904o5b4363efkc4591fc820164bf7@mail.gmail.com> <1212173779.26045.77.camel@localhost.localdomain> <7vd4n3k04r.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "J.H." <warthog19@eaglescrag.net>,
	Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 30 23:33:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2CED-0007NO-Sj
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 23:33:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354AbYE3Vcq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 17:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753082AbYE3Vcq
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 17:32:46 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:61230 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506AbYE3Vcp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 17:32:45 -0400
Received: by fg-out-1718.google.com with SMTP id 19so198989fgg.17
        for <git@vger.kernel.org>; Fri, 30 May 2008 14:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=uAf3j/IxvrSvqvWB9u9w13MPFXeO9lZ5A6KS+WgJfDI=;
        b=YmYGyChD2sVwaKvmKDjFuH1Lxfa66HhwoHWxtDwBXb5mhJVVBVy7o0USrV7pc8/F9WYLTJOiMsEA7qGA0KPmFaJPo4q/CA46ZPm2SKcdvs0ndx9qJCQ5uwREoWVCb1N9K6E9E8bJBUjsuhHYjdxEAmaW/ndltnw963m4Q7Y6pGA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=ciOQ22w7TjeZWgZNdy/w092siwI9EWMtzUYapbOGi5NWe8WFmXuo+hHFMee5hfV+Z3RRlxRubYeeM3W0EzqPQVVbVNbujWQ4xVJd0rPPU2ttD7bUCFundB1Zim88OUgr0Obv7rxaqIGFhuFDMWwFDlmECGggcor71PCQqJsjvHM=
Received: by 10.86.100.19 with SMTP id x19mr1499478fgb.34.1212183163411;
        Fri, 30 May 2008 14:32:43 -0700 (PDT)
Received: from ?192.168.23.50? ( [91.33.213.54])
        by mx.google.com with ESMTPS id 12sm1250785fgg.0.2008.05.30.14.32.41
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 May 2008 14:32:42 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <7vd4n3k04r.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83339>

Junio C Hamano wrote:
> Right now, these "use Git": git-add--interactive.perl
> git-cvsexportcommit.perl git-send-email.perl git-svn.perl
> 
> Introducing 5.8 dependency to Git.pm in such a way that
> "use Git" from these fail might make these people somewhat unhappy.

Git seems to generally work with Perl 5.6 after installing Scalar::Util 
through CPAN.  I'm happy with (sporadically) testing it with 5.6.2, 
though I don't have any older version installed.  Also, if at some point 
Perl 5.6 compatibility gets in the way (due to lack of Unicode support), 
we'll have to revisit this issue, but for now that should be fine.

Gitweb relies on Unicode support (e.g. "use Encode") and will continue 
to be compatible with 5.8 and 5.10 only.

I'm not sure how much changes between Perl's micro versions.  Should we 
boldly claim "use 5.6.0" or only "use 5.6.2"?  Are people still using 
versions 5.6.0/1 at all?  And for Gitweb, use 5.8.0, or use 5.8.8 (which 
is the version I'm testing with, currently)?  Or should I downgrade?

-- Lea
