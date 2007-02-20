From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH 1/4] Add prefixcmp()
Date: Tue, 20 Feb 2007 11:04:26 +0100
Message-ID: <87mz3916xh.fsf@morpheus.local>
References: <200702191839.05784.andyparkins@gmail.com> <7vlkit7vy5.fsf@assigned-by-dhcp.cox.net> <200702200942.18654.andyparkins@gmail.com> <7vbqjpxilh.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C. Hamano" <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 20 11:04:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJRrk-0006FS-P2
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 11:04:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932721AbXBTKEx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 20 Feb 2007 05:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932732AbXBTKEx
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 05:04:53 -0500
Received: from main.gmane.org ([80.91.229.2]:43550 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932721AbXBTKEw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 05:04:52 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HJRrV-0008OI-48
	for git@vger.kernel.org; Tue, 20 Feb 2007 11:04:41 +0100
Received: from c83-253-22-207.bredband.comhem.se ([83.253.22.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Feb 2007 11:04:41 +0100
Received: from davidk by c83-253-22-207.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Feb 2007 11:04:41 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-207.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:lkUCEvR8rhXn0t1bNeQ2KN5TMhg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40224>

Junio C Hamano <junkio@cox.net> writes:

> We have too many strncmp(a, b, strlen(b)).
>
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> ---
>  git-compat-util.h |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 9863cf6..0a9ac56 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -279,4 +279,9 @@ static inline int sane_case(int x, int high)
>  	return x;
>  }
> =20
> +static inline int prefixcmp(const char *a, const char *b)
> +{
> +	return strncmp(a, b, strlen(b));
> +}
> +
>  #endif

Is it just me, or coudln't this be a little more self-documenting.  I
find it annoying to have to read through a functions implementation to
figure out what to pass to it.

If a doc comment is too much, just naming the parameters is often
enough.

+static inline int prefixcmp(const char *s, const char *prefix)

--=20
David K=C3=A5gedal
