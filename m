From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Q] Determing if a commit is reachable from the HEAD ?
Date: Mon, 23 Jan 2012 08:09:38 -0800
Message-ID: <7vk44i9z99.fsf@alter.siamese.dyndns.org>
References: <201201201433.30267.brian.foster@maxim-ic.com>
 <CAMK1S_gkZYpK3nrNMsnmFzi=tzjyEjVwOo_j4Z=d0hqjdF7r_w@mail.gmail.com>
 <201201231020.04041.brian.foster@maxim-ic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git mailing list <git@vger.kernel.org>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: Brian Foster <brian.foster@maxim-ic.com>
X-From: git-owner@vger.kernel.org Mon Jan 23 17:09:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpMSr-000585-KT
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 17:09:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131Ab2AWQJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jan 2012 11:09:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33380 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750885Ab2AWQJm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 11:09:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08FFC524D;
	Mon, 23 Jan 2012 11:09:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B5GZjeeOYtVeeUFX/oqeWNsZwvI=; b=MyUAw0
	/W6Jv9tOCXA4E6jAmOa78IL2dDZxp+Ku+U8BzkEpHG35bg1Wzy5jOMfmxBSogOFn
	ZNXmM3VbyFTeZ/97N6JcZQxMtpVLldE5WCGT8rVGV+jfD5xzZrp1BuFR0mHqLE0V
	CI3XNQMchCEBu/xFb7DgkWo59hz1zbfYLQ93Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x6/brhZLRnh42KW1+rKvo1M5VzlmEhGc
	N9JEJFkrutyZWCIT0hGhOqSIn92uhnDWod/CvtW7V3xo75S3wtEVqcLEgSaqt3XW
	U1INVaTYFIe20kqSKRSHVWOMfN9lj3NuQCZGBda2wTznjM/jB6KMKvvXUt2Eueb/
	qANjIMGOBGA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0043E524C;
	Mon, 23 Jan 2012 11:09:41 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 88080524B; Mon, 23 Jan 2012
 11:09:40 -0500 (EST)
In-Reply-To: <201201231020.04041.brian.foster@maxim-ic.com> (Brian Foster's
 message of "Mon, 23 Jan 2012 10:20:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A7A6F25A-45DC-11E1-B177-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188997>

Brian Foster <brian.foster@maxim-ic.com> writes:

>  I am probably misunderstanding ‘--quiet’, which the
>  man page cryptically describes as “... allow the
>  caller to test the exit status to see if a range
>  of objects is fully connected (or not).”  What is
>  meant here by “fully connected” ?

If the real history looks like this:

 ---Y---x---HEAD

i.e. the commit at HEAD says "parent x" in it, and your lacks "x"
for whatever reason, Y..HEAD is not fully connected.
