From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: [Q] Tell Git to follow symlinks?
Date: Mon, 25 Feb 2008 05:54:55 +0000
Message-ID: <e1dab3980802242154h721bd8a5x60b7f73d9fc3a2ef@mail.gmail.com>
References: <c6c947f60802240305w40a7af96yc47f90e573384c04@mail.gmail.com>
	 <87zltq2xzn.dlv@maison.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Alexander Gladysh" <agladysh@gmail.com>, git@vger.kernel.org
To: "Remi Vanicat" <vanicat@debian.org>
X-From: git-owner@vger.kernel.org Mon Feb 25 06:56:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTWJj-0001fD-Dz
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 06:55:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbYBYFy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 00:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751647AbYBYFy7
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 00:54:59 -0500
Received: from el-out-1112.google.com ([209.85.162.176]:57570 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040AbYBYFy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 00:54:58 -0500
Received: by el-out-1112.google.com with SMTP id v27so1174186ele.23
        for <git@vger.kernel.org>; Sun, 24 Feb 2008 21:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=IjhoVzehqGnPfqz0R3ENS40+JyNNiYK7GuNGSBhjasU=;
        b=fMzEnYdSaxOgZmVZk6je90rRnWVQxTTds78OuucVxVlmM2q6AfvdRgvXPN45KNIwiVY21EgdlXAjokJM4vjbjbY9W6r0Pca1LYjSvDlP4I3W2WkwOG2h4AnQgo+7IdI60MS6Itj7TsC4MmvG7uFQ/4H64eyyvXSBfieZC3CCk5s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Os4u6nifHA+/aEWWhldxAFR9Swj9OA9eGD3zbVw91VbtE9r1BQySRDOBAxa2UJhVSYheBjkrUompmEVm1xOL5jThzBaGDulDKaebB8FfaaiB430ugt0YjGE0NWZAMKeuIx813UksBPX19uwtRkFKaHDXVnUm5rE3XiauaTthdqE=
Received: by 10.151.9.1 with SMTP id m1mr921018ybi.12.1203918895115;
        Sun, 24 Feb 2008 21:54:55 -0800 (PST)
Received: by 10.150.149.2 with HTTP; Sun, 24 Feb 2008 21:54:55 -0800 (PST)
In-Reply-To: <87zltq2xzn.dlv@maison.homelinux.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74992>

On Sun, Feb 24, 2008 at 3:08 PM, Remi Vanicat <vanicat@debian.org> wrote:
> "Alexander Gladysh" <agladysh@gmail.com> writes:
>
>  > I thought to construct my repo of the number of symlinks to other
>  > places, but apparently Git does not follow any simlinks.
>
>  I use "reverse" symlinks: the files i want to manage are replaced by
>  symlink to the file that is in then git repository:
>
>  my home contain:
>
>  .abbrev_defs -> .myconfig/abbrev_defs
>  .bash_logout -> .myconfig/bash_logout
[...]
>
>  and a .myconfig git repository that manage those file.

For configuration files I tend to actually physically copy them to a
directory under the tree that I'm archiving using git, just because it
feels slightly safer. If something git related goes wrong (probably
due to my input) it can't, eg, stick an old, corrupted version of, eg,
.bashrc in my home directory, which stops terminal login when I next
reboot. (I had something similar happen when I actually had the live
version of my archiving script being put into the archive. When I
checked out a previous tree to look at something, an old buggy
archiving script got checked out and created half a dozen corrupt
commits I had to reset away.) Of course, the odds of anything like
this happening in practice are quite small.

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"while having code so boring anyone can maintain it, use Python." --
attempted insult seen on slashdot
