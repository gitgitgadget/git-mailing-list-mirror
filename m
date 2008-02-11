From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: limiting rename detection during merge is a really bad idea
Date: Mon, 11 Feb 2008 14:29:34 +0100
Message-ID: <EFA2BCB7-B552-4952-B1EC-53307DA9972E@zib.de>
References: <CF28A4AE-62F0-4E41-9794-2CF85C2C7855@zib.de> <20080211074817.GA18898@sigill.intra.peff.net> <8c5c35580802110241i72169620s693a31f9a098f596@mail.gmail.com> <20080211110816.GA6344@coredump.intra.peff.net> <8aa486160802110320h78f7228fg84ae2c4986f67372@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lars Hjemli <hjemli@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 11 14:29:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOYin-0001kH-74
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 14:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbYBKN2p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Feb 2008 08:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752001AbYBKN2p
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 08:28:45 -0500
Received: from mailer.zib.de ([130.73.108.11]:33778 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751621AbYBKN2o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Feb 2008 08:28:44 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m1BDSbaS011996;
	Mon, 11 Feb 2008 14:28:37 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m1BDSbC4019013
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 11 Feb 2008 14:28:37 +0100 (MET)
In-Reply-To: <8aa486160802110320h78f7228fg84ae2c4986f67372@mail.gmail.com>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73531>


On Feb 11, 2008, at 12:20 PM, Santi B=E9jar wrote:

>> Steffen, can you tell us how large your rename set is (unfortunately=
,
>> there is no way to get this information easily; you can stop
>> merge-recursive in the debugger at diffcore-rename.c:457 and look at
>> num_src and num_create). And how long it takes to run with
>> diff.renamelimit turned off?

I don't know the size.  I can only say that it took a few
seconds on a MacBook Pro.


>> That might give us a clue where a reasonable value is.
>
> Additionally git could warn if the limit is reached in the merge.

I think this would have saved me.  I did not know about the
rename limit.  Therefore I did not understand why the merge
failed.  If git merge had reported that the rename detection
limit was reached, I probably would have looked up what this
limit is about.  At least git should tell when rename detection
gets disabled.  Users expect that renames work and git should tell
the user when it does not even try to detect renames.

Personally, I can easily switch to a larger machine if this
helps completing a merge and I think I would do this.  But
I also know that I shouldn't expect too much from a larger
machine for an O(n^2) algorithm.

	Steffen
