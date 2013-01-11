From: Matt Kraai <kraai@ftbfs.org>
Subject: Re: [PATCH v2 03/21] Export parse_pathspec() and convert some
 get_pathspec() calls
Date: Fri, 11 Jan 2013 09:56:44 -0800
Message-ID: <20130111175644.GA12359@ftbfs.org>
References: <1357903275-16804-1-git-send-email-pclouds@gmail.com>
 <1357903275-16804-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 18:57:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ttiqt-0006CR-6V
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 18:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754637Ab3AKR4v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jan 2013 12:56:51 -0500
Received: from kvm.ftbfs.org ([46.22.115.26]:42629 "EHLO kvm.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753050Ab3AKR4u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 12:56:50 -0500
Received: from kraai by kvm.ftbfs.org with local (Exim 4.72)
	(envelope-from <kraai@ftbfs.org>)
	id 1TtiqS-0003y3-MJ; Fri, 11 Jan 2013 09:56:44 -0800
Mail-Followup-To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <1357903275-16804-4-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213229>

On Fri, Jan 11, 2013 at 06:20:57PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
> +#define PATHSPEC_FROMTOP    (1<<0)

The previous commit introduces a use of this macro in get_pathspec.
Should this be defined by that commit instead?

> @@ -266,9 +266,9 @@ static int pathspec_item_cmp(const void *a_, cons=
t void *b_)
>   * Given command line arguments and a prefix, convert the input to
>   * pathspec. die() if any magic other than ones in magic_mask.
>   */
> -static void parse_pathspec(struct pathspec *pathspec,
> -			   unsigned magic_mask, unsigned flags,
> -			   const char *prefix, const char **argv)
> +void parse_pathspec(struct pathspec *pathspec,
> +		    unsigned magic_mask, unsigned flags,

The prototype for this function uses just "magic" instead of
"magic_mask".  Should they be consistent?

--=20
Matt
