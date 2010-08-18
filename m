From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: [BUG?] Fresh clone of jquery.git shows modifications?
Date: Wed, 18 Aug 2010 17:37:36 +0100
Message-ID: <1282149456.24584.114.camel@wpalmer.simply-domain>
References: <1282135226.24584.92.camel@wpalmer.simply-domain>
	 <2F030CF4-995A-4BA2-9D79-DA2A71F9FF79@gmail.com>
	 <1282140854.24584.112.camel@wpalmer.simply-domain>
	 <AANLkTik8RGR4OTeZYsttyBtiywGU7Wtz3gQsTjoqAQPD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org
To: Thomas Berg <merlin66b@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 18:37:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Olle9-0002iN-CG
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 18:37:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836Ab0HRQhm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 12:37:42 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:37740 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236Ab0HRQhl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 12:37:41 -0400
Received: by eyg5 with SMTP id 5so490407eyg.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 09:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=DWZdbIBQnRHZsK3Gh5/PNRV3ghgq2p6n1uLEh41eFIY=;
        b=Pz2huFAhzEDle+/Sc1jAlP/kwpBsnzNnpHEE8cLaAJPMKQlQauxr8fdq9VjCCbMLGQ
         Qq2vWRxmyTmALGswNo0SvCCQtqk7g5pkZe0BYRXq49JWPmp4vXRyW85k66jc5GXPPuNN
         Zu76w1eSWufu6yNwzeIGlVjQ9Q6MnJHETb+L4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=bqp8jAJOh+7rUMQNYTGn/BgR41QAoDWVwazb3bKx+vz90xfogGShb3dHBksQMrPhXG
         Onqm05Pxs5/RcLwWuWpZt3ngXtgyGPbMRm2P4dR7wefd2edXXzYFAOB4I4c8l58pnluw
         YdOwqkVsaduD+YJIMv1x73g7MrENL5Xx3BHsk=
Received: by 10.216.86.15 with SMTP id v15mr7124302wee.9.1282149459831;
        Wed, 18 Aug 2010 09:37:39 -0700 (PDT)
Received: from [192.168.2.64] ([193.164.118.24])
        by mx.google.com with ESMTPS id u32sm327374weq.35.2010.08.18.09.37.38
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 09:37:38 -0700 (PDT)
In-Reply-To: <AANLkTik8RGR4OTeZYsttyBtiywGU7Wtz3gQsTjoqAQPD@mail.gmail.com>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153868>

On Wed, 2010-08-18 at 17:50 +0200, Thomas Berg wrote:
> Hi,
> [snip]
> > Just to re-state: This is not "my repository". That is, I don't consider
> > it to be. So I would prefer only solutions which involve editing
> > something unversioned, such as .git/config, rather than making random
> > patches which feel very much like work-arounds to a git problem.
> 
> Such a solution exists, you can create a file .git/info/attributes,
> which will override the faulty .gitattributes file in the repository
> [1]. Then you could make git treat all files as binary files, making
> no conversions. Using this unversioned file also enables you to jump
> back in history, rebase etc. without problems.
> 

.git/info/attributes
* -crlf

seems to be what I was looking for! Thank you.

Though I very much think the way git currently acts in this situation is
quite inexcusably broken.

> Hope this helps,
> Thomas
> 
> [1] http://www.kernel.org/pub/software/scm/git/docs/gitattributes.html
