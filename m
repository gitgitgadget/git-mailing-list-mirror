From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: howto handle name clashes
Date: Fri, 23 Mar 2012 18:43:37 +0100
Message-ID: <4F6CB649.8080006@tu-clausthal.de>
References: <4F6C7539.3080607@tu-clausthal.de> <20120323171219.GB12881@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 18:43:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB8WA-0008Vm-8T
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 18:43:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757052Ab2CWRnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 13:43:08 -0400
Received: from poseidon.rz.tu-clausthal.de ([139.174.2.21]:12794 "EHLO
	poseidon.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755565Ab2CWRnH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Mar 2012 13:43:07 -0400
Received: from poseidon.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 70C8327AFC4;
	Fri, 23 Mar 2012 18:43:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=csRtSJqofEUl1yrha2eWZSmjA7o=; b=HrXeODfYgS/pM9gwhxF+Hw2SIyF+
	I5S4JG1Bnqm2Y0YaTWLwGt6s6zaD8qufOMzS4+QuUOS2TCwpZOrohWrhcGlmQ7fm
	KTT1stG71LHcn0JT8CjwZiRyx+FkR4gqlXFeSNUzVn1c7TykWjyTl7qjywsZiqru
	sCGOcbmg+nf0XCY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=WP0UgwTs5px/kKBntafwBjqZWU5AhO4hKY0bjm+JRoAognrK+c7UhN5
	4j2zhI5W3ZpTcp7Glo3e2ebRTdZJEN19tHzKCUov5q/68pdIq8LC/hb0ZHpW9GJe
	K5KwmUosdpauMLthzf7Xfwxs12YqYEOSh+UOBa9cV3O5M1ccnuP4=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by poseidon.rz.tu-clausthal.de (Postfix) with ESMTP id C59AE27AFBF;
	Fri, 23 Mar 2012 18:43:03 +0100 (CET)
Received: from [139.174.101.48] (account sstri@tu-clausthal.de [139.174.101.48] verified)
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.3)
  with ESMTPSA id 29782919; Fri, 23 Mar 2012 18:43:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20120312 Thunderbird/11.0
In-Reply-To: <20120323171219.GB12881@sigill.intra.peff.net>
X-Enigmail-Version: 1.4
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
X-Spam-Level: (8%, '
 HTML_00_01 0.05, HTML_00_10 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1000_LESS 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, BODY_SIZE_900_999 0, CT_TEXT_PLAIN_UTF8_CAPS 0, __ANY_URI 0, __BOUNCE_CHALLENGE_SUBJ 0, __BOUNCE_NDR_SUBJ_EXEMPT 0, __CP_URI_IN_BODY 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __MOZILLA_MSGID 0, __SANE_MSGID 0, __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0, __TO_NO_NAME 0, __URI_NO_MAILTO 0, __URI_NO_PATH 0, __URI_NS , __USER_AGENT 0')
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193779>

Am 23.03.2012 18:12 schrieb Jeff King:
>> - for merging "git merge --no-ff refs/branches/test" works, but
>> generates a not so nice default merge message. ("merged  commit
>> refs/branches/test" instead of "merged branch test")
> 
> Did you mean "refs/heads/test"?

yes. Your example was the correct one. Thanks for spotting my problem.

>> - how to drop a remote tag/branch ("git push origin :test" does not work)
> 
> Does "git push origin :heads/foo" (or :tags/foo) not work?

seems to work. Thanks.

Really problematic is checkout:
"git checkout heads/foo" creates a detached HEAD (is this intended).
However, "git checkout heads/foo -B foo" can be used.

Is there a git command to find out if a name is ambiguous?
"git rev-parse foo" outputs "warning: refname 'test' is ambiguous.", but
the return code is zero.

-- 
Best regards,
 Sven Strickroth
 ClamAV, a GPL anti-virus toolkit   http://www.clamav.net
 PGP key id F5A9D4C4 @ any key-server
