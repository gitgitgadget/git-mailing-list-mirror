From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] git-send-email: add ~/.authinfo parsing
Date: Tue, 29 Jan 2013 16:34:22 -0800
Message-ID: <7v1ud3o6ep.fsf@alter.siamese.dyndns.org>
References: <7vehh3obs0.fsf@alter.siamese.dyndns.org>
 <5d18d777d6ddf6f01bbf460f37af637d3dc28ed5.1359503987.git.mina86@mina86.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Krzysztof Mazur <krzysiek@podlesie.net>,
	Michal Nazarewicz <mina86@mina86.com>
To: Michal Nazarewicz <mpn@google.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 01:34:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0Lda-0001W3-0W
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 01:34:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752276Ab3A3Ae1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 19:34:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34206 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751652Ab3A3AeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 19:34:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14D3AC1A4;
	Tue, 29 Jan 2013 19:34:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kbERRqegRB9P8nmjSKR1EHhx1ww=; b=vn3dLt
	fNw621HomW654y1Djo6l83/69vxJT+G+sWHRAp67tOZ5ZHDFpyEHwimtRRvmcz41
	0lZg7fM5Hu5cu1Tjgo3sN5w2qobU+tq+yfOIt1GB4IKlDszMi24lOOB+ux8A29y1
	TtG++rkYBGdlFJrT1AudRm7RiFySFZQ94Awyw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cZMf4k/YNsg7Fpt3fZu6zhtYge/unGSn
	MT2JnJArVIJ6YN7LQ1fBc6p4hRJ7kiYHhwdmeIzKZvOBYE9js3FMcSzlnHVDGHlJ
	15OuVl9XtslM2/DVBM21gCUUyueZPt37POQ0UpyFyHiuVDtvIDaiIQIQ8iOET1E/
	gGEOuaGeNaA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F19A7C1A2;
	Tue, 29 Jan 2013 19:34:24 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C5C5C19F; Tue, 29 Jan 2013
 19:34:24 -0500 (EST)
In-Reply-To: <5d18d777d6ddf6f01bbf460f37af637d3dc28ed5.1359503987.git.mina86@mina86.com>
 (Michal Nazarewicz's message of "Wed, 30 Jan 2013 01:03:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CBF5E040-6A74-11E2-821A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214984>

Michal Nazarewicz <mpn@google.com> writes:

>> Is it bad to use Net::Netrc instead?  This looks like exactly the
>> use case that module was written for, no?
>
> I don't think that's the case.  For one, Net::Netrc does not seem to
> process port number.
>
> There is a Text::Authinfo module but it just uses Text::CSV.
>
> I can change the code to use Net::Netrc, but I dunno if that's really
> the best option, since I feel people would expect parsing to be
> somehow compatible with
> <http://www.gnu.org/software/emacs/manual/html_node/gnus/NNTP.html>
> rather than the original .netrc file format.

Thanks for pushing back (I wish more contributors did so when I
suggest nonsense ;-)); you are right that both canned modules are
lacking.

Will queue.  Thanks.
