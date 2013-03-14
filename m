From: John Keeping <john@keeping.me.uk>
Subject: Re: difftool -d symlinks, under what conditions
Date: Thu, 14 Mar 2013 09:43:00 +0000
Message-ID: <20130314094300.GN2317@serenity.lan>
References: <20130312194306.GE2317@serenity.lan>
 <7vfw0073pm.fsf@alter.siamese.dyndns.org>
 <20130312210630.GF2317@serenity.lan>
 <CAJELnLGBr1wOX4-3rCNjPpPLezc_6FgyeuPqty268JR0==qtvQ@mail.gmail.com>
 <7vehfk5kn2.fsf@alter.siamese.dyndns.org>
 <3222724986386016520@unknownmsgid>
 <20130313001758.GH2317@serenity.lan>
 <CAJDDKr7ZU16XWtCfYX9-RMzcpKa_FF80Od+mUMG4n8dUKeLsvw@mail.gmail.com>
 <7vtxof48sg.fsf@alter.siamese.dyndns.org>
 <7v1ubj45ac.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>,
	Matt McClure <matthewlmcclure@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Tim Henigan <tim.henigan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 14 10:43:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UG4hH-0006Zb-02
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 10:43:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755714Ab3CNJnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 05:43:12 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:56939 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755075Ab3CNJnL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 05:43:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 47BCC6064D5;
	Thu, 14 Mar 2013 09:43:11 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -11
X-Spam-Level: 
X-Spam-Status: No, score=-11 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tRwhyFPh+zO6; Thu, 14 Mar 2013 09:43:10 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 9B7BA6064E2;
	Thu, 14 Mar 2013 09:43:02 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7v1ubj45ac.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218124>

On Wed, Mar 13, 2013 at 09:45:47AM -0700, Junio C Hamano wrote:
> Does the temporary checkout correctly apply the smudge filter and
> crlf conversion, by the way?  If not, regardless of the topic in
> this thread, that may want to be fixed as well.  I didn't check.

I've had a look at this and I think it will be much quicker for someone
more familiar with git-checkout-index to answer.

What git-difftool does is to create a temporary index containing only
the files that have changed (using git-update-index --index-info) and
then check this out with "git checkout-index --prefix=...".  So I think
this question boils down to: does git-checkout-index still read
.gitattributes from the working tree if given --prefix?


John
