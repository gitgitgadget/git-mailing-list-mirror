From: Eli Barzilay <eli@barzilay.org>
Subject: Re: Multiple user.name and user.email (possible feature request)
Date: Sun, 18 Apr 2010 16:11:15 -0400
Message-ID: <19403.26467.273476.220670@winooski.ccs.neu.edu>
References: <19402.52486.274010.66636@winooski.ccs.neu.edu>
	<F5BFE3BD-7416-4F13-AF7F-0775E3234C92@gmail.com>
	<20100418183759.GA11366@coredump.intra.peff.net>
	<r2wfabb9a1e1004181143o7ebe2cf1t883ee4a12ba29a24@mail.gmail.com>
	<20100418185519.GA14331@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>, Jeff King <peff@peff.net>,
	Steven Michalske <smichalske@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 18 22:11:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3apv-00061O-2W
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 22:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922Ab0DRULS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 16:11:18 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:56539 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752451Ab0DRULR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 16:11:17 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1O3apn-0006UD-9C; Sun, 18 Apr 2010 16:11:15 -0400
In-Reply-To: <F5BFE3BD-7416-4F13-AF7F-0775E3234C92@gmail.com>,
	<20100418183759.GA11366@coredump.intra.peff.net>,
	<r2wfabb9a1e1004181143o7ebe2cf1t883ee4a12ba29a24@mail.gmail.com>,
	<20100418185519.GA14331@coredump.intra.peff.net>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145243>

On Apr 18, Steven Michalske wrote:
> 
> I have three different email address for different repositories on my  
> computer.  I have my global config set with my most common address,  
> and the repositories with the less common email set locally in the  
> repository.

(As already guessed) I really do want it to error instead of guessing.
My problem is that I'm very often checking out trees of one project
(and starting from today that svn-checkout has been replaced by a git
clone), and I will definitely get confused.  (It seems to me that this
is a common source of problems, leading to much flammage.)


On Apr 18, Jeff King wrote:
> 
> Sine 1.7.0, git will complain loudly if you simply don't have your
> identity set at all. There is no way to make it actually refuse the
> commit, but the warning is quite gigantic and hard to miss:
> [...]
> So I expect that will serve Eli's purpose.

Well, that would get closer, but I'd really prefer if there was a
do-not-use-me value I could set.  But in any case, even this is not
working for me -- digging through my environment, I found that I have
EMAIL set to my email, and so git guesses my name and doesn't produce
that huge response.

Worse, if I set up

  [user]
    name = ""
    email = ""

in my ~/.gitconfig (and make sure that I don't have EMAIL set), then
git still guesses the values -- without any warning.


On Apr 18, Jeff King wrote:
> On Sun, Apr 18, 2010 at 08:43:11PM +0200, Sverre Rabbelier wrote:
> > 
> > If it does not, would a pre-commit hook work? If he sets some
> > recognizable string (such as not setting it) as email and install
> > a hook that barfs if it sees that?
> 
> Yeah, that could work. It would do what he wants, but he would have
> to have the hook set up. Which means he either needs to remember to
> configure it in each repository (at which point he could just
> remember to configure his identity), or he needs to point to a
> special init template directory with the hook.
> 
> I think setting init.templatedir or GIT_TEMPLATE_DIR in the
> environment would accomplish the latter.

Yes, that sounds like it will work, and I'll do that.  But in general
this well beyond what most people would do.  If it was done as I
suggested (actually, how I thought it would behave), then this whole
thing would be easy even for people who are afraid of shell
programming...

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
