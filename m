From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/3] Purest update to bash completions to prevent
	unbounded variable errors.
Date: Tue, 13 Jan 2009 08:34:21 -0800
Message-ID: <20090113163421.GQ10179@spearce.org>
References: <496CBC98.7090101@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 17:36:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMmF1-0008A1-BZ
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 17:35:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053AbZAMQeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 11:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752983AbZAMQeX
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 11:34:23 -0500
Received: from george.spearce.org ([209.20.77.23]:40141 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967AbZAMQeW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 11:34:22 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id B2CAD38210; Tue, 13 Jan 2009 16:34:21 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <496CBC98.7090101@tedpavlic.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105507>

Ted Pavlic <ted@tedpavlic.com> wrote:
>
> First in a series of patches that make bash completions more robust to
> different interactive shell configurations and editors.
>
>
> Signed-off-by: Ted Pavlic <ted@tedpavlic.com>

Your commit message leaves a lot to be desired.  I would instead
have written something like this:

  bash-completion: Support running when set -u is enabled

  Under set -u semenatics it is an error to access undefined
  variables.  Some user environments may enable this in the
  interactive shell.

  In any context where the completion functions access an undefined
  variable, accessing a default empty string (aka "${1-}" instead of
  "$1") is a reasonable way to code the function, as it silences
  the undefined variable error while still supplying an empty string.

Acked-by: Shawn O. Pearce <spearce@spearce.org>

> ---
>  contrib/completion/git-completion.bash |   18 +++++++++---------
>  1 files changed, 9 insertions(+), 9 deletions(-)

-- 
Shawn.
