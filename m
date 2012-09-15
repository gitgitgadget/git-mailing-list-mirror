From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] git-gui: Fix semi-working shortcuts for unstage and revert
Date: Sat, 15 Sep 2012 13:04:42 +0200
Message-ID: <CAKPyHN0_GVwCzrmH1YJu-cgGrPSQ3eqgFM8Ad1JJP8ZpF7Dx9w@mail.gmail.com>
References: <1347665801-22634-1-git-send-email-vi0oss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, patthoyts@users.sourceforge.net
To: vi0oss@gmail.com
X-From: git-owner@vger.kernel.org Sat Sep 15 13:04:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCqBA-0006cl-FX
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 13:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447Ab2IOLEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2012 07:04:43 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:51058 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752911Ab2IOLEm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2012 07:04:42 -0400
Received: by obbuo13 with SMTP id uo13so7375269obb.19
        for <git@vger.kernel.org>; Sat, 15 Sep 2012 04:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nzdHoluaR0WEwspdcRd42hE9iO8zbVRSfg2r0XBJgi0=;
        b=BA8ZzCjpxdinAuib8/PGu0vN+9Pl6n3b3aP2HAhaD4h2D2Leq4/GXPxQyZgvXy2Sv0
         KHrqFi3FI4ewLRQfDSdQwVPcU9DvTSu5BO1RQnbmzxnsCyR8OwFOOw1Ka8lbDSiq1g+R
         Pt6nrNATgERxNjJxawgdPameE0iTBELG+gnTiloc5Aa9Nk85ZwHeaKONP8tOoqvg1Krj
         BuMda5SmnmZHSJ91dG+P2R+XGILFXoEptRjkT+Fx6cLDeeZELgTdSm7xP7fxZq/ZGPmx
         T+W9xleq0F7aBlxw6NHWpqmDkNx8WbgZu/gQ1JyoYv98+sqLgT/2Hkr+Dpt3J57owBDB
         BwlQ==
Received: by 10.60.8.39 with SMTP id o7mr6968432oea.122.1347707082079; Sat, 15
 Sep 2012 04:04:42 -0700 (PDT)
Received: by 10.76.141.167 with HTTP; Sat, 15 Sep 2012 04:04:42 -0700 (PDT)
In-Reply-To: <1347665801-22634-1-git-send-email-vi0oss@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205550>

On Sat, Sep 15, 2012 at 1:36 AM,  <vi0oss@gmail.com> wrote:
> From: Vitaly _Vi Shukela <vi0oss@gmail.com>
>
> Make Ctrl+U for unstaging and Ctrl+J for reverting selection behave
> more like Ctrl+T for adding.
>
> They were working only when one area was focused (diff or commit message),
> now they should work everywhere.
>
> Signed-off-by: Vitaly _Vi Shukela <vi0oss@gmail.com>
> ---
> Sending the patch the third time (haven't got any replies to previous two attempts).

For what its worth:

Acked-by: Bert Wesarg <bert.wesarg@googlemail.com>

But unless Pat reacts this is useless.

Bert

>
>  git-gui/git-gui.sh |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> index ba4e5c1..6618016 100755
> --- a/git-gui/git-gui.sh
> +++ b/git-gui/git-gui.sh
> @@ -3710,6 +3710,8 @@ bind $ui_diff <$M1B-Key-v> {break}
>  bind $ui_diff <$M1B-Key-V> {break}
>  bind $ui_diff <$M1B-Key-a> {%W tag add sel 0.0 end;break}
>  bind $ui_diff <$M1B-Key-A> {%W tag add sel 0.0 end;break}
> +bind $ui_diff <$M1B-Key-j> {do_revert_selection;break}
> +bind $ui_diff <$M1B-Key-J> {do_revert_selection;break}
>  bind $ui_diff <Key-Up>     {catch {%W yview scroll -1 units};break}
>  bind $ui_diff <Key-Down>   {catch {%W yview scroll  1 units};break}
>  bind $ui_diff <Key-Left>   {catch {%W xview scroll -1 units};break}
> @@ -3742,6 +3744,8 @@ bind .   <$M1B-Key-s> do_signoff
>  bind .   <$M1B-Key-S> do_signoff
>  bind .   <$M1B-Key-t> do_add_selection
>  bind .   <$M1B-Key-T> do_add_selection
> +bind .   <$M1B-Key-u> do_unstage_selection
> +bind .   <$M1B-Key-U> do_unstage_selection
>  bind .   <$M1B-Key-j> do_revert_selection
>  bind .   <$M1B-Key-J> do_revert_selection
>  bind .   <$M1B-Key-i> do_add_all
> --
> 1.7.8.5
>
