From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC][PATCH] Print the usage string on stdout instead of stderr.
Date: Mon, 17 May 2010 13:46:30 +0200
Message-ID: <4BF12C96.9030802@drmicha.warpmail.net>
References: <878w7ieu4p.fsf@thor.thematica.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Giuseppe Scrivano <gscrivano@gnu.org>
X-From: git-owner@vger.kernel.org Mon May 17 13:46:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODymI-0004h2-6U
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 13:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755220Ab0EQLqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 07:46:25 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:37532 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754352Ab0EQLqY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 May 2010 07:46:24 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E9F07F6F21;
	Mon, 17 May 2010 07:46:23 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 17 May 2010 07:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=MB43WL8ASgFEHF/4yYFJFbhO80s=; b=LDTq0Xwe2Mx9AeoFvkFTEiwI9JXbNUZLtQl98UvKlSjahiQA8CU/dGcNhG9kxzYlVkySvfs9H3zQASX3NMQ962dd89eLUOlfP+MKX2AmMNX3DT3+5dc8sXSYFHs0hRgCUfdi72dN3hoeFTebvpgRHdSgzcAPAg2idoaYgX6U7xY=
X-Sasl-enc: sIpRStbJ583rlq7T93DZAPSRyziFnIXT+VS+19C2fyst 1274096783
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 54D114DDFF8;
	Mon, 17 May 2010 07:46:23 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100503 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <878w7ieu4p.fsf@thor.thematica.it>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147226>

Giuseppe Scrivano venit, vidit, dixit 17.05.2010 11:48:
> Hello,
> 
> I have noticed that the -h flag uses stderr to print the usage string,
> is there any reason for it?

As a general rule, regular output goes to stdout and error reports to
stderr.

Now, usage messages are displayed on specific request (-h) as well as
when a command is used with wrong arguments. So the classification
depends on the use case! But I reckon that even with '-h', usage strings
are not exactly "regular output", so stderr looks more natural to me.

More importantly, callers expect error messages on stderr, such as usage
with wrong arguments. I don't think scripts would call commands with
'-h', and if they do they do so on purpose and can parse stderr, knowing
there is no stdout in this case.

Michael

P.S.: I guess this means NACK from me FWIIW.

> 
> The small patch I have attached changes -h to print on stdout.
> 
> Thanks,
> Giuseppe
> 
