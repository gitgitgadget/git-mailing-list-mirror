From: Junio C Hamano <gitster@pobox.com>
Subject: Re: `format:%>` padding and `git log --graph`
Date: Tue, 22 Dec 2015 08:08:50 -0800
Message-ID: <xmqqlh8mea99.fsf@gitster.mtv.corp.google.com>
References: <CAPZ477ObN53VffNVvHVuqT0MQ2Csu70i0+himmmjvPj1wfXjUQ@mail.gmail.com>
	<20151222113309.GA8804@lanh>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Elliott Cable <me@ell.io>, git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 17:09:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBPUi-0006Zv-IP
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 17:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135AbbLVQIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 11:08:54 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50415 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751859AbbLVQIx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2015 11:08:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 870AC33459;
	Tue, 22 Dec 2015 11:08:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TJr3+1rRDP5Tx+G7qkowbwGWPSc=; b=jLPvU3
	A9axPgjoJBRoKCV94JIOJaNID9/R+5f5iUO4rxyo2FZZyXxLK7orGej4ULZmIlWA
	wO0/0PnzsAgl0G6dun7vhyLMh2KvPg0dHfqipmiC9IGU4RfyietaK8mvXJQ3xqOc
	jEJ9NIcfGSFvNCXKNtKvETDBwMHzMfxPo/w2c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WnxFxdjuXK4XMIOaqKc2C4lYxV74IA9v
	cTeizVsieHCBgOjBVtGE41/A99VcEk3onYpadFhtIayR4pQXyEipnyit3xNuaOt6
	6RjnMcjTdL6gtoVdOkCTEvpLOzYizgGcpJCRFO4VDS9AhQXeN8zZw8DFpMTBC5R6
	ucPU34zb2YI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7E59933458;
	Tue, 22 Dec 2015 11:08:52 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E3B5333457;
	Tue, 22 Dec 2015 11:08:51 -0500 (EST)
In-Reply-To: <20151222113309.GA8804@lanh> (Duy Nguyen's message of "Tue, 22
	Dec 2015 18:33:09 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4AF852C8-A8C6-11E5-9DBB-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282882>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sun, Dec 20, 2015 at 10:41:44AM -0600, Elliott Cable wrote:
>> I'm not sure what version the `%>` / `<|` / etc padding showed up in,
>> but they're truly excellent for building beautiful one-line `git log`
>> output.
>
> Somebody found my code useful!! :-D

Is this related to

    http://thread.gmane.org/gmane.comp.version-control.git/277710/focus=278326

in any way?  My gut feeling is that, while the original patch itself
breaks existing uses and is not acceptable as-is, its idea is good,
and we are OK with a change like that if it added a new/different
kind of %>|(N) that makes the new behaviour available to those who
want to use it, without negatively affecting existing uses.
