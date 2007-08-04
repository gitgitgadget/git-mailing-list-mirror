From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] unpack-trees.c: assume submodules are clean during check-out
Date: Sat, 4 Aug 2007 13:41:06 +0200
Message-ID: <8c5c35580708040441ue1c3ef8qc022912a5af4883e@mail.gmail.com>
References: <20070717182828.GA4583MdfPADPa@greensroom.kotnet.org>
	 <7vy7he6ufj.fsf@assigned-by-dhcp.cox.net>
	 <20070801140532.GC31114MdfPADPa@greensroom.kotnet.org>
	 <7v643vj316.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: skimo@liacs.nl, "Sven Verdoolaege" <skimo@kotnet.org>,
	git@vger.kernel.org, "Eran Tromer" <git2eran@tromer.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 13:41:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHI0N-0002iW-QQ
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 13:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759706AbXHDLlJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 07:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753190AbXHDLlI
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 07:41:08 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:22390 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbXHDLlH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 07:41:07 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1145213wah
        for <git@vger.kernel.org>; Sat, 04 Aug 2007 04:41:06 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pvtU7+pomHmJq5x7gxVElfjZJcXzEnWtVXYRtHOXUoWem0Bo8XdJlDcKXmZOiWmi9vk5qwqc6sp4cWSug3TsJfjyfeGbBPs0aBKUp1E7l/3hJL8Q2j5rBpq160bdcYv2M8TgmRQIaTDEtkcUPjI7+7NsuFiBwfp2hCxRAal2IOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R6Y0X8HQoLgPy03EzOPwHC8Iey9hDDBFW5pJtZPoO/B6LUMG5XDaVr4uTtZjPf/boNKWsLI4PbhykqP2pA2BiMHPaizTmB347DFA5VCnP5NEJ65iFyHWyIf1aCRagUv/CeCfbbyDorfW4tIbLtoFwJz9bwLbBOjjtuwOaT7OLao=
Received: by 10.114.149.2 with SMTP id w2mr3873430wad.1186227666450;
        Sat, 04 Aug 2007 04:41:06 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Sat, 4 Aug 2007 04:41:06 -0700 (PDT)
In-Reply-To: <7v643vj316.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54827>

On 8/4/07, Junio C Hamano <gitster@pobox.com> wrote:
> As we explicitly allow
> submodule checkout to drift from the supermodule index entry,
> the check should say "Ok, for submodules, not matching is the
> norm" for now.  Later when we have the ability to mark "I care
> about this submodule to be always in sync with the superproject"
> (thereby implementing automatic recursive checkout and perhaps
> diff, among other things), we should check if the submodule in
> question is marked as such and perform the current test.

Yes, this sounds like a sane plan (and a good explanation of the
current semantics: maybe something to include in the release notes for
1.5.3?)

Btw: I've applied your patch to rc-4 and tested the result in my cgit
repo: very nice, and very ack'd ;-)

--
larsh
