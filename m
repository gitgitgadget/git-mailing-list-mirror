From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] git send-email: include [anything]-by: signatures
Date: Sat, 31 Aug 2013 22:22:50 +0300
Message-ID: <20130831192250.GA3823@redhat.com>
References: <20130826165747.GA30788@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 31 21:21:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFqjH-0004Y1-Hv
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 21:21:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889Ab3HaTUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 15:20:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44627 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752554Ab3HaTUt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 15:20:49 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r7VJKmW2030646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sat, 31 Aug 2013 15:20:48 -0400
Received: from redhat.com (vpn1-7-65.ams2.redhat.com [10.36.7.65])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id r7VJKkah015248;
	Sat, 31 Aug 2013 15:20:47 -0400
Content-Disposition: inline
In-Reply-To: <20130826165747.GA30788@redhat.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233543>

On Mon, Aug 26, 2013 at 07:57:47PM +0300, Michael S. Tsirkin wrote:
> Consider [anything]-by: a valid signature.
> This includes Tested-by: Acked-by: Reviewed-by: etc.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Ping.
Any opinion on whether this change is acceptable?

> ---
>  git-send-email.perl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/git-send-email.perl b/git-send-email.perl
> index ecbf56f..bb9093b 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1359,7 +1359,7 @@ foreach my $t (@files) {
>  	# Now parse the message body
>  	while(<$fh>) {
>  		$message .=  $_;
> -		if (/^(Signed-off-by|Cc): (.*)$/i) {
> +		if (/^([A-Za-z-]*-by|Cc): (.*)$/i) {
>  			chomp;
>  			my ($what, $c) = ($1, $2);
>  			chomp $c;
> -- 
> MST
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
