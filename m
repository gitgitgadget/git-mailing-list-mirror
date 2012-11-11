From: Max Horn <max@quendi.de>
Subject: Re: [PATCH v5 11/15] remote-testgit: make clear the 'done' feature
Date: Sun, 11 Nov 2012 21:49:06 +0100
Message-ID: <29291552-880A-4FEB-88E0-A73A1C7742F7@quendi.de>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com> <1352642392-28387-12-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 21:49:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXeTH-0001ui-Vn
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 21:49:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466Ab2KKUtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 15:49:22 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:34751 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751642Ab2KKUtV convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 15:49:21 -0500
X-Greylist: delayed 566 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Nov 2012 15:49:21 EST
Received: from ip-178-200-227-112.unitymediagroup.de ([178.200.227.112] helo=[192.168.178.28]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1TXeSo-00022K-To; Sun, 11 Nov 2012 21:49:06 +0100
In-Reply-To: <1352642392-28387-12-git-send-email-felipe.contreras@gmail.com>
X-Mailer: Apple Mail (2.1283)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1352666961;298f7ea8;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209444>


On 11.11.2012, at 14:59, Felipe Contreras wrote:

> People seeking for reference would find it useful.

Hm, I don't understand this commit message. Probably means I am just too dumb, but since I am one of those people who would likely be seeking for reference, I would really appreciate if it could clarified. Like, for example, I don't see how the patch below makes anything "clear", it just seems to change the "import" command of git-remote-testgit to make use of the 'done' feature?

Perhaps the idea of the patch is to make use of the "done" feature so that remote-testgit acts as "reference implementation"? If that is the intention, then perhaps this could be used as commit message:

  remote-testgit: make use of the 'done' feature

  This might be helpful for people who would like to see how to properly
  implement the "done" feature.

But again, I am not sure if I understood the purpose of this patch correctly. So please forgive me if this was totally off-base :-(.

Cheers,
Max

> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
> git-remote-testgit | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/git-remote-testgit b/git-remote-testgit
> index 698effc..812321e 100755
> --- a/git-remote-testgit
> +++ b/git-remote-testgit
> @@ -55,8 +55,10 @@ while read line; do
> 
> 		echo "feature import-marks=$gitmarks"
> 		echo "feature export-marks=$gitmarks"
> -		git fast-export --use-done-feature --{import,export}-marks="$testgitmarks" $refs | \
> +		echo "feature done"
> +		git fast-export --{import,export}-marks="$testgitmarks" $refs | \
> 			sed -e "s#refs/heads/#${prefix}/heads/#g"
> +		echo "done"
> 		;;
> 	export)
> 		before=$(git for-each-ref --format='%(refname) %(objectname)')
> -- 
> 1.8.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
