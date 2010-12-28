From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 13/14] t4135-*.sh: Skip the "backslash" tests on cygwin
Date: Tue, 28 Dec 2010 18:10:47 +0000
Message-ID: <4D1A2827.6070503@ramsay1.demon.co.uk>
References: <4D07B977.9010502@ramsay1.demon.co.uk> <201012142149.33725.j6t@kdbg.org> <4D0A94D8.6090206@ramsay1.demon.co.uk> <201012172254.31242.j6t@kdbg.org> <4D1100A3.2010309@ramsay1.demon.co.uk> <AANLkTi=-7ihdW_cMiAqnyjbUE_d35OFrSSnQQw4mi64G@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>, jrnieder@gmail.com
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 28 19:13:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXe2e-0005ew-Vs
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 19:13:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263Ab0L1SMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 13:12:52 -0500
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:52520 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751975Ab0L1SMv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Dec 2010 13:12:51 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1PXe2U-0001M0-aD; Tue, 28 Dec 2010 18:12:50 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <AANLkTi=-7ihdW_cMiAqnyjbUE_d35OFrSSnQQw4mi64G@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164283>

Nguyen Thai Ngoc Duy wrote:
> On Wed, Dec 22, 2010 at 2:31 AM, Ramsay Jones
> <ramsay@ramsay1.demon.co.uk> wrote:
>> The problem boils down to the call to strncmp_icase() suppressing the call to
>> fnmatch() when the pattern contains glob chars, but the (remaining) string is
>> equal to the name; thus returning an exact match (MATCHED_EXACTLY) rather than
>> calling fnmatch (and returning either no-match or MATCHED_FNMATCH).
> 
> I think that's expected behavior. Wildcard pathspecs are fixed
> pathspecs will additional wildcard matching support and can match both
> ways. See 186d604 (glossary: define pathspec)

Really? Hmm, that seems ... odd! (To be clear: you are saying that an exact
match, *even if the pattern contains glob chars*, takes precedence over the
glob match! - again *odd*)
Well, if you are happy with that ...

ATB,
Ramsay Jones
