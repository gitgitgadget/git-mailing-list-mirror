From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH v5 2/3] Makefile: detect when PYTHON_PATH changes
Date: Tue, 18 Dec 2012 18:42:02 -0500
Message-ID: <20121218234202.GA13151@padd.com>
References: <20121218190009.29910.39426.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Dec 19 00:42:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl6o7-00007r-P6
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 00:42:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755177Ab2LRXmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 18:42:07 -0500
Received: from honk.padd.com ([74.3.171.149]:44422 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754945Ab2LRXmF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 18:42:05 -0500
Received: from arf.padd.com (unknown [50.55.150.96])
	by honk.padd.com (Postfix) with ESMTPSA id 17DCD20C2;
	Tue, 18 Dec 2012 15:42:05 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id DC27022615; Tue, 18 Dec 2012 18:42:02 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20121218190009.29910.39426.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211795>

chriscool@tuxfamily.org wrote on Tue, 18 Dec 2012 20:00 +0100:
> When make is run, the python scripts are created from *.py files that
> are changed to use the python given by PYTHON_PATH. And PYTHON_PATH
> is set by default to /usr/bin/python on Linux.
> 
> This is nice except when you run make another time setting a
> different PYTHON_PATH, because, as the python scripts have already
> been created, make finds nothing to do.
> 
> The goal of this patch is to detect when the PYTHON_PATH changes and
> to create the python scripts again when this happens. To do that we
> use the same trick that is done to track other variables like prefix,
> flags, tcl/tk path and shell path. We update a GIT-PYTHON-VARS file
> with the PYTHON_PATH and check if it changed.
> 
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

I played around with this a bit in the context of git-p4; and it
seems to work fine.

It's interesting that the code in git_remote_helpers/Makefile
does not work with python3, but that's not a problem to solve
here.  If you get interested in looking, that approach to
installing always struck me as a bit odd.  If it is the right
way, though, maybe we should try to unify the approach to git-p4
and potential future .py scripts in git.

Acked-by: Pete Wyckoff <pw@padd.com>

Thanks for fixing this bug.

		-- Pete
