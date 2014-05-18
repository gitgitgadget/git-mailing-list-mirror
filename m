From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH] rebase --keep-empty -i: add test
Date: Sun, 18 May 2014 19:18:49 -0400
Message-ID: <20140518231849.GA9149@neilslaptop.think-freely.org>
References: <1400444838-12685-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Mon May 19 01:18:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmALx-00062g-Ew
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 01:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752429AbaERXSp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 19:18:45 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:41680 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbaERXSp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 19:18:45 -0400
Received: from neilslaptop.think-freely.org ([2001:470:8:a08:4a5d:60ff:fe96:79da] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1WmALl-0005N4-Hs; Sun, 18 May 2014 19:18:41 -0400
Content-Disposition: inline
In-Reply-To: <1400444838-12685-1-git-send-email-mst@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249552>

On Sun, May 18, 2014 at 11:28:39PM +0300, Michael S. Tsirkin wrote:
> There's some special code in rebase -i to deal
> with --keep-empty.
> Add test for this combination.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>

> ---
>  t/t3404-rebase-interactive.sh | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index c0023a5..3b1b863 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -67,6 +67,14 @@ test_expect_success 'setup' '
>  SHELL=
>  export SHELL
>  
> +test_expect_success 'rebase --keep-empty' '
> +	git checkout -b emptybranch master &&
> +	git commit --allow-empty -m "empty" &&
> +	git rebase --keep-empty -i HEAD~2 &&
> +	git log --oneline >actual &&
> +	test_line_count = 6 actual
> +'
> +
>  test_expect_success 'rebase -i with the exec command' '
>  	git checkout master &&
>  	(
> -- 
> MST
> 
