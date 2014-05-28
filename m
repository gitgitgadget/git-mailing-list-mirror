From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git chokes on large file
Date: Wed, 28 May 2014 11:54:34 -0700
Message-ID: <xmqqmwe1d991.fsf@gitster.dls.corp.google.com>
References: <201405271647.s4RGlDJc024596@hobgoblin.ariadne.com>
	<CACsJy8BM1f1pJPzGPf--a-kUim6wyX+Mr1AfMupY3mpREY+8DA@mail.gmail.com>
	<201405281815.s4SIF5hF025886@hobgoblin.ariadne.com>
	<alpine.DEB.2.02.1405281121200.32611@nftneq.ynat.uz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Dale R. Worley" <worley@alum.mit.edu>,
	Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org
To: David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Wed May 28 20:54:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wpizt-00032x-TL
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 20:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754175AbaE1Sym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 14:54:42 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53739 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752042AbaE1Syl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 14:54:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A8F861AD69;
	Wed, 28 May 2014 14:54:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3pS/Y9FKYAloWAvvon8RKdikkrU=; b=gjqThy
	lBxDYoz/iAllBNSa7YVk0G1T/dBzbFxEuvQI2HRS75YJ0WLSsB0XdUmtINT8Pu38
	yzHDo46OExO3nRYwGmXlvuJdCDOdknqh6A/1/+qiFo4DLr2KMjrPxSoosdYUuoi5
	uYppth57mquoI7EKuxjXvFR3otArJW1mv1yO0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MIqMeEkTyziqlGV5wGGe3MgRqDGdRigj
	P8PoTBaW7FUZFrRsZ6B7DLRJ0Moe0Egtvw+iLWT0K/uLONPcLhhcr2ev79ohGB5D
	B3kLE4j4mUE89h7or1+PU6812RRs0bNPqNlm3BERcConPRF0+eVD7sXAkHPrfbVh
	ruTBznpdTJE=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9D3001AD68;
	Wed, 28 May 2014 14:54:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 47C8C1AD5C;
	Wed, 28 May 2014 14:54:36 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.02.1405281121200.32611@nftneq.ynat.uz> (David
	Lang's message of "Wed, 28 May 2014 11:23:10 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 83928CB6-E699-11E3-8E62-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250316>

David Lang <david@lang.hm> writes:

> On Wed, 28 May 2014, Dale R. Worley wrote:
>
>> It seems that much of Git was coded under the assumption that any file
>> could always be held entirely in RAM.  Who made that mistake?  Are
>> people so out of touch with reality?
>
> Git was designed to track source code, there are warts that show up in
> the implementation when you use individual files >4GB
>
> such files tend to also not diff well. git-annex and other offshoots
> hae methods boled on that handle such large files better than core git
> does.

Very well explained, but perhaps you went a bit too far, I am
afraid.

The fact that our primary focus being the source code does not at
all mean that we are not interested to enhance the system to also
cater to those who want to put materials that are traditionally
considered non-source to it, now that we have become fairly good at
doing the source code.
