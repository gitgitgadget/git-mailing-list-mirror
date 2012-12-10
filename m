From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH] git-clean: Display more accurate delete messages
Date: Mon, 10 Dec 2012 09:04:33 -0800
Message-ID: <5e54ef3e-b872-4aa5-9b10-ca05323e73b5@CH1EHSMHS042.ehs.local>
References: <1354788938-26804-1-git-send-email-zoltan.klinger@gmail.com>
 <7v8v9bjd44.fsf@alter.siamese.dyndns.org>
 <7d290bdc-8654-4526-ba73-89408fa99a16@DB3EHSMHS002.ehs.local>
 <CAKJhZwROXsTa4wu-C9rhfGysetL+cZRDECyFUn5VTb833pWzMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Soren Brinkmann <soren.brinkmann@xilinx.com>,
	Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Zoltan Klinger <zoltan.klinger@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 18:05:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ti6mo-00041C-Uq
	for gcvg-git-2@plane.gmane.org; Mon, 10 Dec 2012 18:04:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624Ab2LJREm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2012 12:04:42 -0500
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:48312
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751528Ab2LJREl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Dec 2012 12:04:41 -0500
Received: from mail168-ch1-R.bigfish.com (10.43.68.227) by
 CH1EHSOBE009.bigfish.com (10.43.70.59) with Microsoft SMTP Server id
 14.1.225.23; Mon, 10 Dec 2012 17:04:40 +0000
Received: from mail168-ch1 (localhost [127.0.0.1])	by
 mail168-ch1-R.bigfish.com (Postfix) with ESMTP id 0C84F320286;	Mon, 10 Dec
 2012 17:04:40 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:149.199.60.83;KIP:(null);UIP:(null);IPV:NLI;H:xsj-gw1;RD:unknown-60-83.xilinx.com;EFVD:NLI
X-SpamScore: -3
X-BigFish: VPS-3(zz98dI1432I4015I1447Izz1de0h1202h1e76h1d1ah1d2ahzzz2fh95h668h839h93fhd24hf0ah119dh1288h12a5h12a9h12bdh137ah13b6h1441h14ddh1504h1537h153bh162dh1631h1758h906i1155h)
Received-SPF: pass (mail168-ch1: domain of xilinx.com designates 149.199.60.83 as permitted sender) client-ip=149.199.60.83; envelope-from=soren.brinkmann@xilinx.com; helo=xsj-gw1 ;helo=xsj-gw1 ;
Received: from mail168-ch1 (localhost.localdomain [127.0.0.1]) by mail168-ch1
 (MessageSwitch) id 135515907976855_14391; Mon, 10 Dec 2012 17:04:39 +0000
 (UTC)
Received: from CH1EHSMHS042.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.254])	by mail168-ch1.bigfish.com (Postfix) with ESMTP id
 06038140066;	Mon, 10 Dec 2012 17:04:39 +0000 (UTC)
Received: from xsj-gw1 (149.199.60.83) by CH1EHSMHS042.bigfish.com
 (10.43.69.251) with Microsoft SMTP Server id 14.1.225.23; Mon, 10 Dec 2012
 17:04:38 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]
 helo=xsj-smtp1.xilinx.com)	by xsj-gw1 with esmtp (Exim 4.63)	(envelope-from
 <soren.brinkmann@xilinx.com>)	id 1Ti6mU-0000Ib-DS; Mon, 10 Dec 2012 09:04:38
 -0800
Content-Disposition: inline
In-Reply-To: <CAKJhZwROXsTa4wu-C9rhfGysetL+cZRDECyFUn5VTb833pWzMQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-RCIS-Action: ALLOW
X-OriginatorOrg: xilinx.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211260>

Hi Zoltan,

On Sun, Dec 09, 2012 at 10:18:19PM +1100, Zoltan Klinger wrote:
> >> Hrm, following your discussion (ellided above), I would have
> >> expected that you would show
> >>
> >>     Removing directory foo/bar
> >>     Removing untracked_file1
> >
> > Also it would be nice to have warnings about undeleted directories since this git
> > clean behavior (or the work around to pass -f twice) is not documented.
> > Without a warning you would probably miss that something was _not_ deleted.
> 
> Thanks for the feedback. I think you're right. Showing 'foo/bar/bar.txt' in
> the list when 'foo/bar/' directory has been successfully deleted is just noise.
> 
> Would like to get some more feedback on the proposed output in case of
>  (1) an untracked subdirectory with multiple files where at least one of them
>      cannot be removed.
>  (2) reporting ignored untracked git subdirectories
> 
> Suppose we have a repo like the one below:
>   test.git/
>     |-- tracked_file
>     |-- untracked_file
>     |-- untracked_foo/
>     |     |-- bar/
>     |     |     |-- bar.txt
>     |     |-- emptydir/
>     |     |-- frotz.git/
>     |     |     |-- frotx.txt
>     |     |-- quux/
>     |           |-- failedquux.txt
>     |           |-- quux.txt
>     |-- untracked_unreadable_dir/
>     |     |-- afile
>     |-- untracked_some.git/
>           |-- some.txt
> 
> $ git clean -fd
> Removing untracked_file
> Removing untracked_foo/bar
> Removing untracked_foo/emptydir
> Removing untracked_foo/quux/quux.txt
> warning: failed to remove untracked_foo/quux/failedquux.txt
> warning: failed to remove remove untracked_unreadable_dir/
> warning: ignoring untracked git repository untracked_foo/frotz.git/
> warning: ignoring untracked git repository untracked_some.git/
> Use git clean --force --force to delete all untracked git repositories
> 
> $ # use forced remove
> $ git clean --force --force -d
> Removing untracked_foo/frotz.git
> Removing untracked_foo/quux/quux.txt
> Removing untracked_some.git/
> warning: failed to remove untracked_foo/quux/failedquux.txt
> warning: failed to remove untracked_unreadable_dir/
> 
> Can you see any issues with the proposed output, wording above? If
> everyone is happy,
> I'm going to prepare patch V2 for it.
Looks good to me.

Thanks,
Soren
