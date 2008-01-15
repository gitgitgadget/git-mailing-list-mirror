From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: git-commit fatal: Out of memory? mmap failed: Bad file	descriptor
Date: Tue, 15 Jan 2008 14:39:19 -0600
Message-ID: <478D19F7.9020308@nrlssc.navy.mil>
References: <4787E981.7010200@nrlssc.navy.mil>	 <478C1D7A.6090103@nrlssc.navy.mil>	 <alpine.LFD.1.00.0801142140560.2806@woody.linux-foundation.org>	 <478CECAB.2030906@nrlssc.navy.mil>	 <alpine.LFD.1.00.0801150931260.2806@woody.linux-foundation.org>	 <478CFAFF.6010006@nrlssc.navy.mil>	 <alpine.LFD.1.00.0801151036110.2806@woody.linux-foundation.org>	 <478D0CDA.5050709@nrlssc.navy.mil> <1200427202.5821.7.camel@gaara.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>, drafnel@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>
To: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 21:41:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEsb1-0004wP-GS
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 21:41:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753225AbYAOUkf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jan 2008 15:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751979AbYAOUke
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 15:40:34 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:37869 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225AbYAOUke (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 15:40:34 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0FKdJbx015677;
	Tue, 15 Jan 2008 14:39:19 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 15 Jan 2008 14:39:19 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <1200427202.5821.7.camel@gaara.boston.redhat.com>
X-OriginalArrivalTime: 15 Jan 2008 20:39:19.0414 (UTC) FILETIME=[B3E96160:01C857B6]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15666001
X-TM-AS-Result: : Yes--13.402100-0-2-1
X-TM-AS-Category-Info: : 2:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1NzA0Mi03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcxMDIwNy0xMzc3MTctNzAwNjkzLTcwMDk3MS03?=
	=?us-ascii?B?MDE0NjEtMTA1MjUwLTE0ODAzOS0xNDgwNTEtMjAwNDA=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70557>

Kristian H=F8gsberg wrote:

> To my defense, the lockfile API is used a little inconsitently in git=
=2E
> Many places in git does a close(fd) and the call commit_locked_index(=
),
> which will close the fd again.

I bet they did that so that the return status of close() could be check=
ed
since commit_lock_file() doesn't currently check it.

-brandon
