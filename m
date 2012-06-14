From: "Simon.Cathebras" <Simon.Cathebras@ensimag.imag.fr>
Subject: Re: [PATCH 3/3] Explicit error when curl_exec() fails
Date: Thu, 14 Jun 2012 11:23:43 +0200
Message-ID: <4FD9AD9F.5050708@ensimag.imag.fr>
References: <1339607025-22725-1-git-send-email-simon.cathebras@ensimag.imag.fr> <1339664243-31952-1-git-send-email-Matthieu.Moy@imag.fr> <1339664243-31952-4-git-send-email-Matthieu.Moy@imag.fr>
Reply-To: Simon.Cathebras@ensimag.imag.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Julien.Khayat@ensimag.imag.fr,
	Simon.Perrat@ensimag.imag.fr, Charles.Roussel@ensimag.imag.fr,
	Guillaume.Sasdy@ensimag.imag.fr
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 14 11:24:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sf6Ho-0003Xm-CY
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 11:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755362Ab2FNJYM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jun 2012 05:24:12 -0400
Received: from mx1.imag.fr ([129.88.30.5]:42617 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755429Ab2FNJXo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 05:23:44 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5E9NgJs004002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 14 Jun 2012 11:23:42 +0200
Received: from [IPv6:::1] (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q5E9NfDM027022;
	Thu, 14 Jun 2012 11:23:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <1339664243-31952-4-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 14 Jun 2012 11:23:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5E9NgJs004002
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: simon.cathebras@ensimag.imag.fr
MailScanner-NULL-Check: 1340270623.2213@p6jcxxXISZ4bnvS3lyq9YQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199988>



On 14/06/2012 10:57, Matthieu Moy wrote:
> Signed-off-by: Matthieu Moy<Matthieu.Moy@imag.fr>
> ---
>   contrib/mw-to-git/t/install-wiki/db_install.php | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/contrib/mw-to-git/t/install-wiki/db_install.php b/contri=
b/mw-to-git/t/install-wiki/db_install.php
> index b34772a..99d24e0 100644
> --- a/contrib/mw-to-git/t/install-wiki/db_install.php
> +++ b/contrib/mw-to-git/t/install-wiki/db_install.php
> @@ -41,6 +41,9 @@ function get ($page_name =3D "") {
>           curl_setopt($curl, CURLOPT_URL, $url);
>
>           $page =3D curl_exec($curl);
> +	if (!$page) {
> +		die ("Could not get page: $url\n");
> +	}
>           curl_close($curl);
>           return $page;
>   }
Seems legitimate.

But there is a whitespace/indentation problem isn't it ?

--=20
CATHEBRAS Simon

2A-ENSIMAG

=46ili=E8re Ing=E9ni=E9rie des Syst=E8mes d'Information
Membre Bug-Buster
