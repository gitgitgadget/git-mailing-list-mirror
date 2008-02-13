From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Add function to checkout a branch in git.el
Date: Wed, 13 Feb 2008 17:43:56 +0100
Message-ID: <20080213164356.GA5828@diana.vm.bytemark.co.uk>
References: <87wsp8u9m7.dlv@maison.homelinux.org> <20080213163002.GA5670@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Alexandre Julliard <julliard@winehq.org>
To: =?us-ascii?B?PT91dGYtOD9xP1I9QzM9QTltaT0yMFZhbmljYXQ/PQ==?= 
	<vanicat@debian.org>
X-From: git-owner@vger.kernel.org Wed Feb 13 17:45:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPKj6-0001o3-L0
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 17:44:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761097AbYBMQoG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Feb 2008 11:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933354AbYBMQoF
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 11:44:05 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4953 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756504AbYBMQoE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 11:44:04 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JPKiC-0001ai-00; Wed, 13 Feb 2008 16:43:56 +0000
Content-Disposition: inline
In-Reply-To: <20080213163002.GA5670@diana.vm.bytemark.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73802>

On 2008-02-13 17:30:02 +0100, Karl Hasselstr=F6m wrote:

> Why the prefix? Wouldn't it be easier to just have one "switch
> branch" prompt that would tab complete existing branch names, and
>
>   * if the user enters the name of an existing branch, just switch to
>     it;
>
>   * if the user enters a name that's not the name of an existing
>     branch, ask for confirmation, and then create the new branch and
>     switch to it.

Reading your code a bit more carefully, I realize that my suggestion
doesn't give you the opportunity to base the new branch on anything
but HEAD. So change the second bullet to

  * if the user enters a name that's not the name of an existing
    branch, display a prompt like this

      Creating new branch "foo". Where should it start?

    Tab complete on existing tags and branches, but accept any
    committish. Create the new branch and switch to it.

This bit of UI could obviously be reused to make create-branch and
create-tag commands that don't switch the current branch.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
