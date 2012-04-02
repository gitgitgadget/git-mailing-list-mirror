From: Martin Fick <mfick@codeaurora.org>
Subject: Re: [PATCH 3/3] revision: insert unsorted, then sort in prepare_revision_walk()
Date: Mon, 2 Apr 2012 10:49:04 -0600
Organization: CAF
Message-ID: <201204021049.04901.mfick@codeaurora.org>
References: <201203291818.49933.mfick@codeaurora.org> <201204021024.49706.mfick@codeaurora.org> <CAJo=hJshOBg4pT8nuWZ=eZvj=E9x+4b9M_EANa=02x=NFW2OfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Shawn Pearce <sop@google.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Apr 02 18:49:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEkRN-0000HD-9f
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 18:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752743Ab2DBQtI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Apr 2012 12:49:08 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:30584 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628Ab2DBQtG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Apr 2012 12:49:06 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6668"; a="175807218"
Received: from pdmz-css-vrrp.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.130])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 02 Apr 2012 09:49:05 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id BF77710004AA;
	Mon,  2 Apr 2012 09:49:05 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-37-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <CAJo=hJshOBg4pT8nuWZ=eZvj=E9x+4b9M_EANa=02x=NFW2OfQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194534>

On Monday, April 02, 2012 10:39:59 am Shawn Pearce wrote:
> On Mon, Apr 2, 2012 at 09:24, Martin Fick=20
<mfick@codeaurora.org> wrote:
> > On Saturday, March 31, 2012 04:11:01 pm Ren=E9 Scharfe=20
wrote:
> Git can't really do the same thing as "cache the
> RevWalk". Its spawning a new process that needs to
> decompress and parse each commit object to determine its
> timestamp so the commits can be sorted into the priority
> queue. This is still an O(N) operation given N
> references.

While I suspect this has been suggested before, an ondisk=20
cache of commits to timestamps would probably help here with=20
large repos.  Such a cache could make even new processes=20
able to create this list much quicker.  Since this cache=20
would contain immutable data, even if it is out of date it=20
would likely provided significant improvements by providing=20
most of the timestamps leaving only a few to parse from=20
newer commits?

-Martin

--=20
Employee of Qualcomm Innovation Center, Inc. which is a=20
member of Code Aurora Forum
