From: Jeff King <peff@peff.net>
Subject: Re: Get a git diff without taking index into account
Date: Wed, 18 Feb 2015 17:30:13 -0500
Message-ID: <20150218223013.GA16287@peff.net>
References: <CAAoZyYN-ohiq-Od=u-cd5FRH8=NpJNGS+zEo+NYgwAK7Kjaz_w@mail.gmail.com>
 <CAAoZyYPhiKX1F5ymdSijR7=e8CT1sqaomehBjt-NVDz_A4V4UA@mail.gmail.com>
 <CAPc5daU9km+gr-DHJzJF59mugwGeNX69H27E_DaoyBZnuzoiFw@mail.gmail.com>
 <CAAoZyYPVopmP_bv7EZS912R4bxpzNm49_q0XXZXqa52dTDDM2Q@mail.gmail.com>
 <xmqqfva341sf.fsf@gitster.dls.corp.google.com>
 <CAAoZyYOst-5cD7qtV=T3Oahja1JN1ZmeyAcELrn7xD0bMc7Mrg@mail.gmail.com>
 <20150218183251.GB6346@peff.net>
 <CAAoZyYOT_OQZ+rrwFvnsVBV_sYRA4Oti3vRNnE6_RaV9w8qxdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Frederich <eric.frederich@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 23:30:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOD8W-0005WZ-Bb
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 23:30:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753037AbbBRWaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 17:30:19 -0500
Received: from cloud.peff.net ([50.56.180.127]:50763 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752993AbbBRWaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 17:30:16 -0500
Received: (qmail 14515 invoked by uid 102); 18 Feb 2015 22:30:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Feb 2015 16:30:15 -0600
Received: (qmail 22032 invoked by uid 107); 18 Feb 2015 22:30:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Feb 2015 17:30:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Feb 2015 17:30:13 -0500
Content-Disposition: inline
In-Reply-To: <CAAoZyYOT_OQZ+rrwFvnsVBV_sYRA4Oti3vRNnE6_RaV9w8qxdg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264068>

On Wed, Feb 18, 2015 at 04:38:55PM -0500, Eric Frederich wrote:

> Also, how would I go about detecting untracked files the way status does?
> There is no way to specify a HEAD per git command using switches or
> environment variables.
> I can't change the HEAD of the Git repo because other processes may be
> using it at the same time.

Untracked files are a function of the index, not of the HEAD. So you
would load whatever tree you like into your index (either "the" index,
or a temporary one you specify with GIT_INDEX_FILE), and then "git
ls-files -o".

-Peff
