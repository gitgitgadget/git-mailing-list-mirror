From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 09/13] revert: Catch incompatible command-line options
 early
Date: Tue, 21 Jun 2011 12:04:17 -0500
Message-ID: <20110621170416.GN15461@elie>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
 <1308661489-20080-10-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 19:04:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ4NI-0000vB-My
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 19:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756862Ab1FUREX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 13:04:23 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58299 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756823Ab1FUREW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 13:04:22 -0400
Received: by vws1 with SMTP id 1so1875445vws.19
        for <git@vger.kernel.org>; Tue, 21 Jun 2011 10:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=VioIvjsTeK72ltKHHgYac9SS8rve7ilsIfhKGFPoiZA=;
        b=MdKb2WXACQFk7UdtLB9KgIl1oe74Wd+5fHNtyhziOVxEom1xCW2pUBb89F0F0LebMp
         utg0Oy7J7lGFe/6Fh0YFCR7AKjMgyehLvXCTgC5xwV2cmT0cMhHEiRJCAKgDRYtg499T
         EAA5MR+F5R9dY15ucp51fAzWf2GeaYC8eVpVE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=j/oILzvmBi7QOeOPaztDMakJrkzoF0xNb5TMdyQX93hIov3xI9mJhG1UXrZynhJrlp
         2DxYG0YvhmFTjuqfFttJu/hbdAnzB39HabCGyfVSxCihIcf9rrfUn1lRUsQsmxc4Kd3S
         hAeKjKnpOr169v/nBySPvNqk5fVRQhdPGx2cA=
Received: by 10.52.75.129 with SMTP id c1mr306435vdw.202.1308675861788;
        Tue, 21 Jun 2011 10:04:21 -0700 (PDT)
Received: from elie (adsl-69-209-79-158.dsl.chcgil.sbcglobal.net [69.209.79.158])
        by mx.google.com with ESMTPS id du9sm1063718vbb.10.2011.06.21.10.04.19
        (version=SSLv3 cipher=OTHER);
        Tue, 21 Jun 2011 10:04:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1308661489-20080-10-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176173>

Ramkumar Ramachandra wrote:

> Earlier, incompatible command-line options used to be caught in
> pick_commits after parse_args has parsed the options and populated the
> options structure.  Instead, hand over the responsibility of catching
> incompatible command-line options to parse_args so that the program
> can die early.

The "Earlier ... used to" phrasing is tripping me up again.

The naive reader (i.e., me) wonders: how long does this option parsing
and populating the options structure that we want to delay until after
verify_opt_compatible take?  Does that delay matter or is there some
other reason for this change?

> Also write a verify_opt_compatible function to handle
> incompatible options in a general manner.

Nitpick: the commit message generally commands the program or the
codebase to behave in a certain way, but in this example it is
commanding the author.  I'd say "add" or "provide".
