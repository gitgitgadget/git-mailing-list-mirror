From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: [PATCH v2] git-pull.sh: better warning message for "git pull"
	on detached head.
Date: Tue, 7 Apr 2009 12:41:46 +0200
Message-ID: <20090407104145.GA22658@pvv.org>
References: <e2b179460904070224o3057c6efk6930bd1249adb0fe@mail.gmail.com> <1239098181-10360-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Apr 07 12:43:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr8m6-0002sh-Od
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 12:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492AbZDGKlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 06:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752362AbZDGKly
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 06:41:54 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:36456 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbZDGKlx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 06:41:53 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1Lr8kU-0006qb-2H; Tue, 07 Apr 2009 12:41:46 +0200
Content-Disposition: inline
In-Reply-To: <1239098181-10360-1-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115946>

On Tue, Apr 07, 2009 at 11:56:21AM +0200, Matthieu Moy wrote:
> Otherwise, git complains about not finding a branch to pull from in
> 'branch..merge', which is hardly understandable. While we're there,
> reword the sentences slightly.
> [...]
> +	if [ -z "$curr_branch" ]; then
> +		echo "You asked me to pull without telling me which branch you want"
> +		echo "to merge with, and you are on a detached HEAD, so I cannot"
> [...]

In this case why can't we just do

echo "You are currently not on any branch."

or

echo "git pull cannot be run without arguments unless you are on a branch."

And possibly also something like this:

echo "Usage: git pull <repository> <refspec>."
echo " See git-pull(1) for details."
echo

If you need all the verbosity this error otherwise gives, "detached
HEAD" is probably going to be confusing?

- Finn Arne
