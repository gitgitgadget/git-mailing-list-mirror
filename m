From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: RE: t0025 weird behaviour on NonStop ksh/bash
Date: Fri, 8 May 2015 22:46:43 -0400
Message-ID: <004d01d08a02$627bc2b0$27734810$@nexbridge.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 09 04:46:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yqun1-0004Yf-BX
	for gcvg-git-2@plane.gmane.org; Sat, 09 May 2015 04:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211AbbEICqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 22:46:49 -0400
Received: from elephants.elehost.com ([216.66.27.132]:40409 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbbEICqt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 22:46:49 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE0023eb577e25-CM602ad06c91a7.cpe.net.cable.rogers.com [99.237.128.150])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id t492kkJI021425
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 8 May 2015 22:46:47 -0400 (EDT)
	(envelope-from rsbecker@nexbridge.com)
References: 
In-Reply-To: 
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AdCJ4ypPBHmn9bfPRiKw8I3QjW1oOwAHoUEg
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268692>

On May 8, 2015 7:17 PM , I wrote in my haste:
> Ok, I'm sure that this is not a git problem, but there is an assumption
about
> echo behaviour in t0025 that may not be correct. When executed from a
shell
> function on the HP NonStop platform under ksh and bash, the LFonly file
> annoyingly contains cr-lf not just lf. This causes sub-test 4 to fail.
Weirdly, this
> does not happen from an interactive shell. My proposed solution, in
t0025-crlf-
> auto.sh, to this is to make it explicit that bad behaviour on the part of
echo
> should be dealt with severely, as in:
> 
>         for w in Hello world how are you; do echo $w; done | tr -d '\r'
>LFonly
> 
> instead of
> 
>         for w in Hello world how are you; do echo $w; done >LFonly
> 
> which is a no-op on platforms that behave themselves in this situation. Is
this
> the proper approach?

Digging deeper, this appears to be is Yet Another Platform Problem. There
are more '\r' characters sneaking about beyond just echo. I am taking it up
with other developers to see whether we can track down where the offending
'\r' characters are coming from. They do not appear to be from git or its
tests at this stage

Cheers,
Randall

-- Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)/NonStop(211288444200000000)
-- In my real life, I talk too much.

.
