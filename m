From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: RE: Ability to remember last known good build
Date: Fri, 11 Mar 2016 14:49:50 -0500
Message-ID: <00be01d17bcf$3022d190$906874b0$@nexbridge.com>
References: <CEDF59214E9E6A4CB418120F4FD7A0056E86A214@US-MBX2.ingrnet.com> <xmqq60wsc2gh.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>,
	"'Pedroso, Osiris'" <osiris.pedroso@intergraph.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 20:50:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeT4h-0005KE-3p
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 20:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbcCKTuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 14:50:11 -0500
Received: from elephants.elehost.com ([216.66.27.132]:27451 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbcCKTuK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 14:50:10 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [174.112.90.66])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id u2BJo0Sp070198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 11 Mar 2016 14:50:00 -0500 (EST)
	(envelope-from rsbecker@nexbridge.com)
In-Reply-To: <xmqq60wsc2gh.fsf@gitster.mtv.corp.google.com>
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFjmSspo0qmFhqiGdjU6pJ3nX/jLgGTlCKmoCPOMRA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288702>

On March 11, 2016 1:08 PM Junio C Hamano wrote:
> "Pedroso, Osiris" <osiris.pedroso@intergraph.com> writes:
> 
> > I participate in an open source project that any pull merge is accepted,
no
> matter what.
> >
> > This makes for lots of broken builds, even though we do have Travis-CI
> enabled on the project, because people will merge a request before even
the
> build is complete.
> >
> > Therefore, I would like to remember the id of the commit of the last
> successful build. This would be updated by the Travis-CI script itself
upon a
> successful build.
> >
> > I imagine best option would be to merge master to a certain branch named
> "Last_known_Linux_build" or "Last_known_Windows_build" or even
> "Last_known_build_all_tests_passing".
> >
> > I am new to git, but some other experienced co-volunteers tell me that
it
> may not be possible due to authentication issues.
> >
> > Any better way of accomplishing this?
> 
> "test && git branch -f last-good"?

I think semantically a last-good tag might be another option, unless you are
applying build fixes to a last-good topic branch. You also have the option
of adding content to the tag describing the build reason, engine used, etc.
See git tag --help. I have used that in a Jenkins environment putting the
tag move in the step following a build (failure does not execute the step so
the last-good build tag stays where it is).

Cheers,
Randall

-- Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)/NonStop(211288444200000000)
-- In my real life, I talk too much.
