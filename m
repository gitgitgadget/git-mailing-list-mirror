From: Mike Hommey <mh@glandium.org>
Subject: Re: Occasional wrong behavior of rev-walking (rev-list, log, etc.)
Date: Fri, 22 May 2015 07:49:56 +0900
Message-ID: <20150521224956.GA23810@glandium.org>
References: <20150521061553.GA29269@glandium.org>
 <xmqq617llw6k.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 22 00:50:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvZI1-0001ZG-7I
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 00:50:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755704AbbEUWuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 18:50:05 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:60666 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754216AbbEUWuD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 18:50:03 -0400
Received: from glandium by zenigata with local (Exim 4.85)
	(envelope-from <glandium@glandium.org>)
	id 1YvZHo-0007QJ-HX; Fri, 22 May 2015 07:49:56 +0900
Content-Disposition: inline
In-Reply-To: <xmqq617llw6k.fsf@gitster.dls.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269672>

On Thu, May 21, 2015 at 09:41:55AM -0700, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > My guess is that rev-walking is tripping on the fact that this repository
> > has commit dates in random order.
> 
> Yeah, that is well known (look for SLOP both in the code and list
> archive).

I found the recent thread about git describe --contains. (and now I
realize this is also why git describe --contains doesn't work quite well
for the same repository).

Now the question is what can we done in the short term? (short of
introducing something like generation numbers) I tried increasing
SLOP and to remove the date check (with the hope that making one or
both configurable might help). Neither fixed the particular test
case I started this thread with.

Mike
