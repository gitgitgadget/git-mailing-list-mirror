From: Phil Hord <hordp@cisco.com>
Subject: Re: [1.8.0] Recursively checkout, merge and reset populated submodules
Date: Mon, 21 Feb 2011 21:32:09 -0500
Message-ID: <4D632029.7040501@cisco.com>
References: <7vwrky5f48.fsf@alter.siamese.dyndns.org>	<4D5FF6E7.8090104@web.de> <4D628F21.3050808@xiplink.com>	<4D62AF46.8030508@web.de> <4D62C385.90204@xiplink.com>	<4D62ED38.7070408@web.de> <87ei70riw1.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Tue Feb 22 03:32:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pri30-0006OX-K0
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 03:32:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040Ab1BVCcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 21:32:13 -0500
Received: from rtp-iport-1.cisco.com ([64.102.122.148]:9190 "EHLO
	rtp-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816Ab1BVCcM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 21:32:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=1108; q=dns/txt;
  s=iport; t=1298341932; x=1299551532;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=V3nI11q86+kzAIW/rADQMYh/x9IpSuDFqh3Djbn3+wY=;
  b=JNKwhBKeumqRuCD7SyAqS/yJ1L6eYEAJl6NwplbdDHJL8FTYedYD6kJV
   0u2mKYXjHcpMNIXItwACi0WdxrbpbDpvBEyh/onwIX9T2083zMqsUlEx/
   6KaUhfJbm+DfMZSg9SalMpZDt9fJg1iSzwiDoqOKaBicjRQ0kOL6PXtUD
   I=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEACuvYk2tJXG//2dsb2JhbACmQnOfUptqhV4EhQ2HBoM7
X-IronPort-AV: E=Sophos;i="4.62,204,1297036800"; 
   d="scan'208";a="218020967"
Received: from rcdn-core2-4.cisco.com ([173.37.113.191])
  by rtp-iport-1.cisco.com with ESMTP; 22 Feb 2011 02:32:11 +0000
Received: from [64.100.104.120] (dhcp-64-100-104-120.cisco.com [64.100.104.120])
	by rcdn-core2-4.cisco.com (8.14.3/8.14.3) with ESMTP id p1M2WAm7015557;
	Tue, 22 Feb 2011 02:32:11 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <87ei70riw1.fsf@catnip.gol.com>
X-Enigmail-Version: 1.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167523>

On 02/21/2011 07:51 PM, Miles Bader wrote:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>>> >> So, .gitmodules initially controls recursion.  When a submodule gets
>>> >> populated, it gets an entry in .git/config which then determines the
>>> >> recursion behavior from then on.  Changing branches might change .gitmodules,
>>> >> but anything in .git/config will persist so any customizations the user makes
>>> >> will also persist.
>> >
>> > Yes. Upstream can give sane defaults but the user has the last word.
> If .git/config entries are created _automatically_ based on the initial
> .gitmodules, doesn't that means it will cease to respect the upstream
> defaults in the case where .gitmodules changes, even if the user didn't
> actually change anything himself...?

Also consider that the .gitmodules'  "upstream defaults" may have many
changes
within the existing repository.  So, $(git checkout foo) will load some
"defaults" and
$(git checkout bar) may load different "defaults".  I guess the defaults
can be migrated
into .git/config using $(git submodule init)...?

Phil
