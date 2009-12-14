From: Junio C Hamano <gitster@pobox.com>
Subject: Re: am fails to apply patches for files with CRLF lineendings
Date: Mon, 14 Dec 2009 12:27:44 -0800
Message-ID: <7vvdg9i9mn.fsf@alter.siamese.dyndns.org>
References: <20091214183337.GA25462@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jk@silentcow.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 14 21:28:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKHWW-0001DH-5H
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 21:28:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755109AbZLNU15 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 15:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752881AbZLNU15
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 15:27:57 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60801 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729AbZLNU14 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2009 15:27:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AB6E81805;
	Mon, 14 Dec 2009 15:27:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vK8bKJAJAO3l
	8TNS1qUyG6B3rhQ=; b=GLFp25gURv3hg0qXLYOfCDwvG39LK1kQNPueGKgs6xq+
	yCzNGKvI4/lWgV2Z5dInz3lvQsozYC1+bUj9TfWDr0oSKtWWPGAFTW8hhamJl55L
	v6nsYTEQN2TkG015ijL8QiYbfIsyLkp1CgZ9JxmkyjxDPxw2otazr3aihzvo3rk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Px1liD
	/Fo3U+Vs5S1fTqEzlJ5uCu8/aJlBBkop7bXesyEZn8DGh1fn+8xzq9Mc0bFeb0tm
	h7zEEDFPIY45PxAfkFPQiOe2O7vq+buNWR0EZBXoE3a4kDTVZgrtw1aNp6y937SM
	p6aF3jPWkJQIwS053ChwF3yKf2H74LDWBZr+g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 64E981804;
	Mon, 14 Dec 2009 15:27:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 86DBD17FE; Mon, 14 Dec
 2009 15:27:46 -0500 (EST)
In-Reply-To: <20091214183337.GA25462@atjola.homenet> (=?utf-8?Q?=22Bj?=
 =?utf-8?Q?=C3=B6rn?= Steinbrink"'s message of "Mon\, 14 Dec 2009 19\:33\:37
 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 26D26C46-E8EF-11DE-8BDC-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135232>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> Commit c2ca1d7 "Allow mailsplit ... to handle mails with CRLF line-en=
dings"
> seems to be responsible.

Yes, that commit is not only responsible but was deliberate.  For a bet=
ter
backstory, see:

  http://thread.gmane.org/gmane.comp.version-control.git/124718/focus=3D=
124721

You'd notice that I was one of the people who didn't want to have this
change, so you don't need to convince _me_ that this was not a change t=
o
keep everybody happy, but you'd need to try a better job than I did bac=
k
then to convince people who thought that "am" should directly work on
"Thunderbird saved mails" that what they want was a bad idea X-<.
