From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fsck: properly bound "invalid tag name" error message
Date: Mon, 8 Dec 2014 12:35:27 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412081232500.13845@s15462909.onlinehome-server.info>
References: <20141208054812.GA30154@peff.net> <20141208055706.GA30207@peff.net> <20141208112835.GA15919@lanh>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 08 12:36:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xxwbg-00035j-8s
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 12:36:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755248AbaLHLfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 06:35:55 -0500
Received: from mout.gmx.net ([212.227.17.21]:52097 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755220AbaLHLfy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 06:35:54 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0McPvw-1YFc0W2Umu-00HfGe;
 Mon, 08 Dec 2014 12:35:28 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20141208112835.GA15919@lanh>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:bmPlWA409P745BzmIBA8o4lkOOWgXV08LFbfC1pNNpMlyvPvHi3
 grufoOyQT+TtPw/9JFvvUFbihBYdWaMCOaEKymusSLtu3hdZ0h/qM9rxfvWLAfL36e0gZUL
 /8dHv2P0IVEVTT9PUO/X346AOIg1rEsHIri5N5pGGXTNz3UgzPZ/YU+uWuNsVdtCqzMe/I5
 a8w5KXVDJbVB+hM75x9PQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261011>

Hi Duy,

On Mon, 8 Dec 2014, Duy Nguyen wrote:

> On Mon, Dec 08, 2014 at 12:57:06AM -0500, Jeff King wrote:
> > I do admit that I am tempted to teach index-pack to always NUL-terminate
> > objects in memory that we feed to fsck, just to be on the safe side. It
> > doesn't cost much, and could prevent a silly mistake (either in the
> > future, or one that I missed in my analysis).
> 
> I think I'm missing a "but.." here.

The "but..."s I have are:

1) we potentially waste space, and

2) I would like to make really certain, preferably with static analysis,
   that fsck_object() only receives buffers that are NUL terminated, and
   that no call path is missed.

The patch looks good, of course, but I lack the broad overview of Git's
source code - it has been years since I was familiar enough with it to
know the places touching particular functions from the top of my head.

Ciao,
Dscho
