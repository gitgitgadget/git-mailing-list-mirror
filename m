From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Added tests for git reset -
Date: Tue, 10 Mar 2015 10:36:52 -0700
Message-ID: <xmqqfv9c21qj.fsf@gitster.dls.corp.google.com>
References: <1425934010-8780-1-git-send-email-dyoucme@gmail.com>
	<1425934010-8780-2-git-send-email-dyoucme@gmail.com>
	<CAPig+cRgA5ZMM8d+ep8cyoZpK8FubzDBNVACgGWyWdRgF+nq7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sundararajan R <dyoucme@gmail.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 18:37:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVO5V-0005LJ-EY
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 18:37:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbbCJRg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 13:36:57 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56834 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751000AbbCJRg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 13:36:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 95D793C367;
	Tue, 10 Mar 2015 13:36:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vg341VzjkgPQ7eNKsGSo0yMZqiY=; b=ImEqKk
	SjR0Y6CqZzl6ukTrlwaJEF67Etq4MkzxiH0SpmMEAPKttWQl8uQjmo654a33hVKn
	xyygNhhgxzraNL+2U99m66+4FTVvjlGI2HNuU4Am1eyLnwZGOugVRlaiVWRsjE2Z
	FQ+VCRYK3U1LFkn9BYPIsFVSk31bVRgUN8glg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dgK8xYBm0E3CEv5Mj3+I30VrdA12Huvr
	20sPeDh6EAvG+DGuuPF4c5UhXVxHDArIUzKLkKeMKq0lzUIAiuFnogWs9D2Fqt7l
	6JIvzJbXEXe1dIR+07wSNr8hV/d8lIdmvDQKazujWq3bmJcujDc4gmGZYq2GXI3s
	3uq7NhnjYEk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 873533C366;
	Tue, 10 Mar 2015 13:36:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B39DC3C365;
	Tue, 10 Mar 2015 13:36:54 -0400 (EDT)
In-Reply-To: <CAPig+cRgA5ZMM8d+ep8cyoZpK8FubzDBNVACgGWyWdRgF+nq7w@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 10 Mar 2015 03:49:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0B38CBD8-C74C-11E4-B976-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265248>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +test_expect_success 'reset - with no @{-1}' '
>> +       git init new --quiet &&
>
> Why --quiet?

Also, to make sure tests serve as good examples, tests should stick
to "options first and then arguments", i.e. "git init --quiet new",
if it passes options.
