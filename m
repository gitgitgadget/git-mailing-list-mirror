From: David Greene <greened@obbligato.org>
Subject: Re: Detecting redundant commits
Date: Tue, 05 Jan 2016 10:31:04 -0600
Message-ID: <49661552-EBD9-4F45-9F31-54B217AE3350@obbligato.org>
References: <nngtwmtwd2q.fsf@lnx-dag.us.cray.com> <20160105040026.GB22620@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 05 17:31:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGUW2-0007k4-S3
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 17:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbcAEQbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 11:31:15 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:46390 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751868AbcAEQbM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 11:31:12 -0500
Received: from [166.175.185.8] (helo=[10.29.98.243])
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1aGUWk-0001Rl-9c; Tue, 05 Jan 2016 10:32:06 -0600
User-Agent: K-9 Mail for Android
In-Reply-To: <20160105040026.GB22620@sigill.intra.peff.net>
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283384>



On January 4, 2016 10:00:26 PM CST, Jeff King <peff@peff.net> wrote:

>Or do you mean commits that, when applied, we find turn out to have
>empty changes (e.g., because we have a set of commits that have
>different patch-ids, but do roughly the same thing)? I don't think you
>can find that with a straight end-to-end diff. You have try to apply
>and
>then look at the result. I think we already catch that case (see
>--allow-empty), though I think the only options are "preserve" or
>"abort", not "silently skip" (and it sounds like the latter is what you
>would want).

This.  I see where --allow-empty is handled in prepare_to_commit but it is not so easy to skip the commit at that point due to state changes.  I was trying to avoid going into commit at all by determining ahead of time whether the commit would become empty.  Any ideas?

David
