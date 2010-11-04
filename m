From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] rebase: teach --autosquash to match on sha1 in
 addition to message
Date: Thu, 04 Nov 2010 12:09:32 -0700
Message-ID: <7vr5f0vrbn.fsf@alter.siamese.dyndns.org>
References: <1288838504-69114-1-git-send-email-kevin@sb.org>
 <1288838504-69114-2-git-send-email-kevin@sb.org>
 <5CCA000B-2178-4DF7-8D72-29F95A9BB360@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Nov 04 20:09:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE5Bx-0000dV-Pg
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 20:09:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360Ab0KDTJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 15:09:41 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58877 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731Ab0KDTJk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 15:09:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AB2AC367A;
	Thu,  4 Nov 2010 15:09:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=keApQcjGlA6fdAdiiy5pHsk1RIg=; b=fmeU+E
	uNFhDHxa53gElJo68WoHoaCGyHtdYvAEjJxbe7pUUVTfihaLSjd5A4FtRjCEwKu8
	gSzJfzC1lzJiOaMg56TsILZ4TsigbZKFozNMWyLDB1/ExXKkFXGEXTCoZkD2CWNH
	9M1C2v58UM2S7PzbaFvfiPPu7RG0WnohCiN9c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XmjtXX2Liys/xgSn60sTNExudijNeoNR
	dPnk64jbDSxvIPUwXIfOIKDv8tOEkSIQIWALCXHFZ85cXUXjLtrMJ/FYx1kVujpt
	CIEtalGvxWmAz/5lLNi6VCtMpMU+vq1wK6yri9QBULzSZkeZ9xiYqdxvN+kgiOmg
	tQWluHhhmYA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8901E3679;
	Thu,  4 Nov 2010 15:09:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AFBA23678; Thu,  4 Nov 2010
 15:09:34 -0400 (EDT)
In-Reply-To: <5CCA000B-2178-4DF7-8D72-29F95A9BB360@sb.org> (Kevin Ballard's
 message of "Wed\, 3 Nov 2010 21\:49\:10 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1150941C-E847-11DF-8A76-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160750>

Kevin Ballard <kevin@sb.org> writes:

> On Nov 3, 2010, at 7:41 PM, Kevin Ballard wrote:
>
>> Support lines of the form "fixup! 7a235b" that specify an exact commit
>> in addition to the normal "squash! Old commit message" form.
>
> I just realized that this only works for sha1's of up to 7 characters.
> If you provide more it won't match, as it's comparing against the sha1
> given in the todo list. I wonder if it's worth resolving all sha1s to
> their full length if the provided string is longer than 7 characters?

Yeah, this is a nice feature I sometimes missed ;-)
