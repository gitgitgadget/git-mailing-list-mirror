From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] completion: clarify ls-tree, archive, show completion
Date: Fri, 07 Jun 2013 11:36:53 -0700
Message-ID: <7vd2rxu5ru.fsf@alter.siamese.dyndns.org>
References: <1370181822-23450-1-git-send-email-artagnon@gmail.com>
	<1370181822-23450-7-git-send-email-artagnon@gmail.com>
	<20130603192555.GK2192@goldbirke>
	<CALkWK0mbVgJHRoNXNkc6n7==-H+caNqvzrzUwspS_Eq2sMfJbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 20:37:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul1X2-0002cB-Kv
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 20:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756667Ab3FGSg4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 14:36:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37426 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755813Ab3FGSg4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jun 2013 14:36:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADDB726B29;
	Fri,  7 Jun 2013 18:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=68H/sdNxskGZ
	sg7kpKbb5FExCGA=; b=S7EscRZ9i93igLGVrN0JknUVAiMXfJiIV2fR7gEQ2T67
	KSlKMVdS1Exd+zGq6dJ5A6abD5KA8Nu4q/fMEVQMWw9JAcqhpN5ePC90gvCxkqFp
	yjuUD1PoGnrbstbZVuKUTNGrw595jEbxgMMGcbNvQCgsqW7RiqcRRZOReuqC0fA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=hBDGfR
	ROqPwDBsmxdqIrw7NqC+CDmwvmMa3iL+WUI3ulqATLG48OEGcr+3rCfR8kif4G7v
	cCkwtl7R7uB0t1O+9ETyPl4AlAhdvLfztdXT+JDUmkTtuUKdzyVgQ+Po94EHrb7N
	n0mnJTCvPLnzzOA7XDQhD0rl8Ih9UnHBIOCJo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3A9626B28;
	Fri,  7 Jun 2013 18:36:55 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2AA7226B25;
	Fri,  7 Jun 2013 18:36:55 +0000 (UTC)
In-Reply-To: <CALkWK0mbVgJHRoNXNkc6n7==-H+caNqvzrzUwspS_Eq2sMfJbg@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 7 Jun 2013 22:51:53 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3A732E38-CFA1-11E2-A004-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226664>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> SZEDER G=C3=A1bor wrote:
>> Well, people out there might have completion scriplets for their
>> aliases or custom git commands which use __git_complete_file().
>> Removing this function would break those scripts.
>
> What is the advantage of using __git_complete_file() over
> __git_complete_revlist_file()?  Isn't it just a misleading alias?

None.

But "Those who have been using it can update their script" is not an
answer you give when dealing with a regression.

I think the right thing is to add __git_complete_file() back in;
perhaps strip support of A..B/A...B range notations from it, but
that is an independent change.
