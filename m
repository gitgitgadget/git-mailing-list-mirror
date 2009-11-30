From: "Bernhard R. Link" <brlink@debian.org>
Subject: Re: equal-tree-merges as way to make rebases fast-forward-able
Date: Mon, 30 Nov 2009 17:22:29 +0100
Message-ID: <20091130162229.GA3792@pcpool00.mathematik.uni-freiburg.de>
References: <cover.1259524136.git.brlink@debian.org> <hf0oh0$elj$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 30 17:24:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF92f-0001Yo-Ev
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 17:24:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863AbZK3QXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 11:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752440AbZK3QXt
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 11:23:49 -0500
Received: from pcpool00.mathematik.uni-freiburg.de ([132.230.30.150]:47126
	"EHLO pcpool00.mathematik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752055AbZK3QXt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Nov 2009 11:23:49 -0500
Received: from pcpool09.mathematik.uni-freiburg.de ([132.230.30.159])
	by pcpool00.mathematik.uni-freiburg.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1NF92Z-0005Er-Dv
	for git@vger.kernel.org; Mon, 30 Nov 2009 17:23:55 +0100
Received: from brl by pcpool09.mathematik.uni-freiburg.de with local (Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1NF92Z-00013P-C6
	for git@vger.kernel.org; Mon, 30 Nov 2009 17:23:55 +0100
Content-Disposition: inline
In-Reply-To: <hf0oh0$elj$1@ger.gmane.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134117>

* Paolo Bonzini <bonzini@gnu.org> [091130 16:32]:
> On 11/30/2009 03:43 PM, Bernhard R. Link wrote:
>> The itch this idea is supposed to scratch is the problem that a rebase
>> or a amended commit is no longer a fast-forward, so cannot be easily
>> pulled.
>
> How does this compare with topgit?

It's not easily compareable as having different aims, but I think there
are some use-cases where this allows native usage of git where
previously the best bet was topgit.

Assume for example you want to maintain a set of patches of some
upstream, which you want to have in some form relative to upstream
and in patches easily reviewable and pickable by other people.

You could do that with topgit by making each change a topgit branch.
But to clone that repository then you would need topgit to get all
the information and cherry picking one of your changes (that perhaps
grow with the time, was adapted to new upstreams and had bugs fixed)
needs telling topgit to combine the changes of that branch and use that
instead of a simple cherry pick.

With this equal-tree-marker you can just do a git rebase --eqt or git
rebase -i --eqt and both have a history with your changes as single
commits which are easy to look at (and you can just pushing head^1
somewhere for upstream to pull from) while still having all the history
in your git archive so someone else can look what actually happened or
just clone your current head and repeatenly pull from it.

Hochachtungsvoll,
	Bernhard R. Link
