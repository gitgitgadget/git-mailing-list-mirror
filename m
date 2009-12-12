From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 2/6] reset: use "unpack_trees()" directly instead of "git read-tree"
Date: Sat, 12 Dec 2009 05:19:03 +0100
Message-ID: <200912120519.04328.chriscool@tuxfamily.org>
References: <20091208075005.4475.26582.chriscool@tuxfamily.org> <20091208075616.4475.46720.chriscool@tuxfamily.org> <1260261919.1554.11.camel@swboyd-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 12 05:16:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJJPb-0005eS-D7
	for gcvg-git-2@lo.gmane.org; Sat, 12 Dec 2009 05:16:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755894AbZLLEQe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Dec 2009 23:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754735AbZLLEQd
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 23:16:33 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:42878 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752112AbZLLEQc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Dec 2009 23:16:32 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 0609E818052;
	Sat, 12 Dec 2009 05:16:28 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 6C93E81805D;
	Sat, 12 Dec 2009 05:16:25 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <1260261919.1554.11.camel@swboyd-laptop>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135114>

On mardi 08 d=C3=A9cembre 2009, Stephen Boyd wrote:
> On Tue, 2009-12-08 at 08:56 +0100, Christian Couder wrote:
> > +static int parse_and_init_tree_desc(const unsigned char *sha1,
> > +					     struct tree_desc *desc)
> > +{
> > +	struct tree *tree =3D parse_tree_indirect(sha1);
> > +	if (!tree)
> > +		return 1;
> > +	init_tree_desc(desc, tree->buffer, tree->size);
> > +	return 0;
> > +}
> > +
>
> Is there a reason why you use this function instead of
> fill_tree_descriptor()?

I didn't know about fill_tree_descriptor(). I will use it in the next=20
series.

Thanks,
Christian.
