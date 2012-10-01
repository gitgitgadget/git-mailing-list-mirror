From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] git-add: -s flag added (silently ignore files)
Date: Mon, 01 Oct 2012 20:04:58 +0200
Message-ID: <vpqehlif4qd.fsf@grenoble-inp.fr>
References: <1349075700-26334-1-git-send-email-olaf.klischat@gmail.com>
	<1349075700-26334-2-git-send-email-olaf.klischat@gmail.com>
	<7vipaucbur.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Olaf Klischat <olaf.klischat@gmail.com>, git@vger.kernel.org,
	olaf@sofd.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 20:07:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIkO7-0003tH-Qv
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 20:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754009Ab2JASGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 14:06:30 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52099 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751379Ab2JASG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 14:06:28 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q91HxYPO015453
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 1 Oct 2012 19:59:34 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TIkMV-0006fC-7y; Mon, 01 Oct 2012 20:04:59 +0200
In-Reply-To: <7vipaucbur.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 01 Oct 2012 10:59:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 01 Oct 2012 19:59:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q91HxYPO015453
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1349719175.49801@56CgASaHyYLvIW890Fjpxg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206753>

Junio C Hamano <gitster@pobox.com> writes:

>>  static struct option builtin_add_options[] = {
>>  	OPT__DRY_RUN(&show_only, N_("dry run")),
>> @@ -329,6 +329,7 @@ static struct option builtin_add_options[] = {
>>  	OPT_BOOLEAN( 0 , "refresh", &refresh_only, N_("don't add, only refresh the index")),
>>  	OPT_BOOLEAN( 0 , "ignore-errors", &ignore_add_errors, N_("just skip files which cannot be added because of errors")),
>>  	OPT_BOOLEAN( 0 , "ignore-missing", &ignore_missing, N_("check if - even missing - files are ignored in dry run")),
>> +	OPT_BOOLEAN('s', "silent-ignores", &silent_ignores, N_("don't fail when ignored files are specified on the command line (ignore them silently)")),
>
> I'd prefer not to see a new option whose worth hasn't been proven in
> the field to squat on any short-and-sweet single letter option
> name and would suggest replacing that 's' with 0, at least for now.

Another option would be a -k (--keep-going) that would ignore the files,
but not silently. "git mv" has such an option already.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
