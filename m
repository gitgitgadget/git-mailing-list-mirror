From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH 1/3] mailinfo: ensure handle_filter gets only one line at a time
Date: Sat, 16 Feb 2008 01:51:45 -0500
Message-ID: <76718490802152251x20102ecep383fb76ce0c96b64@mail.gmail.com>
References: <1203112418-25199-1-git-send-email-jaysoffian@gmail.com>
	 <7vodahg5w4.fsf@gitster.siamese.dyndns.org>
	 <76718490802151537r7658e109o3c981832ae32154d@mail.gmail.com>
	 <7vmyq1e86n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 07:52:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQGud-0005XS-UR
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 07:52:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbYBPGvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 01:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbYBPGvr
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 01:51:47 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:31955 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbYBPGvq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 01:51:46 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1569755wah.23
        for <git@vger.kernel.org>; Fri, 15 Feb 2008 22:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=SGanHZfEjbaO5LKon2NgjoCFXY0degDiSCm9eNVEJwc=;
        b=ruszWoMaLVLnrEgK6/mlUzFpBaY+rx8qg5JwvwrSkR4KYOxfpaSPGbRPSVKvQ3kf3G9+1JDzvyFLKbW4DP7GDdByRFwSCoBh8Gt0r2CdK99ES1H3r0/UR7Dx++NsJ6TJ5NCvdZtFf5SLjCumpGUp/InFYeAN3Fs7TgdJR2txsZI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OXyC/HrUKIVUAvyx57ebtANcD8WNboTBX3Uyb5h7rXDAYg2tmN+Y8KAyvXI6b1oARTpbLLw2g6bHfTx/Wb8BLd+YW3UBZatxi2Y9Fc5EqvdECy8GNF5gMOQ12WlsTyWjqOUScK/i7ZPLX2UuXHlhb0XNu0ogptnItH8NlcHl9F4=
Received: by 10.114.195.19 with SMTP id s19mr2392595waf.58.1203144705972;
        Fri, 15 Feb 2008 22:51:45 -0800 (PST)
Received: by 10.114.255.11 with HTTP; Fri, 15 Feb 2008 22:51:45 -0800 (PST)
In-Reply-To: <7vmyq1e86n.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74019>

On Feb 16, 2008 1:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Jay Soffian" <jaysoffian@gmail.com> writes:
>
> > On Feb 15, 2008 6:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >> Care to provide a test case for this one?
> >
> > I'll see what I can do. I'm not sure it makes a difference...
>
> Of course it does; otherwise I wouldn't have asked.

What I meant was, I wasn't sure if the output of mailinfo
would have been incorrect w/o the patch. I noticed it only
when I added the format=flowed code which relied on
handle_filter() getting a single line at a time. I hadn't
looked at whether handle_commit_msg() and/or handle_patch()
(downstream of handle_filter) would care.

I wasn't trying to shirk off adding a test case. :-)

j.
