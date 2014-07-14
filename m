From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: RE: [PATCH 3/3 v5] tag: support configuring --sort via .gitconfig
Date: Mon, 14 Jul 2014 22:08:32 +0000
Message-ID: <02874ECE860811409154E81DA85FBB58571987B5@ORSMSX115.amr.corp.intel.com>
References: <1405099447-27555-1-git-send-email-jacob.e.keller@intel.com>
	<1405099447-27555-3-git-send-email-jacob.e.keller@intel.com>
	<20140711174628.GC7856@sigill.intra.peff.net>
	<xmqqmwcf36jy.fsf@gitster.dls.corp.google.com>
	<20140712011735.GB17349@sigill.intra.peff.net>
 <xmqqk37h19dc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 15 00:08:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6oQI-0004Pl-V5
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 00:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756976AbaGNWIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 18:08:36 -0400
Received: from mga03.intel.com ([143.182.124.21]:11888 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756122AbaGNWIe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jul 2014 18:08:34 -0400
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101.ch.intel.com with ESMTP; 14 Jul 2014 15:08:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,661,1400050800"; 
   d="scan'208";a="456911943"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by azsmga001.ch.intel.com with ESMTP; 14 Jul 2014 15:08:33 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.59]) by
 ORSMSX101.amr.corp.intel.com ([169.254.8.157]) with mapi id 14.03.0123.003;
 Mon, 14 Jul 2014 15:08:33 -0700
Thread-Topic: [PATCH 3/3 v5] tag: support configuring --sort via .gitconfig
Thread-Index: AQHPnrwHtKQEouEPQUqhaN0T4H7NY5ugIkJg
In-Reply-To: <xmqqk37h19dc.fsf@gitster.dls.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.138]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253541>



> -----Original Message-----
> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Sunday, July 13, 2014 10:01 AM
> To: Jeff King
> Cc: Keller, Jacob E; git@vger.kernel.org
> Subject: Re: [PATCH 3/3 v5] tag: support configuring --sort via .gitconfig
> 
> Jeff King <peff@peff.net> writes:
> 
> > On Fri, Jul 11, 2014 at 02:54:25PM -0700, Junio C Hamano wrote:
> >
> >> > Yeah, we're quite inconsistent there. In some cases we silently
> ignore
> >> > something unknown (e.g., a color.diff.* slot that we do not
> understand),
> >> > but in most cases if it is a config key we understand but a value we
> do
> >> > not, we complain and die.
> >>
> >> Hm, that's bad---we've become less and less careful over time,
> >> perhaps?
> >
> > I don't think so. I think we've always been not-very-lenient with
> > parsing values. Two examples:
> > ...
> > So I do not think we have ever had a rule, but if we did, it is probably
> > "silently ignore unknown keys, complain on unknown values".
> 
> Yeah, somehow I was mixing up these two cases fuzzily in my mind
> while responding.  Rejecting unknown keys is bad, but we cannot be
> perfectly forward compatible nor behave sensibly on unknown values
> while issuing errors against known-to-be-bad values, so your rule
> above sounds like the most sensible thing to do.

The only difference is whether we halt or ignore the unknown value we complained about. Personally I am ok with either, but prefer the "complain and choose the default" so that older gits don't completely stop. But in some cases, the change is not easily compatible so then stopping might be preferred as the old git will not behave as expected.

Thanks,
Jake
