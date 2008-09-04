From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: git rev-list --author/--committer b0rked with -F/--fixed-strings
Date: Thu, 4 Sep 2008 15:46:52 +0200
Message-ID: <cb7bb73a0809040646l25737a82jf380b4e17ef103f1@mail.gmail.com>
References: <g9o0ac$qig$1@ger.gmane.org>
	 <7v4p4w75b7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 15:48:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbFBq-0000zs-GX
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 15:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbYIDNqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 09:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbYIDNqy
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 09:46:54 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:44948 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbYIDNqx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 09:46:53 -0400
Received: by gxk9 with SMTP id 9so6279673gxk.13
        for <git@vger.kernel.org>; Thu, 04 Sep 2008 06:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=f6cb0DWsviyQXxE90T/Z8rvkwePCMpM5lltYzp+W+wM=;
        b=Np97QPYH4WLUgz1zadgEcbQjUnRghGfuKwKK7bOb+jPmeTHt+AfFXTiQ3WGKAfRboc
         zefixx/ZyROx/2sEHPLNZKt1T1P4HpyATbAFY6mhDGKNEczdRIwc07z/tpYebTKGQGld
         j2l/ePv2EQAO09CNknILN654Z7m/Duql5rXk8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=CfdSoE5YJJ+1AomK40XdOhaFbHO/k21KO6H56y4fxG7b35KtKnsv7CuBgmEJ8cd0Yt
         fBVAJnIuVWAYpkW1zxYEYTXM2zwl6PQyGJY4htQqyxAb1NHZAcJciaT/ZEizmHMzZWlU
         pOufGRf5b7qGy3vBsuqRIVWA75EpqsFSGLbJ4=
Received: by 10.151.49.8 with SMTP id b8mr14454354ybk.180.1220536012482;
        Thu, 04 Sep 2008 06:46:52 -0700 (PDT)
Received: by 10.150.145.2 with HTTP; Thu, 4 Sep 2008 06:46:52 -0700 (PDT)
In-Reply-To: <7v4p4w75b7.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94934>

On Thu, Sep 4, 2008 at 9:12 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Because we allow you to give "-F" and "--author=foo" in any order, looking
> at the options we have seen already and adjusting the pattern depending on
> the fixed-string option in the code would not be workable.  You would have
> to instead queue up all the --grep/--author/--committer options until the
> very end and _then_ compile them at the end, after you saw all the other
> grep related options such as -i/-F/-E

I suspected as much ... basically the idea would be to transform
fixed-string searches into auto-quoted regexp matches, right? I wonder
what kind of speed hit this would give.

> I am not interested in helping people with attitude very much ;-)

Ouch, I'm sorry. Did I come through as having an attitude? The reason
why I specified I thought it was a bug was because, as you specified,
regexps are actually necessary with --author etc, so one might
consider it a simple flag incompatibility. Sorry.


-- 
Giuseppe "Oblomov" Bilotta
