From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-gui.sh: support Tcl 8.4
Date: Tue, 06 Jan 2015 16:02:25 -0800
Message-ID: <xmqqk30zmp9q.fsf@gitster.dls.corp.google.com>
References: <97e448e7908a1f959a7294e389553b5@74d39fa044aa309eaea14b9f57fe79c>
	<xmqqvbkjofvw.fsf@gitster.dls.corp.google.com>
	<82A625FF-768E-4D7E-8248-B14005464EAE@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git mailing list <git@vger.kernel.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 01:04:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8e5O-0003W3-UE
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 01:02:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752575AbbAGACl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 19:02:41 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62258 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751734AbbAGAC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 19:02:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 866972DFD9;
	Tue,  6 Jan 2015 19:02:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JDTgoXH/FfTjJoEi/WX1w2Szo/Q=; b=pfT+Dy
	Kvpyxzn+DXdqdoXw+TqcoZeM5BYqh+NE74LKdmXqEq7d4403lIUudzEyZN0z3z7A
	ceK2NAuDI4JtTaVVdGh6yy/+ZbSPmYn3EeRqQgAphngVD1Eygun2WlDo6ibWkLvh
	G8znAByHWI/1dQwEl3Ql4sJIrZRirRRQiTNGs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dzxYDZoJGdcqHrFgINRy0t+x2BLZ6fWY
	WsjnGSvRpeNbL8u4/bcBxIIVXUSM4NM+agHF/0S1NZ0VtLHryseXnd3X/dT6W9oV
	SC+5A/HHaR1pok/xA1J2mL6kXPDIb0aaimdURB+FBYGOpaPCTD/R8gl4x22YP7vl
	dV1XhL6h1PQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D9492DFD8;
	Tue,  6 Jan 2015 19:02:27 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EF7742DFD4;
	Tue,  6 Jan 2015 19:02:26 -0500 (EST)
In-Reply-To: <82A625FF-768E-4D7E-8248-B14005464EAE@gmail.com> (Kyle J. McKay's
	message of "Tue, 6 Jan 2015 14:47:32 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 77142A82-9600-11E4-9759-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262115>

^"Kyle J. McKay" <mackyle@gmail.com> writes:

> greater.  But Jens mentions this in $gmane/249491 (that the original
> patch was missing the ">= 0" part).

Ah, that is what I missed.  Thanks.

> I can't find anything in that thread about why vsatisfies was
> preferred over vcompare other than the obvious that the vsatisfies
> version is only a 1-character change.  And that would be more than
> enough except that Tcl 8.4 doesn't support the trailing '-' vsatisfies
> syntax.

Yeah, I fully agree with that observation.

>> * Would it be a good idea to update the places $gmane/248895 points
>>   out?  It is clearly outside the scope of this fix, but we may
>>   want to do so while our mind is on the "how do we check required
>>   version?" in a separate patch.
>
> Makes sense to me, but my Tcl knowledge isn't up to making those
> changes as the code's a bit different.  I have to paraphrase Chris's
> message here by saying that I guess those checks are correct if not
> consistent with the others.

OK, let's ask Pat (cc'ed) to apply your version as-is without
touching these 1.5.3 references.  I do not take patches to git-gui
directly to my tree.

Thanks.

-- >8 --
From: "Kyle J. McKay" <mackyle@gmail.com>
Date: Tue,  6 Jan 2015 02:41:21 -0800 

Tcl 8.5 introduced an extended vsatisfies syntax that is not
supported by Tcl 8.4.

Since only Tcl 8.4 is required this presents a problem.

The extended syntax was used starting with Git 2.0.0 in commit
b3f0c5c0 (git-gui: tolerate major version changes when comparing the
git version, 2014-05-17), so that a major version change would still
satisfy the condition.

However, what we really want is just a basic version compare, so use
vcompare instead to restore compatibility with Tcl 8.4.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-gui.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index b186329d..a1a23b56 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1283,7 +1283,7 @@ load_config 0
 apply_config
 
 # v1.7.0 introduced --show-toplevel to return the canonical work-tree
-if {[package vsatisfies $_git_version 1.7.0-]} {
+if {[package vcompare $_git_version 1.7.0] >= 0} {
 	if { [is_Cygwin] } {
 		catch {set _gitworktree [exec cygpath --windows [git rev-parse --show-toplevel]]}
 	} else {
@@ -1539,7 +1539,7 @@ proc rescan_stage2 {fd after} {
 		close $fd
 	}
 
-	if {[package vsatisfies $::_git_version 1.6.3-]} {
+	if {[package vcompare $::_git_version 1.6.3] >= 0} {
 		set ls_others [list --exclude-standard]
 	} else {
 		set ls_others [list --exclude-per-directory=.gitignore]
-- 
2.1.4
