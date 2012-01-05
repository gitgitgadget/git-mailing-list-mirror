From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: checkout on an empty directory fails
Date: Thu, 05 Jan 2012 14:59:50 +0100
Message-ID: <4F05ACD6.6040603@ira.uka.de>
References: <4F0576D9.4030207@gmx.de> <CACsJy8A42n4t+WqGaTx7vDQ3jP_YkD1bB0WL9amrrg1B4eOx7w@mail.gmail.com> <4F0599E0.7090902@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?UmVuw6kgRG/Dnw==?= <doss@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 05 14:59:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rinr3-0007MT-Iu
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 14:59:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076Ab2AEN7c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jan 2012 08:59:32 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:56487 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753094Ab2AEN7b (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jan 2012 08:59:31 -0500
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1Rinqn-0004ye-AZ; Thu, 05 Jan 2012 14:59:30 +0100
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1Rinqm-00009G-SM; Thu, 05 Jan 2012 14:59:24 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <4F0599E0.7090902@gmx.de>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1325771970.438620000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187977>

On 05.01.2012 13:38, Ren=C3=A9 Do=C3=9F wrote:
> git status says not special informations.

  versus

> red@linux-nrd1:~/iso/a> git status
> # On branch master
> # Changed but not updated:
> # (use "git add/rm <file>..." to update what will be committed)
> # (use "git checkout -- <file>..." to discard changes in working dire=
ctory)
> #
> # deleted: SP601_RevC_annotated_master_ucf_8-28-09.ucf
> # deleted: rtl/ether_speed.vhd
> # deleted: rtl/ether_top.vhd
> # deleted: rtl/ether_tx.vhd
> # deleted: rtl/takt.vhd
> # deleted: sim/makefile
> # deleted: sim/tb_ether_top.vhd
> #

This *is* special information: It tells you that master has those 7=20
files but your working directory has none of them (i.e. it is as if you=
=20
had deleted them from your working directory).

"git checkout <branch>" switches between branches, *but* leaves changes=
=20
you made (files you edited, added or deleted) intact! This is so you ca=
n=20
switch branches before commiting if you suddenly realize you are in the=
=20
wrong branch.

"git checkout -- <paths...>" or in your case "git checkout -- ." is=20
different, it really overwrites the files in your working dir with the=20
versions stored somewhere else, by default from the index.

 > What means the point in checkout?

"." is simply your current directory
