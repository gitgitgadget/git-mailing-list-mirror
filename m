From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: imap-send badly handles commit bodies beginning with "From <"
Date: Tue, 01 Nov 2011 17:06:48 +0100
Message-ID: <4EB01918.8080604@alum.mit.edu>
References: <20111028180044.GA3966@foghorn.codeweavers.com> <20111028203256.GA15082@sigill.intra.peff.net> <20111030090111.GA1624@jpl.local> <20111101153803.GB5552@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?TWFnbnVzIELDpGNr?= <magnus.back@sonyericsson.com>,
	git@vger.kernel.org, Andrew Eikum <aeikum@codeweavers.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 01 17:07:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLGs7-0001Mg-4e
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 17:07:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755259Ab1KAQH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Nov 2011 12:07:26 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:56575 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754212Ab1KAQH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2011 12:07:26 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pA1G6mn4005935
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 1 Nov 2011 17:06:48 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <20111101153803.GB5552@sigill.intra.peff.net>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184573>

On 11/01/2011 04:38 PM, Jeff King wrote:
> Right. If you properly quote and unquote "From " lines, then mbox can be
> unambiguous.

That is not quite true.  The RFC says only that lines matching "^From "
should be quoted, not lines matching "^>From " (or, generally, "^>*From
").  So the quoting is lossy; it is *not* possible to tell whether a
line starting with ">From " should be unquoted (it could have been
">From " in the original).

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
