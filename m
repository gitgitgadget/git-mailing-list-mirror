From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: RFD: tables in documentation
Date: Sun, 02 May 2010 17:08:31 +0200
Message-ID: <4BDD956F.5070800@drmicha.warpmail.net>
References: <4BDC74F3.2020206@drmicha.warpmail.net>	 <20100502050622.GF14776@coredump.intra.peff.net>	 <4BDD7E96.2050603@drmicha.warpmail.net>	 <1272811394.24767.7.camel@dreddbeard> <1272811916.24767.16.camel@dreddbeard>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: wmpalmer@gmail.com
X-From: git-owner@vger.kernel.org Sun May 02 17:08:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8amd-00084o-4U
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 17:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756545Ab0EBPIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 11:08:34 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44236 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755008Ab0EBPId (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 May 2010 11:08:33 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9815CF2569;
	Sun,  2 May 2010 11:08:32 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Sun, 02 May 2010 11:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=dBX1LcwHG7DNNBDqjlYJNZn4So0=; b=Kb7FC3uBFEDpQo7zo+zmVpWjRLmIEg4lU/GDtfgpHNK85KQddxcDRANLg3WZBlE0Tp8TJ+0zOYeX2RrrCfpgYiVjNVYOGexykR4CnZGqxtagRW9FjObk8BUWcg9/QSddTFcOA3PUtmzNQGj7oiG5am/dy0BIj8G1q0WUTKW0Ubk=
X-Sasl-enc: +JN2EqdhlxWaTxgrm5Yn64DYS1CZ5XuUvNFnhoxmDA5x 1272812912
Received: from localhost.localdomain (p5DCC03EE.dip0.t-ipconnect.de [93.204.3.238])
	by mail.messagingengine.com (Postfix) with ESMTPSA id AD5AF49F9BF;
	Sun,  2 May 2010 11:08:31 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100429 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <1272811916.24767.16.camel@dreddbeard>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146180>

Will Palmer venit, vidit, dixit 02.05.2010 16:51:
> sorry about that, apparently "shift+enter" means "send" to this thing...
> 
> On Sun, 2010-05-02 at 15:43 +0100, Will Palmer wrote:
>> On Sun, 2010-05-02 at 15:31 +0200, Michael J Gruber wrote:
>>> Jeff King venit, vidit, dixit 02.05.2010 07:06:
>>>> On Sat, May 01, 2010 at 08:37:39PM +0200, Michael J Gruber wrote:
>>>> Did you put the source up anywhere? I didn't see it, but it would be
>>>> interesting to see how painful it is to write.
>>>
>>> http://repo.or.cz/w/git/mjg.git/shortlog/refs/heads/doc-use-tables
>>>
>>> Tough guess, I know ;)
>>>
>>> Michael
>>
> 
> that looks suspiciously like a format that's intended to be readable in
> both plaintext and eventually-generated form. This is me speaking in
> pure ignorance, but would something like (though I assume not exactly):
> 
> [cols="1,3*5,8"]
>    |=====================
>    |		   |I		 |H		|M		|Result
>    |     0	   |nothing	 |nothing	|nothing	|(does not happen)
>    |     1	   |nothing	 |nothing	|exists		|use M
>    |     2	   |nothing	 |exists	|nothing	|remove path from index
> .2+|	 3	.2+|nothing   .2+|exists	|exists, H == M |use M if "initial checkout", keep index otherwise
> 						 exists, H != M |fail
>    |=====================
> 
> work as intended?
> 

Uhm, how is that different from my patch (except for spaces which I
didn't bother with for this p-o-c)? [This is AsciiDoc - you know, do
you? ;)]

Jeff doesn't like the ascii art in the roff output (.1, as can be seen
in the .1.txt file). It looks very "strong", just like the content.

Further experimentation (editing the xml) indicates that with my
toolchain, I can either shut off all borders (between cells as well as
outer) or none. Why does working with the toolchain always frustrate me?
It's often a hindrance for improvements.

So, we could shut off all borders by adding an output dependent table
definition in asciidoc.conf, copying current asciidoc's own and
modifying it for docbook-man output. Is it worth it? Maybe others like
the strong ascii borders...

Michael
