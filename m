From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH v5 2/9] connect: only match the host with core.gitProxy
Date: Tue, 17 May 2016 07:36:39 +0900
Message-ID: <20160516223639.GA16182@glandium.org>
References: <20160516000740.19042-1-mh@glandium.org>
 <20160516000740.19042-3-mh@glandium.org>
 <xmqqvb2dzlee.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, tboegi@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 17 00:36:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2R87-0005o2-A2
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 00:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbcEPWgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 18:36:48 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:54910 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751356AbcEPWgr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 18:36:47 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1b2R7v-0004c9-Q8; Tue, 17 May 2016 07:36:39 +0900
Content-Disposition: inline
In-Reply-To: <xmqqvb2dzlee.fsf@gitster.mtv.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294809>

On Mon, May 16, 2016 at 03:30:01PM -0700, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > Currently, core.gitProxy doesn't actually match purely on domain names
> > as documented: it also matches ports.
> > ...
> > This per-port behavior seems like an oversight rather than a deliberate
> > choice, so, make git://kernel.org:port/path call the gitProxy script in
> 
> Hmph.  The fact that hostandport, not just host after stripping
> possible ":port" part, is passed to the function smells like a
> deliberate design to allow people to use different proxy for
> different port, so I am not sure everybody agrees with your "seems
> like an oversight".
> 
> Don't existing users depend on the behaviour?  Isn't the change
> robbing Peter to pay Paul?

The gitProxy script gets the port passed. Why would you need different
scripts for different ports if the port is passed as an argument? Also,
if it's deliberate, it's widely undocumented.

Mike
