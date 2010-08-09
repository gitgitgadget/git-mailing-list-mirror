From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/5] merge-recursive: porcelain messages for checkout
Date: Mon, 09 Aug 2010 22:52:00 +0200
Message-ID: <vpq4of3se4v.fsf@bauges.imag.fr>
References: <1281363602-27856-1-git-send-email-Matthieu.Moy@imag.fr>
	<1281363602-27856-3-git-send-email-Matthieu.Moy@imag.fr>
	<7vhbj34kz8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 09 22:52:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiZKo-0003RI-9A
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 22:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754826Ab0HIUwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 16:52:33 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56205 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754746Ab0HIUwd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 16:52:33 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o79KnbbO010924
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 9 Aug 2010 22:49:37 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OiZKD-0002AF-7I; Mon, 09 Aug 2010 22:52:01 +0200
In-Reply-To: <7vhbj34kz8.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 09 Aug 2010 12\:58\:03 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 09 Aug 2010 22:49:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o79KnbbO010924
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1281991781.88271@nVRdmNSkX6teAtDZH87WoQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153021>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> +void set_porcelain_error_msgs(const char **msgs, const char *cmd)
>>  {
>> +	const char *msg;
>> +	char *tmp;
>> +	const char *cmd2 = strcmp(cmd, "checkout") ? cmd : "switch branches";
>
> This may have implications to the later i18n effort, but lets ignore it
> for now.  I don't think it will be too bad.

Note that the ? : construct just allows factoring out two messages,
but one can easily distinguish all cases and give the complete error
message in the source (we don't care about performance/memory here,
it's a one-time thing).

So, yes, that's easily fixable later if it causes problems to i18n.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
