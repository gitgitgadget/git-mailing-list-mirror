From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: GSoC 2016: Microproject
Date: Fri, 19 Feb 2016 14:03:24 +0100
Message-ID: <vpq37so26oz.fsf@anie.imag.fr>
References: <CA+DCAeTAmUAciCx33ZHLKReHSy4K-dEeaKSb19qBcQc_U80UJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 14:03:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWkic-0003rB-M5
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 14:03:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757198AbcBSNDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 08:03:31 -0500
Received: from mx2.imag.fr ([129.88.30.17]:36978 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757146AbcBSND3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 08:03:29 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u1JD3MIP015272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 19 Feb 2016 14:03:23 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1JD3Okm007256;
	Fri, 19 Feb 2016 14:03:24 +0100
In-Reply-To: <CA+DCAeTAmUAciCx33ZHLKReHSy4K-dEeaKSb19qBcQc_U80UJA@mail.gmail.com>
	(Mehul Jain's message of "Fri, 19 Feb 2016 14:29:03 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 19 Feb 2016 14:03:23 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1JD3MIP015272
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1456491803.49145@w9iu/Re2oHlzHm/Wa2egMw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286714>

Hi,

This is a double-post. You've posted almost the same message under the
title "GSoC 2016". Nothing serious, but attention to details is
important if you want to give a good image of yourself.

Mehul Jain <mehul.jain2029@gmail.com> writes:

> Hello everyone,
>
> I'm Mehul Jain. I'm looking for participating in GSoC 2016.

Note that we are just submitting our application, but have no guarantee
that the Git organization will be accepted for this year's GSoC.

> I've started work on a Microproject" Teach git pull --rebase the
> --no-autostash" option. While looking at Git's source code I have made
> following observation: In the pull.c file
> 1.  git_config_get_bool( , ) search in the configuration key for the
> value of rebase.autostash, if found true then modify autostash's value
> to a non-zero number and thus making a stash to encounter the problem
> of dirty tree.
> 2. Here if in command line a flag "--no-autostash" is given then we
> can easily set the value of autostash = 0 and thus killing the process
> by die_on_unclean_work_tree(prefix).
> Is my observation is right?

I don't have all the code in mind, but I think it is. In this situation,
you always end up with a variable telling Git what to do (I guess,
autostash here), and this variable is set according to the configuration
and the command-line.

You should be careful about the precedence: command-line should override
the configuration. And the default behavior should be used if neither
the command-line nor the configuration specified otherwise.

To get an example, you can pick any pair (command-line option, config)
that work together, find the code implementing it and blame to find the
corresponding commit.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
