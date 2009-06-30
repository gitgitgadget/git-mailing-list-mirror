From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git-gui is slow to display a large number of changed/new files
Date: Tue, 30 Jun 2009 16:47:27 +0200
Message-ID: <81b0412b0906300747id528b76ue48d0bf1ba3709fe@mail.gmail.com>
References: <4A492FFA.5030703@zwell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Dan Zwell <dzwell@zwell.net>
X-From: git-owner@vger.kernel.org Tue Jun 30 16:58:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward1.uio.no ([129.240.10.70])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLem0-0002KX-GG
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 16:57:28 +0200
Received: from exim by mail-out1.uio.no with local-bsmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLecY-0000mE-I1
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 16:47:42 +0200
Received: from mail-mx1.uio.no ([129.240.10.29])
	by mail-out1.uio.no with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLecY-0000m8-Gr
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 16:47:42 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx1.uio.no with esmtp  (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLecW-00066B-Ub
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 16:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179AbZF3Ora (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 10:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751900AbZF3Or3
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 10:47:29 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:53687 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbZF3Or2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 10:47:28 -0400
Received: by fxm18 with SMTP id 18so187979fxm.37
        for <git@vger.kernel.org>; Tue, 30 Jun 2009 07:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1YLXfCPLZ8M9ZPweL75QCJHwAT8Hh/Qq/E9XrGaQ/0g=;
        b=xzjfw+NseGiezNURMUGibVIV6b6Q56GODAy6pgyhchJCBQO00SegUpANN0Fxvuy847
         jzPkW1ME/gDyOtEnE6QZo8Digc3C3GmBaPuCogTrwujnr+g6aku+fq+XEFYTIwTQMtTE
         HqbE7ZrdNDmsPssB1VTePjWlOcCS7odmdP168=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wfyB9eF1iAHvsInp27s0N8EYEFB5kU1qhpj4SUFa6A8m2+CCqBlNBvwTpy2ATNGpSa
         EdA5o0F/zVI7V7iYlKVMijsfCzgoMbXy02/tLRp0XbMtNEZQ5CdbMIE5jKnMAAR3Zl/+
         HpWbiYiu8TleV42ezEAPlU1z5f/mF3GudMp1A=
Received: by 10.204.65.65 with SMTP id h1mr8455406bki.18.1246373250563; Tue, 
	30 Jun 2009 07:47:30 -0700 (PDT)
In-Reply-To: <4A492FFA.5030703@zwell.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3, uiobl=NO, uiouri=_URIID_)
X-UiO-Scanned: CF93D669E1307E42F6E83385F4E1A558C2162FD4
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -69 maxlevel 80 minaction 2 bait 0 mail/h: 194 total 2547872 max/h 849 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122516>

2009/6/29 Dan Zwell <dzwell@zwell.net>:
> Is this behavior worth changing? I doubt the scenario I encountered is a
> common one.

It happens. There are imported repositories, and things like CVS/SVN/Perforce
force people to do giant commits. So yes, it definitely is worth looking into.

> ... However, I have written a patch to display at most 5000
> changed/new files, warning the user that the list has been truncated. If
> this is a worthy change, I can submit the patch--I can also change it so
> that the maximum number of displayed files is taken from git's
> configuration.

Even 5000 is insane, so that would be a good start, for sure.

Paul Mackerras is gitk's maintainer, remember to put him on Cc:
