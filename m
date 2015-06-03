From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: bug "$message" literal in commit message
Date: Wed, 03 Jun 2015 20:19:13 +0200
Message-ID: <vpqiob47izi.fsf@anie.imag.fr>
References: <CAF-5DQ+WGhHq0OZZh+90iuD1qrffcYyuprzW9m7XC6NGXPZzSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Yauheni Zablotski <e.zablotski@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 20:19:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0DG4-00074K-T4
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 20:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754776AbbFCSTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 14:19:17 -0400
Received: from mx2.imag.fr ([129.88.30.17]:46338 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754209AbbFCSTP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 14:19:15 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t53IJAS6016866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 3 Jun 2015 20:19:10 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t53IJDpE012000;
	Wed, 3 Jun 2015 20:19:13 +0200
In-Reply-To: <CAF-5DQ+WGhHq0OZZh+90iuD1qrffcYyuprzW9m7XC6NGXPZzSQ@mail.gmail.com>
	(Yauheni Zablotski's message of "Wed, 3 Jun 2015 18:51:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 03 Jun 2015 20:19:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t53IJAS6016866
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433960351.22508@+7sA+3t/Px5Uw6LVETzVwg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270720>

Yauheni Zablotski <e.zablotski@gmail.com> writes:

> Hello,
>
> I think I found a bug(or strange behavior) in the git.
> If commit message contains literal "$message" than that literal
> disappears from commit message.
>
> For example:
> -------------
> user@comp ~/cc $ git commit -am "1$message1"

Not a Git issue, but a user-error that Git cannot recover.

Your shell is doing the variable expansion before calling git, and
$message1 is considered as a shell variable here. Git does not know that
you used $message1.

Solution:

git commit -am '1$message1'

or

git commit -am "1\$message1"

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
