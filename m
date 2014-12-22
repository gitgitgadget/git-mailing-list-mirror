From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 16/18] fsck: support demoting errors to warnings
Date: Mon, 22 Dec 2014 15:13:38 -0800
Message-ID: <xmqqppbb6zx9.fsf@gitster.dls.corp.google.com>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
	<cdd5730d0003a7220f659804e9e286e77619b57c.1418055173.git.johannes.schindelin@gmx.de>
	<xmqqzjavgym5.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412222319370.21312@s15462909.onlinehome-server.info>
	<xmqq38878gao.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412222344250.21312@s15462909.onlinehome-server.info>
	<xmqqtx0n710m.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412222356400.21312@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 23 00:13:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3CAd-0000l1-H2
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 00:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752369AbaLVXNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 18:13:43 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61796 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751162AbaLVXNm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 18:13:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9EDB429564;
	Mon, 22 Dec 2014 18:13:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ssmAHLvscRAciCiUvI4dTZhnRY4=; b=kINR6K
	wI2TzsJH0bH9rt3as8IahiOkV50hKBhXhUNDEyzQywuGmQzdUA570Hr92Zkx+v69
	8iwyLPIGvpgrrD5tneMC5CivvbuWU9PmQgGy4Ra7u5UY2csVZ9tQFDK7l+7oyiy3
	9jwXnsfqPxqv7p5YunIsMLja4FtWlOzcel4DA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VjHnETQwLdnQevbyHvZ06pziDewALmcc
	dHJzYjSj1UnQMtwcr9eWGxvNEZIdMI9WaCyPH62YeQPuxnIOVBfMO48K0Uc/gmVY
	z8mYz2Awc+HJjMXeFq7qtm7aLlEnmVaLdly91v8cBv5g2AYswMw8Iofn3Bz+dyeJ
	DNc6JHYc+Ow=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 94E7529563;
	Mon, 22 Dec 2014 18:13:41 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1DCD329562;
	Mon, 22 Dec 2014 18:13:41 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1412222356400.21312@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Mon, 22 Dec 2014 23:57:13 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2AEF7AFC-8A30-11E4-B2E5-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261696>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Mon, 22 Dec 2014, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > Of course you can say that! ;-) The problem these ugly messages try to
>> > solve is to give the user a hint which setting to change if they want to
>> > override the default behavior, though...
>> 
>> Ahh, OK, then dashed form would not work as a configuration variable
>> names, so missingTaggerEntry would be the only usable option.
>
> Except that cunning me has made it so that both missing-tagger-entry *and*
> missingTaggerEntry work...

Then the missing-tagger-entry side needs to be dropped.  The naming
does not conform to the way how we name our officially supported
configuration variables.
