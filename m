From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: add a setting to control the tabstop width
Date: Mon, 3 Mar 2008 23:33:28 +0100
Message-ID: <200803032333.29426.jnareb@gmail.com>
References: <20080303221159.GA6875@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 23:34:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWJEN-00063B-Kb
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 23:34:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736AbYCCWdW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 17:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752683AbYCCWdW
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 17:33:22 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:25483 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501AbYCCWdV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 17:33:21 -0500
Received: by nf-out-0910.google.com with SMTP id g13so202453nfb.21
        for <git@vger.kernel.org>; Mon, 03 Mar 2008 14:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=sG7JG2LFIyF6U5WfQH3pxXovw3FXhIxZ0d9UOiEICSE=;
        b=P40sKpztJLHhuOGkkC3TYxBdSwiiNzl7j9aNoNxhGJZAJS5+P1R5/SMUM2MBjWko3m86TGeL/fMYyjdHO8H1X1VpvC4lEdIXUN4OPj5xuV1Q0hAJpRF2ssC7sp+FtHN7XGfAesSM9RIIzfxGx7+T43Sgj3uzY7d5AMx5uVg7aAg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=vUY2vVs6knVcrj7tSJ0eDJIpUtPk75LSY0VJiGkLq+YlIjffJKiNXeC5KABE9VgaJ+qDrRka/NZfnOesNGssS85fEa/UYyoJcM6F6Xe2OYW7NjRFp32uHAUSPV6NbkuLH9ydRhZ1/AZHe3kfMl5cAmf2MHDlYj62lApNobbLR5k=
Received: by 10.82.153.5 with SMTP id a5mr514873bue.5.1204583599059;
        Mon, 03 Mar 2008 14:33:19 -0800 (PST)
Received: from ?192.168.1.15? ( [83.8.251.32])
        by mx.google.com with ESMTPS id c5sm424649nfi.31.2008.03.03.14.33.15
        (version=SSLv3 cipher=OTHER);
        Mon, 03 Mar 2008 14:33:16 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20080303221159.GA6875@hashpling.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75989>

Charles Bailey <charles@hashpling.org> writes:

> Not everyone uses the same tab width. gitweb learns a new setting to
> control the tabstop width. The configuration can be set globally and
> on a per project basis. The default is 8, preserving existing
> behaviour. The configuration variable name is borrowed from the vim
> setting with the same behaviour.

Good idea. Very nice change.
 
> Signed-off-by: Charles Bailey <charles@hashpling.org>
> ---
> 
> The untabify function seems the sensible place to make the change. As
> untabify is called once per line from various different locations it
> also makes sense to cache the result of the config lookup in a package
> variable, though this makes the change slightly less neat.

Since b201927 (gitweb: Read repo config using 'git config -z -l')
repository config is cached in %config hash (per repository), so
I don't think global / package variable $tabstop_width is really
needed...
 
> This change should have a minimal impact on performance but it would
> appreciate some more eyes and ideally some performance testing on
> heavier systems than my own. 

...but it would be better if you have checked at least on your system
if it does affect performance or not.

[...]

+our $tabstop_width;

I think I would write "our $tabstop_width = 8;" here.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
