From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 13/16] init: allow alternate backends to be set for new
 repos
Date: Wed, 23 Dec 2015 10:52:41 +0100
Message-ID: <567A6EE9.3030600@alum.mit.edu>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
 <1449102921-7707-14-git-send-email-dturner@twopensource.com>
 <CACsJy8DDKW4np7N+KA=dpz9uNke0+cyQD-J3U74VM=4WbsjrKQ@mail.gmail.com>
 <20151205074444.GD21639@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 23 10:53:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBg6Q-0000pm-BE
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 10:53:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933154AbbLWJw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2015 04:52:56 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:46962 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753360AbbLWJwx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Dec 2015 04:52:53 -0500
X-AuditID: 12074414-f794f6d000007852-3d-567a6eecfa91
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id B6.E1.30802.CEE6A765; Wed, 23 Dec 2015 04:52:44 -0500 (EST)
Received: from [192.168.69.130] (p4FC971CA.dip0.t-ipconnect.de [79.201.113.202])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tBN9qg7q016480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 23 Dec 2015 04:52:43 -0500
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.4.0
In-Reply-To: <20151205074444.GD21639@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsUixO6iqPsmryrMoHMBs8X8TScYLbqudDNZ
	dE95y2jxo6WH2YHFY+esu+wez3r3MHoseH6f3ePzJrkAlihum6TEkrLgzPQ8fbsE7oy/zU0s
	BafYK7bP4GpgXMTWxcjBISFgIrG8yamLkRPIFJO4cG89UJiLQ0jgMqPE0R0PGCGcC0wSt3+t
	YQapEhYIlthwbysbiC0iYCvxdPd/qI5/jBLn98wFK2IWiJHY2bccrIhNQFdiUU8zE8QKOYne
	7kksIDavgLbEjqndYHEWAVWJFVdmgtmiAiESe3d2QNUISpyc+QTM5hSwllh5vh9qvrrEn3mX
	oGx5ieats5knMArOQtIyC0nZLCRlCxiZVzHKJeaU5urmJmbmFKcm6xYnJ+blpRbpWujlZpbo
	paaUbmKEBLrIDsYjJ+UOMQpwMCrx8Dq0VYYJsSaWFVfmHmKU5GBSEuX1t6oKE+JLyk+pzEgs
	zogvKs1JLT7EKMHBrCTCm/4OqJw3JbGyKrUoHyYlzcGiJM77bbG6n5BAemJJanZqakFqEUxW
	hoNDSYL3aS7QUMGi1PTUirTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQBMcXA2MYJMUDtPcu
	SDtvcUFiLlAUovUUoy7Hgh+31zIJseTl56VKifP2ghQJgBRllObBrYCltVeM4kAfC/M+BKni
	AaZEuEmvgJYwAS35s64cZElJIkJKqoFR696Rh9//v94qp2dS9klynYawLUNwX3lK48s5l9nD
	vy+aZvw8PJb7/vFnc5rmHtQRu7fL/KR1gqHObcPmivIZrJKPm3b95Czou3riqdyp 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282930>

On 12/05/2015 08:44 AM, Jeff King wrote:
> [...]
> I think the config option needs to be extensions.refsBackendType, too,
> per the logic in 00a09d5 (introduce "extensions" form of
> core.repositoryformatversion, 2015-06-23). And I guess it needs to bump
> core.repositoryformatversion to "1".

I think also, strictly speaking, the extensions.refsBackendType option
should be ignored if core.repositoryFormatVersion is not "1". In
practice, it probably makes more sense for the code to error out in that
case because it is likely the result of a bug.

Note that if the user explicitly chooses the "files" backend, it would
be preferable to leave "core.repositoryFormatVersion" at "0" (assuming
that no other extension is being used) and leave
"extensions.refsBackendType" unset. This approach creates a repository
that is compatible with older clients that don't know about
refsBackendTypes.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
