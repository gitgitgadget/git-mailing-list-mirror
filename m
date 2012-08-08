From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 resend] gitk: Use an external icon file on Windows
Date: Wed, 08 Aug 2012 14:13:53 -0700
Message-ID: <7v628trsry.fsf@alter.siamese.dyndns.org>
References: <500CEF06.2030501@gmail.com> <5022CDFC.4090900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Aug 08 23:14:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzDZr-0005pF-Bb
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 23:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030891Ab2HHVN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 17:13:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50111 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030872Ab2HHVN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 17:13:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 824C19C28;
	Wed,  8 Aug 2012 17:13:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gOAWzW1DwVRWJm0N2jIghAoGbo8=; b=U4VhDr
	WswyMBDMhWxByYYRusjzRJapbARtbsycarj4X8wyxkMwLTwsRSx+BiEVNFJ12MBB
	I4ldUPomIbux2vlL7JCosPH6v1s6V4SJN0WdqfpRy/bMv5gvWJ4s4foeRohZE5w+
	OptQGIcKy1zLRpxitv6LRZSCCjEFWYFcufml0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nOK9Qr6DjOdJ8CdfjfCF1f5dw9E6ovT1
	zFGzSpHLLbWSAUUZUPg7wUSGPMuf1h6PfjZH85PI0FTSoy9GQCQbLaga1+EaCHUN
	6HyeKdn94AOoAcSO28XB2Ndlbizocvjg0SswY6/HCSLbbYcEEfPSFVNYETT7X2ke
	zmKaaDfS52Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 708529C27;
	Wed,  8 Aug 2012 17:13:55 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A540A9C25; Wed,  8 Aug 2012
 17:13:54 -0400 (EDT)
In-Reply-To: <5022CDFC.4090900@gmail.com> (Sebastian Schuberth's message of
 "Wed, 08 Aug 2012 22:37:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F5BE9418-E19D-11E1-BF76-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203133>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> Git for Windows now ships with the new Git icon from git-scm.com. Use that
> icon file instead of the old procedurally drawn one if it exists.
>
> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
> ---

Forwarding a misdirected patch to the maintainer who is free to pick
or ignore.

Personally I am negative on it (nobody on the list asked for the
"new" Git icon as far as I recall), but my voice on this counts just
as little as others.

Thanks.

>  gitk-git/gitk | 49 ++++++++++++++++++++++++++-----------------------
>  1 file changed, 26 insertions(+), 23 deletions(-)
>
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 59693c0..5127e55 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -11664,7 +11664,6 @@ if { [info exists ::env(GITK_MSGSDIR)] } {
>      set gitk_prefix [file dirname [file dirname [file normalize $argv0]]]
>      set gitk_libdir [file join $gitk_prefix share gitk lib]
>      set gitk_msgsdir [file join $gitk_libdir msgs]
> -    unset gitk_prefix
>  }
>  
>  ## Internationalization (i18n) through msgcat and gettext. See
> @@ -11821,28 +11820,32 @@ if {[expr {[exec git rev-parse --is-inside-work-tree] == "true"}]} {
>  set worktree [exec git rev-parse --show-toplevel]
>  setcoords
>  makewindow
> -catch {
> -    image create photo gitlogo      -width 16 -height 16
> -
> -    image create photo gitlogominus -width  4 -height  2
> -    gitlogominus put #C00000 -to 0 0 4 2
> -    gitlogo copy gitlogominus -to  1 5
> -    gitlogo copy gitlogominus -to  6 5
> -    gitlogo copy gitlogominus -to 11 5
> -    image delete gitlogominus
> -
> -    image create photo gitlogoplus  -width  4 -height  4
> -    gitlogoplus  put #008000 -to 1 0 3 4
> -    gitlogoplus  put #008000 -to 0 1 4 3
> -    gitlogo copy gitlogoplus  -to  1 9
> -    gitlogo copy gitlogoplus  -to  6 9
> -    gitlogo copy gitlogoplus  -to 11 9
> -    image delete gitlogoplus
> -
> -    image create photo gitlogo32    -width 32 -height 32
> -    gitlogo32 copy gitlogo -zoom 2 2
> -
> -    wm iconphoto . -default gitlogo gitlogo32
> +if {$::tcl_platform(platform) eq {windows} && [file exists $gitk_prefix/etc/git.ico]} {
> +    wm iconbitmap . -default $gitk_prefix/etc/git.ico
> +} else {
> +    catch {
> +        image create photo gitlogo      -width 16 -height 16
> +
> +        image create photo gitlogominus -width  4 -height  2
> +        gitlogominus put #C00000 -to 0 0 4 2
> +        gitlogo copy gitlogominus -to  1 5
> +        gitlogo copy gitlogominus -to  6 5
> +        gitlogo copy gitlogominus -to 11 5
> +        image delete gitlogominus
> +
> +        image create photo gitlogoplus  -width  4 -height  4
> +        gitlogoplus  put #008000 -to 1 0 3 4
> +        gitlogoplus  put #008000 -to 0 1 4 3
> +        gitlogo copy gitlogoplus  -to  1 9
> +        gitlogo copy gitlogoplus  -to  6 9
> +        gitlogo copy gitlogoplus  -to 11 9
> +        image delete gitlogoplus
> +
> +        image create photo gitlogo32    -width 32 -height 32
> +        gitlogo32 copy gitlogo -zoom 2 2
> +
> +        wm iconphoto . -default gitlogo gitlogo32
> +    }
>  }
>  # wait for the window to become visible
>  tkwait visibility .
