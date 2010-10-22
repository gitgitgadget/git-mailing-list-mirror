From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [long] worktree setup cases
Date: Fri, 22 Oct 2010 12:36:17 +0700
Message-ID: <AANLkTi=7R6nfdXQ10hme87xPPVnomZu+m9A_SZ8j8dpk@mail.gmail.com>
References: <20101020085859.GA13135@do> <20101020190709.GB10537@burratino>
 <AANLkTimzfxJFz2FRVCJ7b4+icXMxpQGNo0WGm_BXzXNy@mail.gmail.com>
 <20101021033042.GA1891@burratino> <AANLkTikwApJ2EtJNiOZPHVrz6seJNP-zEqzH_b62ksLf@mail.gmail.com>
 <20101021185132.GB28700@nibiru.local> <AANLkTinS0co8TMmyRCQ4Xe9+pDR-uUn20WNQwYJEAQea@mail.gmail.com>
 <20101022050011.GA27179@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: weigelt@metux.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 22 07:36:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9AJ2-0005C2-3d
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 07:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105Ab0JVFgj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 01:36:39 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47307 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738Ab0JVFgi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 01:36:38 -0400
Received: by wwe15 with SMTP id 15so413196wwe.1
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 22:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type;
        bh=15Cdn2P/TM9qMpCAJRlBjg7ZmIs/AMAVS+75Ruf/TsM=;
        b=F/XYHF6oDP0cktpBFEhdrjTn+m5iFSPgcBt1GP7CDBiEZVsM+Z9WT+ppcCWFx3Sr42
         AQq0yAuBe2r8OHCfR9cjKpPlzdAlwS6MroQOzhdl0DIAdzgMObWalNrg6FoBu9VxwzYs
         SqQnkXLE5EMcfZxiPM9/Kzp7cj8qap+KtxXp4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        b=UZMOGT8tQ2VF899t8Rv5mKwO7Jf6i9X0zxlkohLce6Ok0lbFb4RrOqE9BP1eN5Etew
         nXk97b4p3QoiqoUauLfM7MA/h3ucksU5bWWVjlSxsUf6m2XSZ67Gf5odn9CkawxcR/1w
         h+EKwxg3UuN3i954HndaKJOlKHGIzFgr420dI=
Received: by 10.216.143.163 with SMTP id l35mr1478885wej.68.1287725797543;
 Thu, 21 Oct 2010 22:36:37 -0700 (PDT)
Received: by 10.216.171.207 with HTTP; Thu, 21 Oct 2010 22:36:17 -0700 (PDT)
In-Reply-To: <20101022050011.GA27179@nibiru.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159647>

On Fri, Oct 22, 2010 at 12:00 PM, Enrico Weigelt <weigelt@metux.de> wrote:
> * Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>> On Fri, Oct 22, 2010 at 1:51 AM, Enrico Weigelt <weigelt@metux.de> wrote:
>> >> Also the "relative to $GIT_DIR" may be confusing. If $GIT_DIR points
>> >> to a file that points to a true repo, then to which one it is
>> >> relative?
>> >
>> > Despite the fact that I doubt the usefulness of an .git file at
>> > all, it IMHO should be interpreted as an kind of userland symlink.
>>
>> I do find .git file useful. I put my worktree in a server where it can
>> be wiped out completely. So I don't want to put my .git there. .git
>> file can be used this case so I don't have to set
>> GIT_DIR/GIT_WORK_TREE every time and my .git is safe elsewhere.
>
> Why not using a symlink here ?

Paranoia. A fault in Makefile's clean rule may make deletion follow
symlinks. Also symlinks are not available everywhere.
-- 
Duy
