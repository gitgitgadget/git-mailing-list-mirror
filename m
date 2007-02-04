From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Navigating remote branches in qgit
Date: Sun, 4 Feb 2007 12:00:11 +0100
Message-ID: <e5bfff550702040300x60bb1dfdxd312dc214bc49014@mail.gmail.com>
References: <1170574889.21644.38.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Pavel Roskin" <proski@gnu.org>
X-From: git-owner@vger.kernel.org Sun Feb 04 12:00:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDf6W-0002TY-9f
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 12:00:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752291AbXBDLAN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 06:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752295AbXBDLAN
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 06:00:13 -0500
Received: from nz-out-0506.google.com ([64.233.162.229]:17483 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752291AbXBDLAM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 06:00:12 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1337373nze
        for <git@vger.kernel.org>; Sun, 04 Feb 2007 03:00:11 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oJZbzz4TtBzLFoYyDaxcqvuW977Uufy2OP6ZIz1FcMyfULbnCizKr1TGiOsT5158tX7T3W8B2bHLU8p2qYVKDBaZmiF4QXICFnJ12IxOctBiOnGYVt1/f6DM0cJb7Td/JWCdHOTATBedQPzHmVaiqiBWF4lgj6KuGVom39P5hyw=
Received: by 10.114.133.1 with SMTP id g1mr494550wad.1170586811041;
        Sun, 04 Feb 2007 03:00:11 -0800 (PST)
Received: by 10.114.61.6 with HTTP; Sun, 4 Feb 2007 03:00:11 -0800 (PST)
In-Reply-To: <1170574889.21644.38.camel@dv>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38686>

On 2/4/07, Pavel Roskin <proski@gnu.org> wrote:
> Hello, Marco!
>
> While at that, we should think how to show refs in a more compact manner
> in the revision list.  I think "refs/" can be dropped in any case, since
> qgit only scans under refs.  Any rectangle implies "refs/" already.
> That's what gitk does.
>

After the posted two patches "refs/" is shown only in StGIT bases. Currently
qgit uses 'git show-ref -d' to retrieve ref list and "ref/" prefix is
already in git-show-ref output,
so as a general rule I would try to avoid 'massaging' git output as
much as is possible to have more chances thing do not break after a
git behaviour change.

It is difficult now to say it's (and will be) true that refs are only
under "refs/". Perhaps in the future someone came up with an idea to
use "refs_of_some_kind/" directory and this would break stuff.

So last line is: if git-show-ref prints this info, perhaps it's better to keep.

  Marco
