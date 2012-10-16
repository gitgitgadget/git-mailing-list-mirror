From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC/PATCH 3/4v2] test-lib: provide lazy TIME_COMMAND prereq
Date: Tue, 16 Oct 2012 21:21:00 +0200
Message-ID: <507DB39C.3080005@kdbg.org>
References: <007001cdaba8$5afc6c00$10f54400$@schmitz-digital.de> <28ca29e59c5905ba7232dcdbe4661f37ef90cac5.1350399860.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Joachim Schmitz <jojo@schmitz-digital.de>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Oct 16 21:22:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOCiQ-0003oS-Uf
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 21:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755372Ab2JPTV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 15:21:59 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:33736 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754398Ab2JPTV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 15:21:58 -0400
Received: from bsmtp.bon.at (unknown [192.168.181.107])
	by lbmfmo03.bon.at (Postfix) with ESMTP id 25F72CE0A4
	for <git@vger.kernel.org>; Tue, 16 Oct 2012 21:21:21 +0200 (CEST)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 9A7EF130045;
	Tue, 16 Oct 2012 21:21:02 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 5A3F319F3E6;
	Tue, 16 Oct 2012 21:21:01 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120825 Thunderbird/15.0
In-Reply-To: <28ca29e59c5905ba7232dcdbe4661f37ef90cac5.1350399860.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207872>

Am 16.10.2012 17:07, schrieb Michael J Gruber:
> Some test want to use the time command (not the shell builtin) and test
> for its availability at /usr/bin/time.
> 
> Provide a lazy prereq TIME_COMMAND which tests for $TEST_COMMAND_PATH,
> which can be set from config.mak. It defaults to /usr/bin/time.

This avoids the builtin:

	command time $that_command

It works for bash, ksh, zsh, and dash (where the latter doesn't have it
as builtin).

-- Hannes
