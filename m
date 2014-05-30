From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH 1/5] fetch doc: update introductory part for clarity
Date: Fri, 30 May 2014 15:13:27 -0400
Message-ID: <5388D857.7010705@xiplink.com>
References: <1401403350-7122-1-git-send-email-gitster@pobox.com>	<1401403350-7122-2-git-send-email-gitster@pobox.com>	<5388972C.5020307@xiplink.com> <xmqqioon9msf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 30 21:13:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqSEh-0000wv-2T
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 21:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933731AbaE3TM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 15:12:59 -0400
Received: from smtp154.ord.emailsrvr.com ([173.203.6.154]:53564 "EHLO
	smtp154.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933467AbaE3TM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 15:12:58 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp20.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 05DBD1C02BE;
	Fri, 30 May 2014 15:12:58 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp20.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id C8BBC1C0602;
	Fri, 30 May 2014 15:12:57 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <xmqqioon9msf.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250468>

On 14-05-30 01:52 PM, Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
> 
>> On 14-05-29 06:42 PM, Junio C Hamano wrote:
>>> +
>>> +The names of refs that are fetched, together with the object names
>>> +they point at, are written to `.git/FETCH_HEAD`.  This information
>>> +is used by a later merge operation done by 'git merge'.  In addition,
>>
>> Isn't this merge stuff about pull, not fetch?
> 
> It is true that "git pull" uses "git fetch" and .git/FETCH_HEAD is a
> documented mechanism between the two to communicate what commits the
> latter downloaded are to be merged by the former, and that is one of
> the reasons why we had the description here in the original before
> this patch.  A user can also do this to refer to the tip of the
> single branch she fetched:
> 
> 	git fetch origin master
>         git log -p ..FETCH_HEAD
>         git merge FETCH_HEAD
> 
> Perhaps "is used ... by 'git merge'" can be rephrased somehow, like
> "can be used to refer to what was fetched"?  Or we could go in the
> opposite direction and be more explicit, i.e.
> 
> 	"git pull" calls "git fetch" internally, and this
> 	information is used by the former to learn what commits were
> 	fetched by the latter.
> 
> I dunno.

Y'know, I've always been a bit confused by FETCH_HEAD, especially if the
fetch updates several remote-tracking branches.

The docs say that all the fetched refs are written to FETCH_HEAD (perhaps a
more accurate name would have been FETCH_HEADS?).  If that's truly the case,
it seems weird to use FETCH_HEAD in log and merge commands.  (My FETCH_HEAD
file currently has 1434 lines in it -- what does that mean, and what does it
imply for those log and merge commands?)

Perhaps FETCH_HEAD shouldn't be mentioned at all in the introductory part of
fetch's man page.

		M.
