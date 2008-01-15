From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: git-commit fatal: Out of memory? mmap failed: Bad file	descriptor
Date: Tue, 15 Jan 2008 14:27:45 -0600
Message-ID: <478D1741.8040807@nrlssc.navy.mil>
References: <4787E981.7010200@nrlssc.navy.mil>	 <478C1D7A.6090103@nrlssc.navy.mil>	 <alpine.LFD.1.00.0801142140560.2806@woody.linux-foundation.org>	 <478CECAB.2030906@nrlssc.navy.mil>	 <alpine.LFD.1.00.0801150931260.2806@woody.linux-foundation.org>	 <478CFAFF.6010006@nrlssc.navy.mil>	 <alpine.LFD.1.00.0801151036110.2806@woody.linux-foundation.org>	 <478D0CDA.5050709@nrlssc.navy.mil> <1200427202.5821.7.camel@gaara.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>, drafnel@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>
To: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 21:29:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEsPQ-0000so-PK
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 21:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246AbYAOU2w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jan 2008 15:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752002AbYAOU2w
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 15:28:52 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:36421 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbYAOU2v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 15:28:51 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0FKRkHI015515;
	Tue, 15 Jan 2008 14:27:46 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 15 Jan 2008 14:27:46 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <1200427202.5821.7.camel@gaara.boston.redhat.com>
X-OriginalArrivalTime: 15 Jan 2008 20:27:46.0039 (UTC) FILETIME=[16A0C070:01C857B5]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15666001
X-TM-AS-Result: : Yes--16.556500-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1NzA0Mi03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwOTIyMy0xMzc3MTctNzA0NTg3LTcwMTk4MS03?=
	=?us-ascii?B?MDUxNzgtNzAzNzQ3LTcwMDEwNy0xNDgwMzktMTQ4MDUxLTIwMDQw?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70552>

Kristian H=F8gsberg wrote:

> There's four close(fd) calls in prepare_index() and they're all
> incorrect.  The open fd's are cleaned up in rollback_index_files() an=
d
> shouldn't be closed manually.  The patch below gets rid of the extra
> close() calls and should fix the problem.

It does. Thanks.

-brandon
