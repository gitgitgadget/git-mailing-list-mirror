From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui.sh: support Tcl 8.4
Date: Tue, 13 Jan 2015 01:12:19 +0000
Message-ID: <87iogbmqks.fsf@red.patthoyts.tk>
References: <97e448e7908a1f959a7294e389553b5@74d39fa044aa309eaea14b9f57fe79c>
	<xmqqvbkjofvw.fsf@gitster.dls.corp.google.com>
	<82A625FF-768E-4D7E-8248-B14005464EAE@gmail.com>
	<xmqqk30zmp9q.fsf@gitster.dls.corp.google.com>
	<54ACE1C4.4030502@web.de>
Reply-To: patthoyts@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 13 02:12:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAq1z-0004wV-Fx
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 02:12:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbbAMBMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2015 20:12:22 -0500
Received: from know-smtprelay-omc-7.server.virginmedia.net ([80.0.253.71]:40537
	"EHLO know-smtprelay-omc-7.server.virginmedia.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751411AbbAMBMV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2015 20:12:21 -0500
Received: from red.patthoyts.tk ([82.45.42.101])
	by know-smtprelay-7-imp with bizsmtp
	id fDCK1p01X2AxhvW01DCL1W; Tue, 13 Jan 2015 01:12:20 +0000
X-Originating-IP: [82.45.42.101]
X-Spam: 0
X-Authority: v=2.1 cv=cpwVkjIi c=1 sm=1 tr=0 a=FEdcR8KTC/yDun0iFnNZnw==:117
 a=FEdcR8KTC/yDun0iFnNZnw==:17 a=6gpmbu8EOFEA:10 a=xqWC_Br6kY4A:10
 a=FP58Ms26AAAA:8 a=YNv0rlydsVwA:10 a=pGLkceISAAAA:8 a=TSbVqHtbAAAA:8
 a=ybZZDoGAAAAA:8 a=Rf460ibiAAAA:8 a=tvE0EfFrxTuNXD3qxZcA:9 a=AkUkIWUyXwcA:10
 a=NWVoK91CQyQA:10
Received: from red.patthoyts.tk (red.patthoyts.tk [IPv6:2a01:348:2be::2])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by red.patthoyts.tk (Postfix) with ESMTPS id A5AD21961C5A;
	Tue, 13 Jan 2015 01:12:19 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
In-Reply-To: <54ACE1C4.4030502@web.de> (Jens Lehmann's message of "Wed, 07 Jan
	2015 08:35:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262312>

Jens Lehmann <Jens.Lehmann@web.de> writes:

>Am 07.01.2015 um 01:02 schrieb Junio C Hamano:
>> ^"Kyle J. McKay" <mackyle@gmail.com> writes:
>>> I can't find anything in that thread about why vsatisfies was
>>> preferred over vcompare other than the obvious that the vsatisfies
>>> version is only a 1-character change.  And that would be more than
>>> enough except that Tcl 8.4 doesn't support the trailing '-' vsatisfies
>>> syntax.
>>
>> Yeah, I fully agree with that observation.
>
>Having rather corroded TCL-knowledge myself it was Pat's comment in
>
>   http://thread.gmane.org/gmane.comp.version-control.git/247511/focus=249464
>
>that made me change the patch to use the smaller change of adding
>the trailing '-' after vsatisfies instead of using vcompare with
>a trailing ">= 0" in v2.
>
>>>> * Would it be a good idea to update the places $gmane/248895 points
>>>>    out?  It is clearly outside the scope of this fix, but we may
>>>>    want to do so while our mind is on the "how do we check required
>>>>    version?" in a separate patch.
>>>
>>> Makes sense to me, but my Tcl knowledge isn't up to making those
>>> changes as the code's a bit different.  I have to paraphrase Chris's
>>> message here by saying that I guess those checks are correct if not
>>> consistent with the others.
>
>When I looked at it back then I was convinced these checks are ok
>and should stay as they are to support ancient Git versions (and
>they do not use vsatisfies either).
>
>> OK, let's ask Pat (cc'ed) to apply your version as-is without
>> touching these 1.5.3 references.  I do not take patches to git-gui
>> directly to my tree.
>
>It's an ack from me on the change below as that was what I came up
>with and tested successfully before Pat suggested to just add the '-'.
>
>> -- >8 --
>> From: "Kyle J. McKay" <mackyle@gmail.com>
>> Date: Tue,  6 Jan 2015 02:41:21 -0800
>>
>> Tcl 8.5 introduced an extended vsatisfies syntax that is not
>> supported by Tcl 8.4.
>>
>> Since only Tcl 8.4 is required this presents a problem.
>>
>> The extended syntax was used starting with Git 2.0.0 in commit
>> b3f0c5c0 (git-gui: tolerate major version changes when comparing the
>> git version, 2014-05-17), so that a major version change would still
>> satisfy the condition.
>>
>> However, what we really want is just a basic version compare, so use
>> vcompare instead to restore compatibility with Tcl 8.4.
>>
>> Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>   git-gui.sh | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/git-gui.sh b/git-gui.sh
>> index b186329d..a1a23b56 100755
>> --- a/git-gui/git-gui.sh
>> +++ b/git-gui/git-gui.sh
>> @@ -1283,7 +1283,7 @@ load_config 0
>>   apply_config
>>
>>   # v1.7.0 introduced --show-toplevel to return the canonical work-tree
>> -if {[package vsatisfies $_git_version 1.7.0-]} {
>> +if {[package vcompare $_git_version 1.7.0] >= 0} {
>>   	if { [is_Cygwin] } {
>>   		catch {set _gitworktree [exec cygpath --windows [git rev-parse --show-toplevel]]}
>>   	} else {
>> @@ -1539,7 +1539,7 @@ proc rescan_stage2 {fd after} {
>>   		close $fd
>>   	}
>>
>> -	if {[package vsatisfies $::_git_version 1.6.3-]} {
>> +	if {[package vcompare $::_git_version 1.6.3] >= 0} {
>>   		set ls_others [list --exclude-standard]
>>   	} else {
>>   		set ls_others [list --exclude-per-directory=.gitignore]
>>
>

This look good and tested ok with 8.4.19.

vsatisfies is the smarter command but vcompare will work just fine as it
is used here given the git version string gets pre-processed before any
comparisons are performed. The vcompare test will be ok with increasing
major version numbers in the future.

Applied.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
