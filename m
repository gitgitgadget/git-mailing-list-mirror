From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH RFC/RFD] clone: quell the progress report from init
Date: Thu, 25 Mar 2010 10:26:39 +0100
Message-ID: <4BAB2C4F.3080305@drmicha.warpmail.net>
References: <4BAB2234.4070202@drmicha.warpmail.net>	 <7b9006620fab4214ee0db53ebc9e0caffc397959.1269506526.git.git@drmicha.warpmail.net> <81b0412b1003250202m67dc4d2m9042d1242800cd27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Neal Kreitzinger <neal@rsss.com>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 25 10:29:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NujNf-0006ln-2N
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 10:29:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546Ab0CYJ33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 05:29:29 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:41033 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750903Ab0CYJ32 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Mar 2010 05:29:28 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0C469E910E;
	Thu, 25 Mar 2010 05:29:28 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 25 Mar 2010 05:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=BMbJSMhUii9am2kYAfkjqg18wqE=; b=ZXp0U9ph9eji+AGPF5KnQbgS8onGbuRfCGHgFkxTTHJtwjA5pTnCMI2LbKW8hejLGaMh6WpLxkVDBL8MxsRkLh5vDhzrhLS0j8f55+XHubwjmEuJP0SKf+ENzdjEyTQy70C19TbJ4L4j/42fO/dFV1SqLxBb5N6PgMP8MKHQjWY=
X-Sasl-enc: SJV2h/tnID7yfU8zcBkX82nSsXzfQOKh+Z8b28evmcoH 1269509367
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2576C4921B;
	Thu, 25 Mar 2010 05:29:27 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10pre) Gecko/20100319 Lightning/1.0b2pre Shredder/3.0.5pre
In-Reply-To: <81b0412b1003250202m67dc4d2m9042d1242800cd27@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143175>

Alex Riesen venit, vidit, dixit 25.03.2010 10:02:
> On Thu, Mar 25, 2010 at 09:46, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Currently, we really have two philosophies:
>> - report only on error
>> - be chatty on success
>>
>> I don't think that's a problem, but "simple" commands (e.g. branch, init,
>> add) should be in the former camp.
> 
> Right. Everytime add scrolls out the current terminal buffer I wish I
> had it sent to /dev/null.
> 
>>  builtin/clone.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> Sometimes I think a statistics like "1 byte inserted" are more appropriate :)

Yeah, I was thinking this would be the/a minimal patch, but I screwed it
with the commit message :)

> 
>> -       init_db(option_template, (option_verbosity < 0) ? INIT_DB_QUIET : 0);
>> +       init_db(option_template, (option_verbosity <= 0) ? INIT_DB_QUIET : 0);

Michael
