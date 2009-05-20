From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC/PATCH] completion: complete pretty format placeholders
Date: Wed, 20 May 2009 15:52:58 -0700
Message-ID: <20090520225258.GT30527@spearce.org>
References: <1242468449-3364-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 21 00:53:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6uet-0006yr-Cr
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 00:53:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756677AbZETWw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 18:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756649AbZETWw5
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 18:52:57 -0400
Received: from george.spearce.org ([209.20.77.23]:55724 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756841AbZETWw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 18:52:57 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9F0C5381FD; Wed, 20 May 2009 22:52:58 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1242468449-3364-1-git-send-email-bebarino@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119639>

Stephen Boyd <bebarino@gmail.com> wrote:
>  This seems to work most of the time.
> 
>  This
>     git log --pretty=format:%ad:%<TAB>
>  becomes
>     git log --pretty=format:%ad:%ad:% 
>  which is wrong.
> 
>  But in quotes
>     git log --pretty=format:"%ad:%<TAB>
>  works.
> 
>  I'm not sure why.

bash oddity?  Back when I started the completion I had a lot
of trouble with stuff like --pretty=<TAB>, or foo:<TAB> because
bash more often than not tried to second guess what I was doing.
I wonder if you are running against that here.
  
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index ad26b7c..3819c73 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1117,6 +1117,9 @@ __git_log_shortlog_options="
>  
>  __git_log_pretty_formats="oneline short medium full fuller email raw format:"
>  __git_log_date_formats="relative iso8601 rfc2822 short local default raw"
> +__git_log_format_placeholders="ad aD ae aE ai an aN ar at b Cblue cd cD ce cE
> +Cgreen ci cn cN cr Cred Creset ct d e f h H m n p P s t T x
> +"

To be honest, I'm not sure what value this provides.  Its just as
many characters to type, isn't it, and it doesn't offer me any help
as to which placeholder should be inserted to get the value I want.
"Was it ae or aE that I wanted here?  WTF, manpage time!".
  
-- 
Shawn.
