From: Junio C Hamano <gitster@pobox.com>
Subject: Re: scan entire repo for changes to file
Date: Tue, 16 Nov 2010 09:48:39 -0800
Message-ID: <7vk4kdi2h4.fsf@alter.siamese.dyndns.org>
References: <ibi59v$pjg$1@dough.gmane.org>
 <AANLkTi=uKhrvAS6ApnmCZnfbFboYU77rNcKDpaSBn1id@mail.gmail.com>
 <20101112014434.GA10679@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 16 18:49:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIPeN-00083m-RA
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 18:49:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755876Ab0KPRsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 12:48:54 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62808 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752929Ab0KPRsx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 12:48:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EA3253DCF;
	Tue, 16 Nov 2010 12:49:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mCwMqpvYcd9YphITCp+sj05s1ZQ=; b=rv6vy4
	l+p5Axh6OCIvSHDFSE76Ry8uw1VYPqm470Fjn9ppZiYe4Q69WTowW6GL5YDIWNMa
	oarfBOQ+hwkdYZMAWdIKDXIFgzs+/gBgr3Lc0IBobNWXjHqgcLZO+dB1eyZre0QJ
	fVpLJ706tHnbO9we1TmvrNBHLGDV782F+YZ90=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VdTXgwi0C5efo55VgplEnf0Vze79F29l
	gxevJptB+NBEZDWueFT/TOYnmJczFNqcZVGr8AK1TJegwA9o1nwqzvDSxIa9g17c
	svgNUH/H4/djN01OCJR7gNP3vd0UXs4zwTn5Z0QbdZxdk/8THLFVDT+tg6o81p/9
	R0Ez/KL2yoo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A56D13DC4;
	Tue, 16 Nov 2010 12:48:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EF83C3DC2; Tue, 16 Nov 2010
 12:48:50 -0500 (EST)
In-Reply-To: <20101112014434.GA10679@burratino> (Jonathan Nieder's message of
 "Thu\, 11 Nov 2010 19\:44\:34 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C8DFA404-F1A9-11DF-B0A4-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161569>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Martin von Zweigbergk wrote:
>> On Thu, Nov 11, 2010 at 8:28 PM, Neal Kreitzinger <neal@rsss.com> wrote:
>
>>> Is there a way to scan my entire repo (many unmerged branches) for any
>>> changes to a file?
>>> e.g.
>>> $ git log * -- somepath/myblob
>>> would return all commits in the repo that changed myblob.
>>
>> Might replacing '*' by '--all' give you what are looking for?
>
> Probably with --full-history if you want to know what happened on
> historic branches, too.

You would need to clarify what you mean by "historic branches" here.
