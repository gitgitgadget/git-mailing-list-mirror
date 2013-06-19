From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [Request] Git reset should be able to ignore file permissions
Date: Wed, 19 Jun 2013 07:40:45 +0200
Message-ID: <vpqsj0emzdu.fsf@anie.imag.fr>
References: <CACuz9s31OUWNxTqCmj7ukAo7=TpXK7zBv5kTFZ5obpXKOju9ng@mail.gmail.com>
	<vpqsj0fr19j.fsf@anie.imag.fr>
	<CACuz9s1KGKsL-pGftAtAWyX5gUA5c-PYyJUSstf+xw151rZLtA@mail.gmail.com>
	<vpq7ghrqzrv.fsf@anie.imag.fr>
	<CACuz9s0=7z-M1-zgRNUs2hS-4LcuXrsWbqyDaMnuvFXRnP7E-Q@mail.gmail.com>
	<vpqppvjpjz3.fsf@anie.imag.fr>
	<CACuz9s2DfN5O91ZF8QOnWuA0V3bGFuUG5RVmkmjeL7Jien+fYg@mail.gmail.com>
	<CACuz9s1H2Gi+B7=Fc3yJ+PC9oDueLQzXstSX0C9uAy3_MN4Kag@mail.gmail.com>
	<vpqy5a7mmsg.fsf@anie.imag.fr>
	<CACuz9s2KEne5_PwHwmsd1X7iE=GB3pC=iUzxSo=t6TbF+ZjCxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Alexander Nestorov <alexandernst@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 07:40:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpB8W-0004bN-Hw
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 07:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227Ab3FSFkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 01:40:49 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58415 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751325Ab3FSFks (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 01:40:48 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5J5ejOB004978
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 19 Jun 2013 07:40:45 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UpB8P-0001R0-Oj; Wed, 19 Jun 2013 07:40:45 +0200
In-Reply-To: <CACuz9s2KEne5_PwHwmsd1X7iE=GB3pC=iUzxSo=t6TbF+ZjCxA@mail.gmail.com>
	(Alexander Nestorov's message of "Tue, 18 Jun 2013 19:03:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 19 Jun 2013 07:40:45 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228342>

Alexander Nestorov <alexandernst@gmail.com> writes:

> How about that:
>
> +Reset only files who's content changed (instead of mtime modification)::

Much better, yes. I'd say "stat information" instead of mtime (that's
what used in the description of update-index --refresh, and is a bit
more accurate since Git also checks the inode number IIRC).

> +------------
> +$ git update-index --refresh               <1>
> +$ git reset --hard                         <2>
> +------------
> ++
> +<1> Make git realize which files actually changed instead of

s/git/Git/ when talking about "The Git system" (as opposed to "The git
command"). git-gui or other Git clients would also see the index change.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
