From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] rebase -i: only automatically amend commit if HEAD did not change
Date: Wed, 23 Jul 2008 11:55:41 -0400
Message-ID: <32541b130807230855y19bbedfah38dce9391ff4f481@mail.gmail.com>
References: <alpine.DEB.1.00.0807222235520.8986@racer>
	 <32541b130807221522r2a43c49cl6400f00dbe7451a0@mail.gmail.com>
	 <7viquxjwyf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 17:56:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLghm-0006lW-Pg
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 17:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753241AbYGWPzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 11:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753235AbYGWPzn
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 11:55:43 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:21509 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139AbYGWPzm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 11:55:42 -0400
Received: by yx-out-2324.google.com with SMTP id 8so428641yxm.1
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 08:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=MEPNtY1Oh60q79XXJC3OsG73AcStJCGzjUtzZarVhUM=;
        b=CtkYJiRZ7zOMJbMzV8IH8tNp0epVEJnoI3KSLrnsWOdO44+kLOtci/nqB/jLo3wnGF
         pJfUy25+iBrQlKXNofU9oUq/TkzCNG6euh/fzxrAFhW5ei5GbPU1sJamvSn0yOSe84ZY
         7gzkCZqtSi2Ilg07Q2kWzATZv2EvqhwxKf0no=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=k/xLNsvx83ZcWOvSUdsM+4406v1iqmY97Fxgzts8pXL94tgreMnh3BxWkKIIcHU/mQ
         sm8LPc2sxwgYyzZf7KostvG4Ap7pzXmtRTyVu4YFPBuVWalivEwhzm059N927l7MoJef
         plSy6wOveng6MjQLcZY0tjsgZGPh4xgtzYFyk=
Received: by 10.150.197.8 with SMTP id u8mr347558ybf.118.1216828541864;
        Wed, 23 Jul 2008 08:55:41 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Wed, 23 Jul 2008 08:55:41 -0700 (PDT)
In-Reply-To: <7viquxjwyf.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89691>

On 7/22/08, Junio C Hamano <gitster@pobox.com> wrote:
> "Avery Pennarun" <apenwarr@gmail.com> writes:
>  > Why doesn't "edit" just stage the commit and not auto-commit it at
>  > all?  That way an amend would *never* be necessary, and rebase
>  > --continue would always do a commit -a (if there was anything left to
>  > commit).  The special case fixed by this patch would thus not be
>  > needed.
>
> That would actually be in-line with the way how "rebase --skip" does the
>  resetting without asking the user to do so, wouldn't it?

I'm not sure exactly what you mean, but I think with my proposed
change, "rebase --skip" would do "git reset --hard HEAD" while "rebase
--continue" would do "git commit -a", so it would be nice and
symmetrical, where currently it isn't exactly.

Have fun,

Avery
