From: Josh Triplett <josht@us.ibm.com>
Subject: Re: [PATCH 1/3] git-format-patch: Make the second and subsequent
	mails replies to the first
Date: Fri, 14 Jul 2006 10:16:47 -0700
Message-ID: <1152897407.5177.8.camel@josh-work.beaverton.ibm.com>
References: <20060710162920.GR20191@harddisk-recovery.com>
	 <1152556878.8890.45.camel@josh-work.beaverton.ibm.com>
	 <7vwtal9lu1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 14 19:17:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1RHf-0002Tz-Qr
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 19:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422649AbWGNRQt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 13:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422646AbWGNRQt
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 13:16:49 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:65485 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422647AbWGNRQs
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jul 2006 13:16:48 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k6EHGlGO013828
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <git@vger.kernel.org>; Fri, 14 Jul 2006 13:16:47 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k6EHGlfm303008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 14 Jul 2006 11:16:47 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k6EHGlpq005794
	for <git@vger.kernel.org>; Fri, 14 Jul 2006 11:16:47 -0600
Received: from dyn9047018143.beaverton.ibm.com (dyn9047018143.beaverton.ibm.com [9.47.18.143])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k6EHGkqH005759;
	Fri, 14 Jul 2006 11:16:46 -0600
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtal9lu1.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.6.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23899>

On Mon, 2006-07-10 at 14:44 -0700, Junio C Hamano wrote:
> Josh Triplett <josht@us.ibm.com> writes:
> 
> > Add message_id and ref_message_id fields to struct rev_info, used in show_log
> > with CMIT_FMT_EMAIL to set Message-Id and In-Reply-To/References respectively.
> > Use these in git-format-patch to make the second and subsequent patch mails
> > replies to the first patch mail.
> >
> > Signed-off-by: Josh Triplett <josh@freedesktop.org>
> > ---
> > Resend of previous patch as part of new patch series.
> 
> While I understand what you said about imap-send, I really would
> feel better if this was optional.  Do not change the default
> output format, please.

So rather than the --no-thread option provided in the second patch of
this series, you'd prefer a --thread option to enable setting the
In-Reply-To/References headers?

Note that I based the direction of the --no-thread switch on
git-send-email's inclusion of these headers by default with no way to
turn them off, figuring that having an option to do so gave it an
advantage over git-send-email while remaining consistent with it.  I
also figured that most people would not mess with the defaults, and thus
the default should make a patch series more readable on mailing lists.

- Josh Triplett
