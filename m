From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Add gitattributes file making whitespace checking
	pickier
Date: Sun, 10 Feb 2008 13:56:49 -0500
Message-ID: <20080210185649.GB8267@fieldses.org>
References: <20080209162234.GA25533@fieldses.org> <alpine.LNX.1.00.0802091251430.13593@iabervon.org> <20080209185038.GB25533@fieldses.org> <7vr6fletkl.fsf@gitster.siamese.dyndns.org> <7vabm9gk1p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 19:57:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOHMq-0005Va-On
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 19:57:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332AbYBJS4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 13:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752375AbYBJS4z
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 13:56:55 -0500
Received: from mail.fieldses.org ([66.93.2.214]:40151 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752201AbYBJS4y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 13:56:54 -0500
Received: from bfields by fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1JOHM9-0002Ui-58; Sun, 10 Feb 2008 13:56:49 -0500
Content-Disposition: inline
In-Reply-To: <7vabm9gk1p.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73389>

On Sun, Feb 10, 2008 at 02:52:50AM -0800, Junio C Hamano wrote:
> I've tried "unexpand | expand" to Documentation/*.txt and
> compared the formatted documentation before and after the
> change, and as we suspected everything seems to match.

Thanks for testing that.

> So I am considering applying this patch.  We may want to tighten
> it later but as the initial set of rules this should do.

No objections from me.--b.

> 
> -- >8 --
> [PATCH] Add gitattributes file making whitespace checking pickier
> 
> This establishes what the "bad" whitespaces are for this
> project.
> 
> The rules are:
> 
>  - For C source files, trailing whitespaces, an HT that follows
>    a SP in the leading indent, and initial indent by SP that can
>    be replaced with HT are all bad.
> 
>  - The same rule applies to the AsciiDoc input files in the
>    Documentation/ hierarchy.
> 
>  - It is Ok to indent with all spaces the Python and Elisp
>    sources in the contrib/ area.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  .gitattributes               |    1 +
>  Documentation/.gitattributes |    1 +
>  contrib/.gitattributes       |    3 +++
>  3 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/.gitattributes b/.gitattributes
> new file mode 100644
> index 0000000..9dd769a
> --- /dev/null
> +++ b/.gitattributes
> @@ -0,0 +1 @@
> +*.[ch] whitespace
> diff --git a/Documentation/.gitattributes b/Documentation/.gitattributes
> new file mode 100644
> index 0000000..ddb0301
> --- /dev/null
> +++ b/Documentation/.gitattributes
> @@ -0,0 +1 @@
> +*.txt whitespace
> diff --git a/contrib/.gitattributes b/contrib/.gitattributes
> new file mode 100644
> index 0000000..2b48d05
> --- /dev/null
> +++ b/contrib/.gitattributes
> @@ -0,0 +1,3 @@
> +*.py whitespace=!indent,trail,space
> +*.el whitespace=!indent,trail,space
> +fast-import/git-p4 whitespace=!indent,trail,space
