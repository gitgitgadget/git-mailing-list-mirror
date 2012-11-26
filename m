From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 p1.1 00/14] fast-export and remote-testgit
 improvements
Date: Mon, 26 Nov 2012 15:04:57 -0800
Message-ID: <7vd2z0otie.fsf@alter.siamese.dyndns.org>
References: <1353727034-24698-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 00:05:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td7jr-0005j8-0Z
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 00:05:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192Ab2KZXFB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 18:05:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41221 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755876Ab2KZXFA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 18:05:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9B91A768;
	Mon, 26 Nov 2012 18:04:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rqS89gqYEB7KSHZIwiPRabsHKlQ=; b=J1SWrv
	YmKOEmNCBgMp+djudpo9mJhyWwryGIeZ9U7vDS/PB76Jwlya5pJNVCP8kBQRJLrP
	4PrqVM1aTPNvZf5T1TkX3vzH6klO+PTHbmiP8+UAPfWIMVfkOOICwpxNdf2t3Lye
	ovd+eaoaZ+UT20M9Xrd7g51tW1ZJZIKwbtqds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OrgtXl7QdBZNiuez0JOykXzUgFa146w3
	ilnDT8zm/xqsmh4zScpIgQ/w6hrtSjPxxeOzzo8ZS8oWPgFOsv7qPNXXxhrIu83g
	E74gFciBGBiqNBMO/CHQd3shhOfIsEuXLmyBntGlO1ai/q3UC0lxjG8b9RXvsffp
	27hiBob1ATk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5662A767;
	Mon, 26 Nov 2012 18:04:59 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0A2EEA765; Mon, 26 Nov 2012
 18:04:58 -0500 (EST)
In-Reply-To: <1353727034-24698-1-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Sat, 24 Nov 2012 04:17:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B379BA48-381D-11E2-B55B-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210510>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> I'm rerolling this series with the changes fron Junio, plus a bit more cleanups.
>
> I dropped the last patch, because I found an issue and a separate patch series
> would take care of that. Other than that the main changes remain the same.
>
> The old remote-testgit is now remote-testpy (as it's testing the python
> framework, not really remote helpers). The tests are simplified, and exercise
> more features of transport-helper, and unsuprisingly, find more bugs.

Thanks.

I've queued [v6 p1.1] but not later parts (yet).  The result merged
to 'pu' however seems to break t5800.  It could be a stupid and
trivial merge error or something, but I didn't look into the
details.

Could interested parties take a look? 

$ cd t && sh ./t5800-remote-testpy.sh

ok 1 - setup repository
ok 2 - cloning from local repo
ok 3 - cloning from remote repo
ok 4 - create new commit on remote
ok 5 - pulling from local repo
ok 6 - pulling from remote remote
ok 7 - pushing to local repo
not ok 8 - synch with changes from localclone
#
#               (cd clone &&
#                git pull)
#
not ok 9 - pushing remote local repo
#
#               (cd clone &&
#               echo content >>file &&
#               git commit -a -m four &&
#               git push) &&
#               compare_refs clone HEAD server HEAD
#
ok 10 - fetch new branch
not ok 11 - fetch multiple branches
#
#               (cd localclone &&
#                git fetch
#               ) &&
#               compare_refs server master localclone refs/remotes/origin/master &&
#               compare_refs server new localclone refs/remotes/origin/new
#
not ok 12 - push when remote has extra refs
#
#               (cd clone &&
#                echo content >>file &&
#                git commit -a -m six &&
#                git push
#               ) &&
#               compare_refs clone master server master
#
ok 13 - push new branch by name
not ok 14 - push new branch with old:new refspec # TODO known breakage
ok 15 - proper failure checks for fetching
not ok 16 - proper failure checks for pushing # TODO known breakage
# still have 2 known breakage(s)
# failed 4 among remaining 14 test(s)
1..16
