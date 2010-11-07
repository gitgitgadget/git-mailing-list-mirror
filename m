From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Sparse checkouts
Date: Sun, 7 Nov 2010 13:39:11 +0700
Message-ID: <AANLkTi=7jeeEw58SQOWmWUx54epWinTuTJE_h=bxcYvO@mail.gmail.com>
References: <loom.20101107T030122-536@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Uri Moszkowicz <uri@4refs.com>
X-From: git-owner@vger.kernel.org Sun Nov 07 07:41:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEywD-0000pE-MK
	for gcvg-git-2@lo.gmane.org; Sun, 07 Nov 2010 07:41:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829Ab0KGGjd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Nov 2010 01:39:33 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61474 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764Ab0KGGjc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Nov 2010 01:39:32 -0500
Received: by wyb36 with SMTP id 36so2421187wyb.19
        for <git@vger.kernel.org>; Sat, 06 Nov 2010 23:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=BfP7p1lCmzeQJNXI6LZ4D14yovB7b/xdsodzBB1qujk=;
        b=aq/EuTwRex1k0Y2Xxo5elPKVP0ns+zl/6QSkuEh1/kFmTxJr1kgvBJ0Pr6MdBv5Kbv
         p6lbTNubqVOdsGr3y1od7QNxm+ovddopoUaPbN0OmFbF+km0R/NGwLDW0IbYfgYNdIH2
         wt2g7lo/I1MJEaXHTIAkeK+kLR7906kZK5afE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=BPME7kMLBVeJtImzy9seZnJZBfGPtqJMPwaYHqrXMYcOgQ8njK1V1KvpSxoyh+mdT3
         IWJlcOQkOwcnBjvlCpaKfDWkWOBKw0i+C4zykDqlq0fnYpY9BG3htBBCS9E5Uuz6ahWe
         umTHWZXrJVCP5eNCm8rnXZyFgR/nbP47GYS/o=
Received: by 10.216.47.19 with SMTP id s19mr2951411web.56.1289111971304; Sat,
 06 Nov 2010 23:39:31 -0700 (PDT)
Received: by 10.216.172.199 with HTTP; Sat, 6 Nov 2010 23:39:11 -0700 (PDT)
In-Reply-To: <loom.20101107T030122-536@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160866>

On Sun, Nov 7, 2010 at 9:04 AM, Uri Moszkowicz <uri@4refs.com> wrote:
> Hi,
> I'm working with a repository with a very large number of files and G=
it is
> appealing because it officially supports sparse checkouts unlike the =
other
> DVCS tools. However, all of the usage examples that I've come across =
have
> you checkout the full repository and then prune the undesired files a=
s such:
>
> =C2=A0git clone <dir>
> =C2=A0git config core.sparsecheckout true
> =C2=A0echo "<dir>/" > .git/info/sparse-checkout
> =C2=A0git read-tree -m -u HEAD

You can replace the last command with "git checkout" (no additional arg=
ument)

> I tried adding "-n" to the clone command but then none of the missing
> directories are checked out by read-tree.

Hmm.. it works fine here. Can you post the exact sequence of commands y=
ou used?

> I can manually check them out
> and everything seems to work fine but I can also manually check out a=
 bunch
> of other directories and read-tree, reset, etc all seem to ignore the=
 extra
> directory even though they aren't specified in the sparse-checkout fi=
le

Sparse checkout mode does not stop you from checking out non-sparse
files. But all those files are not "seen" by git because of sparse
checkout mode. They are ignored most of the time, except when git is
going to overwrite them.

> Is this use mode just not well supported by git yet or am I missing s=
omething?

Sparse checkout support is pretty basic. Any suggestions are welcome.
--=20
Duy
