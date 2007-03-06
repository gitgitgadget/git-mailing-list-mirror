From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Git checkout preserve timestamp?
Date: Tue, 6 Mar 2007 13:06:21 +1300
Message-ID: <46a038f90703051606m7ce73f88hd0f6356969b73535@mail.gmail.com>
References: <17895.18265.710811.536526@lisa.zopyra.com>
	 <17900.30394.172067.743310@lisa.zopyra.com>
	 <Pine.LNX.4.63.0703052143120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <17900.36569.805689.922989@lisa.zopyra.com>
	 <Pine.LNX.4.64.0703051347490.3998@woody.linux-foundation.org>
	 <17900.39124.763603.695942@lisa.zopyra.com>
	 <Pine.LNX.4.64.0703051431130.3998@woody.linux-foundation.org>
	 <17900.42415.750335.329874@lisa.zopyra.com>
	 <Pine.LNX.4.63.0703060026340.13683@wbgn013.biozentrum.uni-wuerzburg.de>
	 <17900.43487.947400.649777@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	git@vger.kernel.org
To: "Bill Lear" <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 01:07:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HONCj-0005uA-O5
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 01:06:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933331AbXCFAGY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 19:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933372AbXCFAGY
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 19:06:24 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:15517 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933331AbXCFAGX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 19:06:23 -0500
Received: by nf-out-0910.google.com with SMTP id m19so2113720nfc
        for <git@vger.kernel.org>; Mon, 05 Mar 2007 16:06:21 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sDe6YbCRMIiCHr+F89+vuqkP95ZEA+5TPsyAdncfaYDG1rmM5S0JByWeOlHZN7hDoFUNAHXIDyXPxoBgnmq+KtZE9SMN2hixhtNs62Jk2vyY8X2+HfqHSA1JIF2SHrlrSvDLlMOfPsfIUyRTOqj+nB+quoP1X1a95iMbLaB7ikQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pjfoCfk83ciaq0WsNEkktyyb44916rkSLajdn6qLV8gKs4zopb/C6Ez1i/JRj2trYkferK8cdi/imQDDP5HZFEfCWhMl0hsh+xfDyKnJt3riby83ZfxKi2kD2DwJqL+J7wnSNt+n4yyposL05eg1vITuMqS/BIZ2+iculNSY1FU=
Received: by 10.82.163.13 with SMTP id l13mr6144751bue.1173139581491;
        Mon, 05 Mar 2007 16:06:21 -0800 (PST)
Received: by 10.48.215.2 with HTTP; Mon, 5 Mar 2007 16:06:21 -0800 (PST)
In-Reply-To: <17900.43487.947400.649777@lisa.zopyra.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41509>

On 3/6/07, Bill Lear <rael@zopyra.com> wrote:
> No, I think you missed my point.  There are two xyz.o's:
>
> One in .master/xyz.o, and one in .branchX/xyz.o.  So, you're example
> becomes:

For most users, there are no dedicated branch-specific build
directories. In any situation where there _are_ such
branch/arch/config-option specific builddirs, someone has crafted a
neat multi-<factor> build system.

Now, if you have such a build system, it's trivial to have a separate
checkout for each branch. Trying to push this bit of complexity into
git means that git would have an option that lets most users shoot
themselves in the foot, big time.

So - your ideas are OK, but just do all the trickery and magic for the
super-build-system _in_ the super-build-system. You don't need any GIT
changes, just take advantage of the really fast and lightweight "local
clone".

I guess that's the definition of "WRONG" above. It's wrong and
error-prone for most users, and for the handsome few that could take
advantage of it, there are better ways of doing it.

cheers,


martin
