From: James Pickens <jepicken@gmail.com>
Subject: Background processes in post-receive hook
Date: Sat, 2 Apr 2011 16:03:43 -0700
Message-ID: <AANLkTinrEt6DkwhknpDZ0iV9PR+7bBd3DAaPRJOgNFTG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 03 01:04:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q69rY-0005ij-36
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 01:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757347Ab1DBXEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2011 19:04:06 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53960 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017Ab1DBXEF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2011 19:04:05 -0400
Received: by fxm17 with SMTP id 17so3274121fxm.19
        for <git@vger.kernel.org>; Sat, 02 Apr 2011 16:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=bYOq1r1g/fT1fkIRnCxbAmnVaPTsgdRsMP57fRxVOHE=;
        b=GmGjXwxqV987BWWCfMmd01dV8cny5sTpMjnbvgfhR5jWk8y134a8sQiywwG7YcNKnW
         TcoZ4Q0Hyf6IzpeGWUSVOejG3RGNy+O6yEUOb7PY0rNqhNaWc1+KjEtfl61ZKAbxCsr+
         cE9mz2xLks/ZfVtM+O9s3tEPKn+00HtA1XIAw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=U2dNYnx5J1IUgYz2OOjeLFEf7kwcUAUJJCQ4p0GCKyiERwJDzXiHEjmE67m/0qQEHB
         JCkWD+iIdFkXiJ6iGwhg90V+aLJTojkrKpkp+ZyTaPLCBYHk2sAxbJ5M2WraIK9G5Aey
         0bbP8I3Kib4zKgHGcznEUIdcy6abCnhfeAtfI=
Received: by 10.223.160.8 with SMTP id l8mr1543512fax.114.1301785443112; Sat,
 02 Apr 2011 16:04:03 -0700 (PDT)
Received: by 10.223.109.1 with HTTP; Sat, 2 Apr 2011 16:03:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170666>

Hi,

I have a post-receive hook (bash script) that launches several background
processes and exits immediately.  I do that so I don't have to wait for the
background processes to finish every time I push to the repository, but Git
seems to wait for them to finish anyways, even though the post-receive hook
itself already exited.  Is there any way to stop Git from waiting and let the
push finish immediately?  Sorry if I'm missing something obvious...

Thanks,
James
