From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add "--expire <time>" option to 'git prune'
Date: Thu, 29 Nov 2007 12:06:07 -0800
Message-ID: <7vlk8gvmts.fsf@gitster.siamese.dyndns.org>
References: <200711181225.52288.johannes.sixt@telecom.at>
	<7v3av3wg7h.fsf@gitster.siamese.dyndns.org>
	<200711182101.53936.johannes.sixt@telecom.at>
	<7v7ikfuxfk.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711290340470.27959@racer.site>
	<7vaboxy3va.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711291146090.27959@racer.site>
	<Pine.LNX.4.64.0711291419350.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	pasky@suse.cz
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 29 21:07:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxpfM-0002h0-Jx
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 21:07:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759338AbXK2UGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 15:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757721AbXK2UGb
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 15:06:31 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:49936 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932121AbXK2UGa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 15:06:30 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 2AC942EF;
	Thu, 29 Nov 2007 15:06:50 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id E77B09B17D;
	Thu, 29 Nov 2007 15:06:43 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711291419350.27959@racer.site> (Johannes
	Schindelin's message of "Thu, 29 Nov 2007 14:21:23 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66558>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The implementation uses st.st_mtime rather than st.st_ctime,
> because it can be tested better, using 'touch -d <time>' (and
> omitting the test when the platform does not support that
> command line switch).

But I think you can use more portable -t for setting mtime to
1970/01/01, but I had a feeling that earlier we were bitten by
non-portability of "touch" and introduced test-chmtime.
