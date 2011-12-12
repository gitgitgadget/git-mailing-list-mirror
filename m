From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: Question about commit message wrapping
Date: Mon, 12 Dec 2011 17:37:13 +0100
Message-ID: <4EE62DB9.8030406@ira.uka.de>
References: <35A5A513-91FD-4EF9-B890-AB3D1550D63F@sidneysm.com>	<m3zkf1hnh9.fsf@localhost.localdomain>	<E085218D-9287-4F82-B34C-8379742F818A@sidneysm.com>	<201112102030.15504.jnareb@gmail.com>	<CAH5451kGn72tLAwdvQFBjSyHSL0rUmaPZrbL7Z-KfHWN-HAuCQ@mail.gmail.com> <CAH6sp9NwyxZi6KR4U96=sWdiqCseyTLEDoHdw=y9hUx2kHwOpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?B?U2lkbmV5IFNhbiBNYXJ0w61u?= <s@sidneysm.com>,
	git@vger.kernel.org
To: Frans Klaver <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 17:36:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra8rd-000661-Dw
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 17:36:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009Ab1LLQgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 11:36:25 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:52013 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751373Ab1LLQgY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Dec 2011 11:36:24 -0500
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1Ra8rQ-0003q1-Oc; Mon, 12 Dec 2011 17:36:22 +0100
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1Ra8rQ-0001eZ-Fj; Mon, 12 Dec 2011 17:36:16 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <CAH6sp9NwyxZi6KR4U96=sWdiqCseyTLEDoHdw=y9hUx2kHwOpg@mail.gmail.com>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1323707782.174498000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186915>

On 12.12.2011 09:41, Frans Klaver wrote:
>> Emails on this list are almost exclusively sent pre-wrapped to 80
>> character line lengths.
>> The result is exactly the kind of ragged output you used in your
>> example. Changing this behaviour may break backwards compatibility,
>> but it is already broken for 'future' compatibility.

I don't really see backwards compatibility broken either. At the moment 
commit messages are usually pre-wrapped at 72 columns, which looks 
perfect only on 80 column displays, ok on wider displays and bad on 
narrow displays.

If the requirement to pre-wrap would fall and either 'git log' or 'less' 
doing the wrap, old commit messages would still look perfect on 80 
column, ok on wider and bad on narrow displays. Newer commit messages 
would look good everywhere.

The only breakage would be that new long commit messages would look bad 
on older git versions. Because of that the auto-wrap should be 
implemented first and the "requirement" for 72 columns should fall in a 
later version.

> I am starting to think that we need to somehow keep the current
> behavior, but override at smaller widths. Maybe even use format=flowed
> in format-patch.

Could you explain what overriding at smaller widths would achieve? 
Supporting format=flowed would be nice though.

> On the other hand, the fundamental use with git is to
> communicate code, and I'm not sure how that [cw]ould be handled.

I prefer wrapped code to code that is cut of at a specific column. 
Wrapped code has much less possibility for misinterpretation. Python 
programmers might disagree?

I see your proposal mainly as an improvement to the display of texts, 
not code.
