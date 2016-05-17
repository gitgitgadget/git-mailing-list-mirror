From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GIT_INDEX_FILE relative path breaks in subdir
Date: Tue, 17 May 2016 10:34:56 -0700
Message-ID: <xmqqy478wptr.fsf@gitster.mtv.corp.google.com>
References: <20160517171836.GA12183@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Joey Hess <id@joeyh.name>
X-From: git-owner@vger.kernel.org Tue May 17 19:35:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2itf-0007Y3-AH
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 19:35:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbcEQRfB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 13:35:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63212 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751352AbcEQRfA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 13:35:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 61A191C570;
	Tue, 17 May 2016 13:34:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HbgjVbm5xtfumP+kvAs9LantgFU=; b=vVziHp
	4H7XZZpyGt1oOMo0wKB5jr95PmVDmdwE0o7Iczyg6+TnGVhRLHvpF2s76D/aZG1x
	u8NAsMIxJvSq+rsJVO3Nj4Ywho+QyW0TnWs2s2rLVw/uFwlOc9xvMAnpVjZemY3C
	ofVhf/wfH0NhNLXXi0OdibaCI0ZbupH1qdv7w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Sw6sF5ogzbrGPXhWnJE+YOItUmoVgOGO
	HS1UF1aUc3NSuAw0JtboLZ7s/gXupoDt940UeYBun5kmgHSmWRFOAdEg6OPQaS1F
	lqyVIBRxj5WBWTskGWRBJi9BMamx0a/RA0KfDaTMlsxYsSH6u7Ul9Bdr8oXeMlJ9
	k9pesGwwlS0=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 57C951C56F;
	Tue, 17 May 2016 13:34:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C5B521C56D;
	Tue, 17 May 2016 13:34:58 -0400 (EDT)
In-Reply-To: <20160517171836.GA12183@kitenet.net> (Joey Hess's message of
	"Tue, 17 May 2016 13:18:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AD646B10-1C55-11E6-98FA-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294883>

Joey Hess <id@joeyh.name> writes:

> Appears to be a bug in git. Seems that it's assuming GIT_INDEX_FILE is
> relative to the top of the worktree and not to the CWD.

I think that has always been the case.  You can always specify it as
relative to the top.  Of course, you can use absolute.
