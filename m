From: Phil Hord <hordp@cisco.com>
Subject: Re: [PATCH] git-filter-branch: add --egrep-filter option
Date: Tue, 19 Apr 2011 12:03:13 -0400
Message-ID: <4DADB241.1060602@cisco.com>
References: <4DA8CBB0.6080103@rivulet.ca> <201104161016.51690.j6t@kdbg.org> <4DAA464E.7010804@rivulet.ca> <20110419080143.GA17915@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Michael O'Cleirigh" <michael.ocleirigh@rivulet.ca>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 18:03:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCDOa-0001xD-Qc
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 18:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753213Ab1DSQDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 12:03:16 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:58059 "EHLO
	sj-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752929Ab1DSQDP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 12:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=1277; q=dns/txt;
  s=iport; t=1303228995; x=1304438595;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=zB4K30EM+fLRYDFHH4W/79qVxZoWJ4RzkVTNbTOjrZE=;
  b=UxaSaW1SkBikAdtxRzwdEiFNVDd2/0AydLE41c6XqLjiwpSUvTk1R0KA
   mmjvxtB+n30ho/tFdhqIXu2Yn4cuYUoLUPt3HItH6C9CfOh2/IrFrskgD
   IzyRaWNCckOReTgJ3p0LeA+Wz3UxMnTB7rQ7lkFkVJN4IidKRlSqtwgDh
   c=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAA2yrU2tJXG+/2dsb2JhbAClLHeoBpxmhXEEjgeDfA
X-IronPort-AV: E=Sophos;i="4.64,240,1301875200"; 
   d="scan'208";a="683931194"
Received: from rcdn-core2-3.cisco.com ([173.37.113.190])
  by sj-iport-6.cisco.com with ESMTP; 19 Apr 2011 16:03:14 +0000
Received: from [64.100.104.120] (dhcp-64-100-104-120.cisco.com [64.100.104.120])
	by rcdn-core2-3.cisco.com (8.14.3/8.14.3) with ESMTP id p3JG3EKO017370;
	Tue, 19 Apr 2011 16:03:14 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <20110419080143.GA17915@elie>
X-Enigmail-Version: 1.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171800>



On 04/19/2011 04:01 AM, Jonathan Nieder wrote:
> Hi,
>
> Michael O'Cleirigh wrote:
>
>> After considering your comment I have to agree with you that it is a
>> special case of index-filter and probably not useful/general for
>> enough other cases to justify adding in a new command line option.
> Now, why do you give up so easily? ;-)
>
> Surely what your patch is hinting at is the possibility of an
> --ls-tree-filter (for lack of a better name) that works with trees
> without the overhead of unpacking them.

I have invented something similar[*] for git three different times in
three different ways.  The last one is the fastest and uses
git-fast-import instead of filter-branch, but I was sure one of the
filter-branch methods would have been more efficient.  More examples
would be very welcome.

Phil

[*] My implementations mostly focused on applying a ".gitignore" file to
the repo history.  I spent many hours on this.  I wound up with a script
that also handles file and branch renaming (the latter important so I
can run different filters on the same repo and drop results into
different branches).  It's not patch-worthy (yet), but I would have
loved to have more examples along the way such as the mktree one you
just provided.
