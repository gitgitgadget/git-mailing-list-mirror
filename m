From: Pete Harlan <pgit@pcharlan.com>
Subject: Re: How to fork a file (git cp ?)
Date: Sun, 08 May 2011 12:40:56 -0700
Message-ID: <4DC6F1C8.8040007@pcharlan.com>
References: <4DC1934D.6070608@aldan.algebra.com>	<4DC19955.7040503@kdbg.org>	<7viptqdvrf.fsf@alter.siamese.dyndns.org>	<4DC20461.4090703@aldan.algebra.com>	<7v1v0ddhbz.fsf@alter.siamese.dyndns.org>	<4DC2FB0A.2090100@aldan.algebra.com> <BANLkTikE8aMh6RUDzrh=SuOxvKxuPShQhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Mikhail T." <mi+thun@aldan.algebra.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 08 21:42:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ9rf-0006Yo-L1
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 21:42:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755595Ab1EHTlv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 15:41:51 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:54134 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755405Ab1EHTlr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 15:41:47 -0400
Received: from homiemail-a51.g.dreamhost.com (caibbdcaaaaf.dreamhost.com [208.113.200.5])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 57279178136
	for <git@vger.kernel.org>; Sun,  8 May 2011 12:41:47 -0700 (PDT)
Received: from homiemail-a51.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a51.g.dreamhost.com (Postfix) with ESMTP id B237C2E805C;
	Sun,  8 May 2011 12:41:03 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pcharlan.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=pcharlan.com;
	 b=XIYq9ilXN6K/cgOegoqgZu/9cldraTVBR7ZVjWg+qjB7Vq/EvwjOLiHPm8jVS
	5g4BOFZT3fOd2CriPB/rPBceQG6neA6dyzIloFVMsxYAysKbucVSqJYOqXIBnSW5
	OjHiTZxFEdH8DuYXU8BQzJJpKXgM0GTUDfyFC25IiUUS30=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pcharlan.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=pcharlan.com; bh=u/EA
	xGtRYjFmb6dmSn3qqQIUwVE=; b=TF6IugJZFiKmnD9slXm/e83/U0kMJv7kBTAe
	2WVWE44KLEBuI3mamkbRBH644IGZ0JFpiw+X+iqH1NsLfBseC5tEP0U1I8xL0p9k
	EaQma1b9+KM8O7todG1JdEvH3e6kdA+1gk0Cd9G0ijP5KOZygh/UdX6Yo8cg4MY6
	zWWJlQ4=
Received: from [192.168.0.112] (185.132-78-65.ftth.swbr.surewest.net [65.78.132.185])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: pgit@pcharlan.com)
	by homiemail-a51.g.dreamhost.com (Postfix) with ESMTPSA id 650402E8058;
	Sun,  8 May 2011 12:41:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <BANLkTikE8aMh6RUDzrh=SuOxvKxuPShQhQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173174>

On 5/5/2011 1:01 PM, Piotr Krukowiecki wrote:
> On Thu, May 5, 2011 at 9:31 PM, Mikhail T.<mi+thun@aldan.algebra.com>  wrote:
>> On 04.05.2011 22:14, Junio C Hamano wrote:
>>>
>>> I think that is what exactly "blame -C -C" gives you.
>>
>> For that to be useful, one has to suspect, the file was derived by copying
>> something else... Simple "git log" will not suggest that -- unless the
>> commit message, that adds the new copy of a file points to it...
>
> Maybe it should be the default (performance issues?)

...

> BTW, I don't understand why 'status' shows renames but not copies:

Rename detection compares new files against deleted files.  Copy 
detection compares new files against every file in the tree, which is 
usually much more costly.

--Pete
