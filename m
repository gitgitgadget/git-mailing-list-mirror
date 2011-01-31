From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] Disallow empty section and variable names
Date: Mon, 31 Jan 2011 10:29:45 +0100
Message-ID: <4D468109.8020409@viscovery.net>
References: <20110108144644.GA11019@localhost.suse.cz> <20110127145253.GD6312@fm.suse.cz> <20110130203445.GA9689@fm.suse.cz> <4D46694F.5070208@viscovery.net> <20110131091728.GB24297@fm.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Libor Pechacek <lpechacek@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jan 31 10:29:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pjq53-00019M-RE
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 10:29:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755263Ab1AaJ3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 04:29:48 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:56905 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204Ab1AaJ3s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 04:29:48 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Pjq4v-0002yk-Ev; Mon, 31 Jan 2011 10:29:45 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 35AA91660F;
	Mon, 31 Jan 2011 10:29:45 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <20110131091728.GB24297@fm.suse.cz>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165724>

Am 1/31/2011 10:17, schrieb Libor Pechacek:
> On Mon 31-01-11 08:48:31, Johannes Sixt wrote:
>> Am 1/30/2011 21:34, schrieb Libor Pechacek:
>>> +	test_must_fail git config . &&
>>> +	test_must_fail git config .foo &&
>>> +	test_must_fail git config foo. &&
>>> +	test_must_fail git config .foo. &&
>>
>> Not a nit: These tests only show that 'git config' cannot be asked for
>> junk, but they do not show that you cannot insert junk into the config
>> file anymore using 'git config'.
> 
> This change builds on top of "Sanity-check config variable names" which makes
> setting and getting values use the same key checking routine.  For the moment,
> it does not matter if we test the "set" ot "get" path.

The purpose of tests is not to check the implementation, but the
observable behavior. Therefore, you want to write a test case to make sure
that neither usage is broken by future changes.

-- Hannes
