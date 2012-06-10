From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH_v1] add 'git credential' plumbing command
Date: Sun, 10 Jun 2012 15:16:14 +0200
Message-ID: <vpq1ulnnw81.fsf@bauges.imag.fr>
References: <1339267502-13803-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
	<7vzk8baca0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Javier.Roucher-Iglesias@ensimag.imag.fr, git@vger.kernel.org,
	Javier Roucher <jroucher@gmail.com>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 15:17:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sdi0p-000545-Oo
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 15:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753770Ab2FJNQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jun 2012 09:16:23 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51156 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753529Ab2FJNQW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2012 09:16:22 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5AD7PwB012946
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 10 Jun 2012 15:07:25 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Sdi07-0004I3-IK; Sun, 10 Jun 2012 15:16:15 +0200
In-Reply-To: <7vzk8baca0.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 09 Jun 2012 23:53:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 10 Jun 2012 15:07:26 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5AD7PwB012946
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339938447.32327@p0vkJrVK741wtS8K6rzmtg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199600>

Junio C Hamano <gitster@pobox.com> writes:

>> diff --git a/git.c b/git.c
>> index d232de9..7cbd7d8 100644
>> --- a/git.c
>> +++ b/git.c
>> @@ -353,6 +353,7 @@ static void handle_internal_command(int argc, const char **argv)
>>  		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
>>  		{ "config", cmd_config, RUN_SETUP_GENTLY },
>>  		{ "count-objects", cmd_count_objects, RUN_SETUP },
>> +		{ "credential", cmd_count_objects, RUN_SETUP },
>
> Does "git credential" need to have a git repository (i.e. run in a
> git repository or in a working tree that is controlled by one)?

It shouldn't (hence, should use RUN_SETUP_GENTLY).

> A scripted Porcelain you would write using "git credential" may want
> to implement something like "git clone" or "git ls-remote" where you
> do not have to be in an existing repository.

("git clone" might not be the best example, as the authentication is
usually done in the "git fetch" part of "git clone", but never mind)

Actually, "git credential" has very little to do with Git, and could
even be used in a git-unrelated script.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
