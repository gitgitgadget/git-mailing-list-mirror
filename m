From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is there some way to suppress Cc email only to stable?
Date: Mon, 09 Feb 2015 13:46:10 -0800
Message-ID: <xmqqpp9iahct.fsf@gitster.dls.corp.google.com>
References: <20150209194224.GA27482@linux.vnet.ibm.com>
	<xmqq386eby6w.fsf@gitster.dls.corp.google.com>
	<20150209211021.GB4166@linux.vnet.ibm.com>
	<xmqqtwyuaipa.fsf@gitster.dls.corp.google.com>
	<20150209214312.GC4166@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mingo@kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 22:46:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKw9p-0008HK-F9
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 22:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761359AbbBIVqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 16:46:13 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52040 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761134AbbBIVqM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 16:46:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 36B2F3721E;
	Mon,  9 Feb 2015 16:46:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HWLeHXBuHWfz6obC8ICPavxaY2Q=; b=JkzhA3
	AN6MLF109/04LgJ7U7c3p6braX5KR0ybfrtwd4E7mzeA9W4LxwWRDKvHXHEbhOP9
	M4+lp0im3y3qLEZvkZp1aUOiFzXJ9ND80oQaloA2lZulbvpE2BBD9iRQeM171wb6
	p5yukxqdlWymzh1oHRd7/DGrEzMIzgEt+EHrY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V06j45d83AY4uxfpDmhns9BWDbOwZxzE
	D7Ar/1bBRcChIB43hsEDiuirFT9FTCxui75BGdHKyscLz/HIrRg3ny8krxJJlde9
	sHMlwWTfSwmAcSGswi3xL8VccEM/X+hHa2h/xp32TD7oisZE2Yeibn0skj2PkD7U
	9W48xyWmEeQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CC3D3721D;
	Mon,  9 Feb 2015 16:46:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B8ECC3721C;
	Mon,  9 Feb 2015 16:46:11 -0500 (EST)
In-Reply-To: <20150209214312.GC4166@linux.vnet.ibm.com> (Paul E. McKenney's
	message of "Mon, 9 Feb 2015 13:43:12 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 104F01D6-B0A5-11E4-893D-38A39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263608>

"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> writes:

>> > Hence the desire to have a Cc that doesn't actually send any email,
>> > but that is visible in mainline for the benefit of the scripts that
>> > handle the stable workflow.
>> 
>> So a configuration variable that you can set once and forget, e.g.
>> 
>>     [sendemail]
>> 	blacklistedRecipients = stable@vger.kernel.org
>> 
>> would not cut it, as you would _later_ want to send the e-mail once
>> the commit hits the mainline.  Am I reading you correctly?
>
> This would actually work for me.  Once the patch is accepted into
> mainline, I am done with it.  So I should -never- send email to
> stable@vger.kernel.org, unless I am doing so manually, for example because
> I forgot to add the stable tag to a given commit.  But in that case,
> I would just use mutt to forward the patch to stable@vger.kernel.org,
> and git would not be involved.

OK, thanks, we have a workable design to let us move forward, then.

Gits, any takers?
