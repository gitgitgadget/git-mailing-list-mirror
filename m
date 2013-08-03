From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH 3/4] gitweb: omit the repository owner when it is unset
Date: Sat, 3 Aug 2013 23:40:11 +0200
Message-ID: <CANQwDwdA5VnywJmoNpCX7s=hH7tmUDUmRuak12W7BXOQtqRoQw@mail.gmail.com>
References: <20130714234915.GB19057@google.com> <E1Uyete-0003Sv-OI@hermes-2.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Sat Aug 03 23:40:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5jYy-0001bD-7B
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 23:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752871Ab3HCVkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 17:40:32 -0400
Received: from mail-qa0-f48.google.com ([209.85.216.48]:35708 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970Ab3HCVkc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 17:40:32 -0400
Received: by mail-qa0-f48.google.com with SMTP id o19so311887qap.14
        for <git@vger.kernel.org>; Sat, 03 Aug 2013 14:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=E7sHTmI8J+5bC05qafuQ+/Z5AS2FycofzMVvo01kpEU=;
        b=MqsYLWMSoc36tgA4yuvbp716406ppSiF6KRYkv4FfeqyT+hs+wUMh3mRdpQ+K2twz4
         pZcq4JlXqDdU0DME1F5PPSfWqAlzQt1Tk99UWZ6ZWTQXbv7eBrPsjKgF1aJiUzhBQYlP
         fMinYdJXtjbJ+SDEB4Wnl+3JnPCuu0UeiOMteN3Zo/FfxwAwSHIOe8q8Zgwyid4977PR
         sbJfPvvxPfPnJ6nN6sflFZUIt724hrpgs9UtYNp8mx5jboIipn2AiXFq7MfsJqSBvNpI
         Y2e10zziBt/9jiaNY/xiUFizWy+cJ2aDjAbVRxC7d+D3onnfqI4sbmR8sEXUOQbsOnVA
         rg/A==
X-Received: by 10.49.107.105 with SMTP id hb9mr17257428qeb.74.1375566031576;
 Sat, 03 Aug 2013 14:40:31 -0700 (PDT)
Received: by 10.49.75.169 with HTTP; Sat, 3 Aug 2013 14:40:11 -0700 (PDT)
In-Reply-To: <E1Uyete-0003Sv-OI@hermes-2.csi.cam.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231617>

On Tue, Jul 2, 2013 at 6:24 PM, Tony Finch <dot@dotat.at> wrote:

> On the repository summary page, leave the whole owner line out if
> the repo does not have an owner, rather than displaying a labelled
> empty field..

Note that if $omit_owner is true, whole _column_ is skipped.

Is removing cell (instead of leaving it empty) and relying on browser
treating nonexistent cell correctly a good idea, that I do not know.
Does it looks better?  Does it looks better in all web browsers?

> Signed-off-by: Tony Finch <dot@dotat.at>
> ---
>  gitweb/gitweb.perl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 8d69ada..c029b98 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -6463,7 +6463,7 @@ sub git_summary {
>         print "<div class=\"title\">&nbsp;</div>\n";
>         print "<table class=\"projects_list\">\n" .
>               "<tr id=\"metadata_desc\"><td>description</td><td>" . esc_html($descr) . "</td></tr>\n";
> -        unless ($omit_owner) {
> +        if ($owner and not $omit_owner) {
>                 print  "<tr id=\"metadata_owner\"><td>owner</td><td>" . esc_html($owner) . "</td></tr>\n";
>          }
>         if (defined $cd{'rfc2822'}) {
> --
> 1.8.3.1.605.g85318f5
>



-- 
Jakub Narebski
