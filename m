From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] Windows: improve performance by avoiding a static
 	dependency on ws2_32.dll and advapi32.dll
Date: Fri, 29 Jan 2010 08:44:16 +0100
Message-ID: <4B6291D0.5000400@viscovery.net>
References: <1264666525-4956-1-git-send-email-michael.lukashov@gmail.com>	 <4B61543F.6020904@viscovery.net>	 <63cde7731001280218g29a63094od4f5a8135c6986a4@mail.gmail.com>	 <alpine.DEB.1.00.1001281137550.3380@intel-tinevez-2-302> <63cde7731001280247w51d32475ob5fa22f796fa50b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Michael Lukashov <michael.lukashov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 08:44:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NalWk-0007PR-OA
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 08:44:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756065Ab0A2HoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 02:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754132Ab0A2HoT
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 02:44:19 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:60070 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753171Ab0A2HoT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 02:44:19 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NalWa-0000QJ-K7; Fri, 29 Jan 2010 08:44:16 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 5691C1660F;
	Fri, 29 Jan 2010 08:44:16 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <63cde7731001280247w51d32475ob5fa22f796fa50b7@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138302>

Michael Lukashov schrieb:
> The runtime of 'make -j2 test' went down from 35:19min
> to 32:39min on my machine.

Sorry, I can't back this claim. In my tests, 'make -j2 test' did not go
down. My timings were between 13:40min and 13:50min with and without the
patch, and I tried multiple times.

For the MinGW version, I'd rather not apply this patch. People interested
in optimizing the MSVC version could link with /delayload:ws_32.dll to
achieve the same effect without any change to the code.

-- Hannes
