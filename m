From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Questions about branches in git
Date: Thu, 28 Jan 2010 14:03:31 -0600
Message-ID: <b4087cc51001281203q1f467480sdf848c9d3ced323b@mail.gmail.com>
References: <69b754db1001281044y39e52f77hcc8f83144776c78f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mike Linck <mgl@absolute-performance.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 21:04:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Naaav-0000EH-Ml
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 21:04:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940Ab0A1UDx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jan 2010 15:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752674Ab0A1UDx
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 15:03:53 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:43711 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535Ab0A1UDw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jan 2010 15:03:52 -0500
Received: by ewy19 with SMTP id 19so1151420ewy.21
        for <git@vger.kernel.org>; Thu, 28 Jan 2010 12:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=mtO4WEyBehXDM/p/IcQdUwoU3MFCATB242j5tdWg9sg=;
        b=Cw80X4ltkgHDi+KkRQDmkNew3t+GigJYb+TaRyIX+ptxifdIH22eNSDctAO+HyuqFY
         4WMHo8jQft9kSohGXm8BDyiN4EFJIQoufSHFijZ3MlWYHj0qu+H1ARwdtjCDThWb8Keq
         jidhJ7RmJSNeIUaVXKlgSGN+lcLM83qukGT1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=d56jgmhzjW96XudyaGE4UbybC6SKJiz09R5yfL4ZePOptsxHIKSjp/3UJ8QxBBGEP7
         aVaI0echFgBqOvDDagCn0LRvMVkvyuFK9vYI6qRGggNdKL0P59/zPQKO0mWRWLY2zhwA
         xIOLj5zHU69ho3Wa+QuYSLni8NnVQGcGEKdXM=
Received: by 10.213.38.4 with SMTP id z4mr6029359ebd.54.1264709031168; Thu, 28 
	Jan 2010 12:03:51 -0800 (PST)
In-Reply-To: <69b754db1001281044y39e52f77hcc8f83144776c78f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138265>

On Thu, Jan 28, 2010 at 12:44 PM, Mike Linck
<mgl@absolute-performance.com> wrote:
> ...
> It seems that after a topic or bug branch is merged back into its
> parent, especially if it was fast forwarded, it becomes hard to
> determine what changes were made in it, to resolve the problem that i=
t
> was created to address.
> ...
> I understand that there are mechanism kind of available to address
> this problem. =A0If we (all developers in my company) remember always=
 to
> rebase -i before they merge their topic branches back in, then it
> could be squashed making it easier to identify and cherry pick onto
> other branches...

=46or now, you should probably rely on graphical tools like gitk in
order to visualize the various branches. There's also `git log
--graph'. You could also just keep your branches around for reference
and use `git merge-base' as necessary.

However, I've been thinking for a while that it would be useful to
have =FCbercommits (they don't exist) that are treated like single
commits but that actually encapsulate multiple continguous commits.

=46or your case, you could tell git to make merges by creating such
=FCbercommits, which would then be easily identified, referenced, and
manipulated for your backporting purposes; such =FCbercommits would
encapsulate the relevant commits.

These =FCbercommits would also allow developers to make a string of
commits that by themselves break things but together formulate a
complete solution; because the =FCbercommits encapsulate the breakage,
bisection would still be simple (no fear of dealing with broken
commits), but the small manageable commits would still be available
for references and manipulation.

Perhaps trees could be reappropriated for the implementation of =FCberc=
ommits.

Sincerely,
Michael Witten
