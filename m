From: "Cameron McBride" <cameron.mcbride@gmail.com>
Subject: Re: git-cvsserver wart?
Date: Thu, 25 May 2006 23:57:56 -0400
Message-ID: <dcedf5e20605252057n28e77bbdt8094498ce8d496a0@mail.gmail.com>
References: <dcedf5e20605250942g6a7417dfh5f2f26df29842def@mail.gmail.com>
	 <46a038f90605251419kd45fbj419565eabdd63182@mail.gmail.com>
	 <dcedf5e20605252011v6738dc9dg3d4801144d3e9898@mail.gmail.com>
	 <46a038f90605252023v5ff3fd65l9a991b3bbfa0a024@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 26 05:58:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjTSe-0004ol-Ed
	for gcvg-git@gmane.org; Fri, 26 May 2006 05:58:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbWEZD55 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 23:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030299AbWEZD55
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 23:57:57 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:34114 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030258AbWEZD54 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 23:57:56 -0400
Received: by wr-out-0506.google.com with SMTP id i34so1962433wra
        for <git@vger.kernel.org>; Thu, 25 May 2006 20:57:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=txYf4oY2q3cbCBiUKYnS8eaZ9iNcgaa7xcEkbb6D8/HmtxlBn3K8x+b0MzUMDcC6rTlNP6uE6OPyXMp01OcWXL/9ykURZRKO1Ev1iROKok6PXkyuVhCCGYxYvg/AmXniZEeCM56HdNGHisg3PKijKx8mNKwiTefa+e9GA1pPbCM=
Received: by 10.64.151.15 with SMTP id y15mr75599qbd;
        Thu, 25 May 2006 20:57:56 -0700 (PDT)
Received: by 10.65.53.4 with HTTP; Thu, 25 May 2006 20:57:56 -0700 (PDT)
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90605252023v5ff3fd65l9a991b3bbfa0a024@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20790>

On 5/25/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> On 5/26/06, Cameron McBride <cameron.mcbride@gmail.com> wrote:
> Ok. You might want to retain that latest, it has some further fixes ;-)

sounds good.

> Yes, I was guessing as much. I am still curious about what parameters
> (and in what order) cvs 1.11.7 sends...

sure!  now that I know CVS_CLIENT_LOG exists ... ;)

It points in basically the same direction, which is to say the newer
client passes an 'Argument -- ' which is what git-cvsserver seems to
be choking on.

The 'in' versions of the two
noup: cvs 1.11.1p1 that failed plane cvs update
work: cvs 1.11.17 that worked

--- cvs_noup.log.in     2006-05-25 23:44:21.000000000 -0400
+++ cvs_work.log.in     2006-05-25 23:48:38.000000000 -0400
@@ -1,6 +1,7 @@
 Root /export/home/cameron/ws/git_test/ntropy.git
-Valid-responses ok error Valid-requests Checked-in New-entry Checksum
Copy-file Updated Created Update-existing Merged Patched Rcs-diff Mode
Mod-time Removed Remove-entry Set-static-directory
Clear-static-directory Set-sticky Clear-sticky Template
Set-checkin-prog Set-update-prog Notified Module-expansion
Wrapper-rcsOption M Mbinary E F MT
+Valid-responses ok error Valid-requests Checked-in New-entry Checksum
Copy-file Updated Created Update-existing Merged Patched Rcs-diff Mode
Mod-time Removed Remove-entry Set-static-directory
Clear-static-directory Set-sticky Clear-sticky Template Notified
Module-expansion Wrapper-rcsOption M Mbinary E F MT
 valid-requests
+Argument --
 Directory .
 /export/home/cameron/ws/git_test/ntropy.git/master
 Entry /.gitignore/1.1///

Thanks for your help!

Cameron
