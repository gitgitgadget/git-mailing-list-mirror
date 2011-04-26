From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] t0081-*.sh: Fix failure of the 'long read' tests
Date: Tue, 26 Apr 2011 14:35:39 -0500
Message-ID: <20110426193539.GA2616@elie>
References: <4DB70972.20308@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Apr 26 21:35:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEo35-00032P-Tw
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 21:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755334Ab1DZTfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 15:35:46 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46431 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753912Ab1DZTfq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 15:35:46 -0400
Received: by iwn34 with SMTP id 34so787546iwn.19
        for <git@vger.kernel.org>; Tue, 26 Apr 2011 12:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=/9gGRJFE8MYyG+GIYfNvbPQF1POGda4PlwwGHU2iYDo=;
        b=koXphxTFpYXzge4Lp2fx8jvnljXU7BIx8BW/qe9atiGK1hqDsJNIz0J+NnkMUKRTnz
         OsvYQ9vlfIlWGEbi9FhezR58uFTz96h6PAI5mYnNyZ0rlGtxUwJEBI0o1XlUsnygxI6d
         xpHP0uxUneCYqXXaf+d6j5MCmjZh661XLA89Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ZbqsN59elxsmLl9TXed/hIfUolzPWBXWWyjOXBaXGsXAsr0MYmP3EOrQSa0o9uEQ7Z
         0ocHJ3YyhMDYnGfYVNgS0W5RhQpZVaYEvv6kWATkP09JgItSh1FO085DHNhm3IGmUYlw
         BztGtxWMNYyksURcptYd8rxUrwC6niirY+uQ4=
Received: by 10.43.57.16 with SMTP id we16mr1488021icb.130.1303846545619;
        Tue, 26 Apr 2011 12:35:45 -0700 (PDT)
Received: from elie (adsl-68-255-96-190.dsl.chcgil.ameritech.net [68.255.96.190])
        by mx.google.com with ESMTPS id d9sm15862ibb.19.2011.04.26.12.35.43
        (version=SSLv3 cipher=OTHER);
        Tue, 26 Apr 2011 12:35:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4DB70972.20308@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172123>

Ramsay Jones wrote:

> --- a/t/t0081-line-buffer.sh
> +++ b/t/t0081-line-buffer.sh
> @@ -25,8 +25,7 @@ generate_tens_of_lines () {
>  		do
>  			echo "$line"
>  		done &&
> -		: $((i = $i + 1)) ||
> -		return
> +		i=$(($i + 1))
>  	done

This test is a mess.  Could you try the patch from the tip of

	git://repo.or.cz/git/jrn.git svn-fe

which just gets rid of it instead?

Thanks for a reminder.
