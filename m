From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [PATCH 07/12] MINGW: config.mak.uname: reorganize MINGW settings
Date: Mon, 28 Apr 2014 20:42:02 +0400
Message-ID: <20140428164202.GB19504@seldon>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
 <1398693097-24651-8-git-send-email-marat@slonopotamus.org>
 <CABPQNSb_+hrm-avwx4Y1749C_Ak4VN5KKvso3LeFcdDPcbqS5w@mail.gmail.com>
 <20140428150436.GB19002@seldon>
 <CABPQNSa7buDJFYsaW1a51XoRnqZiVUYGSgfS1t-UiF7TnuWX5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 18:42:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeodM-00057d-23
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 18:42:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756843AbaD1QmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 12:42:10 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:57015 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1755802AbaD1QmG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 12:42:06 -0400
Received: from marat by slonopotamus.org with local (Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1Weod0-00057I-HV; Mon, 28 Apr 2014 20:42:02 +0400
Content-Disposition: inline
In-Reply-To: <CABPQNSa7buDJFYsaW1a51XoRnqZiVUYGSgfS1t-UiF7TnuWX5g@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247381>

On Mon, Apr 28, 2014 at 05:17:25PM +0200, Erik Faye-Lund wrote:
> > 1. What are other ways to provide iconv on MinGW?
> 
> I'm not sure I understand. To set HAVE_LIBCHARSET_H, we need to have
> libcharset.h. MinGW doesn't supply by default to my knowledge, so we
> get it from iconv. The THIS_IS_MSYSGIT file is there for us to be able
> to pick the right defaults for msysGit, and us having libcharset is
> indeed a msysGit-detail. Not all iconv-flavors supply libcharset.h, so
> this tells a particularity about the one we have in msysGit.

> > 2. One can still completely disable iconv with NO_ICONV=1
> 
> Sure. And it does seem like the current setup assumes that anyone
> building for MinGW has iconv. But perhaps that's a mistake?

This patch assumes that "if user has iconv under MinGW, he has
libcharset.h". Without it, we assume "if user has iconv under MinGW,
he has langinfo.h". If user doesn't have iconv, he needs to say this
via NO_ICONV=1 in both cases. Anyway, if it is a questionable change,
I'll drop it and only keep NO_R_TO_GCC_LINKER change.

> To be honest, I think the whole THIS_IS_MSYSGIT-block should have
> stayed downstream.

That's a completely different story.
