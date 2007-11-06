From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug in next ?] git-fetch/git-push issue
Date: Tue, 06 Nov 2007 10:23:45 -0800
Message-ID: <7vwssvgrm6.fsf@gitster.siamese.dyndns.org>
References: <20071105175654.GD6205@artemis.corp>
	<20071106175627.GB9517@artemis.corp>
	<20071106180910.GA25934@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git ML <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 06 19:24:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpT5t-0005dW-FX
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 19:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbXKFSXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 13:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753324AbXKFSXz
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 13:23:55 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:32821 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbXKFSXy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 13:23:54 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 0ED042F9;
	Tue,  6 Nov 2007 13:24:14 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 87CBA92D7A;
	Tue,  6 Nov 2007 13:24:09 -0500 (EST)
In-Reply-To: <20071106180910.GA25934@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 6 Nov 2007 13:09:10 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63697>

Jeff King <peff@peff.net> writes:

> On Tue, Nov 06, 2007 at 06:56:27PM +0100, Pierre Habouzit wrote:
>
>>   On the same vein, with today's next:
>> 
>>     $ git push origin :teaser
>>     To ssh://git.corp/srv/git/mmsx.git
>>      - [deleting]        teaser
>>     refs/heads/teaser: 05518bc7df1af680447f58b034b108f66668db03 -> deleted
>>     Everything up-to-date
>>     fatal: Invalid revision range 05518bc7df1af680447f58b034b108f66668db03..0000000000000000000000000000000000000000
>>     fatal: ambiguous argument 'refs/heads/teaser': unknown revision or path not in the working tree.
>>     Use '--' to separate paths from revisions

Isn't this coming from a loosely written post-receive hook that
wants to send mail or something and forgets that a ref could be
removed?
