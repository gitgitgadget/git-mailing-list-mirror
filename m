From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: turn on test-lint-shell-syntax by default
Date: Tue, 05 Feb 2013 13:56:24 -0800
Message-ID: <7vwqumqvav.fsf@alter.siamese.dyndns.org>
References: <201301120650.46479.tboegi@web.de>
 <7vvcb37xfe.fsf@alter.siamese.dyndns.org> <50F28BB5.9080607@web.de>
 <20130113173207.GC5973@elie.Belkin> <7v4nikiu81.fsf@alter.siamese.dyndns.org>
 <50F5B83E.9060800@web.de> <7vk3re2ncb.fsf@alter.siamese.dyndns.org>
 <51037E5F.8090506@web.de> <20130127093121.GA4228@elie.Belkin>
 <5105280A.80002@web.de> <7v4ni2y1fm.fsf@alter.siamese.dyndns.org>
 <51116D3E.3070409@web.de> <7v4nhqsctb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	kraai@ftbfs.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Feb 05 22:56:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2qVY-0008KS-CD
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 22:56:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757004Ab3BEV43 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Feb 2013 16:56:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60306 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756995Ab3BEV41 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Feb 2013 16:56:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1769A9E0C;
	Tue,  5 Feb 2013 16:56:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=kKtpnh061s4j
	5dW5o0E20OiuNoM=; b=NsAhJ5lQXtCsb/swRbALcvKcxxLqKLZ6TEkgxrJFFcnb
	3dZ/LTrfEOxKaeOzHxiPY3Fk0dcj6Pmf6x8kd+fZyvbNdyv2whNxsU3TVZhMRLO3
	zBhO+ZxQlCfHJ5p4BOzUlq9fGMY0987+LUXGoY9in5LvNKsdh8y8QTvoS8madio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=YwsrO7
	NgTuzNcqHjScP3N5Vpsfy7qoaVi0idRmRs0YfsZe0VZdedZMZsnBSvmv3ve35sF3
	jhnguUfZLwC9UUCdguklqqpX5eeJjWyKc0XSnV6ReLZa0htz5fjfPkaW2J+g09yz
	4ZM5zReZwhZn2koIJ/IySrvrnoLMPL7NOqmuk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CC0F9E0B;
	Tue,  5 Feb 2013 16:56:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8044E9E0A; Tue,  5 Feb 2013
 16:56:25 -0500 (EST)
In-Reply-To: <7v4nhqsctb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 05 Feb 2013 12:52:48 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E2EFEABA-6FDE-11E2-8338-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215544>

Junio C Hamano <gitster@pobox.com> writes:

> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> Thanks for the detailed suggestion.
>> Instead of using a file for putting out non portable syntax,
>> can we can use a similar logic as test_failure ?
>
> Your test_bad_syntax_ function can be called from a subshell, and
> its "exit 1" will not exit, no?

What is more important is that the increment to $test_bad_syntax
done in that function will not be propagated up to the main process
that runs the test framework.

Of course, that is why I mentioned communicating using the
filesystem.
