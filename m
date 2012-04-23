From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 4/7] push: introduce new push.default mode "simple"
Date: Mon, 23 Apr 2012 12:32:57 +0200
Message-ID: <4F952FD9.90806@alum.mit.edu>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr> <1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr> <1335170284-30768-5-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Apr 23 12:33:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMGaW-00011h-Tf
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 12:33:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755048Ab2DWKdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 06:33:32 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:44398 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753Ab2DWKdb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 06:33:31 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q3NAWvrH015238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 23 Apr 2012 12:32:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120410 Thunderbird/11.0.1
In-Reply-To: <1335170284-30768-5-git-send-email-Matthieu.Moy@imag.fr>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196109>

On 04/23/2012 10:38 AM, Matthieu Moy wrote:
> [...]
> A question is whether to allow pushing when no upstream is configured. An
> argument in favor of allowing the push is that it makes the new mode work
> in more cases. On the other hand, refusing to push when no upstream is
> configured encourages the user to set the upstream, which will be
> beneficial on the next pull. Lacking better argument, we chose to deny
> the push, because it will be easier to change in the future if someone
> shows us wrong.

I like your conservative approach to this decision.  I agree that a push 
that would create a new branch on the remote server should fail if no 
upstream is configured.

But what do people think about letting push succeed when no upstream is 
configured *provided that* there is already a branch on the remote 
server with the same name as the current branch?  I think this policy 
would cover the bulk of "safe" scenarios without adding 
dangerous/ambiguous ones.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
