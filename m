From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@strlen.de>
Subject: Re: [RFC PATCH] describe: Make --tags and --all match lightweight
	tags more often
Date: Sun, 12 Oct 2008 20:29:13 +0200
Message-ID: <20081012182913.GA8858@strlen.de>
References: <20080930083940.GA11453@artemis.corp> <20081010165952.GI8203@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Erez Zilber <erezzi.list@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Oct 12 20:30:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp5i5-0008A2-Ti
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 20:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753633AbYJLS3W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Oct 2008 14:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753443AbYJLS3W
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 14:29:22 -0400
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:38340 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751218AbYJLS3V (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Oct 2008 14:29:21 -0400
Received: id: ukleinek by Chamillionaire.breakpoint.cc authenticated by ukleinek with local
	(easymta 1.00 BETA 1)
	id 1Kp5gn-0002Jd-BG; Sun, 12 Oct 2008 20:29:13 +0200
Content-Disposition: inline
In-Reply-To: <20081010165952.GI8203@spearce.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98044>

On Fri, Oct 10, 2008 at 09:59:52AM -0700, Shawn O. Pearce wrote:
> If the caller supplies --tags they want the lightweight, unannotated
> tags to be searched for a match.  If a lightweight tag is closer
> in the history, it should be matched, even if an annotated tag is
> reachable further back in the commit chain.
>=20
> The same applies with --all when matching any other type of ref.
>=20
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>=20
>  This come out of the discussions earlier last week, where folks
>  were confused about the meaning of --tags and wanted to see it
>  behave as they expected, which was to match the nearest tag,
>  no matter its "type".
>=20
>  The code is unchanged from what I sent out before, but now it has
>  updated test vectors and a commit message.
>=20
>  Thoughts?
As I already told earlier, this is exactly how I would expect it.

>  static int debug;	/* Display lots of verbose info */
> -static int all;	/* Default to annotated tags only */
> -static int tags;	/* But allow any tags if --tags is specified */
> +static int all;	/* Any valid ref can be used */
> +static int tags;	/* Either lightweight or annotated tags */
Maybe the last comment should better read:

	/* allow lightweight tags */

?  Apart from this one nitpick:

Acked-By: Uwe Kleine-K=F6nig <ukleinek@strlen.de>

Thanks
Uwe
