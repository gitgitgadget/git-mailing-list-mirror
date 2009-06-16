From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] builtin-remote: (get_one_entry): use strbuf
Date: Tue, 16 Jun 2009 09:39:58 +0200
Message-ID: <4A374C4E.2090304@drmicha.warpmail.net>
References: <4A35FCFB.1080000@drmicha.warpmail.net> <1245098728-7502-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jim Meyering <jim@meyering.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 09:40:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGTHS-0008HZ-JC
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 09:40:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759783AbZFPHkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 03:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757499AbZFPHkR
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 03:40:17 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:53686 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753428AbZFPHkO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Jun 2009 03:40:14 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id CABAB362135;
	Tue, 16 Jun 2009 03:40:16 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 16 Jun 2009 03:40:16 -0400
X-Sasl-enc: sGCOv+23IWYxfSGoeo4w2pQDcmlJp2D5T2M9kAkTvgHa 1245138016
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 127D645EA8;
	Tue, 16 Jun 2009 03:40:15 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1pre) Gecko/20090615 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <1245098728-7502-1-git-send-email-bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121662>

Bert Wesarg venit, vidit, dixit 15.06.2009 22:45:
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> 
> ---
> 
> On Mon, Jun 15, 2009 at 09:49, Michael J Gruber<git@drmicha.warpmail.net> wrote:
>> Jim Meyering venit, vidit, dixit 14.06.2009 21:46:
>>>
>>> * builtin-remote.c (get_one_entry): Use xmalloc, not malloc.
>>
>> Learning something new with every patch... Sorry, Junio; thanks, Jim!
>>
> One more reason to re-use existing string handling functions.

Well, when we discussed this before v2 I asked for guidance about
strbuf, esp. regarding the issue of allocating/freeing. From your patch
I infer that "strbuf_detach" is what I was looking for. (And yes, it is
in the api doc where I overlooked it.)

>  builtin-remote.c |   21 ++++++++++-----------
>  1 files changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/builtin-remote.c b/builtin-remote.c
> index 709f8a6..31adeaa 100644
> --- a/builtin-remote.c
> +++ b/builtin-remote.c

For whatever reason, your patch does not apply (am) here on top of next
+ Jim's patch. Given the context (xmallocs), it looks like it's against
something + Jim's patch. OTOH: 709f8a6 show's a get_one_entry with
mallocs. Did you hand edit the diff?

Michael
