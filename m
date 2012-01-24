From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [BUG] Fail to add a module in a subdirectory if module is already
 cloned
Date: Tue, 24 Jan 2012 23:14:16 +0100
Message-ID: <4F1F2D38.9050909@web.de>
References: <jfmvpp$4v7$1@dough.gmane.org> <4F1F1E5F.2030509@web.de> <7vhazk3ibk.fsf@alter.siamese.dyndns.org> <4F1F2642.1070707@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 24 23:14:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpodE-0003Tn-6I
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 23:14:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819Ab2AXWOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 17:14:19 -0500
Received: from fmmailgate04.web.de ([217.72.192.242]:41801 "EHLO
	fmmailgate04.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702Ab2AXWOS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 17:14:18 -0500
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate04.web.de (Postfix) with ESMTP id 895897124558
	for <git@vger.kernel.org>; Tue, 24 Jan 2012 23:14:17 +0100 (CET)
Received: from [192.168.178.43] ([91.3.157.14]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0M73o5-1Sb3Yj3hPp-00xBGQ; Tue, 24 Jan 2012 23:14:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <4F1F2642.1070707@web.de>
X-Provags-ID: V02:K0:NKigLUQ2Gikj3IlT9KiN1z6Eo8GnqGb9GWHfApAE+n3
 kk7UPbatiapxQTTEM3nYZlu7aQ0TUy5Z6hHVEV1IS3utmz+EZ5
 24Hhtzh6r4XrGGKjI4Ta5+asjf1GSqjzCBEIHTDvGZrBwKAkoQ
 6m8OhlBYc0KMBeSvHivNKUWooLjWr0jQesXoNaA9V0MnkL7QRO
 GH5si95sIpW1NAudg3iSQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189074>

Am 24.01.2012 22:44, schrieb Jens Lehmann:
> Am 24.01.2012 22:24, schrieb Junio C Hamano:
>> I see "module_name" calls "git config -f .gitmodules" and I do not see any
>> cd_to_toplevel in git-submodule.sh that would ensure this call to access
>> the gitmodules file at the top-level of the superproject. Is that the real
>> reason why it is not finding what it should be finding?

Just for the record: I checked that and git-submodule does not set the
SUBDIRECTORY_OK environment variable so every time it is not run in the
top level directory it aborts with:
"You need to run this command from the toplevel of the working tree."
