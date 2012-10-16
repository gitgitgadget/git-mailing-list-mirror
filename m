From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 2/2] grep: stop looking at random places for .gitattributes
Date: Tue, 16 Oct 2012 08:39:06 +0200
Message-ID: <507D010A.8000904@viscovery.net>
References: <1349868894-3579-1-git-send-email-pclouds@gmail.com> <1349877544-17648-1-git-send-email-pclouds@gmail.com> <1349877544-17648-3-git-send-email-pclouds@gmail.com> <50758477.3030304@viscovery.net> <7vtxu2ayov.fsf@alter.siamese.dyndns.org> <50765CDC.8020509@viscovery.net> <7vpq4p80sn.fsf@alter.siamese.dyndns.org> <5077C7AC.9010301@viscovery.net> <7v4nlx3cc8.fsf@alter.siamese.dyndns.org> <507BA6F0.4090500@viscovery.net> <7vfw5fy8tx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 08:39:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO0oJ-0005yG-Ab
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 08:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753750Ab2JPGjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 02:39:15 -0400
Received: from so.liwest.at ([212.33.55.24]:64506 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754167Ab2JPGjO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 02:39:14 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TO0nz-0001En-5q; Tue, 16 Oct 2012 08:39:07 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id C63BF1660F;
	Tue, 16 Oct 2012 08:39:06 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <7vfw5fy8tx.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.5
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207806>

Am 10/15/2012 18:54, schrieb Junio C Hamano:
> Ideally, that earlier workaround
> should have done a logica equivalent of:
> ...
> and did so not in-line at the calling site but in a compat/ wrapper
> for fflush() to eliminate the need for the ifdef.

Fair enough.

>> But reverting the EINVAL check from write_or_die.c is out of question,
>> because that handles a real case.

Correction: I can't reproduce the error messages that this was working
around anymore in a brief test. I'll revert the check locally and see what
happens.

-- Hannes
