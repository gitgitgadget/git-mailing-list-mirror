From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Mar 2009, #05; Tue, 17)
Date: Wed, 18 Mar 2009 01:52:22 -0400
Message-ID: <20090318055222.GA17128@coredump.intra.peff.net>
References: <7vbprzo0si.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Miklos Vajna <vmiklos@frugalware.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 06:54:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljojp-0003ct-Th
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 06:54:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753579AbZCRFwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 01:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753894AbZCRFwc
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 01:52:32 -0400
Received: from peff.net ([208.65.91.99]:50901 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753571AbZCRFwb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 01:52:31 -0400
Received: (qmail 11473 invoked by uid 107); 18 Mar 2009 05:52:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 18 Mar 2009 01:52:37 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Mar 2009 01:52:22 -0400
Content-Disposition: inline
In-Reply-To: <7vbprzo0si.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113583>

On Tue, Mar 17, 2009 at 10:30:37PM -0700, Junio C Hamano wrote:

> * mv/parseopt-ls-files (Sat Mar 7 20:27:22 2009 -0500) 4 commits
>  + ls-files: fix broken --no-empty-directory
>  + t3000: use test_cmp instead of diff
>  + parse-opt: migrate builtin-ls-files.
>  + Turn the flags in struct dir_struct into a single variable
> 
> The tip one was a subject for further discussion, but nothing is queued
> yet.

I am inclined to leave it as-is. The other sane option would be
converting it to use NONEG, as Miklos suggested.

Doing it right would probably mean adding a "this option is the opposite
of what we would usually do" flag to parse-options which would display
the option as "no-<option>" in the usage, and would reverse clearing and
setting the bit (i.e., --empty-directory would clear the HIDE_DIRECTORY
bit and --no-empty-directory would set it). But I don't think it is
worth the work to add a negatable version of an option that has never
existed before and which nobody has requested to use.

-Peff
