From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/4] fast-import: define a new option command
Date: Thu, 13 Aug 2009 07:43:27 -0700
Message-ID: <20090813144327.GK1033@spearce.org>
References: <1250140186-12363-1-git-send-email-srabbelier@gmail.com> <1250140186-12363-2-git-send-email-srabbelier@gmail.com> <1250140186-12363-3-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 16:43:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbbWq-0004ds-De
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 16:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753895AbZHMOn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 10:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752907AbZHMOn0
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 10:43:26 -0400
Received: from george.spearce.org ([209.20.77.23]:42660 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbZHMOn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 10:43:26 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9BDA9381FD; Thu, 13 Aug 2009 14:43:27 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1250140186-12363-3-git-send-email-srabbelier@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125823>

Sverre Rabbelier <srabbelier@gmail.com> wrote:
> This allows the frontend to specify any of the supported options as
> long as no non-option command has been given.
> ---
> 
>     As requested, updated the documentation of the language format
> 
>  Documentation/git-fast-import.txt |   23 +++++++++++++++++++++++
>  1 files changed, 23 insertions(+), 0 deletions(-)

Why isn't this new 'option' command actually implemented by this
patch?  Please introduce docs and code in the same patch if you can,
especially when it is this simple.
 
> diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
> index c2f483a..6b5bc1b 100644
> --- a/Documentation/git-fast-import.txt
> +++ b/Documentation/git-fast-import.txt
> @@ -303,6 +303,11 @@ and control the current import process.  More detailed discussion
>  	standard output.  This command is optional and is not needed
>  	to perform an import.
>  
> +`option`::
> +    Specify any of the options listed under OPTIONS to change
> +    fast-import's behavior to suit the frontends needs. This command
> +    is optional and is not needed to perform an import.

s/frontends/frontend's/

> +`option`
> +~~~~~~~~
> +Processes the specified option so that git fast-import behaves in a
> +way that suits the front-ends needs.

s/front-ends/frontend's/

> +Note that options specified by the frontend override any options the
> +user may specify to git fast-import itself.

Hmmph.  Do we really want that?  I would think the command line
options should override the stream, such that we can then do
something like:

  hg fast-export >foo
  git fast-import --export-marks=mymarks <foo

even though 'option export-marks=bar' appears in foo.

-- 
Shawn.
