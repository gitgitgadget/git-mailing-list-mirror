From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Can `git grep` have `--Author` option?
Date: Wed, 06 Apr 2016 08:05:40 +0200
Message-ID: <vpqshyzw9u3.fsf@anie.imag.fr>
References: <8737qztya5.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Chen Bin <chenbin.sh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 08:06:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1angbU-0001oL-Rk
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 08:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754460AbcDFGGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 02:06:05 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47749 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754362AbcDFGGD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 02:06:03 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u3665dw8023846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 6 Apr 2016 08:05:39 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u3665elo001165;
	Wed, 6 Apr 2016 08:05:40 +0200
In-Reply-To: <8737qztya5.fsf@gmail.com> (Chen Bin's message of "Wed, 06 Apr
	2016 09:45:54 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Wed, 06 Apr 2016 08:05:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u3665dw8023846
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1460527540.28025@SvLF2zKWtq0bGMrcdiXNVw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290822>

Chen Bin <chenbin.sh@gmail.com> writes:

> This is a feature request.
>
> From time to time, I want to re-use MY code. So git grep with --Author
> options is really useful. My current git version is 2.6.3, looks it
> doesn't have this option.

Git doesn't "know" which line of code is yours. What it can do is walk
through history to find out: this is "git blame", and you can already do
"git blame | grep ...".

A "git grep --author" would need to blame all files before searching
inside them, or grep first and blame each line in the result to filter
out lines from the wrong author. That would be possible, but relatively
hard to implement and painfully slow. Which probably explains why no one
implemented it yet ...

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
