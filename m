From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] config: Introduce --patience config variable
Date: Tue, 6 Mar 2012 14:01:42 +0100
Message-ID: <87pqcp6fyh.fsf@thomas.inf.ethz.ch>
References: <a87ed689ddfb06601dd639541199fc72d829bdaf.1331031473.git.mprivozn@redhat.com>
	<20120306114914.GB6733@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Michal Privoznik <mprivozn@redhat.com>, <git@vger.kernel.org>,
	<gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 06 14:01:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4u1X-0000qf-DJ
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 14:01:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030322Ab2CFNBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 08:01:46 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:26003 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751757Ab2CFNBq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 08:01:46 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 6 Mar
 2012 14:01:43 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 6 Mar
 2012 14:01:43 +0100
In-Reply-To: <20120306114914.GB6733@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 6 Mar 2012 06:49:14 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192341>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 06, 2012 at 11:59:42AM +0100, Michal Privoznik wrote:
>
>> --- a/Documentation/diff-config.txt
>> +++ b/Documentation/diff-config.txt
>> @@ -86,6 +86,9 @@ diff.mnemonicprefix::
>>  diff.noprefix::
>>  	If set, 'git diff' does not show any source or destination prefix.
>>  
>> +diff.patience:
>> +    If set, 'git diff' will use patience algorithm.
>> +
>
> Should this be a boolean? Or should we actually have a diff.algorithm
> option where you specify the algorithm you want (e.g., "diff.algorithm =
> patience")? That would free us up later to more easily add new values.
>
> In particular, I am thinking about --minimal. It is mutually exclusive
> with --patience, and is simply ignored if you use patience diff.
> we perhaps have "diff.algorithm" which can be one of "myers", "minimal"
> (which is really myers + the minimal flag), and "patience".

Don't forget "histogram".  I have no idea why it's not documented
(evidently 8c912eea slipped through the review cracks) but --histogram
is supported since 1.7.7.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
