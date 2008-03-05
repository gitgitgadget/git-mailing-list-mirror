From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: git clone -l
Date: Tue, 04 Mar 2008 18:53:37 -0600
Message-ID: <47CDEF11.8000807@nrlssc.navy.mil>
References: <alpine.LNX.1.00.0803041900080.19665@iabervon.org> <7vd4qa3t9t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 01:54:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWhu6-0005xD-VN
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 01:54:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758391AbYCEAxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 19:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758344AbYCEAxx
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 19:53:53 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:53084 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758391AbYCEAxw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 19:53:52 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m250rbe7030737;
	Tue, 4 Mar 2008 18:53:38 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 4 Mar 2008 18:53:37 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <7vd4qa3t9t.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 05 Mar 2008 00:53:37.0636 (UTC) FILETIME=[58C30A40:01C87E5B]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15764001
X-TM-AS-Result: : Yes--15.240000-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMDA3NS0xMzkw?=
	=?us-ascii?B?MTAtNzAwMjQxLTcwMzczMS03MDcxMTktNzA4MzI4LTcwMTQzNi03?=
	=?us-ascii?B?MDI2MDktNzAyMzU4LTcwMjkyMC03MDM3ODgtNzEwNTEyLTcwMTc5?=
	=?us-ascii?B?NC03MDE4MjgtMTEzMjI4LTcwMzE3OS03MDA2MTctNzAxNDU1LTcw?=
	=?us-ascii?B?NTQ1MC0xNDgwMzktMTQ4MDUxLTIwMDQy?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76162>

Junio C Hamano wrote:
> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
>> What, exactly, is -l supposed to do for clone? As far as I can tell, we 
>> automatically do the local magic if we can. Would it be okay to make 
>> "local" default to "if possible", have "-l" mean error if not possible, 
>> and have "--no-local" able to avoid using local magic even if we could use 
>> it?
> 
> It used to be that "-l" meant "When it is local, use hardlink if possible
> otherwise copy without complaining, as either are cheaper than the pack
> piped to unpack."  Lack of -l meant no local magic.
> 
> Recently lack of -l stopped to mean "no local magic".  We still do the
> local magic, but we do not do hardlinks and instead do copies.  An "-l"
> that asks clone across filesystems still falls back to copying but now
> gets a warning.  "--no-hardlinks" does not have any significance anymore,
> as that is what you would get for a local clone without -l.

Are you sure?
I thought this was changed by 3d5c418f so that hardlinking is done by default.

  Lack of -l means "do local magic and use hard links".
  Using -l makes git-clone print a warning when hard linking fails.
  --no-hardlinks disables hard linking and still does local magic.

-brandon

