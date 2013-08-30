From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] check-ignore: Add option to ignore index contents
Date: Thu, 29 Aug 2013 21:13:49 -0700
Message-ID: <xmqqmwnz24ua.fsf@gitster.dls.corp.google.com>
References: <20130829224652.GA13621@opensourcesolutions.co.uk>
	<CACsJy8COEwA0hSf4yiTETqA6UBRhcCviayrhnynw23bTC-3foQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dave Williams <dave@opensourcesolutions.co.uk>,
	Git Mailing List <git@vger.kernel.org>,
	Adam Spiers <git@adamspiers.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 30 06:14:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFG62-0005GI-UF
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 06:14:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755389Ab3H3EN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 00:13:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36901 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753316Ab3H3EN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 00:13:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92534368AD;
	Fri, 30 Aug 2013 04:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cHztY2ciCFHdhe0fg6TGvbOn3Oc=; b=lzVXWT
	O8u77hvWYjaTjRFaz1fhRLRFUxgd36T9QnpupwWyEcQf5vklHfsjqHAcJdJzt1Kf
	ZWnGZEIUuuQHADn5wgmJh+fWH4oJ/J9lAi9kFg2sD+8vNR0NSdDu4swmaiKifx4d
	9+LLwGWvAcOFXMYvVElGyLMBnamgFWypdyLH8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OXSZc87Qke9NdiaH4k9WZuh+mxSOLkZF
	+tz1ZDh8RZp9akQ+ETPMfjt8njaXPlhdCF0HmHaoxDLm37Qe0yfVUDdMRT9NgdSV
	YWfFQW/MkTMeClgqQs0HVFLXLZSBSjziiGFgAO+ZzDua+18uf2IY4RTLpBDG15C6
	sqyJzOzZRSM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35AF6368A9;
	Fri, 30 Aug 2013 04:13:55 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D84E368A3;
	Fri, 30 Aug 2013 04:13:52 +0000 (UTC)
In-Reply-To: <CACsJy8COEwA0hSf4yiTETqA6UBRhcCviayrhnynw23bTC-3foQ@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 30 Aug 2013 07:51:26 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 94A58250-112A-11E3-B01B-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233388>

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, Aug 30, 2013 at 5:46 AM, Dave Williams
> <dave@opensourcesolutions.co.uk> wrote:
>> check-ignore currently shows how .gitignore rules would treat untracked
>> paths. Tracked paths do not generate useful output.  This prevents
>> debugging of why a path became tracked unexpectedly unless that path is
>> first removed from the index with git rm --cached <path>
>>
>> This option (-i, --ignore-index) simply by-passes the check for the path
>> being in the index and hence allows tracked path to be checked too.
>
> Maybe --no-index, already used by git-diff and git-grep.

I am somewhat ashamed that I didn't think of it myself when I saw
the patch, but I agree that would be a good change for consistency.


>
>> Whilst this behaviour deviates from the characteristics of git add and
>> git status its use case is unlikely to cause any user confusion.
