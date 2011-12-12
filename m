From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC/PATCH] add update to branch support for "floating submodules"
Date: Mon, 12 Dec 2011 23:31:03 +0100
Message-ID: <4EE680A7.7040302@web.de>
References: <20111109174027.GA28825@book.fritz.box> <7vr51htbsy.fsf@alter.siamese.dyndns.org> <20111129220854.GB2812@sandbox-rc.fritz.box> <loom.20111210T062013-538@post.gmane.org> <7vborhaqgw.fsf@alter.siamese.dyndns.org> <CALFF=ZQKRgx_AodBQH17T9cSe_JFtoKie7DoMMfkTXCyCFospw@mail.gmail.com> <4EE61EED.50604@ursus.ath.cx> <CALFF=ZRYB1LkAY5WSC4Eydu-N0KNnWLLM2CfbSXZji18yO82gw@mail.gmail.com> <4EE64B04.8080405@ursus.ath.cx> <CALFF=ZRB7qjj7VMhzr12ySdHmZsySoqceu5brFht8rX1+W3NPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Andreas T.Auer" <andreas.t.auer_gtml_37453@ursus.ath.cx>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Leif Gruenwoldt <leifer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 23:31:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaEOv-0006do-R7
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 23:31:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754391Ab1LLWbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 17:31:10 -0500
Received: from fmmailgate04.web.de ([217.72.192.242]:39638 "EHLO
	fmmailgate04.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754299Ab1LLWbH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 17:31:07 -0500
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate04.web.de (Postfix) with ESMTP id 48A3B6F4D5AA
	for <git@vger.kernel.org>; Mon, 12 Dec 2011 23:31:06 +0100 (CET)
Received: from [192.168.178.25] ([80.187.110.206]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0McWXI-1RIhY004kC-00HcDw; Mon, 12 Dec 2011 23:31:05
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <CALFF=ZRB7qjj7VMhzr12ySdHmZsySoqceu5brFht8rX1+W3NPg@mail.gmail.com>
X-Provags-ID: V02:K0:UqoQpHzskrfePYu7PCgaZNmTaShykKA/PmiRQNaNh0r
 MR9qZwkYPqri2SlCAEdy2nuUqJfAhF5tEJcLc4ixoVXsYoBi7X
 xys3O37GcWNv5OF1ZeRfa+Bu2A9yyhMTTq7UcKEzCJSsGYCMBU
 lNh7s6SQMIfmDTyQJf8hh+CDFzSj7HShzN1wsvyy5lKvygFBNH
 rCh7BsSgui7Uw3moCro/Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186966>

Am 12.12.2011 20:13, schrieb Leif Gruenwoldt:
> On Mon, Dec 12, 2011 at 1:42 PM, Andreas T.Auer
> <andreas.t.auer_gtml_37453@ursus.ath.cx> wrote:
> 
>> The next question is: Wouldn't you like to have the new stable branch only
>> pulled in, when the projectX (as the superproject) is currently on that new
>> development branch (maybe master)?
>>
>> But if you checkout that fixed released version 1.2.9.8, wouldn't it be
>> better that in that case the gitlinked version of the submodule is checked
>> out instead of some unrelated new version? I mean, when the gitlinks are
>> tracked with the projectX commits, this should work well.
>>
>> And what about a maintenance branch, which is not a fixed version but a
>> quite stable branch which should only have bugfixes. Shouldn't the auto-pull
>> be disabled in that case, too?
>>
>> I think the "auto-pull" behavior should depend on the currently checked out
>> branch. So the configuration options should allow the definition of one or
>> more mappings.
> 
> Yes. I think you nailed it. The floating behaviour would best be
> configured per branch.

Why not use .gitmodules and make the "branch" setting work without having to
sync it?

> An aside. Would this mean a "git pull" on the product repo would
> automatically do a pull (git submodule update) on the submodule too?

Me thinks that only "git submodule update" should do that. Or what should
happen for people not using pull but just doing fetch and checkout?
