From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH] git-clean: Display more accurate delete messages
Date: Mon, 10 Dec 2012 10:16:23 -0800
Message-ID: <aecaf65e-2b7f-4309-a7b5-622c7779de17@DB3EHSMHS018.ehs.local>
References: <1354788938-26804-1-git-send-email-zoltan.klinger@gmail.com>
 <7v8v9bjd44.fsf@alter.siamese.dyndns.org>
 <7d290bdc-8654-4526-ba73-89408fa99a16@DB3EHSMHS002.ehs.local>
 <CAKJhZwROXsTa4wu-C9rhfGysetL+cZRDECyFUn5VTb833pWzMQ@mail.gmail.com>
 <7v38zecrqc.fsf@alter.siamese.dyndns.org>
 <5b69a9f1-0860-41da-914c-d55a17e54092@TX2EHSMHS026.ehs.local>
 <7va9tlbx8v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Soren Brinkmann <soren.brinkmann@xilinx.com>,
	Zoltan Klinger <zoltan.klinger@gmail.com>,
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 19:16:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ti7uQ-00068P-O6
	for gcvg-git-2@plane.gmane.org; Mon, 10 Dec 2012 19:16:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549Ab2LJSQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2012 13:16:38 -0500
Received: from db3ehsobe002.messaging.microsoft.com ([213.199.154.140]:34247
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751487Ab2LJSQh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Dec 2012 13:16:37 -0500
Received: from mail25-db3-R.bigfish.com (10.3.81.242) by
 DB3EHSOBE003.bigfish.com (10.3.84.23) with Microsoft SMTP Server id
 14.1.225.23; Mon, 10 Dec 2012 18:16:36 +0000
Received: from mail25-db3 (localhost [127.0.0.1])	by mail25-db3-R.bigfish.com
 (Postfix) with ESMTP id 613114C0183;	Mon, 10 Dec 2012 18:16:36 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:149.199.60.83;KIP:(null);UIP:(null);IPV:NLI;H:xsj-gw1;RD:unknown-60-83.xilinx.com;EFVD:NLI
X-SpamScore: -1
X-BigFish: VPS-1(zz98dI1432Izz1de0h1202h1e76h1d1ah1d2ahzz8275bhz2fh95h668h839h93fhd24hf0ah119dh1288h12a5h12a9h12bdh137ah13b6h1441h14ddh1504h1537h153bh162dh1631h1758h906i1155h)
Received-SPF: pass (mail25-db3: domain of xilinx.com designates 149.199.60.83 as permitted sender) client-ip=149.199.60.83; envelope-from=soren.brinkmann@xilinx.com; helo=xsj-gw1 ;helo=xsj-gw1 ;
Received: from mail25-db3 (localhost.localdomain [127.0.0.1]) by mail25-db3
 (MessageSwitch) id 1355163394436097_15980; Mon, 10 Dec 2012 18:16:34 +0000
 (UTC)
Received: from DB3EHSMHS018.bigfish.com (unknown [10.3.81.237])	by
 mail25-db3.bigfish.com (Postfix) with ESMTP id 6655A260070;	Mon, 10 Dec 2012
 18:16:34 +0000 (UTC)
Received: from xsj-gw1 (149.199.60.83) by DB3EHSMHS018.bigfish.com
 (10.3.87.118) with Microsoft SMTP Server id 14.1.225.23; Mon, 10 Dec 2012
 18:16:33 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]
 helo=xsj-smtp1.xilinx.com)	by xsj-gw1 with esmtp (Exim 4.63)	(envelope-from
 <soren.brinkmann@xilinx.com>)	id 1Ti7u5-0006MQ-15; Mon, 10 Dec 2012 10:16:33
 -0800
Content-Disposition: inline
In-Reply-To: <7va9tlbx8v.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-RCIS-Action: ALLOW
X-OriginatorOrg: xilinx.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211266>

On Mon, Dec 10, 2012 at 10:03:28AM -0800, Junio C Hamano wrote:
> Soren Brinkmann <soren.brinkmann@xilinx.com> writes:
> 
> >> > Use git clean --force --force to delete all untracked git repositories
> >> 
> >> But I am not sure if this is ever sane.  Especially the one that
> >> removes an embedded repository is suspicious.  "git clean" should
> >> not ever touch it with or without --superforce or any other command.
> > As I mentioned in my email where I reported this incorrect git clean output, I
> > have a use case where I want git clean to remove embedded repositories.
> > Whether it is a sane one is probably a different discussion.
> 
> Why is it a different discussion?  If something is not sane, the
> tool shouldn't encourage users to do such an insane thing.
> 
Well, ok. So I have a repository which essentially consists of a bunch of
scripts which then pull sources via git to build root filesystems, busybox,
kernel etc.
So I have the master repository I'm actually interested in. And then all the
other projects which are pulled in to build stuff from.
looking somehow like this:
	top.git
	 |-src
	 |  |-proj1.git
	 |  |-proj2.git
	 |  |-projn.git
	 |-build
	     |-proj1
	     |-proj2
	     ...

Since the scripts are not perfect I usually used 'git clean -xdf' to wipe
everything and build from scratch. And I had to experience that the git clean
behavior somehow changed recently and the 'projn.git' directories were no longer
removed anymore, despite git indicating otherwise in its output.

So, I think having 'git clean -ff' removing embedded git repos is okay. But either
way, the output of git clean should match what it is doing. And at least tell me
if it didn't remove certain dirs or files.

	Soren
