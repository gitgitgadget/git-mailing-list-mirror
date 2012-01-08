From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/6] revert: decouple sequencer actions from builtin
 commands
Date: Sun, 8 Jan 2012 13:34:54 -0600
Message-ID: <20120108193454.GG1942@burratino>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326025653-11922-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 08 20:29:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjyRD-0007rc-G9
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 20:29:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753985Ab2AHT3r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 14:29:47 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34456 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752212Ab2AHT3q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 14:29:46 -0500
Received: by iaeh11 with SMTP id h11so5652589iae.19
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 11:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=77QgU3Lnm/af2tDZCT2rTXJGqLeSW4riuwlSdOM4Vk4=;
        b=hVkmGunOV6bdUcM2aHfXw5TyW4T9HCiBKv7UYb+2a+yCsJhqGDMweLPKx6M3Xqpp1A
         eoYDX1TVmI0KWsuCyalhKULGs20ge820IKNMYNggZWXv2uUYRbdW3aJ01JpKGTJyjE0P
         eABeyfjilIQ0CbObgDpCgjC91H970vK094Ayo=
Received: by 10.50.41.131 with SMTP id f3mr6644154igl.28.1326050986106;
        Sun, 08 Jan 2012 11:29:46 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id l28sm241697873ibc.3.2012.01.08.11.29.45
        (version=SSLv3 cipher=OTHER);
        Sun, 08 Jan 2012 11:29:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1326025653-11922-3-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188117>

Ramkumar Ramachandra wrote:

>                                                  So, while a future
> instruction sheet would look like:
>
>   pick next~4
>   action3 b74fea
>   revert rr/moo^2~34
>
> the actions "pick", "action3" and "revert" need not necessarily
> correspond to the specific builtins.

So what change does the patch actually make?  Is this a renaming?

[...]
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
[...]
> @@ -64,16 +64,21 @@ struct replay_opts {
>  
>  #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
>  
> -static const char *action_name(const struct replay_opts *opts)
> +static const char *command_name(struct replay_opts *opts)

Why is the const being dropped?  I'm lost, so not reading further.
