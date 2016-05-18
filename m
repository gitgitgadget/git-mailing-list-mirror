From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: RE: [Bug] git-log prints wrong unixtime with --date=format:%s
Date: Wed, 18 May 2016 12:44:43 -0400
Message-ID: <005a01d1b124$976dceb0$c6496c10$@nexbridge.com>
References: <87vb2d37ea.fsf@web.de> <8760ucoaus.fsf@web.de>	<20160518004008.GA20007@sigill.intra.peff.net>	<20160518005824.GA7120@sigill.intra.peff.net> <xmqqvb2bs5f5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Michael Heerdegen'" <michael_heerdegen@web.de>,
	<git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>,
	"'Jeff King'" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 18 18:45:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b34an-0007M9-N9
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 18:45:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753423AbcERQpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 12:45:00 -0400
Received: from elephants.elehost.com ([216.66.27.132]:51208 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609AbcERQo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 12:44:59 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [174.112.90.66])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id u4IGitIP088004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 18 May 2016 12:44:55 -0400 (EDT)
	(envelope-from rsbecker@nexbridge.com)
In-Reply-To: <xmqqvb2bs5f5.fsf@gitster.mtv.corp.google.com>
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQInIeoWAW0xNve+6XPolRPPOistbQJt/9XUA2G2Y9sBlcDtiwKmDhSRnsOnNzA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294972>

On May 18, 2016 12:22 PM Jeff King wrote:
> > I tried a few obvious things, but couldn't make anything work. Setting
> > "timezone" manually seems to do nothing. It's supposed to be set by
> > putting the right thing in $TZ and then calling tzset(). So I tried
> > munging $TZ to something like "+0200". It did have _some_ effect, but
> > I
> 
> Wouldn't that be more like "UTC+0200"?
> 
> In any case, I do not think anybody wants to do tzset() on each and every
> commit while running "git log".  Can we declare "format:<strftime>"
> will always use the local timezone, or something?

Off the wall: Dealing in a dispersed team sharing a server that has a
timezone local for only two of the members, git log messes with me also from
a TZ POV. I would like to suggest a more general solution, like configuring
my own TZ in ~/.gitconfig which would potentially allow an override on the
command line. Would user.timezone be helpful in this situation and if set,
call setenv("TZ=...")? It's not an issue when I'm local, but if I touch a
clone on the server, even I get confused around DST changes in October ;).

Cheers,
Randall

-- Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)/NonStop(211288444200000000)
-- In my real life, I talk too much.
