From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: git-config: aliases with parameter expansion ($1 and such)
Date: Sun, 23 Mar 2008 21:54:49 -0400
Message-ID: <76718490803231854u6ee76437h5acf37b0b602f3b1@mail.gmail.com>
References: <47E65AF5.4060708@dirk.my1.cc>
	 <76718490803230645k13471472sc99932563b0239da@mail.gmail.com>
	 <47E66382.5030800@dirk.my1.cc>
	 <20080323193842.GA23227@coredump.intra.peff.net>
	 <20080323194514.GA23492@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "=?UTF-8?Q?Dirk_S=C3=BCsserott?=" <newsletter@dirk.my1.cc>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 24 02:55:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdbuZ-0004Fg-P7
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 02:55:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754266AbYCXByv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 21:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753330AbYCXByv
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 21:54:51 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:53089 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119AbYCXByu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 21:54:50 -0400
Received: by wa-out-1112.google.com with SMTP id v27so3153608wah.23
        for <git@vger.kernel.org>; Sun, 23 Mar 2008 18:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=O9SjNAyigclHatiUMoty3jPWFmw7Ja6tlcPYikQJQfw=;
        b=bJE4to31TJDxOG7JbSJs/MWLtPo6T6ouRpywE11ECilUM9MMdsUasVzLbANkfkY88zp9c49f3whiVI53CupeCR6EZXcIiW9mIGIGrp0idURvdMNGF4bmeGt84/sfMTEv0j83ESDFSNVQGj1BB32pb5z3Ind+Fvofne3AlEMYBjI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T/7PNgDRWXsHq2ojx6eSrewqlHFAi09naYDoEndDnFfe88U2IgIoDMAULiD6RIu4+4uIgN4xx7u8/p1KXpdNJEFXITGq4hL0WJ8sn8Z0DIAPjKGtudNktVGMJ3epXavZnlTM5plW0p6WXH/UVAp6W949CxTY0Cv9RR2iEPLWN80=
Received: by 10.114.25.3 with SMTP id 3mr10614405way.22.1206323689895;
        Sun, 23 Mar 2008 18:54:49 -0700 (PDT)
Received: by 10.114.13.5 with HTTP; Sun, 23 Mar 2008 18:54:49 -0700 (PDT)
In-Reply-To: <20080323194514.GA23492@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77989>

On Sun, Mar 23, 2008 at 3:45 PM, Jeff King <peff@peff.net> wrote:
>  Hmm, I take it back. Git is doing the right thing, but it is a quirk of
>  the shell that it counts the first argument as the "name of the script"
>  even though the script actually comes from "-c".
>
>   $ sh -c 'echo $0' foo
>   foo
>   $ echo 'echo $0' | sh
>   sh

All my shell aliases therefor look like:

h          = "!sh -c 'git alias \"$1\" || git help \"$1\"' -"

(Notice the trailing '-'.)

j.
