From: Andi Kleen <ak@linux.intel.com>
Subject: Re: make profile issue on Git 2.1.0
Date: Tue, 19 Aug 2014 04:54:49 -0700
Message-ID: <20140819115449.GV5803@tassilo.jf.intel.com>
References: <CAOUWSGA+6gX8ZBv3Wo8FgUdyd99TYWOybTwGT6ADv_HtNFsFMQ@mail.gmail.com>
 <20140819061203.GA14924@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?Andr=E9s_Sicard-Ram=EDrez?= <asr@eafit.edu.co>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 19 13:55:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJi0F-0000o7-PZ
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 13:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbaHSLyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 07:54:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:16439 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779AbaHSLyy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 07:54:54 -0400
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP; 19 Aug 2014 04:54:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,862,1389772800"; 
   d="scan'208";a="374214112"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.157])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Aug 2014 04:51:07 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
	id 3ABE1301E47; Tue, 19 Aug 2014 04:54:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140819061203.GA14924@peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255455>

> Maybe we should do this:

Looks good to me.

> As a side note, while testing this I noticed that the "make perf" run
> goes a lot faster if you set GIT_PERF_REPEAT_COUNT=1. This is bad for
> actually measuring things, but probably fine for profile feedback. I
> don't use the profile builds myself, though, so I will leave it to
> somebody who cares more to investigate whether such a change would be a
> good idea.

Yes should be fine too.

Another way to speed it up would be also to run the tests (both 
tests and benchmarks) in parallel on multiple cores. The gcc feedback mechanism
won't mind, as it doesn't measure time.

-Andi
