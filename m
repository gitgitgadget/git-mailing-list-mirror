From: Hwasung Mars Lee <hwasungmars@hotmail.com>
Subject: RE: libcrypto error
Date: Sat, 29 Dec 2007 16:20:19 +0000
Message-ID: <BLU129-W216CEAD0EC39E5A556F17CB3560@phx.gbl>
References: <BLU129-W145F3EAD72285347BFF215B3560@phx.gbl>
 <BAYC1-PASMTP13D19EDB82ED1407AC5886AE560@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: <git@vger.kernel.org>
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Sat Dec 29 17:31:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8eaT-0000FK-UM
	for gcvg-git-2@gmane.org; Sat, 29 Dec 2007 17:31:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753975AbXL2QaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2007 11:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754173AbXL2QaR
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Dec 2007 11:30:17 -0500
Received: from blu139-omc2-s3.blu139.hotmail.com ([65.55.175.173]:58833 "EHLO
	blu139-omc2-s3.blu139.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753932AbXL2QaQ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2007 11:30:16 -0500
X-Greylist: delayed 595 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Dec 2007 11:30:15 EST
Received: from BLU129-W21 ([65.55.162.184]) by blu139-omc2-s3.blu139.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 29 Dec 2007 08:20:19 -0800
X-Originating-IP: [163.1.148.87]
Importance: Normal
In-Reply-To: <BAYC1-PASMTP13D19EDB82ED1407AC5886AE560@CEZ.ICE>
X-OriginalArrivalTime: 29 Dec 2007 16:20:19.0223 (UTC) FILETIME=[B436AA70:01C84A36]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69319>


Actually, it appears that the server has libcrypto.so.0.9.8 installed. ldd $(which git-upload-pack) gives:

linux-gate.so.1 =>  (0xffffe000)
libz.so.1 => /usr/lib/libz.so.1 (0xb7f39000)
libcrypto.so.0.9.8 => /usr/lib/i686/cmov/libcrypto.so.0.9.8 (0xb7dff000)        
libc.so.6 => /lib/tls/i686/cmov/libc.so.6 (0xb7ccd000)
libdl.so.2 => /lib/tls/i686/cmov/libdl.so.2 (0xb7cc9000)
/lib/ld-linux.so.2 (0xb7f67000)

I don't have a clue where something went wrong. Actually, it used to work but doesn't any more.

Mars


----------------------------------------
> Date: Sat, 29 Dec 2007 10:50:22 -0500
> From: seanlkml@sympatico.ca
> To: hwasungmars@hotmail.com
> CC: git@vger.kernel.org
> Subject: Re: libcrypto error
> 
> On Sat, 29 Dec 2007 15:05:58 +0000
> Hwasung Mars Lee  wrote:
> 
>> I have some problems when using git remotely. When I git clone from Ubuntu or Mac to Debian, I get the following message:
>> 
>> git-upload-pack: error while loading shared libraries: libcrypto.so.0.9.8: cannot open shared object file: No such file or directory
>> fatal: unexpected EOF
>> fetch-pack from 'maths:~/Desktop/TeX' failed.
>> 
> 
> Mars,
> 
> It appears the machine from which you're trying to clone is missing the proper libcrypto
> library.  You'll need to ensure it is installed using whatever package manager is
> appropriate for your Linux distribution.
> 
> The following command will show you which libraries git-upload-pack is using (and missing):
> 
>    ldd $(which git-upload-pack)
> 
> That will likely report that the libcrypto library can't be found and needs to be
> installed.
> 
> Good luck,
> Sean

_________________________________________________________________
Telly addicts unite!
http://www.searchgamesbox.com/tvtown.shtml