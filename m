From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] t9118: avoid PEG revision identifier in tests
Date: Thu, 08 Jul 2010 15:33:27 -0400
Message-ID: <4C362807.80703@gmail.com>
References: <4C361EB5.7010704@drmicha.warpmail.net> <2f9f1bd8efb818456fcc386f419fc17f4e435e19.1278616418.git.git@drmicha.warpmail.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Wong <normalperson@yhbt.net>,
	Torsten Schmutzler <git-ts@theblacksun.eu>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jul 08 21:33:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWwqm-00088o-Q3
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 21:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756019Ab0GHTdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 15:33:31 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:43693 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755869Ab0GHTdb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 15:33:31 -0400
Received: by gwj18 with SMTP id 18so211035gwj.19
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 12:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=TLobiN0SiVDeGu24ibbrwguqFkchu06OVJ8mUilFwm4=;
        b=GmTZupTX2zGi5OwcToDD8aBX4s1mWGGWHAJPhdWeIzubgbO+wUHWHGfikxxvFHdT2K
         EILNPUORt4Hs4g+uhBwcJWavpnF+YR3L5U8MVMzK2NlDa3rD4rHH0WlXfbfC6R5m12km
         VetwMSlLduHbC9+Q2LNfxTxvCktqfte50m6eY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=oAj4Qqapqaa1StDBcDMbTErVs5N82gLlxMexWjy2L8P6FMYLbq7l8pDdUUOfkZ6FU1
         sUt0GBkOuZgP97o1SEGtbkmifcEEFffQwZ5OVIbMq0R1WFYz6jA9NiRHVrCU9AGzKgK2
         hPzmPcbQ+QnMtG1wNp0k3/nznUAvZ6gOFkru8=
Received: by 10.151.72.36 with SMTP id z36mr856043ybk.221.1278617610250;
        Thu, 08 Jul 2010 12:33:30 -0700 (PDT)
Received: from [10.0.1.133] ([24.129.111.166])
        by mx.google.com with ESMTPS id q1sm72839ybk.8.2010.07.08.12.33.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Jul 2010 12:33:29 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10) Gecko/20100620 Icedove/3.0.5
In-Reply-To: <2f9f1bd8efb818456fcc386f419fc17f4e435e19.1278616418.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150603>

On 07/08/2010 03:16 PM, Michael J Gruber wrote:
> @ is SVN's identifier for PEG revisions. But SVN's treatment of PEG
> identifiers in copy target URLs changed in r954995/r952973, i.e. between
> 1.6.11 and 1.6.12. They get eaten now (which is considered the right
> way).
>
> Therefore, avoid the @ in the tests with funky branch names.
>
> Signed-off-by: Michael J Gruber<git@drmicha.warpmail.net>
> ---
> This version is tested with svn 1.6.9 and 1.6.12.
>
>   t/t9118-git-svn-funky-branch-names.sh |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/t/t9118-git-svn-funky-branch-names.sh b/t/t9118-git-svn-funky-branch-names.sh
> index 7d7acc3..45d5b2d 100755
> --- a/t/t9118-git-svn-funky-branch-names.sh
> +++ b/t/t9118-git-svn-funky-branch-names.sh
> @@ -28,7 +28,7 @@ test_expect_success 'setup svnrepo' '
>   	svn_cmd cp -m "trailing .lock" "$svnrepo/pr ject/trunk" \
>   			"$svnrepo/pr ject/branches/trailing_dotlock.lock"&&
>   	svn_cmd cp -m "reflog" "$svnrepo/pr ject/trunk" \
> -			"$svnrepo/pr ject/branches/not-a@{0}reflog"&&
> +			"$svnrepo/pr ject/branches/not-a%40{0}reflog"&&
>   	start_httpd
>   	'
>

With this patch, 'make test' now passes, and make -j4 test' does also.
