From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 2/2 v2] run-command (Windows): Run dashless "git <cmd>" (solves part of problem with system_path)
Date: Tue, 29 Jul 2008 07:55:40 +0200
Message-ID: <42EF8777-BABC-4757-AD49-627320F24D39@zib.de>
References: <BF5B7CBE-ACA8-4D81-8FC0-8A7901205854@zib.de> <1217308647-23673-1-git-send-email-prohaska@zib.de> <20080729052459.GC11947@spearce.org> <7v4p69meka.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 07:56:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNiCK-0004Yd-Vt
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 07:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753993AbYG2Fzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 01:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753875AbYG2Fzg
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 01:55:36 -0400
Received: from mailer.zib.de ([130.73.108.11]:43720 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753866AbYG2Fzg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 01:55:36 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6T5tLKe003512;
	Tue, 29 Jul 2008 07:55:26 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db9068d.pool.einsundeins.de [77.185.6.141])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6T5tHL5004821
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 29 Jul 2008 07:55:21 +0200 (MEST)
In-Reply-To: <7v4p69meka.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90585>


On Jul 29, 2008, at 7:42 AM, Junio C Hamano wrote:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
>
>> This feels wrong to me.  fast-import probably won't be adversly
>> impacted by not being able to read /etc/gitconfig, unless the user
>> has set something like core.deltaBaseCacheLimit and is doing an
>> incremental import.  But other non-builtins may be impacted.
>>
>> It feels like we're fixing this in the wrong place.  If the issue
>> is we don't find our installation directory correctly, we should
>> find our installation directory correctly, not work around it by
>> calling builtins through the git wrapper.
>>
>> Though I can see where it may be a good idea to at some point
>> in the future (git 1.7?) stop creating the redundant builtin
>> links under libexec/git-core.
>
> I agree; that is why I already applied Steffen's original patch with  
> quite
> a different justification from the updated one:
>
> commit b048b9a803f48d88595877271b53bf9ec400e4ba
> Author: Steffen Prohaska <prohaska@zib.de>
> Date:   Mon Jul 28 07:50:28 2008 +0200
>
>    run-command (Windows): Run dashless "git <cmd>"
>
>    We prefer running the dashless form, and POSIX side already does  
> so; we
>    should use it in MinGW's start_command(), too.

Thanks for reading my mind ;-)  This was the alternative justification
I had in mind after reading my patch again.

	Steffen
