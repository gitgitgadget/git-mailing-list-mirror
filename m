From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] edit: Allow setting git tree SHA1 of a patch
Date: Fri, 21 May 2010 13:37:59 +0100
Message-ID: <AANLkTikcG3Chw1cpiKB00MrnZz-HZk9xAF_KtTTiVECi@mail.gmail.com>
References: <20100516172738.5043.94039.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, davidk@lysator.liu.se, kha@treskal.com
To: =?ISO-8859-1?Q?Gustav_H=E5llberg?= <gustav@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 21 14:38:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFRUO-0007QZ-Ln
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 14:38:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753793Ab0EUMiD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 May 2010 08:38:03 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50778 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139Ab0EUMiB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 May 2010 08:38:01 -0400
Received: by fxm5 with SMTP id 5so781807fxm.19
        for <git@vger.kernel.org>; Fri, 21 May 2010 05:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JFSOU2gAWyY4AjZ8LaSX5ScoxYc2mApYYDAYOroQwtk=;
        b=VrL/Nj8pgkhGgLJPwekozTDPKuEE2ot5HFZcOxUXtVCslS8UWXTU7PijUbaABTyjLE
         10g97iKne6DUfwaqsdaVxmNbzKsqXNxC+4V9Wo/JEj6/Vmjt2n+oXPispXgiZOzkAZfc
         w9r/L1HeJAlFFfiyMbfFpzF7KpNmTKBth23U0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=T5yMKKpyybiHxfVxw1Ggy3bwDlexBuneg+EkhAE/CIT5VNuWzR8sFUEyiAPPSF47TO
         GMkrxHJI/MNLgF2ilY18MO5MI+HQJraneXRNo5ZsnfYLOIsW1dq1MBc8G8lyuOGtapax
         HckWLQu/XdRMF/3eiwVZ85yzj+AV6EE4Vb9DM=
Received: by 10.223.62.202 with SMTP id y10mr1374206fah.100.1274445479265; 
	Fri, 21 May 2010 05:37:59 -0700 (PDT)
Received: by 10.223.117.204 with HTTP; Fri, 21 May 2010 05:37:59 -0700 (PDT)
In-Reply-To: <20100516172738.5043.94039.stgit@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147450>

Hi Gustav,

2010/5/16 Gustav H=E5llberg <gustav@gmail.com>:
> I would like to have something similar to this patch, which allows fo=
r
> setting the (git) tree of a particular patch. I would like to use it
> (from the Emacs mode) to make it easier to split an old patch into tw=
o
> (or more).
>
> It might be that this is too "powerful" (read: unsafe), and maybe a
> better (safer) command would use whatever is currently in the index
> rather than a SHA1.

I'm not against such option (as long as it is somehow mentioned that's
dangerous) though I don't fully understand how one would use it,
especially when the patch is buried under other patches. With a series
of patches, any easily accessible tree (sha1) belongs to one of the
patches.

My current approach for splitting patches is to "goto" the patch I
need to split, run "git reset HEAD^", add the files I have to the
index and then do a "refresh --index".

Another approach is to pop the patch I want split, create individual
patches and run "pick --fold" for each new smaller patch.

--=20
Catalin
