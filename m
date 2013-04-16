From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Resend PATCH] t3903 (stash): add failing test for ref of form
 ^{/message}
Date: Tue, 16 Apr 2013 14:06:55 -0700
Message-ID: <7vobdejic0.fsf@alter.siamese.dyndns.org>
References: <1366135765-18437-1-git-send-email-artagnon@gmail.com>
 <7vmwsyl3mv.fsf@alter.siamese.dyndns.org>
 <CALkWK0=JdJGf7+yWvi2xkoruixK5G5mnQXm8pFhK60NQB2qX0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 23:07:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USD5i-0000PJ-4q
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 23:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965248Ab3DPVG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 17:06:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60991 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965213Ab3DPVG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 17:06:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A8631786E;
	Tue, 16 Apr 2013 21:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PmDlrVyJZmfnQqlvE58uFUSG0to=; b=mS3Vbz
	0Rj4fgWWL8MTaaKSuS2G7X+nhEq4Xg1TQ+RDbd08c8saypgpmmuX8c+o/tly7xNg
	F4rAPEglAqN71HzUfY3Zp/dRCMrhrv2I2gzKjN2SDBKRXNo6hYidlOtKoWh00/i8
	1r5ChcU6oL+Y4GZKJ3bgqmHQag93+xb/LQNGU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bDPETxGNpFGWdot2ut/haqLlYspwCOPF
	3JpbBA1NoOoen+LnjFj0g0B1EcN2QDO9rBtl9OkCII2PE7iv8UNfXc+m7yk5+fIN
	TelgdN9pD1SeLicfEoDqtqEkRomdH9L1ZowiXianhLs93tXFnvHvS+7f3yzTSOEW
	p+YDMObntNM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12EF61786D;
	Tue, 16 Apr 2013 21:06:57 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8A6AE1786B; Tue, 16 Apr
 2013 21:06:56 +0000 (UTC)
In-Reply-To: <CALkWK0=JdJGf7+yWvi2xkoruixK5G5mnQXm8pFhK60NQB2qX0Q@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Wed, 17 Apr 2013 01:53:21 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9237AB26-A6D9-11E2-A089-CC48E7F0ECB6-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221472>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> I do not think anybody considered the approach to look at the commit
>> object name and making sure it appears in the reflog that implements
>> the stash. It sounds like a more robust check if done right.
>
> Actually, if you think about it, there is really only one way to
> specify revisions in the stash's reflog: stash@*.
> ...
> * although I'd have been more comfortable if we had a neater way to specify that

Yup.  "git stash pop +4", without a must-be-it token "stash" or
mandatory "@{}" frill would have been much nicer.
