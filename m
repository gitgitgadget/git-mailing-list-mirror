From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] Document toplevel gitconfig file
Date: Sat, 27 Nov 2010 09:52:02 -0600
Message-ID: <20101127155202.GA25598@burratino>
References: <cover.1290870041.git.nathan.panike@gmail.com>
 <f15d6598e5e90de3bcdb8caf706735ac4809ad36.1290870042.git.nathan.panike@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Nathan W. Panike" <nathan.panike@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 27 17:02:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMNEI-0002Go-Sv
	for gcvg-git-2@lo.gmane.org; Sat, 27 Nov 2010 17:02:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744Ab0K0PwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Nov 2010 10:52:14 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:37848 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752553Ab0K0PwN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Nov 2010 10:52:13 -0500
Received: by gwj20 with SMTP id 20so1356742gwj.19
        for <git@vger.kernel.org>; Sat, 27 Nov 2010 07:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=4ikcpAjVLhYw3Sv/bZMU/xGIibqGyhU+6i/LlONZ/3A=;
        b=WhHEg1Sv+bEcxcZ5LCS03z9lQZpdw/20/x2qhxQc83CFMiMETdo8VEBf+z22xGImXR
         W6cZGgBwZJXAqiIE3QOFxx1+1fFDaeRSAvkQKt0v0hPb+xiE/v97d7JLka1T3oIkt+gt
         LM3g5Tgn6ZR589iZE7LKY+92WukaR8dCnOXiw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UkORiiHXzfTR46ecLMhgy1Ix8Myi94R6cao+sMk1F2h4JL0idyE48ctUDwNyqFzmA8
         e//HHc/1WZUODjd0XIyu6LcQYVZ0nwoZMUiBP9OuZxK2cge+8WpFhT6WCEUCBtO4f9xd
         y5WcUy6F/ef6Q+xVLcGXaSjRfTRhvI/hJiVWY=
Received: by 10.150.191.9 with SMTP id o9mr6988581ybf.444.1290873132918;
        Sat, 27 Nov 2010 07:52:12 -0800 (PST)
Received: from burratino (adsl-68-255-101-216.dsl.chcgil.ameritech.net [68.255.101.216])
        by mx.google.com with ESMTPS id y29sm1975169yhc.0.2010.11.27.07.52.09
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 27 Nov 2010 07:52:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <f15d6598e5e90de3bcdb8caf706735ac4809ad36.1290870042.git.nathan.panike@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162312>

Nathan W. Panike wrote:

> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -8,6 +8,17 @@ is used to store the configuration for that repository, and
>  fallback values for the `.git/config` file. The file `/etc/gitconfig`
>  can be used to store a system-wide default configuration.
>  
> +One can also create a `.gitconfig` file in the toplevel of the
> +repository. This config file will then be propogated to collaborators
> +when they pull from your repository.  Only `alias` config variables are
> +allowed to be set in this `.gitconfig` file.  One can turn off the
> +shared `.gitconfig` by setting the environment variable
> +'GIT_CONFIG_NOSHARED' to 1; it will then be propogated but will not be
> +used for configuration settings.

Please no.  Why not set up aliases in a setup-aliases.sh script and
mention it in your README?

If I clone a repository to investigate it and then a typo results in

	$ git lgo

emptying my $HOME directory, I would not call that a feature.
