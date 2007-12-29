From: Sean <seanlkml@sympatico.ca>
Subject: Re: libcrypto error
Date: Sat, 29 Dec 2007 10:50:22 -0500
Message-ID: <BAYC1-PASMTP13D19EDB82ED1407AC5886AE560@CEZ.ICE>
References: <BLU129-W145F3EAD72285347BFF215B3560@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Hwasung Mars Lee <hwasungmars@hotmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 29 16:50:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8dxf-000559-VQ
	for gcvg-git-2@gmane.org; Sat, 29 Dec 2007 16:50:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753801AbXL2Pu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2007 10:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753810AbXL2Pu3
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Dec 2007 10:50:29 -0500
Received: from bay0-omc2-s8.bay0.hotmail.com ([65.54.246.144]:52082 "EHLO
	bay0-omc2-s8.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752226AbXL2Pu2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Dec 2007 10:50:28 -0500
Received: from BAYC1-PASMTP13 ([65.54.191.186]) by bay0-omc2-s8.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 29 Dec 2007 07:50:25 -0800
X-Originating-IP: [74.15.76.104]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([74.15.76.104]) by BAYC1-PASMTP13.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Sat, 29 Dec 2007 07:50:24 -0800
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with smtp (Exim 4.43)
	id 1J8dx2-0003gb-0b; Sat, 29 Dec 2007 10:50:16 -0500
In-Reply-To: <BLU129-W145F3EAD72285347BFF215B3560@phx.gbl>
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.1; i686-pc-linux-gnu)
X-OriginalArrivalTime: 29 Dec 2007 15:50:24.0310 (UTC) FILETIME=[865CAD60:01C84A32]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69316>

On Sat, 29 Dec 2007 15:05:58 +0000
Hwasung Mars Lee <hwasungmars@hotmail.com> wrote:

> I have some problems when using git remotely. When I git clone from Ubuntu or Mac to Debian, I get the following message:
> 
> git-upload-pack: error while loading shared libraries: libcrypto.so.0.9.8: cannot open shared object file: No such file or directory
> fatal: unexpected EOF
> fetch-pack from 'maths:~/Desktop/TeX' failed.
> 

Mars,

It appears the machine from which you're trying to clone is missing the proper libcrypto
library.  You'll need to ensure it is installed using whatever package manager is
appropriate for your Linux distribution.

The following command will show you which libraries git-upload-pack is using (and missing):

   ldd $(which git-upload-pack)

That will likely report that the libcrypto library can't be found and needs to be
installed.

Good luck,
Sean
