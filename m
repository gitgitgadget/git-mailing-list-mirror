From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Add some fancy colors in the test library when terminal supports it.
Date: Tue, 23 Oct 2007 06:08:14 +0200
Message-ID: <200710230608.15124.chriscool@tuxfamily.org>
References: <20071022081341.GC32763@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Oct 23 06:01:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkAxJ-0002me-16
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 06:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbXJWEBO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Oct 2007 00:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbXJWEBO
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 00:01:14 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:39067 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750811AbXJWEBN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Oct 2007 00:01:13 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id C0E0B1AB2BA;
	Tue, 23 Oct 2007 06:01:11 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 811D41AB2B8;
	Tue, 23 Oct 2007 06:01:11 +0200 (CEST)
User-Agent: KMail/1.9.7
In-Reply-To: <20071022081341.GC32763@artemis.corp>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62077>

Hi Pierre,

Le lundi 22 octobre 2007, Pierre Habouzit a =E9crit :
> +
> +say_color () {
> +	[ "$nocolor" =3D 0 ] &&  [ "$1" !=3D '-1' ] && tput setaf "$1"
> +	shift
> +	echo "* $*"
> +	tput op
> +}
> +
>  error () {
> -	echo "* error: $*"
> +	say_color 9 "* error: $*"

This will print something like "* * error: ..." instead of "* error: ..=
=2E"

The following should work:

> +	say_color 9 "error: $*"

By the way, where do the 9 here and the 10 and the -1 below come from ?
"man 5 terminfo" says that only values form 0 to 7 are portably defined=
=2E
Maybe 9 is a bold red and 10 a bold green, or something like that, but =
it=20
doesn't seem to work on my konsole.

Anyway, perhaps having:

_red=3D1
_green=3D2

and then using "say_color $_red stuff" might be easier to understand an=
d=20
change if needed.

Thanks for this good idea,
Christian.
