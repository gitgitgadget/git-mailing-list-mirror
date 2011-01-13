From: Sam Vilain <sam@vilain.net>
Subject: Re: Resumable clone/Gittorrent (again)
Date: Fri, 14 Jan 2011 12:40:46 +1300
Message-ID: <4D2F8D7E.6030305@vilain.net>
References: <AANLkTinUV9Z_w85Gz13J+bm8xqnxJ9jBJXJm9bn5Y2ec@mail.gmail.com>	<alpine.LFD.2.00.1101061956470.22191@xanadu.home>	<AANLkTikKn1+2OX1KPy+9US_yX=E6+CiaCTTB6yqnAWwW@mail.gmail.com>	<AANLkTimgn2_BWYjbGKbGoeGJ=erKundX4umfy=s16dB1@mail.gmail.com>	<AANLkTim2A4=y=XcuPuPiYGDGZyKAUEk-yv2cZVEGhQ3C@mail.gmail.com>	<AANLkTi=KPVMEviQhyJeWHynPa2q6NJpQ2VyAhbRcmQ1D@mail.gmail.com>	<AANLkTinwb8orMBjcQjK0ogXd6rMEtRwT8SV41k8D3AXL@mail.gmail.com>	<AANLkTimkDYCL7+N-Rno1-0p3Gy6o0wYrnuStV_n5k4Hk@mail.gmail.com> <AANLkTi=3ikJ2UNNCW582CT7LQ7o2DBZ1hXJhPfMUNbKk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Git Mailing List <git@vger.kernel.org>
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 14 00:40:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdWmm-0002ER-2B
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 00:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756883Ab1AMXku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jan 2011 18:40:50 -0500
Received: from mx3.orcon.net.nz ([219.88.242.53]:41185 "EHLO mx3.orcon.net.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752480Ab1AMXkt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jan 2011 18:40:49 -0500
Received: from Debian-exim by mx3.orcon.net.nz with local (Exim 4.69)
	(envelope-from <sam@vilain.net>)
	id 1PdWme-0000mG-2i
	for git@vger.kernel.org; Fri, 14 Jan 2011 12:40:48 +1300
Received: from [60.234.254.246] (helo=mail.utsl.gen.nz)
	by mx3.orcon.net.nz with esmtp (Exim 4.69)
	(envelope-from <sam@vilain.net>)
	id 1PdWmd-0000m7-Tn
	for git@vger.kernel.org; Fri, 14 Jan 2011 12:40:47 +1300
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id C52922E09D; Fri, 14 Jan 2011 12:40:47 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on naos.lan
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=unavailable version=3.3.1
Received: from [192.168.1.83] (arcturus.local [192.168.1.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 20D722E094;
	Fri, 14 Jan 2011 12:40:46 +1300 (NZDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <AANLkTi=3ikJ2UNNCW582CT7LQ7o2DBZ1hXJhPfMUNbKk@mail.gmail.com>
X-Enigmail-Version: 1.1.2
X-DSPAM-Check: by mx3.orcon.net.nz on Fri, 14 Jan 2011 12:40:48 +1300
X-DSPAM-Result: Innocent
X-DSPAM-Processed: Fri Jan 14 12:40:48 2011
X-DSPAM-Confidence: 0.5736
X-DSPAM-Probability: 0.0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165069>

On 14/01/11 00:39, Luke Kenneth Casson Leighton wrote:
> On Sun, Jan 9, 2011 at 5:48 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>> On Sun, Jan 9, 2011 at 8:55 PM, Luke Kenneth Casson Leighton
>> <luke.leighton@gmail.com> wrote:
>>>  you still have to come up with a mapping from "chains" to "pieces".
>>> in the bittorrent protocol the mapping is done *entirely* implicitly
>>> and algorithmically.
>> Given a commit SHA-1, the mapping can be done algorithmically because
>> the graph from the commit tip is fixed. Perhaps not mapping all at
>> once, but as you have more pieces in the graph, you can map more.
>  you're _sure_ about this?  what happens when new commits get added,
> and change that graph?  are you _certain_ that you can write an
> algorithm which is capable of generating exactly the same mapping,
> even as more commits are added to the repository being mirrored, or,
> does that situation not matter?

For a given set of start and end points, and a given sort algorithm,
walking the commit tree can yield deterministic results.

You need to first make sure topological sanity prevails, then order by
commit date where there are ties.  git rev-list --date-order does this. 
There is the possibility of commits with the same commit date, so if you
need to be really particular you can tie break on those, too.

Did you look at any of the previous research I linked to before?

Sam
