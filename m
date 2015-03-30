From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] enter_repo(): fix suffix precedence documentation
Date: Mon, 30 Mar 2015 13:08:41 +0200
Message-ID: <vpqk2xykaiu.fsf@anie.imag.fr>
References: <1427711433-3104-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 13:08:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcXYo-0004np-Hi
	for gcvg-git-2@plane.gmane.org; Mon, 30 Mar 2015 13:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748AbbC3LIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 07:08:46 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59687 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751659AbbC3LIp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 07:08:45 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t2UB8e6U016694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 30 Mar 2015 13:08:40 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t2UB8f9R030638;
	Mon, 30 Mar 2015 13:08:41 +0200
In-Reply-To: <1427711433-3104-1-git-send-email-pyokagan@gmail.com> (Paul Tan's
	message of "Mon, 30 Mar 2015 18:30:33 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 30 Mar 2015 13:08:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t2UB8e6U016694
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1428318520.6548@Ov6nVYjYXOOsqlLuBQc8gQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266452>

Paul Tan <pyokagan@gmail.com> writes:

> The ordering of the list of suffixes tested in enter_repo() is
> documented as "%s.git/.git", "%s/.git", "%s.git", "%s". This does not
> match the ordering of the list of suffixes tested in the code which is
> "%s/.git", "%s", "%s.git/.git", "%s.git". Fix this.

Indeed:

		static const char *suffix[] = {
			"/.git", "", ".git/.git", ".git", NULL,
		};

So the patch is clearly good. Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
