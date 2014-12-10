From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] gitignore.txt: do not suggest assume-unchanged
Date: Tue, 9 Dec 2014 17:06:58 -0800
Message-ID: <20141210010658.GD16345@google.com>
References: <5486B342.8090800@drmicha.warpmail.net>
 <fe381f27dd50afd44d451577e2315ed5580e3034.1418123458.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?iso-8859-1?Q?S=E9rgio?= Basto <sergio@serjux.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Philip Oakley <philipoakley@iee.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Dec 10 02:07:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyVkD-0007Fp-SJ
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 02:07:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570AbaLJBHD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 20:07:03 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:39870 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbaLJBHB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 20:07:01 -0500
Received: by mail-ie0-f178.google.com with SMTP id tp5so1747637ieb.9
        for <git@vger.kernel.org>; Tue, 09 Dec 2014 17:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ZC8hUkz6m8K4sWuLMInYBxa4d/ReXl3vTbcBbOo2S48=;
        b=sBsO1ip59/ORUCqEnzc/6QgJcsNeIEAxMt4Za2WOPczoA9WC/pgqaZJCD05kX7PUgw
         C3pzqcagvzWbzVj2xC+9wxOBBq2FBNS5VJgMVIBMUxDN7sVX6/Jfl94sqDDHgQkcDr0T
         Mhg6lr46KuwFJkNKhrPAqWkWKNPIbNoDYVK8yedtmEfuj2XO/eNgi0hxedu9SKHxbgoz
         HfJWyeX+sgOJL5E3tAgDH9lYwam0cyM93od7BAz3vGlhvqGaVHiCMZDoIxzZ/Ym5KXT5
         msy3J0n4tpcaL3i4RJlRnxy5LjR+ie5S+AzS2wHGBShqKrBPx1UY9CPzFEHBf9Gk3gKL
         cRwA==
X-Received: by 10.107.4.143 with SMTP id 137mr486186ioe.48.1418173620791;
        Tue, 09 Dec 2014 17:07:00 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:a4ec:4fac:afb2:e506])
        by mx.google.com with ESMTPSA id f187sm1464915ioe.11.2014.12.09.17.06.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Dec 2014 17:07:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <fe381f27dd50afd44d451577e2315ed5580e3034.1418123458.git.git@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261185>

Michael J Gruber wrote:

> git-update-index --assume-unchanged was never meant to ignore changes
> to tracked files (only to spare some stats). So do not suggest it
> as a means to achieve that.
[...]
> +++ b/Documentation/gitignore.txt
> @@ -138,9 +138,6 @@ NOTES
>  The purpose of gitignore files is to ensure that certain files
>  not tracked by Git remain untracked.
>  
> -To ignore uncommitted changes in a file that is already tracked,
> -use 'git update-index {litdd}assume-unchanged'.
> -
>  To stop tracking a file that is currently tracked, use
>  'git rm --cached'.

Makes sense.

But we need some advice to replace the paragraph you are deleting.  Is
the idea something like

	Git will not ignore uncommitted changes in a file that is already tracked.
	If you have time to work on that, please contact git@vger.kernel.org.

(perhaps without that second line)?

Thanks,
Jonathan
