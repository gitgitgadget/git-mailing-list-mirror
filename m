From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool merge/skip/abort
Date: Sat, 24 Jan 2009 21:20:47 -0800
Message-ID: <7vljt0j70w.fsf@gitster.siamese.dyndns.org>
References: <81bfc67a0901210637j52fa7a55q51b599e9ff16f6dc@mail.gmail.com>
 <20090121170434.GA21727@hashpling.org>
 <81bfc67a0901220617l22b5a8e4ma48bb069d67cae91@mail.gmail.com>
 <20090122142258.GA2316@hashpling.org>
 <81bfc67a0901230716i166bfc4chd9a5c0990b0cd3b6@mail.gmail.com>
 <7vwscmue5z.fsf@gitster.siamese.dyndns.org>
 <81bfc67a0901241036v6ca30c24q54487e118fd67c1c@mail.gmail.com>
 <20090125064539.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Caleb Cushing <xenoterracide@gmail.com>,
	Charles Bailey <charles@hashpling.org>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sun Jan 25 06:22:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQxS7-0007jt-Da
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 06:22:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbZAYFU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 00:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbZAYFU4
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 00:20:56 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34063 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896AbZAYFU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 00:20:56 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C655C93182;
	Sun, 25 Jan 2009 00:20:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4586693181; Sun,
 25 Jan 2009 00:20:48 -0500 (EST)
In-Reply-To: <20090125064539.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Sun, 25 Jan 2009 06:45:39 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F0953C10-EA9F-11DD-9F06-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107043>

Nanako Shiraishi <nanako3@lavabit.com> writes:

>  2. patterns in case command start at the same column as case and esac,
>     and ";;" is at the same column as any other commands.
>
> 	case "$ans" in
> 	[mM]*|"")
> 		break
> 		;;
> 	[Ss]*)
> 		...
> 	esac

I generally prefer the above style, but mergetool is not mine, and the
predominant style in it is:

        case xyzzy in
            frotz)
                do this
                ;;
            nitfol)
                do that
                ;;
        esac

Namely, case arms' labels are indented by 4 spaces from case/esac, and the
commands in each case arm are further indented by 4 spaces (including the
terminating double-semicolon).

It is always preferable to match the _local_ convention.  I'd expect a new
script added to git suite to match my preference (the one I showed you in
my comments to you that is used in git-am, which is what you suggested
above), but I'd expect a modification to mergetool to match the style
mergetool already uses.

IOW, Caleb's indentation style is fine.  The placement of double-semicolon
is not, though.
