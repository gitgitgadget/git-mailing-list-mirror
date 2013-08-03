From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH 4/4] gitweb: make search help link less ugly
Date: Sat, 3 Aug 2013 23:37:39 +0200
Message-ID: <CANQwDwdcCUNBZH=YbSjwTZx6vau_cs89EH9FV8OUQcdNzDE5DQ@mail.gmail.com>
References: <20130714234915.GB19057@google.com> <E1Uyeth-0003TF-Kx@hermes-2.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Sat Aug 03 23:38:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5jWY-0003mJ-AG
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 23:38:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649Ab3HCViB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 17:38:01 -0400
Received: from mail-qa0-f48.google.com ([209.85.216.48]:57796 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970Ab3HCViA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 17:38:00 -0400
Received: by mail-qa0-f48.google.com with SMTP id o19so311967qap.0
        for <git@vger.kernel.org>; Sat, 03 Aug 2013 14:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qjIqVEqkTNdTiBPmymQADI0Ak9KRqs/83/Zf8q7DpdA=;
        b=yJU0q86QV0DaZtECbMJh9bTuSaOuQyHipKueFNf4jDhMtmKYN7xeE2Xvm2BBw33kXR
         Or/aFgtiLokmafkTmQUh33Y7RcOIQFMXRBXSyu94hCKQQBAJ9Ke8dKIWZ/Bfu6VJr7nv
         f16lW74Azn5o8QND11QlMgTzk58hByYp5CGV2IenV31sUqkVjJZXubifUEggZfOCFZGk
         ecoqI493QGREDWcvZoIAju3tE5q/hFss3coKZg1imibYD/4bJ89XwQHnKpKj++F56skM
         IDubH7WcQiF+G4jpCjl03AlLSPmXOFy1LdI5ADtw/emcboHhoqQvmjh1e4mHp9nF7ttD
         gtqg==
X-Received: by 10.224.24.134 with SMTP id v6mr19232889qab.58.1375565879574;
 Sat, 03 Aug 2013 14:37:59 -0700 (PDT)
Received: by 10.49.75.169 with HTTP; Sat, 3 Aug 2013 14:37:39 -0700 (PDT)
In-Reply-To: <E1Uyeth-0003TF-Kx@hermes-2.csi.cam.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231616>

On Tue, Jul 9, 2013 at 7:15 PM, Tony Finch <dot@dotat.at> wrote:

> The search help link was a superscript question mark right next to
> a drop-down menu, which looks misaligned

I think the idea was to simulate footnote explaining search terms
(I think, I am not the author of this feature)...

>                                                                and is a cramped and
> awkward click target. Remove the superscript tags and add some
> spacing to fix these nits. Add a title attribute to provide an
> explanatory mouseover.

... but I agree that it makes for poor UI.

>
> Signed-off-by: Tony Finch <dot@dotat.at>
> ---
>  gitweb/gitweb.perl | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index c029b98..874c948 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -4029,9 +4029,9 @@ sub print_search_form {
>               $cgi->input({-name=>"a", -value=>"search", -type=>"hidden"}) . "\n" .
>               $cgi->input({-name=>"h", -value=>$search_hash, -type=>"hidden"}) . "\n" .
>               $cgi->popup_menu(-name => 'st', -default => 'commit',
> -                              -values => ['commit', 'grep', 'author', 'committer', 'pickaxe']) .
> -             $cgi->sup($cgi->a({-href => href(action=>"search_help")}, "?")) .
> -             " search:\n",
> +                              -values => ['commit', 'grep', 'author', 'committer', 'pickaxe']) .

Nb. what changed here (in line above)?

> +             " " . $cgi->a({-href => href(action=>"search_help"),
> +                            -title => "search help" }, "?") . " search:\n",
>               $cgi->textfield(-name => "s", -value => $searchtext, -override => 1) . "\n" .
>               "<span title=\"Extended regular expression\">" .
>               $cgi->checkbox(-name => 'sr', -value => 1, -label => 're',
> --
> 1.8.3.1.605.g85318f5
