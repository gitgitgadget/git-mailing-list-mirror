From: Frank Li <lznuaa@gmail.com>
Subject: Re: [PATCH 3/3] fallback SSH_ASKPASS when GIT_ASKPASS not set
Date: Thu, 25 Feb 2010 09:37:07 +0800
Message-ID: <1976ea661002241737s74e0b9d3q30ba3f6632980fa2@mail.gmail.com>
References: <1267024554-3288-1-git-send-email-lznuaa@gmail.com>
	 <7vocje38ll.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 02:37:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkSfE-0002vl-5O
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 02:37:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758736Ab0BYBhJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Feb 2010 20:37:09 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:59165 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386Ab0BYBhI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Feb 2010 20:37:08 -0500
Received: by gwj16 with SMTP id 16so1439144gwj.19
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 17:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gZZ4hcgTIfYhcXsZpc/2ZNH4ziQAE2qS8eLOI9Mo/+g=;
        b=QE1f5Z+gMHN+cOakKqFD8CtvCmQiHuYz+PP63Rf/b+fBsPpM0nA8a0gjhKc4inDv/7
         55m4fYqlGe3q8npATjrNLYWa0wvVOu5xlooyslnvQMRLIED6p8plkRSA4DMvTW16e2vD
         pe9qQ0EoyxXTdBLgFKFkUzupDO1u/dZyX3mMA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Vo0WWAB32TQ8R6DumohN0AKZTnNZOr+QiS/Qd/PI0CC7Mu1KSiJ5J2V2I2SJG84DOq
         FjXSUo5BO+aCeIGzv56yjCWQ2APzBpZm4mBfgHcwfcJzWuIFIvmN3CuAl9b4K8iOhWwd
         o26wrCY7orTKZPKOumX/9maND3/4hNCmC88jo=
Received: by 10.151.18.38 with SMTP id v38mr577166ybi.274.1267061827488; Wed, 
	24 Feb 2010 17:37:07 -0800 (PST)
In-Reply-To: <7vocje38ll.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141019>

> So probably the patch to implement the fallback should be more like
>
> =A0 =A0 =A0 =A0if (SSH_ASKPASS is set but not GIT_ASKPASS)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set GIT_ASKPASS from SSH_ASKPASS
>

do you means just keep these?

+       if (!getenv("GIT_ASKPASS") && getenv("SSH_ASKPASS"))
+               setenv("GIT_ASKPASS", getenv("SSH_ASKPASS"), 1);


best regards
=46rank Li
