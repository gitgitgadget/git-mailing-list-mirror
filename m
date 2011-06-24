From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/3] protobuf: minimal implementation for compact
 in-memory structures
Date: Fri, 24 Jun 2011 09:48:11 -0700
Message-ID: <7vei2j18hg.fsf@alter.siamese.dyndns.org>
References: <1308728011-14136-1-git-send-email-davidbarr@google.com>
 <1308728011-14136-2-git-send-email-davidbarr@google.com>
 <7voc1p64ap.fsf@alter.siamese.dyndns.org>
 <BANLkTim3WeCHp=ECDBcbHjT=Guv_epL90Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Fri Jun 24 18:48:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qa9YK-0000OX-VY
	for gcvg-git-2@lo.gmane.org; Fri, 24 Jun 2011 18:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413Ab1FXQsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jun 2011 12:48:15 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38487 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773Ab1FXQsO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2011 12:48:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 13D5040B8;
	Fri, 24 Jun 2011 12:50:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d4JciGFb/XCNXC58qwAa/FTTM54=; b=xJIXZb
	aWSpWg+iHQWs5trKVCgq9AnSUveSdflDDNuxywqyyqFzQpSL2UECUeiZ7De6GWW4
	MuVTeOPCAAipAwg9H7RNuTq0OKBRyu6QUpkq9ilmWXgLEgk1wrDkrwhUc4N5Q5C2
	cQbnM5apeitu07M6+tTru0Vmmu8nhxOTxV9Qw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NTMdYIhW2QBpLB2JSHupIjDDf7vllQM+
	RgakmJgqnNL5VUHyKQ5AdPRWiK8l65Wa8qNnJ0CY2TPEH22/AdFOstig29kUSSvf
	hMCcKhBCa0qmmMzzDISNn65H1sjl3w4ZR9jcZCfrVDSJZ6ti3D5TNmbCkszy7T2H
	xryMQJgGo68=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0AB8C40B7;
	Fri, 24 Jun 2011 12:50:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 62C4040B6; Fri, 24 Jun 2011
 12:50:24 -0400 (EDT)
In-Reply-To: <BANLkTim3WeCHp=ECDBcbHjT=Guv_epL90Q@mail.gmail.com> (David
 Barr's message of "Fri, 24 Jun 2011 09:04:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0E4F629C-9E82-11E0-904D-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176310>

David Barr <davidbarr@google.com> writes:

>> How does this relate to http://code.google.com/p/protobuf/ which has a
>> very similar name?  If we do not intend to have any interoperability with
>> it, we should avoid such a confusing name, I think.
>
> The relationship is that the design is shamelessly copied.

... and this will be API and bytestream compatible with that other
protobuf?

If not, please don't use that name. It confuses people, and if somebody
wants to take libified part of our codebase into their application and
link with the real protobuf, it will get even more confusing ;-).

You can (and should) still state that the design was inspired by the other
work in the comment at the beginning of the file or something.

Thanks.
