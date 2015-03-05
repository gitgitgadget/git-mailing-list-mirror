From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] versionsort: support reorder prerelease suffixes
Date: Wed, 04 Mar 2015 17:28:41 -0800
Message-ID: <xmqqmw3s5j1y.fsf@gitster.dls.corp.google.com>
References: <CAPc5daVJJcC--mwq0PfAczge3zG44ToDKP853FkyZ3x1KUfsig@mail.gmail.com>
	<1424947441-19134-1-git-send-email-pclouds@gmail.com>
	<xmqqvbinhw7l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 02:28:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTKau-000841-8D
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 02:28:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753802AbbCEB2s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 20:28:48 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63555 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753755AbbCEB2q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 20:28:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 65EED3CE0D;
	Wed,  4 Mar 2015 20:28:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hsDTxe0mxUQZGs3HvS9Y1MUa5YY=; b=i6FyyV
	EZmGLU7vjd4TrbQb4Wnw5MXP8cD8b49X1HInnRUw3gTp6B6doq1a6bB73l+g3GCt
	4xkZjuNL8FecvIe/U1jlqL1B3wRV/qGFxFntvy/J7UMWub4B7o7eaam7P8gL3RAr
	R5ucEjrC+bBLw1xKHABpLfqjQ2BbM5I3Er/fQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CwoEFCe3sgroLNjFfutbCFO8n2I86yXr
	XJ1z0RaMT7cqe4ciN0On5VZatvIL2bPoq3ky/Y7KhFchrrKjEt8BCQsl7S+LoQGV
	XycHryGR7IOChTUKfuQwSXrpB4qlK9ZEZJtkCJZiFWCR98FVoHqSod1KF+VDyRHI
	TIAGFaeG1Cc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5EDC13CE0C;
	Wed,  4 Mar 2015 20:28:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D7BEB3CE0A;
	Wed,  4 Mar 2015 20:28:42 -0500 (EST)
In-Reply-To: <xmqqvbinhw7l.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 27 Feb 2015 13:37:50 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F64C8878-C2D6-11E4-9B1A-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264808>

Junio C Hamano <gitster@pobox.com> writes:

>> +versionsort.prereleaseSuffix::
>> +	When version sort is used in linkgit:git-tag[1], prerelease
>> +	tags (e.g. "1.0-rc1") may appear after the main release
>> +	"1.0". By specifying the suffix "-rc" in this variable,
>> +	"1.0-rc1" will appear before "1.0". One variable assignment
>> +	per suffix.
>
> I think the last half-sentence want to mean that
>
> 	[versionsort]
>                 prereleaseSuffix = -pre
>         	prereleaseSuffix = -rc
>
> is the supported way to write, and not
>
> 	[versionsort]
>         	prereleaseSuffix = -pre -rc
>
> but it probably is unclear unless the reader already knows what it
> is trying to say.  The reader also needs to learn somewhere how the
> order of the entries affects the result.

This is already in 'next', so could you fix that half-sentence in
the documentation via an incremental update?

Thanks.
