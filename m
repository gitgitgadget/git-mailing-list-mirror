From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Wrap up of Line Level History Browser [long]
Date: Sun, 22 Aug 2010 14:57:06 -0600
Message-ID: <AANLkTi=R54C8xQGnPW3VPFnyL+784nG8RMEcHF9s_THD@mail.gmail.com>
References: <AANLkTikORUbVA+AJNT-Z1d+KJ-j1xxRdBN4hzLuXBXX5@mail.gmail.com>
	<201008222247.45600.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bo Yang <struggleyb.nku@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, david@lang.hm
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Aug 22 22:57:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnHbQ-0001bM-4i
	for gcvg-git-2@lo.gmane.org; Sun, 22 Aug 2010 22:57:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752742Ab0HVU5K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Aug 2010 16:57:10 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57701 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594Ab0HVU5J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Aug 2010 16:57:09 -0400
Received: by iwn5 with SMTP id 5so2907374iwn.19
        for <git@vger.kernel.org>; Sun, 22 Aug 2010 13:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Uc/3R7qgAf//QgnLJ42jEsJxtHX2ni9WSBhBaTlZwRE=;
        b=PDuKQLcIRsIFmh49uxdE4yvjJX3ygGYzrZzbnSLkFGa14O+IU7+1vIchsu6vwaoA8d
         TpwzyBN4yxTXXYmbNLPaE55qYMhJKJ2kaXqGC9x7rVZJb4CMnAm7g15yz98PdF0DMjuU
         yEYibPB9mCsTx4hqEOSlXLRsncCgPaaObpSqM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DdtuU5wqT9FolwzXhH8Xx5oUJXOYeq7SWFjX9V4P2A5jdVLhH+k/GAFayk4IiNVFNE
         LdtIXeu0AEG0WcibFW5EqzYJ+sWXYS9FF9hLaaHh4nlWcTPAvX5NNxn3/G/7Va4gTDkL
         WWuMtgxnZolc8ROv/9yxDpJv13kJBsR6VdYFU=
Received: by 10.231.40.9 with SMTP id i9mr5569722ibe.5.1282510626640; Sun, 22
 Aug 2010 13:57:06 -0700 (PDT)
Received: by 10.231.19.74 with HTTP; Sun, 22 Aug 2010 13:57:06 -0700 (PDT)
In-Reply-To: <201008222247.45600.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154191>

Thomas Rast wrote:

> For me it replaces a manual iterative process to find out in what way=
s
> a function was patched until it came to have its current shape:
>
> =C2=A0git-blame the area, find the most recent commit C
> =C2=A0while 1:
> =C2=A0 =C2=A0git show C
> =C2=A0 =C2=A0if that explains the code: break
> =C2=A0 =C2=A0git-blame the area in C^
> =C2=A0 =C2=A0find the most recent commit and call it C again
[...]
> All of this can now be replaced by a simple
>
> =C2=A0git log -L <range> <filename>
>
> A good example that I did a lot of testing with:
>
> =C2=A0git log --graph be58e70d^ -L /builtin_funcname_pattern/,/^}/ di=
ff.c

Thanks. (And thanks to Bo for implementing it!)
