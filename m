From: David Kastrup <dak@gnu.org>
Subject: Re: Stupid quoting...
Date: Tue, 19 Jun 2007 09:44:20 +0200
Message-ID: <86sl8owfqj.fsf@lola.quinscape.zz>
References: <86ir9sw0pi.fsf@lola.quinscape.zz> <f51irh$shq$1@sea.gmane.org> <86ir9l1ylc.fsf@lola.quinscape.zz> <Pine.LNX.4.64.0706190156110.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 19 10:12:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0Yp8-0002Ka-4i
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 10:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538AbXFSIMX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 04:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753198AbXFSIMW
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 04:12:22 -0400
Received: from main.gmane.org ([80.91.229.2]:54570 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752291AbXFSIMV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 04:12:21 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I0YXo-0004BF-TC
	for git@vger.kernel.org; Tue, 19 Jun 2007 09:54:33 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 19 Jun 2007 09:54:32 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 19 Jun 2007 09:54:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:ZAQ99uJKhaa5CMYhrRffVScbsgs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50455>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 18 Jun 2007, David Kastrup wrote:
>
>> Jakub Narebski <jnareb@gmail.com> writes:
>> 
>> > David Kastrup wrote:
>> >
>> >> what is the point in quoting file names and their characters in 
>> >> git-diff's output?
>> >
>> > 7-bit email.
>> 
>> I think it can be reasonably safely assumed that people using 8-bit
>> characters in file names will not refrain from using them in the files
>> themselves: [...]
>
> However, please realise that chances are very good that none of these 
> 8-bit unclean things show in the diff.

Puh-leaze.  So you prefer a behavior which makes it harder to notice
problems, on the chance that it may sometimes work by accident?

If you want to process diffs, you need an 8-bit clean (and
space-preserving) channel, period.  This is the task of mail
encapsulation, not of the diff utility.

> Besides, the proper fix would probably involve making
> none-8-bit-clean diffs binary diffs (for FORMAT_EMAIL only, of
> course).

This is so utterly absurd for people working on non-English documents
that I get the expression you are pulling people's legs considering
your Email address.

>> So I don't see what quoting such characters in file names is
>> supposed to buy with regard to diff output in 7-bit email.
>
> But isn't that obvious? Even if the diffs are not 7-bit clean, which
> I consider as an error, quoting the file names is already half what
> is required.

What is required is a reliable mail channel, and there are a lot of
tools for that, from uuencode to various MIME standards and
encapsulation methods.  The right tool for the right job.  Everything
else is a mistake because it makes life harder for everyone, not just
those using mail, for no good purpose.

> Don't just throw away backwards compatibility, only because it does
> not fit your wishes.

There is no backwards compatibility involved here _at_ _all_.  No
current tool can process the quoted mess, not even humans (random
octal escape sequences are not more readable than characters, or we
never would have progressed beyond ASCII).

So you are not talking about backward compatibility, but rather
gratuitous forward _incompatibility_, and nobody is better off by the
latter.  There is no point in making life harder for people using
non-ASCII characters when there is absolutely no benefit whatsoever
involved for those restricting themselves to ASCII characters.

-- 
David Kastrup
