From: Parag Kalra <paragkalra@gmail.com>
Subject: Re: Making Git untrack few folders
Date: Sun, 12 Sep 2010 13:00:17 -0700
Message-ID: <AANLkTi=5_u+Ei-3+9uUYcv5bkrpGCuibMiOW-_N6H8tb@mail.gmail.com>
References: <AANLkTi=vjueuP66BAMsRDww=J3Nq3Q4BooKF+85khcBn@mail.gmail.com>
 <AANLkTiktMe190OVPrTXMtmfaLRLXeJBZ4vSZewJecQWe@mail.gmail.com> <20100912103717.GA24576@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 12 22:00:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OusjD-00014q-Er
	for gcvg-git-2@lo.gmane.org; Sun, 12 Sep 2010 22:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439Ab0ILUAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Sep 2010 16:00:38 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:49682 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752972Ab0ILUAi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Sep 2010 16:00:38 -0400
Received: by qyk36 with SMTP id 36so1175209qyk.19
        for <git@vger.kernel.org>; Sun, 12 Sep 2010 13:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=+UOsLROgNTVDEZSEayexQYUGhL5u29SsuxFGBQdXHGE=;
        b=NwdAbfkhjCLCHJSBJ0bNo0GUMVxhRuHCFqD+fOJ+bp++h794yWwmkc6VlAzeGhgrdy
         hC5clPkzVYS8lqGIGw2IWmKNqdoe0+FD4/k1NqBpohp5dkAcSRLOPO4kkvwJa9+Vos+r
         Z+pCbvWxfuHatK17mF2fZWomaBCGZqNrwJ47Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=kywzizPVzrnuyd3co8LdjW2FHfahM13nV3pJlg/Esrags0BB3BttlY9tOOU/7SSBRv
         J7cMBoyL4osKEzELjrNVecJuKXdR70Vj1Y7QxYndpSAKcNrOk4o0sjnxMiXTzqqmWRLk
         C6KgSd/in1BHWgneCwkv4GCOYce3nUpgVJ0A4=
Received: by 10.229.233.80 with SMTP id jx16mr2605164qcb.62.1284321637155;
 Sun, 12 Sep 2010 13:00:37 -0700 (PDT)
Received: by 10.229.248.149 with HTTP; Sun, 12 Sep 2010 13:00:17 -0700 (PDT)
In-Reply-To: <20100912103717.GA24576@kytes>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156048>

Thanks Ram.

git rm --cached was precisely what I was looking for.

Also .gitignore file worked without any issues.

Cheers,
Parag




On Sun, Sep 12, 2010 at 3:37 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Hi Parag,
>
> Parag Kalra writes:
>> 1. Is there a way I can make Git not track a particular folder in my
>> working code base directory. For example, I have a tmp folder in my
>> local code base and I don't want Git to track whats going on inside
>> that directory.
>
> Yes. See gitignore (5).
>
>> 2. Accidently I have added this folder, committed and pushed it to
>> origin master. Is there a way I can remove this tmp folder from git
>> revision history and at the same time keeping it intact in my local
>> code base directory.
>
> Yes. Simply `rm --cached` the folder, and amemd your previous commit
> using `commit --amend`, and perform a non-ff push using the `+`
> syntax. For example, to perform a non-ff push to remote branch `foo`
> whose local name is `foo`, invoke `push +foo:foo`. Note that other
> users who have already pulled the bad commit will have to forget about
> it explicitly too.
>
> If the folder tracking information is a few revision deep, consider
> using `rebase -i` to manually overwrite those commits to exclude that
> folder. If the folder was too many revisions earlier, use a
> `filter-branch` index filter to make Git completely forget that
> folder.
>
> -- Ram
>
