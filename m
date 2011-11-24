From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Incremental use of fast-import may cause conflicting notes
Date: Thu, 24 Nov 2011 17:09:17 -0600
Message-ID: <20111124230917.GC27586@elie.hsd1.il.comcast.net>
References: <Pine.GSO.4.63.1111231137350.5099@shipon.roxen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing list <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	David Barr <davidbarr@google.com>
To: Henrik =?utf-8?Q?Grubbstr=C3=B6m?= <grubba@grubba.org>
X-From: git-owner@vger.kernel.org Fri Nov 25 00:09:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTiQD-0002Nj-3j
	for gcvg-git-2@lo.gmane.org; Fri, 25 Nov 2011 00:09:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753192Ab1KXXJ0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Nov 2011 18:09:26 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34721 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757Ab1KXXJZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Nov 2011 18:09:25 -0500
Received: by yenl6 with SMTP id l6so610611yen.19
        for <git@vger.kernel.org>; Thu, 24 Nov 2011 15:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BmlPP+5242RmLcvtMidOgg1vkk6Tn2vyHb+Y+uR2pR8=;
        b=JFad1KKtMHvNEdFVuXnOrvZgwQB1mMGHkm4mGVKDokmNneaWos9hGZOzO8oeyMwSCd
         aeZHpE5VQpfF1Rtw0ycQzr36Hwf2CmePDEH+4xBL/CNQRFOq1QjbMZp45vTXoF3BYlEa
         JP1EY6uusI5GJA1/safgWQxtMBzS/V8RaREzI=
Received: by 10.236.179.2 with SMTP id g2mr43998129yhm.27.1322176165186;
        Thu, 24 Nov 2011 15:09:25 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id x17sm56667252anj.18.2011.11.24.15.09.23
        (version=SSLv3 cipher=OTHER);
        Thu, 24 Nov 2011 15:09:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.63.1111231137350.5099@shipon.roxen.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185918>

Hi Henrik,

Henrik Grubbstr=C3=B6m wrote:

> Background: I have an incremental repository-walker creating a corres=
ponding
> documentation repository from a source repository
> that uses git-notes to store its state, a use for which notes
> seem very suitable.

Nice.

[...]
> when fast-import is restarted
> it won't remember the fanout, and will start writing files in the roo=
t
> again. This means that there may be multiple notes-files for the same
> commit, eg both de/adbeef and deadbeef.
[...]
> The problem is probably due to b->num_notes not being initialized pro=
perly
> when the old non-empty root commit for the notes branch is loaded in
> parse_from()/parse_new_commit().

Sounds like a bug.  Can you suggest a reproduction recipe (ideally as
a patch to t/t9301-fast-import-notes.sh), a fix, or both?

Thanks.

Regards,
Jonathan
