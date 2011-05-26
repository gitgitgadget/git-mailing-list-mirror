From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 2/2] builtin/commit.c: set status_format _after_ option
 parsing
Date: Thu, 26 May 2011 16:34:50 -0500
Message-ID: <zC-f1fI9ZM3f29xvafX60e8cV8ocMeVmk23oEjhHXxWYhonKbDLDGw@cipher.nrlssc.navy.mil>
References: <vdMu20HxiNaWL_IogfamtfZCd6xRyKanIqTSw0k4f2SrbLfUYHDzKT2EGkwdFRlaLzX-5vGGtDCZRGu84HrJzw@cipher.nrlssc.navy.mil> <vdMu20HxiNaWL_IogfamtflLupHrDNZVtQH5MK7obj8IjaOAuDtj-EwLzysKLoeGXYfBRtJqF-hgEQF5bfRzsQ@cipher.nrlssc.navy.mil> <20110526211723.GE31340@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 26 23:36:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPiDo-0003xw-8q
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 23:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755301Ab1EZVfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 17:35:55 -0400
Received: from mail2.nrlssc.navy.mil ([128.160.25.4]:41501 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756699Ab1EZVfz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 17:35:55 -0400
Received: by mail.nrlssc.navy.mil id p4QLZcFm031498; Thu, 26 May 2011 16:35:40 -0500
In-Reply-To: <20110526211723.GE31340@sigill.intra.peff.net>
X-OriginalArrivalTime: 26 May 2011 21:34:51.0151 (UTC) FILETIME=[BEA359F0:01CC1BEC]
X-Virus-Scanned: clamav-milter 0.95.3 at mail2
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174577>

On 05/26/2011 04:17 PM, Jeff King wrote:
> On Thu, May 26, 2011 at 01:43:21PM -0700, Brandon Casey wrote:
> 
>> 'git status' should use --porcelain output format when -z is given.
>> It was not doing so since the _effect_ of using -z, namely that
>> null_termination would be set, was being checked _before_ option parsing
>> was performed.
>>
>> So, move the check so that it is performed after option parsing.
> 
> Wow, that's an embarrassing bug. I was about to own up to it, but it
> actually looks like it is Junio's bug from 173e6c8 (git stat -s: short
> status output, 2009-08-04). Of course, I _twice_ modified the
> conditional afterwards and failed to notice that it was doing absolutely
> nothing. So I'm not sure which one of us deserves the brown paper bag. :)

:) Well, apparently no one uses -z with git-status anyway (or they only
do so in addition to --porcelain).  Otherwise it would have been fixed
a long time ago.

-Brandon
