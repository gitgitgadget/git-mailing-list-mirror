From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [REROLL PATCH 2/8] Support mandatory capabilities
Date: Wed, 9 Dec 2009 17:12:30 +0200
Message-ID: <20091209151230.GA15673@Knoppix>
References: <1260278177-9029-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1260278177-9029-3-git-send-email-ilari.liusvaara@elisanet.fi>
 <7vzl5t59bp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 16:12:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIODZ-0004V1-PC
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 16:12:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754157AbZLIPMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 10:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754053AbZLIPM3
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 10:12:29 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:37826 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753838AbZLIPM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 10:12:29 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id CD3B3C7FB0;
	Wed,  9 Dec 2009 17:12:34 +0200 (EET)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A06566C969A; Wed, 09 Dec 2009 17:12:34 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 6FEE3158A67;
	Wed,  9 Dec 2009 17:12:31 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <7vzl5t59bp.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134974>

On Tue, Dec 08, 2009 at 03:34:34PM -0800, Junio C Hamano wrote:
> Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:

> > +			fflush(stderr);
> > +			die("Unknown madatory capability %s. This remote "
> > +			    "helper probably needs newer version of Git.\n",
> > +			    capname);
> 
> Why fflush() here?  Is the reason for needing to flush stderr before
> letting die() to write into it very specific to this codepath, or shared
> among other callers of die()?  I am wondering if we should add this
> fflush() to report() in usage.c instead.

No idea why its there (anymore). Die will flush stderr anyway via exit.
Removed.

-Ilari
