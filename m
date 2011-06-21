From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/13] revert: Propogate errors upwards from
 do_pick_commit
Date: Tue, 21 Jun 2011 12:19:47 -0700
Message-ID: <7viprz8018.fsf@alter.siamese.dyndns.org>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
 <1308661489-20080-5-git-send-email-artagnon@gmail.com>
 <20110621162232.GI15461@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 21:19:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ6UN-0007Qe-VD
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 21:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757402Ab1FUTTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 15:19:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38209 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756933Ab1FUTTu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 15:19:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BC7F24767;
	Tue, 21 Jun 2011 15:22:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T6UteXB9g8v/iKuhZi82TONX3Fc=; b=Ye2jiR
	hOy4vLbBuyanBH7GyKVg8nqNr6KulDhbXBppH8kT9uK7PqDGJW/hm0jL/j0HawVj
	WXLDkAXWMDwuim4OONA2lbun21qFF5g+2vk42hfHgd0esxjq+dDDKYM3Gx1soFxr
	198KaKHw79fgsoVKwOA4bepZl4nX01c7hDDRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ws1fVXAvdQpVXS/sF1c/sGieqcJG45Wn
	xgGZE4oxMG989Tu/o3oi665GYpNZ4rw37ybR63AvtIl1tWHuTqBH3g3JxfCPmiCR
	zZkwc+3D81IEkM86pmyYqkIX9+dtKWpHslFSVQHkQfPrR3qeYTjydDxUGRC2EXnP
	ovkFLu39k2Q=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B23B84766;
	Tue, 21 Jun 2011 15:22:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 022884765; Tue, 21 Jun 2011
 15:22:00 -0400 (EDT)
In-Reply-To: <20110621162232.GI15461@elie> (Jonathan Nieder's message of
 "Tue, 21 Jun 2011 11:22:32 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BD13D748-9C3B-11E0-9CD1-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176184>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> +	if (res < 0)
>> +		die(_("%s failed"), me);
>> +	return 0;
>
> Should the "revert" or "cherry-pick" here be part of the message
> marked for translation?  A translator might want to paraphrase to
>
> 	fatal: failed to cherry-pick
>
> if that is more natural in the language at hand.

Wouldn't such a message file simply say

	msgid "%s failed"
        msgstr "failed to %s"

IOW, I am not sure what problem you are seeing.
