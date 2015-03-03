From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: [PATCH] git: make was_alias and done_help non-static
Date: Tue, 3 Mar 2015 11:58:49 +0100
Message-ID: <54F593E9.2070209@atlas-elektronik.com>
References: <1425297757-16431-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Alexander Kuleshov <kuleshovmail@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 03 12:07:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSkfs-0004gB-4S
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 12:07:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756225AbbCCLHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 06:07:35 -0500
Received: from mail96.atlas.de ([194.156.172.86]:19592 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754385AbbCCLHf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 06:07:35 -0500
X-Greylist: delayed 512 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Mar 2015 06:07:34 EST
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 26EA91067C;
	Tue,  3 Mar 2015 11:59:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IDq_YgstPHj8; Tue,  3 Mar 2015 11:58:50 +0100 (CET)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Tue,  3 Mar 2015 11:58:50 +0100 (CET)
Received: from MSSRVS1.atlas.de (mssrvs1.atlas.de [10.200.101.71])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 9972D27169;
	Tue,  3 Mar 2015 11:58:49 +0100 (CET)
Received: from [10.200.54.122] (10.200.54.122) by MSSRVS1.atlas.de
 (10.200.101.71) with Microsoft SMTP Server id 8.3.327.1; Tue, 3 Mar 2015
 11:58:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <1425297757-16431-1-git-send-email-kuleshovmail@gmail.com>
OpenPGP: id=922127AF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264648>

Am 02.03.2015 um 13:02 schrieb Alexander Kuleshov:
> 'was_alias' variable does not need to store it's value on each
> iteration in the loop, anyway this variable changes it's value with run_argv.

s/it's/its/


> 'done_help' variable does not need to be static variable too if we'll move it
> out the loop.
> 
> So these variables do not need to be static.
> 
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  git.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/git.c b/git.c
> index 1780233..96723b8 100644
> --- a/git.c
> +++ b/git.c
> @@ -619,6 +619,7 @@ int main(int argc, char **av)
>  {
>  	const char **argv = (const char **) av;
>  	const char *cmd;
> +	int done_help, was_alias;
>  
>  	startup_info = &git_startup_info;
>  
> @@ -681,8 +682,6 @@ int main(int argc, char **av)
>  	setup_path();
>  
>  	while (1) {
> -		static int done_help = 0;
> -		static int was_alias = 0;
>  		was_alias = run_argv(&argc, &argv);
>  		if (errno != ENOENT)
>  			break;
> 

/S
-- 
----------------------------------------------------------------
/dev/random says: Recovery program for excessive talkers: On-and-on-Anon.
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6e696b2e636f6d'.decode('hex')" 
GPG Key fingerprint = 2DF5 E01B 09C3 7501 BCA9  9666 829B 49C5 9221 27AF
