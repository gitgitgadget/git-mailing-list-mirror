From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [ANNOUNCE] Git v2.8.1 (and call-for-help to "make rpmbuild"
 users)
Date: Tue, 5 Apr 2016 11:49:24 +0200
Message-ID: <57038A24.2030808@drmicha.warpmail.net>
References: <xmqqtwjiebw2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 11:49:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anNcE-0007wt-0G
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 11:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757514AbcDEJt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 05:49:28 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:44423 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751985AbcDEJt1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Apr 2016 05:49:27 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 242092097F
	for <git@vger.kernel.org>; Tue,  5 Apr 2016 05:49:26 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Tue, 05 Apr 2016 05:49:26 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=YUs+RZhjoF8W1doq+ZkiO89JsRQ=; b=bIanTF
	epSLkeI7z1tD4deqGpv08SW445C4JSLl4jrTwXi9UwNhuv0oSsKhV18SB9xRnmfO
	aIry6onU93XZSbOlddmsT/fXAe2AeFE3AVN/HPKuFC7Ck3RGlkII4wMEaoBlQ9+j
	EqbsF2WOfQ9VbAArOTY1sVSus505KwdXCVPIQ=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=YUs+RZhjoF8W1do
	q+ZkiO89JsRQ=; b=COmUtLjOMupUrIUhoRjwQ+WtBWN3anT5rqHNk5HHRiG7oLo
	uPluQfSfIYZClyZ13ttFK8sBg+96isGpUi1Y2ZBH62RVOwC6mhQc+WL+mqoI0x+U
	Ev9lA3MCOciy1u/vg+5AVUgdPUCGrFtZRbUsfACEOb/sb45uXWbXnd4JSATk=
X-Sasl-enc: xKPhKyxZeJQjeYHi1FxMoNGpLdCXr8U5Swvqi1xzU2wO 1459849765
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 839C5680179;
	Tue,  5 Apr 2016 05:49:25 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.1
In-Reply-To: <xmqqtwjiebw2.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290769>

Junio C Hamano venit, vidit, dixit 03.04.2016 21:21:
> If you do not build RPM binary packages from our pristine source,
> you can safely ignore this release and stop reading this message.
> 
> Now that the audience of this message has been limited to a narrow
> target, before I make an announcement, here is a call-for-help to
> you.
> 
> Git v2.8 removed README file and added a corresponding README.md
> file.  The change however did not adjust git.spec.in that still
> referred to README, causing "make rpmbuild" to fail.  The breakage
> was not noticed by anybody who tested v2.8.0-rc0 and later release
> candidates, and ended up in the final v2.8 release, and we saw a
> handful of bug reports on the list after the release happened.
> 
> This maintenance release is to correct this bug for those who run
> "make rpmbuild". It has no other changes.
> 
> It is clear that nobody who relies on being able to "make rpmbuild"
> ever tried any of the 5 release candidate snapshots that happened
> during Feb 26-Mar 28.  We had a whole month and nobody noticed?
> 
> This incident clearly shows that something needs to happen, if
> people want "make rpmbuild" to keep working.  Even though this
> maintenance release may fix this single bug, breakages similar to it
> that only affect "make rpmbuild" users are guaranteed to appear in
> future releases, unless those who can prevent them from happening
> start helping to test at least release candidate snapshots.

In RedHat/Fedora land, we use our own spec files, "make" and "make
install" into a special purpose tree and package that.

E.g. in fedora, the packager noticed the README file name change in
2.8.0, adjusted the corresponding "%doc" line, and that was basically
all besides updating the sources.

As a fedora user, I either use rpms targetting fedora (possibly patched
and rebuilt by myself), or I build from sources (--prefix=$HOME). With
"generic" rpms you never know which guidelines they follow or where they
install to. Also, naming schemes for dependencies may differ between
RedHat land, SuSe land and other rpm based distros.

So, just like in the deb case, I'm wondering if there's a use case for
make rpmbuild in git.git.

Michael
