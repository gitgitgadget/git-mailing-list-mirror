From: Jeff King <peff@peff.net>
Subject: Re: merge, keeping the remote as a new file?
Date: Mon, 2 Mar 2009 02:04:06 -0500
Message-ID: <20090302070406.GA12937@coredump.intra.peff.net>
References: <81bfc67a0903011616w32ebdad9ofc096f5d1fd3174a@mail.gmail.com> <20090302041113.GA3094@coredump.intra.peff.net> <20090302063604.GA17245@hashpling.org> <20090302064519.GA5635@coredump.intra.peff.net> <20090302065949.GD6289@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Charles Bailey <charles@hashpling.org>,
	Caleb Cushing <xenoterracide@gmail.com>, git@vger.kernel.org
To: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 02 08:06:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Le2Dc-0007WJ-BG
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 08:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754303AbZCBHEM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Mar 2009 02:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754195AbZCBHEL
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 02:04:11 -0500
Received: from peff.net ([208.65.91.99]:51946 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753821AbZCBHEL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 02:04:11 -0500
Received: (qmail 4244 invoked by uid 107); 2 Mar 2009 07:04:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 02 Mar 2009 02:04:09 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Mar 2009 02:04:06 -0500
Content-Disposition: inline
In-Reply-To: <20090302065949.GD6289@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111906>

On Mon, Mar 02, 2009 at 07:59:49AM +0100, Bj=C3=B6rn Steinbrink wrote:

> Hm, how about this?
> git checkout --theirs file
> git mv file newname
> git checkout HEAD file # Can't use --ours here due to the mv

Actually, you can use --ours if you don't "git mv":

  git checkout --theirs file
  mv file newfile
  git checkout --ours file
  git add file newfile

One more command, but I think more obvious about what is going on (and =
I
think both are better than the other suggestions).

-Peff
