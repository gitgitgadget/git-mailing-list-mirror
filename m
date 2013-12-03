From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 0/5] teach replace objects to
 sha1_object_info_extended()
Date: Tue, 03 Dec 2013 21:46:17 +0100 (CET)
Message-ID: <20131203.214617.1435733880353938948.chriscool@tuxfamily.org>
References: <20131130133934.2697.75781.chriscool@tuxfamily.org>
	<20131202145225.GA12457@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, joey@kitenet.net
To: peff@peff.net
X-From: git-owner@vger.kernel.org Tue Dec 03 21:46:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vnwrj-0002by-Cb
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 21:46:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755196Ab3LCUqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 15:46:39 -0500
Received: from [194.158.98.15] ([194.158.98.15]:43534 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755058Ab3LCUqj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 15:46:39 -0500
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 43E4193;
	Tue,  3 Dec 2013 21:46:18 +0100 (CET)
In-Reply-To: <20131202145225.GA12457@sigill.intra.peff.net>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238738>

From: Jeff King <peff@peff.net>
>
> On Sat, Nov 30, 2013 at 02:51:18PM +0100, Christian Couder wrote:
> 
>> Here is a patch series to improve the way sha1_object_info_extended()
>> behaves when it is passed a replaced object.
> 
> Overall looks OK to me.

Thanks for reviewing it.

[...]
 
> I checked the resulting behavior against the list I made earlier; looks
> like all of the _extended callsites are doing the right thing.
> 
> I do think the checks you added in 277336a (replace: forbid replacing an
> object with one of a different type, 2013-09-06) need updating. I
> started on that, but I wonder if all of cmd_replace should simply turn
> off read_replace_refs. I'd think it would always want to be dealing with
> the true objects.

Yeah, I think you are right. I will have a look and probably turn off
read_replace_ref in cmd_replace() as you suggest.

Thanks,
Christian.
