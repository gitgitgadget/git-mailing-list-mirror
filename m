From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH, take 1] Linear-time/space rename logic (exact renames only)
Date: Mon, 22 Oct 2007 10:31:03 +1000
Message-ID: <ee77f5c20710211731n2646ae11jd2fb2c0be12494ac@mail.gmail.com>
References: <alpine.LFD.0.999.0710211603200.10525@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"David Kastrup" <dak@gnu.org>, "Jeff King" <peff@peff.net>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Oct 22 02:31:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjlCQ-0001IC-Jy
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 02:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbXJVAbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 20:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbXJVAbG
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 20:31:06 -0400
Received: from rv-out-0910.google.com ([209.85.198.191]:21401 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbXJVAbD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2007 20:31:03 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1022143rvb
        for <git@vger.kernel.org>; Sun, 21 Oct 2007 17:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=a/t3ogQAnL6lLOvgUOkzEHg/AcOv4zNu4/gHHeLlepM=;
        b=RPgSaP2hZH9frIAr93b9sHq4XnKDxF3q3Vsc7OfFeFFwtPNePgaUJxfIU2+/FQdf/x5rD6+COuaqxrOXPWyUg9kIJvmlTG5OFTrBpB+uSSGqPVDYx4gN4uiGEwR3GA+Ekv61P54qUGFdf5WfXKoBEc+c6EXIevJBZw4HPRBS7xw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LmoZqWjciN+A5DHMqaLUHoBxxz1uAVy3AjX2slfB3UFq4H3vxNgzTa4RHt3qtHIwk2uvwkCgi/CZ145G7gSvuAux8V686iAG+/+Sk5egGhKEsLaq53aaSFxMHzoVerQHheAiToSDN+071C9rJnxaA+Fr7vq68wG7ukcuIyQ6z34=
Received: by 10.140.164.1 with SMTP id m1mr2029293rve.1193013063068;
        Sun, 21 Oct 2007 17:31:03 -0700 (PDT)
Received: by 10.141.153.4 with HTTP; Sun, 21 Oct 2007 17:31:03 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0710211603200.10525@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61924>

On 22/10/2007, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> diff --git a/Makefile b/Makefile
> index 8db4dbe..17c31ba 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -291,7 +291,7 @@ LIB_H = \
>         run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
>         tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
>         utf8.h reflog-walk.h patch-ids.h attr.h decorate.h progress.h \
> -       mailmap.h remote.h
> +       mailmap.h remote.h hash.o

I assume that should be "hash.h", not "hash.o"?


Dave.
