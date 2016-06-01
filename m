From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: [PATCH 1/2] completion: create variable for untracked file
 modes
Date: Wed, 1 Jun 2016 11:14:40 +0200
Message-ID: <569545b0-a5cb-c722-601e-2654d4c6e5e1@virtuell-zuhause.de>
References: <5a3d279f-d3cc-90ec-a0e7-90b7ef438966@virtuell-zuhause.de>
	 <20160601040542.GA18978@sigill.intra.peff.net>
	 <xmqqk2i91jf5.fsf@gitster.mtv.corp.google.com>
Reply-To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: git <git@vger.kernel.org>,
	=?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder@ira.uka.de>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 11:34:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b82Y0-0006tO-NG
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 11:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757508AbcFAJem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 05:34:42 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:59736 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753885AbcFAJek convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Jun 2016 05:34:40 -0400
Received: from p4fc87c53.dip0.t-ipconnect.de ([79.200.124.83] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1b82Xt-0000bL-Pt; Wed, 01 Jun 2016 11:34:37 +0200
FCC: imap://wp1126771-182009@wp156.webpack.hosteurope.de/Gesendete Objekte
X-Identity-Key: id2
X-Account-Key: account1
X-Priority: Normal
X-Enigmail-Draft-Status: N1110
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; DSN=0;
 uuencode=0; attachmentreminder=0
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
In-Reply-To: <xmqqk2i91jf5.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.12.9-1+b1 
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1464773680;1b020a46;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296070>

> Junio C Hamano <gitster@pobox.com> hat am 1. Juni 2016 um 09:02 geschrieben:
> 
> 
> Jeff King <peff@peff.net> writes:
> 
> >> diff --git a/contrib/completion/git-completion.bash
> >> b/contrib/completion/git-completion.bash
> >> index 3402475..57a0acc 100644
> >> --- a/contrib/completion/git-completion.bash
> >> +++ b/contrib/completion/git-completion.bash
> >> @@ -1098,6 +1098,8 @@ _git_clone ()
> >>  	esac
> >>  }
> >>  +__git_untracked_file_modes="all no normal"
> >> +
> >>  _git_commit ()
> >>  {
> >>  	case "$prev" in
> >
> > There's something funny about the formatting of your patch. The first
> > "+" line is indented, which it shouldn't be. As it is, it looks like
> > context (but it's not actually part of the preimage). But if it's not
> > context, then you are missing a context line.
> 
> Not just that.  Count the context lines and notice that this appears
> to have only 2 lines of precontext.
> 
> I think the MUA is somehow eating a blank line context (i.e. a
> single SP on a line by itself) immediately after the closing brace
> of the function before _git_commit and the next new line that began
> with '+' in the original and made them into a single line.  I've
> seen this exact breakage before, I think.

Thanks both for noticing and sorry for the mess.

I'm using Thunderbird 45.1.1 on Windows and the "Toggle Word Wrap" addon
for well trying to avoid messing up whitespace. The emails are created
with `git format-patch ... | git imap-send` and sent to my drafts
folder. There they look good *until* I choose "Edit as new" which seems
to be required to actually send the email.  So I'll
stick to other solutions for now.

Reroll follows.
