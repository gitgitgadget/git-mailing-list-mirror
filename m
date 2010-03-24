From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Wed, 24 Mar 2010 10:39:33 +0800
Message-ID: <41f08ee11003231939y390ea4cajdb73d09cf2dd6329@mail.gmail.com>
References: <41f08ee11003202316w2fddc5f4jebda47f325451577@mail.gmail.com>
	 <41f08ee11003212048q1950eb3s95f1caf7ba640874@mail.gmail.com>
	 <7vfx3tvv9y.fsf@alter.siamese.dyndns.org>
	 <41f08ee11003212134s586aa71cs23255d02f38d53d1@mail.gmail.com>
	 <7vhbo8syyf.fsf@alter.siamese.dyndns.org>
	 <41f08ee11003220031p6fda651eycff2641df10864da@mail.gmail.com>
	 <7v7hp4n6qn.fsf@alter.siamese.dyndns.org>
	 <20100322081003.GA26535@progeny.tock>
	 <41f08ee11003222301y569a5972q3c67d10c77abe27a@mail.gmail.com>
	 <20100323185745.GA1382@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, gitzilla@gmail.com,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 24 03:39:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuGVP-00011O-UZ
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 03:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754262Ab0CXCjf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Mar 2010 22:39:35 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:36358 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754208Ab0CXCje convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Mar 2010 22:39:34 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1746941qwh.37
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 19:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lZWlMUgNp1TEafBh38wLlX3O3IO66pWwPx6K+gJsbMU=;
        b=ogM4p7qsOdV+dtZzna/uHC65cuZJZEqwg2AeV86D2ry5J3HOt8jtMo5jKXA9tJLWKb
         3kqsa1uzJjSqbqgYrMnr2qOOs5yLmM1TbVegW85ieo0BcurPYqyVo48Gir0Bh6sfXpyt
         8/oq6rnqRGmbdXeyRVoWmU0F+Hyf5rTVfy7JU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SBfy5W11yjVjiQksIFgGrHualgwiV//GnE16nioJkmmtGoGOaQQ+z1z0oXxTmmPt90
         93443l3MP8SU2T0tYlbvclGINluudeIb2z8bt3l4bhkYTh9+Bw78kBPxlKHf+EeDcdBC
         Kxl3sVLgwsjJTiBkrbdG3Gpp5oNzL5VroJ+Ak=
Received: by 10.229.107.29 with SMTP id z29mr1000506qco.42.1269398373156; Tue, 
	23 Mar 2010 19:39:33 -0700 (PDT)
In-Reply-To: <20100323185745.GA1382@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143065>

HI,

On Wed, Mar 24, 2010 at 2:57 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
>
> If you can make a heuristic along these lines this work well, I think=
 it
> would be great. =A0I imagine it might work very well for commits that=
 made
> nice, small changes (like many of those in git.git). =A0Jakub pointed=
 out
> some of the difficulties, and I like to hope your idea of =93when in =
doubt,
> include more lines=94 may work well in many cases in git.git still.
>
> Good luck, and thank you for taking my crazy ideas seriously. :)
>
> Regards,
> Jonathan
>
> [1] See v1.4.4-rc1~2 (Merge branch 'jc/pickaxe', 2006-11-07) and the
> commits preceding it. =A0About that series, Junio wrote:
>
> =A0 =A0 =A0 =A0Actually the plan is to make it do _true_ pickaxe,
> =A0 =A0 =A0 =A0although it will most likely end up either in dustbin =
or
> =A0 =A0 =A0 =A0replace blame.
>
> It replaced blame.
>
> I am not actually sure, but I assume =93true pickaxe=94 refers to the
> goals described in <http://gitster.livejournal.com/35628.html>
> and the linked-to message.

I have looked over the article and the message from Linus, it really
help me very much. The message and article pointed out most of the
things a line level tool should do, and I am happy to find that it is
similar with my proposal. :) Thanks again for your precious advice and
I think I can come up a better proposal, now. Thanks!

Regards!
Bo
