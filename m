From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git log fails to show all changes for a file
Date: Tue, 14 Jul 2015 19:54:09 +0200
Message-ID: <87615maam6.fsf@igel.home>
References: <20150714073035.GA22707@aepfle.de>
	<20150714074508.GE1451@serenity.lan>
	<20150714075955.GA24577@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
X-From: git-owner@vger.kernel.org Tue Jul 14 19:54:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZF4PK-00042U-Dn
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 19:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585AbbGNRyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2015 13:54:14 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:46031 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958AbbGNRyN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2015 13:54:13 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3mW8c312hMz3hjcC;
	Tue, 14 Jul 2015 19:54:11 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3mW8c30Gsrzvh1v;
	Tue, 14 Jul 2015 19:54:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id QgrLOimOz-At; Tue, 14 Jul 2015 19:54:10 +0200 (CEST)
X-Auth-Info: 7cAShYUCa0eqmZo70TsFkU76DJaUWVXd6vj3AC4l/XLkjmXDv7W4pQPKVXARstqp
Received: from igel.home (host-188-174-218-179.customer.m-online.net [188.174.218.179])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Tue, 14 Jul 2015 19:54:09 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id A58CD2C13E4; Tue, 14 Jul 2015 19:54:09 +0200 (CEST)
X-Yow: Can you MAIL a BEAN CAKE?
In-Reply-To: <20150714075955.GA24577@aepfle.de> (Olaf Hering's message of
	"Tue, 14 Jul 2015 09:59:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273969>

Olaf Hering <olaf@aepfle.de> writes:

> On Tue, Jul 14, John Keeping wrote:
>
>> It was added in an evil merge (f9da455b93f6ba076935b4ef4589f61e529ae046),
>> try:
>> 
>> 	git log -p -M --stat --cc -- drivers/hv/channel_mgmt.c
>
> Thanks. Thats rather useless output...

Why do you think this is useless?

> @@@ -404,7 -365,7 +404,7 @@@ static u32  next_vp
>    * performance critical channels (IDE, SCSI and Network) will be uniformly
>    * distributed across all available CPUs.
>    */
> - static void init_vp_index(struct vmbus_channel *channel, uuid_le *type_guid)
>  -static u32 get_vp_index(const uuid_le *type_guid)
> ++static void init_vp_index(struct vmbus_channel *channel, const uuid_le *type_guid)

One branch renamed get_vp_index to init_vp_index, the other branch added
the const attribute.  This hunk combines both changes.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
