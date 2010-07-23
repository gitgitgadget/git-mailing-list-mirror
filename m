From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 5/5] rebase: protect against diff.renames configuration
Date: Fri, 23 Jul 2010 14:53:46 -0500
Message-ID: <AANLkTik3uZTmcjv4Jeg7VXbC8Lmai_xjRF80yHfUHxKf@mail.gmail.com>
References: <7vwsfb2k3u.fsf@gitster.siamese.dyndns.org> <1279742303-29817-1-git-send-email-ddkilzer@kilzer.net> 
	<20100722075133.GA9292@burratino> <681325.9577.qm@web30002.mail.mud.yahoo.com> 
	<20100723170103.GA2507@burratino> <20100723170613.GF2507@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "David D. Kilzer" <ddkilzer@kilzer.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 23 21:54:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcOK2-0007Gs-MZ
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 21:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757927Ab0GWTyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 15:54:09 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57088 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758060Ab0GWTyH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 15:54:07 -0400
Received: by iwn7 with SMTP id 7so475040iwn.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 12:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=kPdXKt5QMTvgmhtpSx0/plknUjmk4X9YU7CODHTKFk4=;
        b=vuVEXVE9oN4TN+h10P5xE1FpKnZKhUp9ak1Giuc+Eqx5zexDHX6LW4tFKvhhnD1/zy
         4qr7JxeuHdV/6PHXSXt9R8JpeE7/VEGxZeVwMnbxrTg0yxilGC7KBu2KYOtqDI0DDBJD
         /eZkp6Vql4sc1LyrkzliXpAKp+FKiL0zBfVSU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ZkqLnRsyf5ZPILAPlRZ4ZJRnlUpnM1GND3VeZNuQYxRgiO58tMTd86CukqDnNBTSA7
         PfVQ2i5SegFaqCvGTEKc9LvF3F+sBdAz78+64YEm2kStuF74OtqPdLLgcFVISd9LNsVm
         otAgnNiOGSBwso5rVp232YpyV50mJTHpZ9KNM=
Received: by 10.231.39.137 with SMTP id g9mr4162651ibe.133.1279914846705; Fri, 
	23 Jul 2010 12:54:06 -0700 (PDT)
Received: by 10.231.34.135 with HTTP; Fri, 23 Jul 2010 12:53:46 -0700 (PDT)
In-Reply-To: <20100723170613.GF2507@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151569>

Heya,

On Fri, Jul 23, 2010 at 12:06, Jonathan Nieder <jrnieder@gmail.com> wrote:
> The end user configuration for "diff" should not affect the result
> produced by the higher level command that is related to "diff" only
> because internally it is implemented in terms of it.

Almost completely unrelated and perhaps not relevant, I seem to recall
that if you set 'ui.color' to 'always' you will get unapplyable
patches because 'git format-patch' will include the color in it's
output. Perhaps it should --no-color as well, while we're fixing it?

-- 
Cheers,

Sverre Rabbelier
