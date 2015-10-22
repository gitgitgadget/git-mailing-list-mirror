From: Alexander Riesen <alexander.riesen@cetitec.com>
Subject: Re: [PATCH] Consider object stores in alternates during a dissociating
 clone
Date: Thu, 22 Oct 2015 20:08:18 +0200
Message-ID: <56292612.3020609@cetitec.com>
References: <561F8DE9.4040703@cetitec.com>	<alpine.DEB.1.00.1510151609280.31610@s15462909.onlinehome-server.info>	<561FBA48.3050609@cetitec.com> <56274922.80007@cetitec.com>	<xmqqpp085cth.fsf@gitster.mtv.corp.google.com>	<5628EBAF.1030205@cetitec.com>	<xmqq7fmeubkf.fsf@gitster.mtv.corp.google.com>	<562911AD.50004@cetitec.com> <xmqqd1w6ssg5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 20:08:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpKI4-0007tD-Fn
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 20:08:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965403AbbJVSIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2015 14:08:36 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:56250 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932428AbbJVSIe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2015 14:08:34 -0400
Received: from pflsmail.localdomain ([37.123.123.67]) by
 mrelayeu.kundenserver.de (mreue104) with ESMTPSA (Nemesis) id
 0Lutwv-1aXDqO2V1t-0107wC; Thu, 22 Oct 2015 20:08:29 +0200
Received: from localhost (localhost [127.0.0.1])
	by pflsmail.localdomain (Postfix) with ESMTP id 10E6CB016C2;
	Thu, 22 Oct 2015 20:08:28 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at pflsmail.corp.cetitec.com
Received: from pflsmail.localdomain ([127.0.0.1])
	by localhost (pflsmail.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xxg8qR8frIdr; Thu, 22 Oct 2015 20:08:18 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (unknown [10.10.11.230])
	by pflsmail.localdomain (Postfix) with ESMTPS id 22EDCB01679;
	Thu, 22 Oct 2015 20:08:18 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <xmqqd1w6ssg5.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:X3N7KwEoBjOXhWj0fk8SU8952mxSIlNqoThAV+u+ZICi6kSkE/t
 wAdor6lym8+d5hPer9wogBB/I0vQuTPR2YAgEm8/TOrOBOsHxcKXzmjVhr+XsC9aq8y51wj
 J9cKxpIHBu+xD5S1rEtpX5X25U//zVHVV9ruq7hgVTfBjxTiXo6+Dc8AIxK0vv/PIo+eedW
 2M2linS4T9k95gnxRK7BA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gUe79cl4QpQ=:dGF/Z/fqvZF0w9udu/5h1C
 YL+zLDOG67yg2uKZIYE/X7D+NOV2oBHFH0xjx6J3xgcFir+zJRBVwJVaSFzMbYSniYkmsrBJV
 feCNbZ3eOiClMtI2rZw2Ql2WhgD2sh38nF2uvuBH9VEvgOFDaFU+J7Bft1QdzjH0/wRqsLUQG
 QeRUX5sKKgt5kTTUnd9BUiWBTkwXQLwdHakyuxPSx0dNlv/5/nTKoNrskmZxEQdqir+/IeVNE
 6CordM9CDSFbMsuQ3A9m3DTo2pjxeB1deT0hZa2bwCvRfi3TN1Ri8OShWPhSRYUUBOa5vsD42
 5zG/V9PuxQXS9d6LehhMXZj+jKLDJkEWDfZu8kUR9gaXHvbHV9ho3vtxS8On1MDJDIq2Oel9l
 7tTlpr8Zk04/W5ABwIZCWzFLvArz9rC2uhTSEQH21iP9eIWLxrFiwbt1BpYq1pYPZo2uyE9PT
 exKbJJ8Uq4um4DnRiJEpMs9UZ8yb073GDcnYnuvVyu9V6MuHaF3UAdDh5uAz5jUB7hPh5rceR
 a5NWr9zIxCnwXrGdQBPbbjDUhuBPMDX0nJBaggieClptQRXszyERXbCPZr5q8gexmTO0oANqy
 1hpV508WrJ5tIpm4b6DwcRWS128RfqI85dwMtApqSjwbf79oln0sPuaNObpfFCDFl1MVRHp2G
 9AplV2ubEB/5UX2nRCaSSzT/BsmhcwPAgf/AH0Isb5YeaMaN/aSvcyDUYYjXvXOvTYKrydRZN
 5pkVnhMkcuLfSbF5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280067>

On 10/22/2015 07:50 PM, Junio C Hamano wrote:
> Alexander Riesen <alexander.riesen@cetitec.com> writes:
>
>>> Content-Type: text/plain; charset=windows-1252; format=flowed
> I had to hand-munge it as the above lost all tabs and made the patch
> unusable for machines X-<.
I'm very sorry. I don't know why Icedove does that, nor do
I know how to stop it mangling the text. Right now I just
hate the damn thing.

Thank you very much for reformatting the patch, as it would
take quite some time until I configure a sane mail program
to work here.

Incidentally, what does "---" mean in the documentation hunk?

Regards,
Alex
