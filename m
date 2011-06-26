From: Pedro Sa Costa <psdc1978@gmail.com>
Subject: Re: git push in a git-init without --bare option?
Date: Sun, 26 Jun 2011 22:21:33 +0100
Message-ID: <201106262221.33294.psdc1978@gmail.com>
References: <201106261142.28142.psdc1978@gmail.com> <vpqliwoa24m.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Jun 26 23:26:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QawqB-0004xd-3n
	for gcvg-git-2@lo.gmane.org; Sun, 26 Jun 2011 23:26:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755336Ab1FZVXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jun 2011 17:23:04 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62734 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754522Ab1FZVVh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2011 17:21:37 -0400
Received: by wyg8 with SMTP id 8so736051wyg.19
        for <git@vger.kernel.org>; Sun, 26 Jun 2011 14:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=KOU6uimksdl0vilO0Y3VCKp+uCKPBwfgF5jfztcUDP0=;
        b=cfukf0b/9w5CLlSHfAVSTJ/wASrlglMoF33VQA1abjc/cokx1/u653cGbjmRavfUlf
         8iCf16Mt2Tg5m3v5iSQteBTshIBdoOcD1DatU4Y+6hhbwX8WchMNGh6Se0uUnHkAtos+
         k360SZM5uy9ylcwRzbNLIeqQQouCuBg72myd8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id;
        b=g4cEzA3TZ5SdmVeVOFUDUObLHYBpjGl2PZtvIkFA9kpoT9u4gzjo0V0XkPKEMLzwdX
         0z2oGkwEEjbbRHOKUFh/sxjtyyAH9Oq8yGa/5ATzQwTcRHRJ/SPSRVGcGag+XZaYsB1M
         Ui3dFlVfPSmZPMEPNBWbOGIHeUelBYKHlRFTA=
Received: by 10.216.58.131 with SMTP id q3mr444255wec.25.1309123296388;
        Sun, 26 Jun 2011 14:21:36 -0700 (PDT)
Received: from barcelona.localnet (bl4-33-138.dsl.telepac.pt [81.193.33.138])
        by mx.google.com with ESMTPS id w10sm2454712weq.27.2011.06.26.14.21.34
        (version=SSLv3 cipher=OTHER);
        Sun, 26 Jun 2011 14:21:35 -0700 (PDT)
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic-pae; KDE/4.6.2; i686; ; )
In-Reply-To: <vpqliwoa24m.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176335>

So this means that eveytime that I want a repository to be shared by several 
persons, the repository must always be bare?



> Pedro Sa Costa <psdc1978@gmail.com> writes:
> > - I see that in git, I can't do git-push to a repository that wasn't
> > created with git-init --bare. Why?
> > 
> > - But doing git-pull and git-checkout to the same repository is possible.
> > I'm really confused. Any help?
> 
> git pull involves a merge, and merge may involve conflicts, and
> conflicts involve a user fixing them ... So, doing a "git pull" to merge
> in remote changes is OK, but a "git push" cannot merge changes remotely,
> hence the asymetry.
> 
> Git could just send the commits, without updating the working tree, but
> that would be terrible for the user. Let's say the user has no local
> change before the push. His checkout points to the tip of a branch
> (information stored in HEAD), so the tree matches the old HEAD. Updating
> the branch means changing the commit pointed to by HEAD, hence after a
> push, the tree does not match the HEAD anymore (which means the next
> commit will seem to revert the pushed history). This is to prevent this
> situation that Git refuses to push to non-bare repos.
-- 
Best regards,

-----------------------
