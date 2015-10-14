From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/1] send-email: allow to compose only prepared cover
 letter
Date: Wed, 14 Oct 2015 12:42:19 +0300
Organization: Intel Finland Oy
Message-ID: <1444815739.8361.621.camel@linux.intel.com>
References: <1444752768-82136-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <xmqqa8rma2xx.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 11:42:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmIZq-0003j2-P6
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 11:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753151AbbJNJm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 05:42:26 -0400
Received: from mga09.intel.com ([134.134.136.24]:19608 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751478AbbJNJmX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 05:42:23 -0400
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP; 14 Oct 2015 02:42:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,681,1437462000"; 
   d="scan'208";a="580468897"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Oct 2015 02:42:22 -0700
In-Reply-To: <xmqqa8rma2xx.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.3-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279566>

On Tue, 2015-10-13 at 14:11 -0700, Junio C Hamano wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> 
> > My often use case is to do:
> > 	% git format-patch --cover-letter --subject-prefix="PATCH 
> > vN" rev1^..revXYZ
> > 	% $GIT_EDITOR 0000-*
> > 	% git send-email 00* # assumes series less than 100 
> > patches
> > 	% rm -f 00*
> 
> I guess this patch would not hurt too much, but the above would
> vastly be improved if you used "-vN" option, instead of the
> hand-rolled subject prefix, and dropped the last "rm -f" (which in
> turn would mean you would want to use -o option to specify where to
> keep the older iterations of the topic).  Then you can easily refer
> to cover letters and patches from previous rounds while preparing
> the latest to send out.

Thanks!

The patch I sent was a modification of previous variant I have. It
unfortunately misses undef $compose; line in the first conditional
branch.

Besides that I found that --annotate might be a workaround and it comes
a burden of editor how to avoid editing every patch but first.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
