From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: [PATCH 2/2] completion: add git status
Date: Wed, 1 Jun 2016 11:05:44 +0200
Message-ID: <5ce10133-e982-4c02-7f97-77d03231e677@virtuell-zuhause.de>
References: <b881e8b7-8364-f78b-d7ac-817850783c6e@virtuell-zuhause.de>
	 <20160601040722.GB18978@sigill.intra.peff.net>
Reply-To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder@ira.uka.de>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 01 11:34:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b82Y0-0006tO-4p
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 11:34:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757404AbcFAJek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 05:34:40 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:59691 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752036AbcFAJei convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Jun 2016 05:34:38 -0400
Received: from p4fc87c53.dip0.t-ipconnect.de ([79.200.124.83] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1b82Xr-0000aC-Bw; Wed, 01 Jun 2016 11:34:35 +0200
FCC: imap://wp1126771-182009@wp156.webpack.hosteurope.de/Gesendete Objekte
X-Identity-Key: id2
X-Account-Key: account1
X-Priority: Normal
X-Enigmail-Draft-Status: N1110
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; DSN=0;
 uuencode=0; attachmentreminder=0
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
In-Reply-To: <20160601040722.GB18978@sigill.intra.peff.net>
X-Mailer: Evolution 3.12.9-1+b1 
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1464773678;a7629ffd;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296071>

> Jeff King <peff@peff.net> hat am 1. Juni 2016 um 06:07 geschrieben:
> 
> 
> On Wed, Jun 01, 2016 at 01:42:18AM +0200, Thomas Braun wrote:
> 
> > Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
> > ---
> >  contrib/completion/git-completion.bash | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> > 
> > diff --git a/contrib/completion/git-completion.bash
> > b/contrib/completion/git-completion.bash
> > index 57a0acc..96b7d86 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -1782,6 +1782,35 @@ _git_stage ()
> >  	_git_add
> >  }
> >  +_git_status ()
> 
> This patch has the same funniness as the other. Weird.

Should be fixed now.

> > +{
> > +	case "$cur" in
> > +	--ignore-submodules=*)
> > +		__gitcomp "none untracked dirty all" "" "${cur##--ignore-submodules=}"
> > +		return
> > +		;;
> > +	--untracked-files=*)
> > +		__gitcomp "$(__git_untracked_file_modes)" "" "${cur##--untracked-files=}"
> 
> Same comment on $() here.

Fixed.

> > +		return
> > +		;;
> > +	--column=*)
> > +		__gitcomp "
> > +			always never auto column row plain dense nodense
> > +			" "" "${cur##--column=}"
> > +		return
> > +		;;
> > +	--*)
> > +		__gitcomp "
> > +			--short --branch --porcelain --long --verbose
> > +			--untracked-files= --ignore-submodules= --ignored
> > +			--column= --no-column
> > +			"
> > +		return
> > +		;;
> > +	esac
> > +	__git_complete_file
> > +}
> 
> The rest of it (both the overall goal, and the patch itself) look OK to
> me.

Thanks,
Thomas
