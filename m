From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Highlight the link target line in Gitweb using CSS
Date: Thu, 20 Dec 2012 12:54:53 -0800
Message-ID: <7vbodo4f6q.fsf@alter.siamese.dyndns.org>
References: <1356027399-5356-1-git-send-email-matt@blissett.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
To: Matthew Blissett <matt@blissett.me.uk>
X-From: git-owner@vger.kernel.org Thu Dec 20 21:55:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tln98-00051v-Sp
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 21:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341Ab2LTUy6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Dec 2012 15:54:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57235 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869Ab2LTUy4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Dec 2012 15:54:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EC63A4E2;
	Thu, 20 Dec 2012 15:54:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BRSH9CQx3DBo
	gGhDbtyqUSQPY20=; b=lCN9pZM9CdAeZPp39hXyV6tSuVRmcilDqdpnad1eQhA9
	6jzJHGbSl0OKkBJeA5lYLhfeo2MzaZIHbWmT9Xv3ye3SDQ7CCdQRSNWLuKq+zKRM
	eEbJMeIzWFJ3WkZIIs55WGar6lHrpjSjjWVbc785Y4P3Qls9OkGSauV7MtwiGtU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=q5PRMC
	E+sXjutNbMzevA7LgyQVnJorCKZrQm//JU5EwgaUXYrk68vIgFVtMmZ/lUxAWevz
	TG0sE3XoXRxnsD1FkGrbxyD09oQRbNv0wxz/o76GCuXxkDydkZUTvXV62dfklyIn
	pChcGeWpIHEdUkaHnujbx+RB9KhSBty5p7fM4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B465A4DE;
	Thu, 20 Dec 2012 15:54:56 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9DE60A4DA; Thu, 20 Dec 2012
 15:54:55 -0500 (EST)
In-Reply-To: <1356027399-5356-1-git-send-email-matt@blissett.me.uk> (Matthew
 Blissett's message of "Thu, 20 Dec 2012 18:16:38 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 822ED8CE-4AE7-11E2-A0B4-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211927>

[jc: adding area expert to Cc]

Matthew Blissett <matt@blissett.me.uk> writes:

> This is useful when a Gitweb link with a target (like #l100) refers t=
o
> a line in the last screenful of text.  Highlight the background in
> yellow, and display a =E2=9A=93 character on the left.  Show the same
> highlight when hovering the mouse over a line number.
>
> Signed-off-by: Matthew Blissett <matt@blissett.me.uk>
> ---
> The background-colour change is the 'main' (tiny) change.

In the "blob" view, I think it does make it more discoverable that
these line numbers are links, so I personally think a.linenr:hover
part is an improvement.  I am not sure about other three changes
adding any value, though.

> Consider the ::before part a suggestion.  I think it helps show the
> target line, but it does overlap the first character of any line >999=
=2E

Actually, when viewing the blame view, this is even worse, as it
seems to always overlap.  The background color ought to be enough
cue without being overly distracting, I would have to say.

Jakub?  Comments on any other points I may have missed?

>
> I've tested this on the browsers I have access to, which excludes
> Internet Explorer.  Since it's cosmetic it shouldn't matter if it doe=
sn't
> work.
>
> Wikipedia use similar CSS for their citation links:
> <http://en.wikipedia.org/wiki/Git_(software)#cite_note-1>
>
>  gitweb/static/gitweb.css |   10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
> index cb86d2d..9f54311 100644
> --- a/gitweb/static/gitweb.css
> +++ b/gitweb/static/gitweb.css
> @@ -546,6 +546,16 @@ a.linenr {
>  	text-decoration: none
>  }
> =20
> +a.linenr:hover, a.linenr:target {
> +	color: #444444;
> +	background-color: #ff4;
> +}
> +
> +a.linenr:hover::before, a.linenr:target::before {
> +	content: '=E2=9A=93';
> +	position: absolute;
> +}
> +
>  a.rss_logo {
>  	float: right;
>  	padding: 3px 0px;
