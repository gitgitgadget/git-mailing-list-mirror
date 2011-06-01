From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Clarified how "git submodule add" handles relative paths.
Date: Wed, 01 Jun 2011 21:55:49 +0200
Message-ID: <4DE69945.1080601@web.de>
References: <7vaae2ihe1.fsf@alter.siamese.dyndns.org> <1306943792-1825-1-git-send-email-marcnarc@xiplink.com> <7vsjrth4iy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org,
	Mark Levedahl <mlevedahl@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 21:56:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRrWs-00010S-Su
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 21:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759601Ab1FAT4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 15:56:30 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:35651 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755300Ab1FAT43 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 15:56:29 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate01.web.de (Postfix) with ESMTP id E476119023819;
	Wed,  1 Jun 2011 21:55:49 +0200 (CEST)
Received: from [93.246.50.133] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QRrW9-0006R0-00; Wed, 01 Jun 2011 21:55:49 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <7vsjrth4iy.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+vtpFTR1TtsscJHxnQPMYYN+LXG7kVbbEOoGBV
	DkgmizOU0tQ8rZXRtmoTZhaadTAxwnKOwlcHyKMt1sIdvHtYPh
	t6PMB0gF5TrY///SYrZQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174898>

Am 01.06.2011 18:59, schrieb Junio C Hamano:
> I thought that in general "submodule add" takes a URL and never a _local_
> filesystem location, as the whole point [*1*] of running "submodule add"
> command is to update the entry in the .gitmodules file for people who may
> not have access to _your_ local filesystem in the first place?

I often use a local filesystem location for shared code I'm using in some
personal projects, mainly because I want to avoid the hassle of setting
up a server location for it (and the git test suite uses that feature too
for similar reasons). That doesn't make much sense when working together
with others, but that is not an issue in these use cases.

So I see three different location types supported by current submodule
add:
  1) a URL reachable by you and your coworkers
  2) a path relative to the URL of the superproject's default remote
  3) A local filesystem location which can only be shared locally
And each of them has its merits and uses (and using two of them everyday
might make it easy to overlook the third ;-)
