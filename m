From: Junio C Hamano <gitster@pobox.com>
Subject: Re: am fails to apply patches for files with CRLF lineendings
Date: Mon, 14 Dec 2009 12:34:34 -0800
Message-ID: <7viqc9i9b9.fsf@alter.siamese.dyndns.org>
References: <20091214183337.GA25462@atjola.homenet>
 <7vvdg9i9mn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	jk@silentcow.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 21:34:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKHd7-00046M-A3
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 21:34:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbZLNUes convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 15:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbZLNUes
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 15:34:48 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49550 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbZLNUer convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2009 15:34:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B3A65A6BCC;
	Mon, 14 Dec 2009 15:34:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8xq6VWVerzB4
	Qt/PYwvXN061epM=; b=ruTmxriMry00Ai7ielFoIHg+iZWX/dbMmJCYBauQuIup
	MtWNknBRB70lVbEYCVFDKGKwha2buJkXmvhdDvrUje+i16JPlVCsyxaiBrtEvtBU
	jgjt8SYgW9e23TpcV5bffFwOHQXFCfCVxSnYz5klfX/XVHnhKnTXtF653kcfCCc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ehYCsf
	xJhyC8O+J4IEeonLcDgyv8MgMBoZydogLdBqCtNscA6iJw0N8EaA45kT7FFjdK+I
	E4vyGTARwKkbjaRXWw+hQIZhcUA0lFqKAuuQJRgigFFtTECunhOOpSQuMd0zrs7m
	SXPWCN/Iq6tkCf2X9jdzmYc0+bp1EkSYypSP0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 72C3EA6BC5;
	Mon, 14 Dec 2009 15:34:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 92B6BA6BC0; Mon, 14 Dec 2009
 15:34:35 -0500 (EST)
In-Reply-To: <7vvdg9i9mn.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 14 Dec 2009 12\:27\:44 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1BCF619A-E8F0-11DE-97B4-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135234>

Junio C Hamano <gitster@pobox.com> writes:

> Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:
>
>> Commit c2ca1d7 "Allow mailsplit ... to handle mails with CRLF line-e=
ndings"
>> seems to be responsible.
>
> Yes, that commit is not only responsible but was deliberate.  For a b=
etter
> backstory, see:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/124718/focus=
=3D124721
>
> You'd notice that I was one of the people who didn't want to have thi=
s
> change, so you don't need to convince _me_ that this was not a change=
 to
> keep everybody happy, but you'd need to try a better job than I did b=
ack
> then to convince people who thought that "am" should directly work on
> "Thunderbird saved mails" that what they want was a bad idea X-<.

Having said that, I think you can tell "format-patch" to emit it as mim=
e
attachment to work this around.  It _might_ even make sense to do so
automatically when the payload contains CRLF but that is a separate iss=
ue.
