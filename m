From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [PATCH] t1301-shared-repo.sh: fix 'stat' portability issue
Date: Fri, 17 Aug 2007 14:48:28 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070817124828.GB11107@informatik.uni-freiburg.de>
References: <1187277663740-git-send-email-arjen@yaph.org> <7v3ayjjnz7.fsf@gitster.siamese.dyndns.org> <20070816220217.GH25161@regex.yaph.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Arjen Laarhoven <arjen@yaph.org>
X-From: git-owner@vger.kernel.org Fri Aug 17 14:49:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IM1G4-00072w-TM
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 14:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758380AbXHQMse convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 17 Aug 2007 08:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758132AbXHQMsd
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 08:48:33 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:46837 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758055AbXHQMsc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Aug 2007 08:48:32 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1IM1Ff-0006HJ-PQ; Fri, 17 Aug 2007 14:48:31 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l7HCmTaC012627;
	Fri, 17 Aug 2007 14:48:29 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l7HCmTsp012626;
	Fri, 17 Aug 2007 14:48:29 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Arjen Laarhoven <arjen@yaph.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070816220217.GH25161@regex.yaph.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56062>

Hello,

> +	actual=3D"$(ls -l .git/info/refs)" &&
> +	case "$actual" in
> +	-r--r--r--*)
> +		: happy
> +		;;
> +	*)
> +		echo Oops, .git/info/refs is not 0444
> +		false
> +		;;
> +	esac

Don't know if this matters here, but a while ago I learnd that if I
really need to parse output of ls -l, then I should set LANG=3DC and
LC_ALL=3DC.  I didn't see any breakage when LS_COLORS is set, but maybe
you want to reset that, too?

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D2004+in+roman+numerals
