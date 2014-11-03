From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] submodule: Fix documentation of update subcommand
Date: Mon, 03 Nov 2014 21:58:41 +0100
Message-ID: <5457EC81.2060504@web.de>
References: <1415009391-14979-1-git-send-email-sojkam1@fel.cvut.cz>	<xmqqegtkrtt9.fsf@gitster.dls.corp.google.com> <xmqqsii0qa4l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michal Sojka <sojkam1@fel.cvut.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 21:58:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlOiH-00008K-Hf
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 21:58:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753789AbaKCU6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 15:58:53 -0500
Received: from mout.web.de ([212.227.17.11]:54576 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753721AbaKCU6w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 15:58:52 -0500
Received: from [192.168.178.41] ([79.211.117.185]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MWj2N-1XZTyb2r2x-00XpZt; Mon, 03 Nov 2014 21:58:42
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <xmqqsii0qa4l.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:hbS6V6BOC/xipFJv8CIwAXVCdhvyviB0JWsfqwt++H45Iu6okqg
 Y1SrW/VY7ee9HOooXn4JzNBJvGpaplas5cmUi+2CMbtODWruTk8u7/juAlOG+9dDWNQALlc
 5k8+7pOOyWSkQLVZ/oy5Zh2eKg/zVm7VhRAteKMvp+RtZBuVFyt4ifXfLU4PpgasYT7GAIw
 GtMXibibmjIqKEU0Kh+yg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.11.2014 um 21:53 schrieb Junio C Hamano:
> I did a bit more digging of the history, and came up with this,
> which would be with a clearer and fairer description.  Also to
> clarify, I spelled what Michal's "This" meant to refer to.
>
> -- >8 --
> From: Michal Sojka <sojkam1@fel.cvut.cz>
> Date: Mon, 3 Nov 2014 11:09:51 +0100
> Subject: [PATCH] submodule: clarify documentation for update subcommand
>
> e6a1c43a (document submdule.$name.update=none option for gitmodules,
> 2012-05-10) meant to say "Unlike the case where your .update
> configuration is set to either 'rebase' or 'merge', when it is set
> to 'none', the tip of the submodule would never move.  You can use
> the --checkout option if you want the contents of the submodule to
> be updated to some other commit."
>
> But the resulting text made it sound as if using "--checkout" would
> have no effect when .update configuration is set to 'rebase' or
> 'merge', which was misleading.  In fact, with the "--checkout"
> option, the tip of the submodule moves to the exact commit that is
> recorded in the superproject tree, regardless of .update
> configuration.
>
> Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   Documentation/git-submodule.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 8e6af65..648323f 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -158,7 +158,7 @@ update::
>   	checkout the commit specified in the index of the containing repository.
>   	This will make the submodules HEAD be detached unless `--rebase` or
>   	`--merge` is specified or the key `submodule.$name.update` is set to
> -	`rebase`, `merge` or `none`. `none` can be overridden by specifying
> +	`rebase`, `merge` or `none`. The configuration can be overridden by specifying
>   	`--checkout`. Setting the key `submodule.$name.update` to `!command`
>   	will cause `command` to be run. `command` can be any arbitrary shell
>   	command that takes a single argument, namely the sha1 to update to.

Yup, but we should also mention '--merge' and '--rebase' here.
