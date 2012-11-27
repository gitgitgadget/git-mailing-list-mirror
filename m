From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/7] New remote-bzr remote helper
Date: Tue, 27 Nov 2012 15:32:55 -0800
Message-ID: <7vehjelizc.fsf@alter.siamese.dyndns.org>
References: <1352643598-8500-1-git-send-email-felipe.contreras@gmail.com>
 <CAMP44s2F9C4cr6v===M3AWHieaiUk1adigcU8txpZPL0wN81Ow@mail.gmail.com>
 <7v4nkdxawx.fsf@alter.siamese.dyndns.org>
 <CAMP44s1G3b3XQX+=5Ag2exdy83hULbz1m0Z6UFDrhZU2TGwBMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 00:33:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdUeR-0004Ei-7U
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 00:33:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756452Ab2K0XdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 18:33:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54121 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756023Ab2K0Xc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 18:32:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 783159DBF;
	Tue, 27 Nov 2012 18:32:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YlqL8BS/pJaPQZgOTlBcUWyENdg=; b=aLxxu3
	Eijt46XgtHpS3FCrOpsw7X9gvotXZk71KCaZYL495Ohj2Pvua/2DPSIS7i0Qi4bQ
	SNO9H8BRix/xIRdsRb2Gjma5/RDOK5C4gO99O66msdpO+mlPYI0CKjXtwFeO0UNr
	b6i8whezRNClYFcDqsIM+M6MoqaD77jKPTO/s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t6BcEPOJuUXbzcFpIoE5MXBP9/0PlG0I
	BWc5ZF/A1mRglLdKzmJZHlk69LztYq7Ot1QFxU3Mx71d3CXW7anWwl7pc1gcG9pM
	SU5xrKFhMzEQ2q62TC8ORR6Fa/1FGdr5yI6r6itmf7w+VdPlhopcYpCphJ5m4V05
	FrNl35mhp3k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65B409DBE;
	Tue, 27 Nov 2012 18:32:57 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BF4A89DBB; Tue, 27 Nov 2012
 18:32:56 -0500 (EST)
In-Reply-To: <CAMP44s1G3b3XQX+=5Ag2exdy83hULbz1m0Z6UFDrhZU2TGwBMg@mail.gmail.com> (Felipe
 Contreras's message of "Mon, 26 Nov 2012 12:34:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C5E179BE-38EA-11E2-9C7C-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210631>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Mon, Nov 26, 2012 at 5:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> On Sun, Nov 11, 2012 at 3:19 PM, Felipe Contreras
>>> <felipe.contreras@gmail.com> wrote:
>>>> This is a re-roll of the previous series to add support to fetch and push
>>>> special modes, and refactor some related code.
>>>
>>> It seems this one got forgotten, I only see v2 in pu.
>>
>> Oops; I think that was fell through the cracks during the maintainer
>> hand-off.  As the previous one has already been cooking in 'next'
>> for a week or so, I would appreciate if you send incremental updates
>> to fix or enhance what is in there.
>
> Yes, that's what I have planned for the next patches, as I already did
> for remote-hg, but the changes in remote-bzr were a bit bigger.

OK.  Both fc/remote-hg and fc/remote-bzr are slated for 'master'
soonish, but I take the above to mean that fc/remote-hg is ready
while it is better to wait for updates to fc/remote-bzr before
merging it.

Thanks.
