From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: cherry picking several patches at once
Date: Sun, 24 Jan 2010 15:10:09 +0200
Message-ID: <94a0d4531001240510g25ea3398qdd0c7b98f9b81209@mail.gmail.com>
References: <20100121161157.GA3628@gandalf>
	 <94a0d4531001221557n7a892f03u5e5d1c5e5ba5fea0@mail.gmail.com>
	 <1264330354.14140.1.camel@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: me@felipebalbi.com
X-From: git-owner@vger.kernel.org Sun Jan 24 14:10:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZ2EP-0004ks-J1
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 14:10:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753747Ab0AXNKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 08:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753774Ab0AXNKM
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 08:10:12 -0500
Received: from mail-iw0-f180.google.com ([209.85.223.180]:58445 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158Ab0AXNKL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 08:10:11 -0500
Received: by iwn10 with SMTP id 10so2159017iwn.22
        for <git@vger.kernel.org>; Sun, 24 Jan 2010 05:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=BJLla3dk+RSxqG1bf0AnK7pqwVdmo7lqlKlJcMV8QOo=;
        b=dtO2gLqbTBXfUYGzESrc6JBpRicjOx4DQFERcON6H70ikLepgeO83gkj2PQUj7ZQXB
         BbJP0wXOM1I/aiUVEP4MPPa402nJmieCqrM8tWmu8ehqbyRvm+BLs3TFs9Nowg+fXf0S
         mLSm8SXHgBmBF7jHvBKlc9yInlUvSRF3Adyyc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=eGkPDjsAoUWJjR7H+drhsIybNX8m5zxK2K0wVih91FzN1qGvPW6DIDxMlATBqPcUy9
         QRl9jpIOTNzgZCkirAEBDblbmcxwBoNQFZM1eidQN0Ew0mB4UgIsqbwEEF6AWtkj50Wm
         +EJ/jst3t0u2/18VtayAhXgLtBCQ2hRPiY9Yk=
Received: by 10.231.154.213 with SMTP id p21mr3384379ibw.42.1264338609398; 
	Sun, 24 Jan 2010 05:10:09 -0800 (PST)
In-Reply-To: <1264330354.14140.1.camel@gandalf>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137894>

On Sun, Jan 24, 2010 at 12:52 PM, Felipe Balbi <me@felipebalbi.com> wrote:
> On Sat, 2010-01-23 at 01:57 +0200, Felipe Contreras wrote:
>> Have you tried something like:
>> git format-patch old-base --full-diff -- /path
>> git am -3 *.patch
>
> yes, sure that can be done, but the idea is to avoid having
> format-patch, switch branches and git am those patches ;-)

When you do a 'git rebase' you are also doing a format-patch/am, but
that happens inside the script; you can write a script that does what
you want in a way that you wouldn't notice it: save the old branch,
git stash, switch to new branch, generate the patches, apply the
patches, switch back to the old branch, git stash pop.

>> I think that would not be possible because of the challenges when
>> dealing with conflicts.
>
> there shouldn't be any. I have the same driver internally and publicly
> and would be cherry-picking only the patches for that particular driver.

Ok, in that case we would just need a cherry-pick that can commit to a
separate branch, however I don't think git internals allow that kind
of thing.

-- 
Felipe Contreras
