From: Junio C Hamano <junkio@cox.net>
Subject: Re: git rebase: unexpected conflict
Date: Wed, 07 Feb 2007 11:32:32 -0800
Message-ID: <7vr6t17ohb.fsf@assigned-by-dhcp.cox.net>
References: <20070204190519.GB29029@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
X-From: git-owner@vger.kernel.org Wed Feb 07 20:32:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEsX0-0001Iz-Ga
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 20:32:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161086AbXBGTcf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 7 Feb 2007 14:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422704AbXBGTcf
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 14:32:35 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:62884 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161086AbXBGTce convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Feb 2007 14:32:34 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070207193233.KMWB1349.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Wed, 7 Feb 2007 14:32:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id LjYZ1W00E1kojtg0000000; Wed, 07 Feb 2007 14:32:33 -0500
In-Reply-To: <20070204190519.GB29029@mellanox.co.il> (Michael S. Tsirkin's
	message of "Sun, 4 Feb 2007 21:05:19 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38954>

"Michael S. Tsirkin" <mst@mellanox.co.il> writes:

> When you have resolved this problem run "git rebase --continue".
> If you would prefer to skip this patch, instead run "git rebase --ski=
p".
> To restore the original branch and stop rebasing run "git rebase --ab=
ort".
> --------------------------
>
> Sure enough, there are conflicts in drivers/mtd/nand/Kconfig:
>
> <<<<<<< HEAD:drivers/mtd/nand/Kconfig
> config MTD_NAND_CAFE
>        tristate "NAND support for OLPC CAF=C3=89 chip"
>        depends on PCI
>        help
>          Use NAND flash attached to the CAF=C3=89 chip designed for t=
he $100
>          laptop.
> =3D=3D=3D=3D=3D=3D=3D
> config MTD_NAND_AT91
>         bool "Support for NAND Flash / SmartMedia on AT91"
>         depends on MTD_NAND && ARCH_AT91
>         help
>           Enables support for NAND Flash / Smart Media Card interface
>           on Atmel AT91 processors.
>>>>>>>> [MTD] NAND: AT91 NAND driver:drivers/mtd/nand/Kconfig
>
> But I don't really understand where do the conflicts come from:
> The patch I skipped (9b3bfe5696aa417d38ce903eb345a03d65743dd2)
> only touched the file drivers/infiniband/core/addr.c,
> so why can't rebase replay all of the changes?

That is because David Woodhouse has an evil merge at
c45aa055c32b488fc3fd73c760df372b09acf69a.

Running "git show" on that commit would tell you the story.
