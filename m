From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] pull: use git-rev-parse --parseopt for option parsing
Date: Mon, 18 May 2015 16:43:49 +0200
Organization: gmx
Message-ID: <389cf040410c499b2f382bfbcdb526d4@www.dscho.org>
References: <1431957296-31534-1-git-send-email-pyokagan@gmail.com>
 <1431957296-31534-3-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 18 16:44:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuMGr-0000fs-Rh
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 16:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710AbbEROny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 10:43:54 -0400
Received: from mout.gmx.net ([212.227.17.21]:61148 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752387AbbEROnx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 10:43:53 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Ll0tl-1ZUFRz0puf-00apTo; Mon, 18 May 2015 16:43:50
 +0200
In-Reply-To: <1431957296-31534-3-git-send-email-pyokagan@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:C0KBuqrARHwiPGS35fMv6yTMUlZ4CxTZo+/HPUT9LhEOevFDlcl
 lKtDxxITf9dSMCKg0fZdTXAECDyoR1tRo6XnUXZEX+CZGmOdQIOU1g4dTFF85Cki5SJ6r5w
 aY6FD7AaLJlct6OrGEJa9ih0PMaq7MQxPYFYDSi3fmndmjts6rsr01aqBDIuzoRbl1cjfal
 Q1X+4nQ73HSYz1gMDasgA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269254>

Hi Paul,

On 2015-05-18 15:54, Paul Tan wrote:

> diff --git a/git-pull.sh b/git-pull.sh
> index 633c385..67f825c 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -4,13 +4,53 @@
>  #
>  # Fetch one or more remote refs and merge it/them into the current HEAD.
>  
> -USAGE='[-n | --no-stat] [--[no-]commit] [--[no-]squash]
> [--[no-]ff|--ff-only] [--[no-]rebase|--rebase=preserve] [-s
> strategy]... [<fetch-options>] <repo> <head>...'
> -LONG_USAGE='Fetch one or more remote refs and integrate it/them with
> the current HEAD.'
>  SUBDIRECTORY_OK=Yes
> -OPTIONS_SPEC=
> +OPTIONS_KEEPDASHDASH=Yes

I have to admit that I was puzzled by this at first. But it seems that the intention is to handle a dashdash argument as an error, therefore we have to keep it. Is my understanding correct?

Ciao,
Dscho
