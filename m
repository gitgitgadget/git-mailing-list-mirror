From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 07/18] revert: Eliminate global "commit" variable
Date: Wed, 27 Jul 2011 06:43:41 +0200
Message-ID: <20110727044341.GE18470@elie>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-8-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 06:43:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlvyP-00089n-GQ
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 06:43:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210Ab1G0Enw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 00:43:52 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:53945 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736Ab1G0Env (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 00:43:51 -0400
Received: by ewy4 with SMTP id 4so1028913ewy.19
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 21:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0rD8W6hDVPgyJ6q5+yw6mPUWI7uTWwDVlsenUfgC55g=;
        b=w6GJ5UQLKMFrdR3+lZuxLhUbWmy4cNeTEeRh5eZ0BSG307dnXcT7ZU7bhHTDFleTws
         BsGzygJvmfWcFP5B3DQZ5qrnIqXbrhobLA6ubk9QJidVG3yVpZ2oY/6AdpdPGMGtB6UB
         B66Vu9iUeJE1Egy26mm/024RQBygWyHOeikBM=
Received: by 10.213.98.202 with SMTP id r10mr2704208ebn.86.1311741830383;
        Tue, 26 Jul 2011 21:43:50 -0700 (PDT)
Received: from elie (adsl-165-157-240.teol.net [109.165.157.240])
        by mx.google.com with ESMTPS id s55sm818618eeb.25.2011.07.26.21.43.48
        (version=SSLv3 cipher=OTHER);
        Tue, 26 Jul 2011 21:43:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1311736755-24205-8-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177927>

Ramkumar Ramachandra wrote:

> Functions which act on commits currently rely on a file-scope static
> variable to be set before they're called.  Consequently, the API and
> corresponding callsites are ugly and unclear.  Remove this variable
> and change their API to accept the commit to act on as additional
> argument so that the callsites change from looking like
>
> commit = prepare_a_commit();
> act_on_commit();
>
> to looking like
>
> commit = prepare_a_commit();
> act_on_commit(commit);

Very sane, and from a cursory look, it seems to be implemented well.

Tiny commit message nit: code, diagrams, and other text for which line
breaks are significant are more easily read when indented so the
reader knows you are not just editing with a funny line width (e.g.,
grepping for : at ends of lines in the pager shown by "git log" should
show some examples).
