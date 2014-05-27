From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v3 2/5] commit test: Change $PWD to $(pwd)
Date: Tue, 27 May 2014 07:46:59 +0200
Message-ID: <538426D3.8090107@viscovery.net>
References: <20140525062427.GA94219@sirius.att.net> <1401130586-93105-1-git-send-email-caleb@calebthompson.io> <1401130586-93105-3-git-send-email-caleb@calebthompson.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Jeremiah Mahler <jmmahler@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Caleb Thompson <cjaysson@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 07:47:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpAEE-0007xZ-06
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 07:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334AbaE0FrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 01:47:11 -0400
Received: from so.liwest.at ([212.33.55.23]:33543 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751713AbaE0FrI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 01:47:08 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WpAE1-0002vU-Nj; Tue, 27 May 2014 07:47:01 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 4584316613;
	Tue, 27 May 2014 07:47:01 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <1401130586-93105-3-git-send-email-caleb@calebthompson.io>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250141>

Am 5/26/2014 20:56, schrieb Caleb Thompson:
> Signed-off-by: Caleb Thompson <caleb@calebthompson.io>
> ---
>  t/t7507-commit-verbose.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
> index 6d778ed..3b06d73 100755
> --- a/t/t7507-commit-verbose.sh
> +++ b/t/t7507-commit-verbose.sh
> @@ -8,7 +8,7 @@ cat >check-for-diff <<EOF
>  exec grep '^diff --git' "\$1"
>  EOF
>  chmod +x check-for-diff
> -test_set_editor "$PWD/check-for-diff"
> +test_set_editor "$(pwd)/check-for-diff"
>  
>  cat >message <<'EOF'
>  subject

Why? I see no benefit. Both $PWD and $(pwd) work fine everywhere,
including Windows, and the former is faster, particularly on Windows.

-- Hannes
