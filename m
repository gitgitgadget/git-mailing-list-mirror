From: Junio C Hamano <gitster@pobox.com>
Subject: Re: implement a stable 'Last updated' in Documentation
Date: Wed, 28 Jan 2015 22:18:42 -0800
Message-ID: <xmqqbnlif6t9.fsf@gitster.dls.corp.google.com>
References: <20150126172409.GA15204@aepfle.de>
	<xmqqd25zkeg7.fsf@gitster.dls.corp.google.com>
	<20150128080214.GA18851@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
X-From: git-owner@vger.kernel.org Thu Jan 29 07:18:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGiRK-0005J2-B0
	for gcvg-git-2@plane.gmane.org; Thu, 29 Jan 2015 07:18:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753779AbbA2GSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2015 01:18:46 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61712 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752727AbbA2GSp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2015 01:18:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 66D782931D;
	Thu, 29 Jan 2015 01:18:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uT49AIhie0a1lFl+VHp1YNGPNwA=; b=dZ53cU
	UO2LV/nJoPjU6VjsIC1s6X9xZ+O08QKocIGR29Lh7SidW0GZ/spQJJYwxdqtB7Gq
	ky49u4u17IOAgvqo3tCnPvTkVLdkxkd0ABlMjW8zm2/PezC4dBJTpkS/khLG9OpR
	fS/khfbEPfKu6pqpGcEb99LfJ788M6ngq1Gq0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TPRRBjQzGpT/ISS1r3ApcfLeagR1ayn9
	8DZnyX3F3gffxGJRq9nRaAXWMw7vUvqZ8Bcpqvx6AkBG3Y9GK16BAfBTwXfBj47z
	KvpaC7JnVYuDEczQKRMosJafDv9sYE6/2rBUekNKBKvGfPvb4ucPjU7z4QW6mDwq
	qpwASciu2qM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5CC4F2931C;
	Thu, 29 Jan 2015 01:18:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D8F252931B;
	Thu, 29 Jan 2015 01:18:43 -0500 (EST)
In-Reply-To: <20150128080214.GA18851@aepfle.de> (Olaf Hering's message of
	"Wed, 28 Jan 2015 09:02:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AD0D30A4-A77E-11E4-B6D0-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263139>

Olaf Hering <olaf@aepfle.de> writes:

> On Tue, Jan 27, Junio C Hamano wrote:
>
>> > What file timestamp should be used for them? Likely "../version"?
>> 
>> I tend to think the "Last updated" timestamp taken from the
>> filesystem timestamp is a bad practice inherited by these tools from
>> the days back when nobody used any revision control systems.
>
> I'm not sure. The bug is that such 'Last updated' line exists at all in
> the default output. Noone asked for it, noone really needs it. And it
> makes it impossible to get reproducible builds.

Amen to that ;-)
