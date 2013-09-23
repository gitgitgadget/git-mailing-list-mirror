From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH 1/9] transport-helper: add 'force' to 'export' helpers
Date: Sun, 22 Sep 2013 22:41:29 -0400
Message-ID: <523FAA59.6040200@bbn.com>
References: <1377789808-2213-1-git-send-email-felipe.contreras@gmail.com> <1377789808-2213-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 23 04:41:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNw5i-0007Ph-9U
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 04:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335Ab3IWCle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Sep 2013 22:41:34 -0400
Received: from smtp.bbn.com ([128.33.1.81]:13203 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753156Ab3IWCle (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Sep 2013 22:41:34 -0400
Received: from socket.bbn.com ([192.1.120.102]:43000)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VNw5c-0009DH-Ql; Sun, 22 Sep 2013 22:41:32 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 0A0363FF4D
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <1377789808-2213-2-git-send-email-felipe.contreras@gmail.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235181>

On 2013-08-29 11:23, Felipe Contreras wrote:
> Otherwise they cannot know when to force the push or not (other than
> hacks).
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  transport-helper.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/transport-helper.c b/transport-helper.c
> index 63cabc3..62051a6 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -814,6 +814,9 @@ static int push_refs_with_export(struct transport *transport,
>  			die("helper %s does not support dry-run", data->name);
>  	}
>  
> +	if (flags & TRANSPORT_PUSH_FORCE)
> +		set_helper_option(transport, "force", "true");

Should the return value of set_helper_option() be checked?

Also, should there be a #define TRANS_OPT_FORCE "force" with
TRANS_OPT_FORCE added to boolean_options[]?

Thanks,
Richard
