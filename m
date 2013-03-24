From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/3] t7800: fix tests when difftool uses --no-symlinks
Date: Sun, 24 Mar 2013 02:20:27 -0400
Message-ID: <CAPig+cSjCkghxk50d-g89JUcRTi+mWWsNJ-MQsngdsOWrjuLgA@mail.gmail.com>
References: <cover.1363980749.git.john@keeping.me.uk>
	<cover.1364045138.git.john@keeping.me.uk>
	<e44349728c07d8ae22d4b73527b1d124b49cc4a9.1364045138.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Mar 24 07:21:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJeIi-0004eN-GR
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 07:21:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752774Ab3CXGU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 02:20:28 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:52883 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475Ab3CXGU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 02:20:28 -0400
Received: by mail-ie0-f172.google.com with SMTP id c10so6225751ieb.17
        for <git@vger.kernel.org>; Sat, 23 Mar 2013 23:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=tC4dCYf4UZ+FfwMNbOUQP8H6qWcZ4dx/nVstUwO7YHc=;
        b=VnOiGF2oOAYm7dfDN+PteJYiBP1vYwxQOlZSZj0ixt8iP11fN5dkdVBWVnr344UojX
         DmydoArD2ytUt1PUwefzQriw83liQ43YIBwv2vpPqUelWpwt7vvj/DyZkh5EBHLCsLX6
         TYNcsuXhZ1q1cNZaZ34SzfcayiQqbKRBSAwypr8t/fTB3biqR4ASDussk06+PdhulUtr
         5+XvNFP8mwmhJRw/SNnxFtmc1QppjW1p5JEXrVFP2cfVC991oRe9D/nkQT5qQ6PliKkV
         6+KsCTE3ZchXv36czB7IW/jVHWaK10HSL5WdQEVJlkc6UfvgEBCSSMjv5DR1H/HldFDF
         e5Lg==
X-Received: by 10.50.191.133 with SMTP id gy5mr8723005igc.50.1364106027425;
 Sat, 23 Mar 2013 23:20:27 -0700 (PDT)
Received: by 10.64.23.239 with HTTP; Sat, 23 Mar 2013 23:20:27 -0700 (PDT)
In-Reply-To: <e44349728c07d8ae22d4b73527b1d124b49cc4a9.1364045138.git.john@keeping.me.uk>
X-Google-Sender-Auth: oJn8plOeWh35mxtommSiQItjQlo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218939>

On Sat, Mar 23, 2013 at 9:31 AM, John Keeping <john@keeping.me.uk> wrote:
> 1) the shell opens "output" to redirect the difftool output
> 2) difftool copies the empty "output" to the temporary directory
> 3) difftool runs "ls" which writes to "output"
> 4) difftool copies the empty "output" file back over the output of the
>    command
> 5) the output files doesn't contain the expected output, causing the

s/files doesn't/file doesn't/

>    test to fail
>
> Instead of adding all changes, explicitly add only the files that the
> test is using, allowing later tests to write their result files into the
> working tree.
>
> In the longer term, difftool probably needs to learn to warn the user
> instead of overwrite any changes that have been made to the working tree

s/overwrite/overwriting/

> file.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>
