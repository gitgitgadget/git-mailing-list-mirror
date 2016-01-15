From: Robert Labrie <robert.labrie@gmail.com>
Subject: Re: SChannel support in Git for Windows
Date: Fri, 15 Jan 2016 11:11:58 -0500
Message-ID: <CA+1xWarcXz4RdgXd8p-43sQ5UeRAwXmrsU_JVqwewmro7rz2Gw@mail.gmail.com>
References: <CA+1xWaokgVthDv-up76RP+s+r4pSv5ntmePtDVND+rsKuo+-YA@mail.gmail.com>
	<20160115185923.1e9fe5220b623625fdbc8041@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Konstantin Khomoutov <kostix+git@007spb.ru>
X-From: git-owner@vger.kernel.org Fri Jan 15 17:12:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK6yp-0003rB-K3
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 17:12:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbcAOQMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 11:12:00 -0500
Received: from mail-yk0-f178.google.com ([209.85.160.178]:36029 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790AbcAOQL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 11:11:59 -0500
Received: by mail-yk0-f178.google.com with SMTP id v14so454288847ykd.3
        for <git@vger.kernel.org>; Fri, 15 Jan 2016 08:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Nxq56tOhX9TEnO4oRz1/ot2ApwJYPLVly5uAJrohZdQ=;
        b=PAlUA5Da+A2g8wYlecEg+AwUM9B50B/5hGx90Rma6GPNCYHEb9vFeX0u4Ic6XezRE6
         oa1WH9zCS0Huryl1BeVhVRa6qSAh4Je/tGUdV0dNzc7b2tWJTcTHVKpa3jEgJ0I3cH0Q
         nMvBMN4F75EnibXSVjpvbeX5pqZWNGLoxb1n1fR9WhCz4+3R/OfFwpdtkFRBF+8ojMG8
         1+hmjBpWhAVJXh7KgXX536BdavtoOUnHhjOk9YtOR6z0P1kK7Oy080db2anmXzj0WMKl
         NbY5MnqvajTYzenkqqAeBaFSn0i4JB0zfEaiY8JFaoSqVbvL8r15coGiHFyFLAjGZmN1
         esPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Nxq56tOhX9TEnO4oRz1/ot2ApwJYPLVly5uAJrohZdQ=;
        b=FnVezNwm/d44z+eno9IFBXxPxpYmHi9zC4sEYPHDeC0L2BnQkkPtuUNOhlRc9K0NrG
         gRf0u8mJqDfQRmZWER+w91qV76lrcXZLcoupPakXidyLANYJButtSqJA9P67tYcC4t1I
         7gFPYS5I1Zu+bQOr48msRV01SrhOlkHxNqXmDUvlL0WTtfYCIHxXfqX86if54GDtYlGM
         Px1qmomj1XBzkpWPuonefupeYeRS2yVKbVd1gNK5dmREAvirSZh0cQVwCE64tGtEpZsD
         dHSGtWvBnuYfgIplw/AIpsrsaID6bVNjoo7qIu+J+QfrUSd/HU8+8L2ojE1WUj+7dpxC
         SB4Q==
X-Gm-Message-State: ALoCoQksyN+uJnMZFEzMBheADj4OWXl2ATMGGjBfxPxNLV7FhGOI4vgM6Gk8eT4DRy5fnqtY/t0mPKwhixCg0Ksw7DRnVQPNkQ==
X-Received: by 10.129.77.7 with SMTP id a7mr7913266ywb.121.1452874318176; Fri,
 15 Jan 2016 08:11:58 -0800 (PST)
Received: by 10.13.216.10 with HTTP; Fri, 15 Jan 2016 08:11:58 -0800 (PST)
In-Reply-To: <20160115185923.1e9fe5220b623625fdbc8041@domain007.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284177>

You are correct, SChannel in NT 5.x is limited, but all those versions
are officially out of support.

When you're part of a Windows ecosystem, those root certs get pushed
into the local store by a GPO (usually), and you don't have to think
about it. That's the only reason I'm pushing.

Sounds like libcurl can't make it a run time consideration, and git
(understandably) doesn't want to worry about SChannel limitations in
very old versions of Windows.

Does git use libcurl for everything? I wonder if I could just drop my
own libraries with WinHTTP support?

On Fri, Jan 15, 2016 at 10:59 AM, Konstantin Khomoutov
<kostix+git@007spb.ru> wrote:
> On Fri, 15 Jan 2016 10:04:17 -0500
> Robert Labrie <robert.labrie@gmail.com> wrote:
>
> [...]
>> But it would be more awesome if git just supported schannel on
>> Windows. I think cURL does already.
>
> On the one hand, yes -- that would mean tighter integration into the
> system which is a good thing from the administrative standpoint.
>
> On the other hand, IIUC, this artifically limits the capabilities of
> Git to whatever set of features the schannel implementation in a
> particular version of Windows supports.  As a glaring example, support
> for TLS 1.1 and TLS 1.2 had never made it into Windows XP (and
> supposedly Windows Server 2003, though I may be wrong) despite its
> serious entrenchment.  Among other things, that included IE (6, then 7,
> then 8).  I do understand the reasons MS validly has for its push on its
> customers for upgrades, but ubiquitous OSes nearing their EOL become
> prone to lacking of certain features in their stacks.  This well might
> be true for Windows 7 some 5 years down the road or so: from where I
> sit, it looks like corporate users have zero reasons to upgrade to 10.
>
> Hence ideally there would be some switch which would make libCURL pick
> the implementation at runtime.  But I'm afraid it's hardly doable.
