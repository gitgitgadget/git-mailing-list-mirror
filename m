From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] opening files in remote.c should ensure it is opening
 a file
Date: Fri, 08 Feb 2008 15:14:54 -0600
Message-ID: <47ACC64E.7040102@nrlssc.navy.mil>
References: <20080208174654.2e9e679c@pc09.procura.nl>	<118833cc0802081215t380587f6w7b5c0aba66a55799@mail.gmail.com> <7v8x1vjiic.fsf@gitster.siamese.dyndns.org> <47ACC261.6060404@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Morten Welinder <mwelinder@gmail.com>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 22:15:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNaZf-00027d-GW
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 22:15:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752827AbYBHVPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 16:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752458AbYBHVPS
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 16:15:18 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50414 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762AbYBHVPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 16:15:16 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m18LEsiE013636;
	Fri, 8 Feb 2008 15:14:55 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 8 Feb 2008 15:14:54 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <47ACC261.6060404@nrlssc.navy.mil>
X-OriginalArrivalTime: 08 Feb 2008 21:14:54.0855 (UTC) FILETIME=[A6A5D170:01C86A97]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15706001
X-TM-AS-Result: : Yes--5.968800-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMDA3NS0xMzkw?=
	=?us-ascii?B?MTAtNzAxODQ4LTcwNTM4OC03MDAzMDAtNzA4MTQzLTcwMjA0NC03?=
	=?us-ascii?B?MDEyMzYtMTQ4MDM5LTE0ODA1MS0yMDA0MA==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73147>

Brandon Casey wrote:
> Junio C Hamano wrote:
> 
>> And have Makefile set FOPEN_OPENS_DIRECTORIES on appropriate
>> platforms.
> 
> Which ones _don't_ open directories?
> 
> Shouldn't fopen("path_to_some_directory", "r") work?

Ok. It's the FOPEN_OPENS_DIRECTORIES term that confused me.

fopen is expected to succeed, even on directories. It's the read
that should fail but is not on HPUX. Obviously we don't want to
change the read.

-brandon
