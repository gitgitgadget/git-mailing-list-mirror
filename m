From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: 'git pull' fails with 'not uptodate' message despite 'git reset 
	--hard'
Date: Tue, 28 Jul 2009 20:19:54 -0400
Message-ID: <32541b130907281719y57862c25w524f5bbf1df11c40@mail.gmail.com>
References: <20090728230842.GE22281@clouds>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jody McIntyre <scjody@sun.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 02:20:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVwuD-00083H-7J
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 02:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753719AbZG2AUP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Jul 2009 20:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753553AbZG2AUP
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 20:20:15 -0400
Received: from mail-gx0-f213.google.com ([209.85.217.213]:49220 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528AbZG2AUO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jul 2009 20:20:14 -0400
Received: by gxk9 with SMTP id 9so734157gxk.13
        for <git@vger.kernel.org>; Tue, 28 Jul 2009 17:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=m1o4itAnREsOMKT8lWLunIGVj8BG46jqDqJHQxHjyHs=;
        b=fGr9cZDTkHQIZo8+3b8UnWWBrZ5/uoSK1x++ymah/1dbCaAw2UMHalkvMulKIqsHxj
         X6JPdhHfnVc6ZrA/A2YwKftSe8rbZsGvPzd6s6USAgyh4Zq68bpUL0rBK424Acngy6nh
         gq4jP/nWnByD0txKNKnhw62OHc0I/gzD7DF+o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Z0+vXSpCFAjO2jb3eMmPHNuzQELsn0n6i0YSYmYF3OQRUPFMXp6Lw3PLkMB3N9DCwc
         JcE3EZPrxghnrZTMXIsJ8hhONaCQhsFZJVdGiEtnaqv5a+968JngRJDGOzfHhkTwnLJ6
         5Kgpik5jCujoGc1KdLZek908RkqeYfo4clDyc=
Received: by 10.151.101.3 with SMTP id d3mr347042ybm.269.1248826814281; Tue, 
	28 Jul 2009 17:20:14 -0700 (PDT)
In-Reply-To: <20090728230842.GE22281@clouds>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124291>

On Tue, Jul 28, 2009 at 7:08 PM, Jody McIntyre<scjody@sun.com> wrote:
> I am attempting to update my kernel tree but getting a 'not uptodate'=
 error:
>
> $ git fetch origin
> [...]
> $ git pull origin tags/v2.6.31-rc4
> From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
> =A0* tag =A0 =A0 =A0 =A0 =A0 =A0 =A0 v2.6.31-rc4 -> FETCH_HEAD
> Updating 6847e15..4be3bd7
> error: Entry 'CREDITS' not uptodate. Cannot merge.
[...]
> I use quilt with this tree but no quilt patches are currently applied=
 and it
> should be clean. =A0It hasn't even been built (I rsync to another mac=
hine for
> that.)

I've run into this problem when I rsync a tree from one system to
another.  The inodes will be different, so merge will think files in
the work tree have changed, but then diff (of course) won't see
anything because it looks at the actual file contents, which are
identical.

Usually a 'git status' will fix it.  In any case, if it doesn't,
please send the output of 'git status' :)

I believe this cache out-of-dateness issue was fixed in a recent versio=
n of git.

Have fun,

Avery
