From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Pushing symbolic references to remote repositories?
Date: Sun, 23 Dec 2012 06:40:59 +0530
Message-ID: <CAMK1S_iKYb0sK+2+H1b7wAPjJGEhJHJk9eK1bsMqxOGKoJuipg@mail.gmail.com>
References: <CAD03jn5ACZyxJM9LEOSJov3BsT3W1N0sV3WYwcerJciMSpmSPA@mail.gmail.com>
	<CAJo=hJvqptfKqM+6J8Ddfb5qcqjAU8bB_JO9VB-XVsCCf64NUQ@mail.gmail.com>
	<7vip7vrof6.fsf@alter.siamese.dyndns.org>
	<m2ehiiv3nb.fsf@linux-m68k.org>
	<7vy5gqq6w8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Dun Peal <dunpealer@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 23 02:14:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tma93-0000AZ-DB
	for gcvg-git-2@plane.gmane.org; Sun, 23 Dec 2012 02:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432Ab2LWBLB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2012 20:11:01 -0500
Received: from mail-la0-f54.google.com ([209.85.215.54]:64976 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017Ab2LWBLA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2012 20:11:00 -0500
Received: by mail-la0-f54.google.com with SMTP id j13so6925143lah.41
        for <git@vger.kernel.org>; Sat, 22 Dec 2012 17:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fiRNoo79geyLNmQCBuLHaDJNNRLEAeeUU7uZU1zsqkU=;
        b=jfM/7kUZJ5P8k1jf0aut9CWHuNcUQ+2PcRDMA9MyNGJghBK+VNfLaen3em1TnKU4N5
         IrTSnePDM1sHnt8oR2Cd+i3LLLvkjs8YeMGeciBoeOABfWfCol6r6jDD78zcSM/CmuXu
         PIDPCEOJieakGCG8B8ibpzAi3XbBGmSwkqZFOj7xayWNrEPVS77IzldTP8CFK7vg9XKE
         RlCzg/BO4qjN2UX040G1Iz5wxmuX1roTmls1mBGFUPRSmMNE5wJURi9XWBMhb+FRwyIw
         sOoNNk+7/sG9SFRnBAYkC8b6R+Zn/dwx8ZADhnRH5VivilJP+u5e5z+ceQQfkpwOq5Zp
         OFLQ==
Received: by 10.152.124.226 with SMTP id ml2mr16217433lab.46.1356225059247;
 Sat, 22 Dec 2012 17:10:59 -0800 (PST)
Received: by 10.112.31.137 with HTTP; Sat, 22 Dec 2012 17:10:59 -0800 (PST)
In-Reply-To: <7vy5gqq6w8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212075>

On Sat, Dec 22, 2012 at 11:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Andreas Schwab <schwab@linux-m68k.org> writes:
>
>> This is not limited to HEAD, any ref may want to be set up as a symref
>> at a remote repo.  For example, I want to set up a symref master ->
>> trunk at a repository I have no shell access to.
>
> That is exactly the "hosting side does not give you an easy way so
> pushing seems to be one plausible but not necessarily has to be the
> only way" case, so it is already covered in the discussion.

Just a minor FYI (and at the risk of tooting my own horn) but if the
hosting side is gitolite, you can.set it up so that any user with
write permissions to the repo can run 'git symbolic-ref' with
arbitrary arguments even though he does not get a shell.

The "-m <reason>" has some constraints because gitolite does not allow
a lot of characters in arguments to remote commands but that's mostly
useless unless you have core.logAllRefUpdates set anyway.
