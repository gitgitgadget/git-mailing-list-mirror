From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 1/3] pull: prefer invoking "git <command>" over "git-<command>"
Date: Sun, 14 Apr 2013 10:09:17 +0100
Organization: OPDS
Message-ID: <395BBE63591C415D9C8599D1A17B3892@PhilipOakley>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com> <1365887729-9630-2-git-send-email-artagnon@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Ramkumar Ramachandra" <artagnon@gmail.com>,
	"Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 14 11:09:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URIwC-0008CU-NE
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 11:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822Ab3DNJJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 05:09:14 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:16252 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750735Ab3DNJJN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Apr 2013 05:09:13 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AiQOAA9xalFZ8Yth/2dsb2JhbAAuIoMGNohvuFQEAQMBgQMXdIIaBQEBBAEIAQEuEQUIAQEhBQYCAwUCAQMOBgEBCyUUAQQIEAIGBxcGAQcLCAIBAgMBDASHYQMJCgixAA2JXYxEgWlfC4JnYQOITYV0hmGDBIpUhRyDDDs
X-IronPort-AV: E=Sophos;i="4.87,470,1363132800"; 
   d="scan'208";a="406446286"
Received: from host-89-241-139-97.as13285.net (HELO PhilipOakley) ([89.241.139.97])
  by out1.ip04ir2.opaltelecom.net with SMTP; 14 Apr 2013 10:09:11 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221089>

From: "Ramkumar Ramachandra" <artagnon@gmail.com>
Sent: Saturday, April 13, 2013 10:15 PM
> 14e5d40c (pull: Fix parsing of -X<option>, 2010-01-17) added the lines
> containing "git-push" and "git-merge", even though the prevelant style

s /git-push/git rebase/    The fix is to a git-rebase not git-push 
invocation.

> at the time was to use the unhyphenated "git <command>" form.  Fix
> this.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
> git-pull.sh | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/git-pull.sh b/git-pull.sh
> index 638aabb..5fe69fa 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -285,11 +285,11 @@ fi
> merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || 
> exit
> case "$rebase" in
> true)
> - eval="git-rebase $diffstat $strategy_args $merge_args $verbosity"
> + eval="git rebase $diffstat $strategy_args $merge_args $verbosity"
>  eval="$eval --onto $merge_head ${oldremoteref:-$merge_head}"
>  ;;
> *)
> - eval="git-merge $diffstat $no_commit $verify_signatures $edit 
> $squash $no_ff $ff_only"
> + eval="git merge $diffstat $no_commit $verify_signatures $edit 
> $squash $no_ff $ff_only"
>  eval="$eval  $log_arg $strategy_args $merge_args $verbosity 
> $progress"
>  eval="$eval \"\$merge_name\" HEAD $merge_head"
>  ;;
> -- 
> 1.8.2.1.392.g6943ea6
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> -----
> No virus found in this message.
> Checked by AVG - www.avg.com
> Version: 2013.0.3272 / Virus Database: 3162/6242 - Release Date: 
> 04/13/13
> 
