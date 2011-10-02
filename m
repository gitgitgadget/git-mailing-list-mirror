From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] Don't sort ref_list too early
Date: Sun, 02 Oct 2011 06:58:53 +0200
Message-ID: <4E87EF8D.8020801@alum.mit.edu>
References: <4DF6A8B6.9030301@op5.se>	<9ae990f15489d7b51a172d08e63ca458@quantumfyre.co.uk>	<201109261539.33437.mfick@codeaurora.org>	<201109261552.04946.mfick@codeaurora.org>	<ece30e6a1b74bcddde5634003408f61f@quantumfyre.co.uk>	<7vsjnizxf5.fsf@alter.siamese.dyndns.org> <20110927000010.79913.71464.julian@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Fick <mfick@codeaurora.org>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sun Oct 02 06:59:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAE93-000129-Bd
	for gcvg-git-2@lo.gmane.org; Sun, 02 Oct 2011 06:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771Ab1JBE7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Oct 2011 00:59:07 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:60864 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695Ab1JBE7F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Oct 2011 00:59:05 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BEC733.dip.t-dialin.net [84.190.199.51])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p924ws4l017552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 2 Oct 2011 06:58:54 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <20110927000010.79913.71464.julian@quantumfyre.co.uk>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182591>

On 09/27/2011 02:00 AM, Julian Phillips wrote:
> get_ref_dir is called recursively for subdirectories, which means that
> we were calling sort_ref_list for each directory of refs instead of
> once for all the refs.  This is a massive wast of processing, so now
> just call sort_ref_list on the result of the top-level get_ref_dir, so
> that the sort is only done once.

+1

I think this patch should also be considered for maint, since it is
noninvasive and fixes a bad performance regression.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
