From: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
Subject: Re: git am and CRLF files
Date: Mon, 16 Nov 2009 12:15:44 +0100
Organization: ATLAS Elektronik GmbH
Message-ID: <4B013460.2030406@atlas-elektronik.com>
References: <4AFD2A8F.7000806@atlas-elektronik.com> <4B01004A.8060600@atlas-elektronik.com> <20091116195036.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Mon Nov 16 12:16:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9zZ8-0003or-Jk
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 12:16:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbZKPLQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 06:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751699AbZKPLQA
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 06:16:00 -0500
Received: from lxsrv96.atlas.de ([194.156.172.86]:49078 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751645AbZKPLQA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 06:16:00 -0500
Received: from VSSRV01.atlas.de (vssrv01.atlas.de [10.200.101.18])
	by mail96.atlas.de (Postfix) with ESMTP id 57994138A2
	for <git@vger.kernel.org>; Mon, 16 Nov 2009 12:16:02 +0100 (CET)
X-AuditID: 0ac86512-000000d4000005bc-5c-4b013472176d
Received: from mgsrv01.atlas.de ([10.200.101.16]) by VSSRV01.atlas.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 16 Nov 2009 12:16:02 +0100
Received: from mgsrv01.atlas.de (localhost [127.0.0.1])
	by mail01-int.atlas.de (Postfix) with ESMTP id 2697127174;
	Mon, 16 Nov 2009 12:16:02 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on mgsrv01.atlas.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=5.0 tests=ALL_TRUSTED,BAYES_50
	autolearn=disabled version=3.2.5
Received: from [141.200.42.243] (as106913.atlas.de [141.200.42.243])
	by mail01.atlas.de (Postfix) with ESMTP id 1986527172;
	Mon, 16 Nov 2009 12:16:02 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.14) Gecko/20080421 Lightning/0.8 Thunderbird/2.0.0.14 Mnenhy/0.7.5.0
In-Reply-To: <20091116195036.6117@nanako3.lavabit.com>
X-Enigmail-Version: 0.96.0
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133001>

On 11/16/2009 11:50 AM, Nanako Shiraishi wrote:
> Quoting Stefan Naewe <stefan.naewe@atlas-elektronik.com>
> 
>>> A repository with some UNIX (LF) and some Windows (CRLF) files.
>>> (and no: I will not change the files. My editors handle CRLF and LF correctly)
>>>
>>> My problem:
>>>
>>> 'git am' can't handle changes in CRLF files because the patch
>>> gets converted (by git mailsplit) to contain only LF.
>>> Stefan
>> Does anyone have any comment on this ?
> 
> This was done very much on purpose.
> 
> The "am" command is meant to handle e-mailed patches, and traditionally
> mails are known to clobber carriage returns.
> 
> See commit c2ca1d79dbd54b06a05e5d14a897699e59dc9f9f
> 
>     Allow mailsplit (and hence git-am) to handle mails with CRLF line-endings
>     
>     It is not that uncommon to have mails with DOS line-ending, notably
>     Thunderbird and web mailers like Gmail (when saving what they call
>     "original" message).  So modify mailsplit to convert CRLF line-endings to
>     just LF.
> 

I've noticed that.
But converting everything just breaks git am for CRLF files, doesn't it ?
Wouldn't it be possible (and sensible) to not convert the diff text, but
only the rest (mail text, headers, etc.) ?

Regards,

Stefan
-- 
----------------------------------------------------------------
/dev/random says: Change is inevitable, except from a vending machine.
