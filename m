From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH v2] pull: mention "pull", not "fetch" in the error
	message.
Date: Sat, 27 Mar 2010 00:12:10 +0100
Message-ID: <20100326231209.GB6797@blimp.localdomain>
References: <4BACC241.4010608@drmicha.warpmail.net> <1269615836-13995-1-git-send-email-Matthieu.Moy@imag.fr>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sat Mar 27 00:12:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvIhZ-0005Pl-9Z
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 00:12:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754726Ab0CZXMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 19:12:24 -0400
Received: from mout0.freenet.de ([195.4.92.90]:33173 "EHLO mout0.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754463Ab0CZXMX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 19:12:23 -0400
Received: from [195.4.92.17] (helo=7.mx.freenet.de)
	by mout0.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.72 #2)
	id 1NvIhQ-0006Sz-R4; Sat, 27 Mar 2010 00:12:20 +0100
Received: from p57b1a08b.dip0.t-ipconnect.de ([87.177.160.139]:34948 helo=tigra.home)
	by 7.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.72 #2)
	id 1NvIhP-0002Z1-Go; Sat, 27 Mar 2010 00:12:20 +0100
Received: from blimp.localdomain (blimp.home [192.168.0.79])
	by tigra.home (Postfix) with ESMTP id 687B3277DF;
	Sat, 27 Mar 2010 00:12:10 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 266ED36D28; Sat, 27 Mar 2010 00:12:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1269615836-13995-1-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143298>

Matthieu Moy, Fri, Mar 26, 2010 16:03:56 +0100:
> For newbies who've just been taught "git pull", the error message
> "Where do you want to fetch from today?" is indeed confusing. Change it
> to "Where do you want to pull from today?" in case fetch was called from
> pull.
...
> @@ -842,8 +842,12 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
>  	int ref_nr = 0;
>  	int exit_code;
>  
> +	char *cmd = getenv("GIT_USER_COMMAND");

Isn't the variable name a little too generic? USER_COMMAND doesn't make it
clear that its only purpose is to pass a string "pull" to an error message
which is never even seen under normal circumstances.
