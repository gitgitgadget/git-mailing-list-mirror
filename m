From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 2/2] status: always show tracking branch even no change
Date: Mon, 26 Aug 2013 09:08:50 -0700
Message-ID: <xmqqvc2sigdp.fsf@gitster.dls.corp.google.com>
References: <2f3a942d7049e80dca689aa68d494b70c288f2c7.1377500206.git.worldhello.net@gmail.com>
	<1861495981.5462037.1377503238201.JavaMail.root@openwide.fr>
	<CANYiYbFNGZ=Y4BagNyrZEhO2c6O_J7g-MjA35fqBj2B9aXQf5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeremy Rosen <jeremy.rosen@openwide.fr>,
	Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 26 18:09:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDzLh-000631-Q4
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 18:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182Ab3HZQI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 12:08:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44968 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751933Ab3HZQI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 12:08:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 225AB3C9D8;
	Mon, 26 Aug 2013 16:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y0PUAHbjQAalQ3E1Zpo4+9w09No=; b=O7PsGt
	nHdX2afnyDXI7361EvCt+sN6pqdA5XKfL4eEpvrPOZlX48MWM459tZMiNgOscdkb
	4fUI+USAkP9dCqPCdBg0smhpNdqvgMmadT7j4BeeokGu7BZgvTagNaLgdJ4FGFtW
	F/PWhHGEBVPHK11XhHE/CmTYowld2NURi7XoE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PmNsPE5Y3fHnotZ/xm8kfoSRD0DuEZOc
	4YzeQ+B0eWUWyxfk0kg2qH8oLh9Dt7QVAMrAYsDirwgv8vLHLU6in59W+M2Zw3t5
	WWuBHGDMBRd6wogOEZvL9/x7Dl//5Wa4cRZmnMDbYDmtkRFVc2RHNViQDyHxFNtX
	E8GxHUXfjtc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A51C33C9D3;
	Mon, 26 Aug 2013 16:08:54 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0AEB53C9CD;
	Mon, 26 Aug 2013 16:08:52 +0000 (UTC)
In-Reply-To: <CANYiYbFNGZ=Y4BagNyrZEhO2c6O_J7g-MjA35fqBj2B9aXQf5w@mail.gmail.com>
	(Jiang Xin's message of "Mon, 26 Aug 2013 16:04:00 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CD6A616E-0E69-11E3-84DF-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232998>

Jiang Xin <worldhello.net@gmail.com> writes:

> 2013/8/26 Jeremy Rosen <jeremy.rosen@openwide.fr>:
>>
>> nitpicking, but shouldn't this be worded as "up to date" rather than "identical" ?
>>
>> The reason is that identical gives the idea that the two branch happen to be on the same
>> commit wheras "up to date" gives the idea that there is a special relationship between
>> these two particular branches. We are not just listing all branches on the same
>> commit as us, we are actively telling you about this branch because it's interesting
>> to you.
>
> That's better. I want to use 'up to date' in the beginning, but I don't know
> which prep. should be used. Now I realize I should:
>
>     s/identical to/up to date with/

Yeah, that, or "in sync with" which may be a bit shorter.

I'll queue with "up-to-date with", as "git grep 'up to date'" tells
me that it is less common than "git grep 'up-to-date'", for now.

Thanks.
