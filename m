From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] gc: use parse_options
Date: Mon, 05 Nov 2007 17:08:30 -0600
Message-ID: <472FA26E.4060706@nrlssc.navy.mil>
References: <20071102002856.GB3282@crux.yyz.redhat.com> <7vhck579pm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: James Bowes <jbowes@dangerouslyinc.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 00:09:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpB4O-0001Z8-PB
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 00:09:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301AbXKEXJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 18:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754203AbXKEXJJ
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 18:09:09 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:37250 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700AbXKEXJI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 18:09:08 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id lA5N8VYq023852;
	Mon, 5 Nov 2007 17:08:31 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 5 Nov 2007 17:08:31 -0600
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
In-Reply-To: <7vhck579pm.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 05 Nov 2007 23:08:31.0090 (UTC) FILETIME=[C8327D20:01C82000]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15336001
X-TM-AS-Result: : Yes--1.517400-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTQ2MDA4LTE1MDU2Ny03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwMTUyMi03MDAwNzMtNzAzNzMxLTcwNTEwMi03?=
	=?us-ascii?B?MDQyNTctNzExMTA5LTcwNDkyNy03MDAzOTgtMTA1NzAwLTE4ODAx?=
	=?us-ascii?B?OS03MDM3ODgtNzAyOTAwLTcxMDk4OS03MDA0NzYtMTQ4MDM5LTE0?=
	=?us-ascii?B?ODA1MS0yMDA0MA==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63583>

Junio C Hamano wrote:
> James Bowes <jbowes@dangerouslyinc.com> writes:
> 
>> +	struct option builtin_gc_options[] = {
>> +		OPT_BOOLEAN(0, "prune", &prune, "prune unused objects"),
> 
> I would write "unreferenced loose" instead of "unused" here...

It is not just "loose" objects here, but also unreferenced objects in packs,
since the "-a" option to repack is now only used when --prune is specified.
Without --prune, "-A" is supplied to repack instead.

So maybe the message should just be "prune unreferenced objects"

-brandon
