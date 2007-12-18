From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: log/show: relative pathnames do not work in rev:path
Date: Wed, 19 Dec 2007 00:05:26 +0100
Message-ID: <200712190005.27154.jnareb@gmail.com>
References: <20071218173321.GB2875@steel.home> <200712182224.28152.jnareb@gmail.com> <20071218222032.GH2875@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dana How <danahow@gmail.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 00:06:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4lVd-0001uJ-Lp
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 00:05:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753143AbXLRXFf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Dec 2007 18:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752675AbXLRXFf
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 18:05:35 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:38866 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776AbXLRXFe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 18:05:34 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1483596nfb.21
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 15:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=YOkZAu6HmOZl0c2gXFVAnq2p8een+66BBL3hIH60/4w=;
        b=gcPr1oRPldrlLindtcdElTIm8IwNSAykov0k0Bce7s7oxepZj2SGXugoIUVBcc/Qgm0Kl0T8V8BOI/fQmt3YUf15DW4JxodlMJJ2oa/oj+EVMAc3foRH3UIAI9V7eN2BslarjgYXGfdkaMPai31wvAL6p2LufZamXQ1zaN/E0Lc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=NHAobat6LpWT5u2BZDEI0zaM8P0HxM7gklurbwKyg7ZCu7b1sWP9uXSOjhOlm1kXtT3UeHoQh1dJD6fAZAPTxnvhwqThtxgjQ+0YkPwhtgZHORzVByezGPOx9xRftwja4YeUVEg9cndThEc6WfHxhS9444SUq7OTZ+0FiQqQZ8o=
Received: by 10.78.188.10 with SMTP id l10mr11333314huf.14.1198019129150;
        Tue, 18 Dec 2007 15:05:29 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.255.201])
        by mx.google.com with ESMTPS id k5sm4178402nfh.2007.12.18.15.05.27
        (version=SSLv3 cipher=OTHER);
        Tue, 18 Dec 2007 15:05:28 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20071218222032.GH2875@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68842>

Dnia wtorek 18. grudnia 2007 23:20, Alex Riesen napisa=B3:
> Jakub Narebski, Tue, Dec 18, 2007 22:24:26 +0100:

>> Not "relative to project root". Relative to tree-ish used on right h=
and
>> side in <tree-ish>:<path> extended SHA-1 syntax. It is usually proje=
ct
>> root, because when you specify <commit> or <tag> as <tree-ish> it re=
fers
>> to top/root directory of a project.
>=20
> I know. My problem: it is also awkward. git-show :test-l<Tab>ib.sh ju=
st
> does not do what I expect. Nor does git cat-file HEAD:test-l<Tab>ib.s=
h.
> And git cat-file HEAD:t/test-l<Tab> does not work at all. And this is
> very simple example. Normally the pathnames are about 100 characters
> long.

Doesn't bash completion (or zsh compltion) for git implement this?
Let me check... it does

 $ . contrib/completion/git-completion.bash
 $ git cat-file -p HEAD:t/test-<TAB>
 $ git cat-file -p HEAD:t/test-lib.sh    # autocompleted

It does work correctly also from within t/ directory.

--=20
Jakub Narebski
Poland
