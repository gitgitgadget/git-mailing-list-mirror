From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule helper: accept '.' for repositories with no submodules
Date: Tue, 22 Mar 2016 15:50:46 -0700
Message-ID: <xmqqy49adt4p.fsf@gitster.mtv.corp.google.com>
References: <1458669579-32160-1-git-send-email-sbeller@google.com>
	<xmqqy49agx98.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaMa3CyJ-Y9Xn9QShzTUGythos+pmKZXQ7m-2c0bF0u9A@mail.gmail.com>
	<xmqqoaa6gtuu.fsf@gitster.mtv.corp.google.com>
	<CAGZ79ka=EJ-L+Zaqh0kWUdjmyUva3fEcbwJn18uxshe3R5ABBQ@mail.gmail.com>
	<xmqqtwjyfb0s.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYNQ46Yett8xwtPL8Mi1TkitB1kuWbQDsR6bg-5dxckNA@mail.gmail.com>
	<xmqqpoumf9uy.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYhK1dDQsxjRwhArXMi-0Gbd8ciYwdFnerT4fjvpthWCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Per Cederqvist <cederp@opera.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 23:50:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiV8X-0005sJ-Se
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 23:50:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752810AbcCVWuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 18:50:50 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:57937 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752670AbcCVWut (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 18:50:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D21B84EEC4;
	Tue, 22 Mar 2016 18:50:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VY3RmOQm6TA8MeYgmj2bQP86tV8=; b=g5S9gB
	LSVXCXK14hRdc0hmuZuKSuemPJDHvUwaXkzCQRoSYl9An06I3emsbyLXUoiTeFDj
	YBl88KTic64vq8NB6HQVZSprl6AZK2Mhg2ziZ5PmPmLa4cqe/7q8EqlGFzaO/DtD
	/tyv+BNqdVbFb5YmWQE1hZRYA9Qrn5U3NhBV8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Emse1T9dapcvtyyhFcqt7sqAPSLanjTU
	kjhCO+a56oibJdZ7osOZiQjNxnmLcmo6K5h6NJDIZw9UZFSfOzfhpDADvJPjN84P
	LorIcICpeVfZ+ZTPHU78k7FUL77e1sCs5XIOVXGnZqmM0i6/v3EZHVAm1bBEbFte
	GX+K2lS6wBw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BFD384EEC3;
	Tue, 22 Mar 2016 18:50:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 321FB4EEC2;
	Tue, 22 Mar 2016 18:50:47 -0400 (EDT)
In-Reply-To: <CAGZ79kYhK1dDQsxjRwhArXMi-0Gbd8ciYwdFnerT4fjvpthWCg@mail.gmail.com>
	(Stefan Beller's message of "Tue, 22 Mar 2016 15:10:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8462516A-F080-11E5-BB7B-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289585>

Stefan Beller <sbeller@google.com> writes:

> So for now I would send the performance regressing flip of
> IS_GITLINK and match_pathspec targeting 2.7 and then add a
> --unmatch-ok switch for 2.8 and later?

"git submodule $subcommand -- COPYIN\*" that detects that there is
no submodule that match the pathspec and errors out, which is what
the C rewrite does, is a new feature that was done by accident when
we should have been doing a faithful translation.

I'd say bug-to-bug-compatible regression fix is appropriate for 2.8
and below; the "check ce-mode first and then pathspec match" should
be done as a new feature after 2.8 final, and if --unmatch-ok is
necessary to make the feature work better, that, too, should come in
the same timeframe.
