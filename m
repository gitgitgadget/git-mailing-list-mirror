From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [BUG] git diff-tree --stdin doesn't accept two trees
Date: Wed, 6 Aug 2008 13:53:58 +0200
Message-ID: <20080806115358.GD18336@diana.vm.bytemark.co.uk>
References: <20080805164839.GA3934@diana.vm.bytemark.co.uk> <7vwsivusy2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 13:33:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQhGV-0004XK-V9
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 13:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758091AbYHFLcO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Aug 2008 07:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757966AbYHFLcO
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 07:32:14 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2811 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757964AbYHFLcN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 07:32:13 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KQhaY-0005HD-00; Wed, 06 Aug 2008 12:53:58 +0100
Content-Disposition: inline
In-Reply-To: <7vwsivusy2.fsf@gitster.siamese.dyndns.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91506>

On 2008-08-05 13:07:17 -0700, Junio C Hamano wrote:

> Karl Hasselstr=F6m <kha@treskal.com> writes:
>
> > I'm trying to use diff-tree --stdin to diff several trees in one
> > go. But I just get error messages when I feed it two
> > space-separated trees (one commit works fine):
>
> No, the documentation was made wrong during 1.2.0 timeperiod.
>
> The feature of --stdin to take a commit and its parents on one line w=
as
> broken before that to support the common
>
>         rev-list --parents $commits... -- $paths... |
>                 diff-tree --stdin -v -p
>
> usage pattern by Porcelains.  For diff-tree to talk sensibly about
> commits, it needs to see commits, not just trees.

But is there any fundamental reason why it couldn't accept tree-ishes
as well? It only talks about commits if asked to do so with
command-line options.

Or would that break existing users somehow?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
