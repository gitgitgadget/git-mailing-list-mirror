From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCHv2] gitweb: refactor input parameters parse/validation
Date: Fri, 10 Oct 2008 08:01:08 -0700
Message-ID: <20081010150108.GC29829@spearce.org>
References: <200810071257.38423.jnareb@gmail.com> <1223457985-27094-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 10 17:03:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoJWQ-0001qd-WC
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 17:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761899AbYJJPBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 11:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760844AbYJJPBL
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 11:01:11 -0400
Received: from george.spearce.org ([209.20.77.23]:34205 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761890AbYJJPBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 11:01:09 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id E07B03835F; Fri, 10 Oct 2008 15:01:08 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1223457985-27094-1-git-send-email-giuseppe.bilotta@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97940>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> wrote:
> Since input parameters can be obtained both from CGI parameters and
> PATH_INFO, we would like most of the code to be agnostic about the way
> parameters were retrieved. We thus collect all the parameters into the
> new %input_params hash, delaying validation after the collection is
> completed.

> @@ -672,6 +694,25 @@ sub href (%) {
>  ## ======================================================================
>  ## validation, quoting/unquoting and escaping
>  
> +sub validate_action {
> +	my $input = shift || return undef;
> +	return undef unless exists $actions{$action};
> +	return $action;
> +}

Shouldn't $action here be $input?

-- 
Shawn.
