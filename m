From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/9] Define a structure for object IDs.
Date: Sun, 04 May 2014 22:18:38 +0200
Message-ID: <5366A09E.6030802@kdbg.org>
References: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>	<1399147942-165308-2-git-send-email-sandals@crustytoothpaste.net>	<5365D91E.70207@alum.mit.edu> <536606AB.1020803@kdbg.org> <m2mwexke34.fsf@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun May 04 22:18:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wh2s1-0002g1-Pa
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 22:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753074AbaEDUSl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2014 16:18:41 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:62293 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752460AbaEDUSl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2014 16:18:41 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id C0FEF130052;
	Sun,  4 May 2014 22:18:38 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 3DC6019F438;
	Sun,  4 May 2014 22:18:38 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <m2mwexke34.fsf@linux-m68k.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248109>

Am 04.05.2014 12:55, schrieb Andreas Schwab:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> I think that a compiler that has different size and alignment requirements
>> for the proposed struct object_id and an unsigned char[20] would, strictly
>> speaking, not be a "C" compiler.
> 
> Unlike arrays, a struct can have arbitrary internal padding.  It is
> perfectly compliant (and even reasonable) to make struct object_id
> require 8 byte alignment, adding 4 bytes of padding at the end.

Isn't internal padding only allowed between members to achieve correct
alignment of later members, and at the end only sufficient padding so
that members are aligned correctly when the struct is part of an array?
The former would not be the case because there is only one member, and
the latter is not the case because a char or array of char does not have
alignment requirement?

-- Hannes
