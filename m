From: Mike Hommey <mh@glandium.org>
Subject: Re: Score in diff-format
Date: Thu, 29 Jan 2015 10:22:11 +0900
Message-ID: <20150129012211.GA11678@glandium.org>
References: <20150128062309.GA29506@glandium.org>
 <54C8F306.1000001@drmicha.warpmail.net>
 <xmqqk306fvvk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 02:22:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGdoc-00047F-00
	for gcvg-git-2@plane.gmane.org; Thu, 29 Jan 2015 02:22:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754426AbbA2BWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2015 20:22:34 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:41289 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753080AbbA2BWc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2015 20:22:32 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1YGdoB-00034j-9Z; Thu, 29 Jan 2015 10:22:11 +0900
Content-Disposition: inline
In-Reply-To: <xmqqk306fvvk.fsf@gitster.dls.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263128>

On Wed, Jan 28, 2015 at 01:17:19PM -0800, Junio C Hamano wrote:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
> > I'd say it depends on the definition of "so". The documentation is
> > correct if you read "so" as "*always* followed by a score". I guess you
> > read it as "followed by a score".
> 
> I read it so as well ;-)
> 
> > Percentages with M are not mentioned in diff-format, but they are a
> > consequence of "-B" processing. Maybe we could mention that?
> 
> -- >8 --
> Subject: diff-format doc: a score can follow M for rewrite
> 
> b6d8f309 (diff-raw format update take #2., 2005-05-23) started
> documenting the diff format, and it said
> 
>  ...
>  (8) sha1 for "dst"; 0{40} if creation, unmerged or "look at work tree".
>  (9) status, followed by similarlity index number only for C and R.
>  (10) a tab or a NUL when '-z' option is used.
>  ...
> 
> because C and R _were_ the only ones that came with a number back
> then.  This was corrected by ddafa7e9 (diff-helper: Fix R/C score
> parsing under -z flag., 2005-05-29) and we started saying "score"
> instead of "similarlity index" (because we can have other kind of
> score there), and stopped saying "only for C and R" (because Git is
> an ever evolving system).  Later f345b0a0 ([PATCH] Add -B flag to
> diff-* brothers., 2005-05-30) introduced a new concept,
> "dissimilarity" score and it did not have to fix any documentation.
> 
> The current text that says only C and R can have scores came
> independently from a5a323f3 (Add reference for status letters in
> documentation., 2008-11-02) and it was wrong from the day one.
> 
> Noticed-by: Mike Hommey
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  Documentation/diff-format.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
> index 15c7e79..e6cfc9b 100644
> --- a/Documentation/diff-format.txt
> +++ b/Documentation/diff-format.txt
> @@ -66,7 +66,8 @@ be committed)
>  
>  Status letters C and R are always followed by a score (denoting the
>  percentage of similarity between the source and target of the move or
> -copy), and are the only ones to be so.
> +copy).  M may show how completely the modification rewrites the file
> +with a score (denoting the percentage of dissimilarity).

How about something like:

  Status letter M may be followed by a score (denoting the percentage of
  dissimilarity) for file rewrites.

Mike
