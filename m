From: cpettitt <cpettitt@gmail.com>
Subject: Re: [PATCH] Fix regression in fast-import.c due to strbufs.
Date: Fri, 26 Oct 2007 09:39:27 -0700
Message-ID: <de47e4420710260939h65fbf62dg8d1644a5cd879c23@mail.gmail.com>
References: <de47e4420710251726nb45a19fk15b3105b735a74f8@mail.gmail.com>
	 <de47e4420710251729j5858481cg69146385a2ed798d@mail.gmail.com>
	 <20071026065301.GL14735@spearce.org>
	 <20071026075912.GA25365@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Pierre Habouzit" <madcoder@debian.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	cpettitt <cpettitt@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 26 18:41:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlSFA-0008Lu-0x
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 18:41:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756599AbXJZQje (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 12:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764534AbXJZQjd
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 12:39:33 -0400
Received: from mu-out-0910.google.com ([209.85.134.188]:15598 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764384AbXJZQjb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 12:39:31 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1425526mue
        for <git@vger.kernel.org>; Fri, 26 Oct 2007 09:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Vmzdj+V+cM5eso+VX+QfwnHx1H0N3ap31H3UKoSbt8w=;
        b=a4jIawqwDsVcqzhQYHvwDJ/KwWhVZBbQOgdjzYgH231oRCim6Wew7GACiFLxENlmCsfOdJMBiUEOG3ccxcbkh3PohbsW3udhPCtsNDmqdvecGyLU94m5u5Z0uU3CY0+ThsoU8eH6gmrCT8T7OXWnC+U1eckTrWAoFAB/drOMCzU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TLxJ2rAbSu9qUR/2yWCuHLgy3oeqa/DaU+0dU9Dfs3zDZbzzh0Uzm8ml+l17rphIXC5klFO3zh+OdK+ExSQsgguBpYhfB0ReyG2xHOMwFCgHVrrKG0Plgi5J4POOFkpt2bBbc1ZZYBfOiDxx//wabMyNShU4bvwV/tRTxa5qluo=
Received: by 10.82.138.6 with SMTP id l6mr6290298bud.1193416767783;
        Fri, 26 Oct 2007 09:39:27 -0700 (PDT)
Received: by 10.82.171.3 with HTTP; Fri, 26 Oct 2007 09:39:27 -0700 (PDT)
In-Reply-To: <20071026075912.GA25365@artemis.corp>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62425>

On 10/26/07, Pierre Habouzit <madcoder@debian.org> wrote:
> Without this strbuf_release, it yields a double free later, the command is
> in fact stashed, and this is not a memory leak.
>
> Signed-off-by: Pierre Habouzit <madcoder@debian.org>

Pierre,

You nailed it! No more double frees and no segfault.

Thanks,
Chris
