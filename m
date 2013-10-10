From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] git-prompt.sh: show the upstream abbrev name
Date: Thu, 10 Oct 2013 15:58:13 +0200
Message-ID: <20131010135813.GF19704@goldbirke>
References: <1381411933-20600-1-git-send-email-jcarsique@nuxeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Simon Oosthoek <s.oosthoek@xs4all.nl>,
	"Eduardo R . D'Avila" <erdavila@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Julien Carsique <julien.carsique@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 10 15:58:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUGlA-00081R-PP
	for gcvg-git-2@plane.gmane.org; Thu, 10 Oct 2013 15:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754328Ab3JJN6d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Oct 2013 09:58:33 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:60263 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016Ab3JJN6c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Oct 2013 09:58:32 -0400
Received: from localhost6.localdomain6 (f050225105.adsl.alicedsl.de [78.50.225.105])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0LiGlL-1W7Oyr0TkR-00n9Ud; Thu, 10 Oct 2013 15:58:14 +0200
Content-Disposition: inline
In-Reply-To: <1381411933-20600-1-git-send-email-jcarsique@nuxeo.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:w1jV5iXz5cajr9xTjEBl8eY2xZvZi6xmxLnTr82PSwb
 ANapmduY44jLi01ufBqRJ/Pu0bYp/BnFql5/20dt0VBi6oopB2
 6EhA+37B+aYYbSy36o2JV1nN7hQZ7i45wqp9TcSYOR6Io37D00
 ugTYy1XCudeG26B9hey0xIgTJvzoMIx7WSWNOIrRgMky4JpaFl
 52I49YjQ0E79uuIzZWvyrQ+iKSjH/NgCPzmjoPrkAT0im2FCrl
 etnq02+1bdwPjLVSZjSQliZxmFSkBPGzDQ4ygMdlCjLOIeOQWi
 4QfQIY0It3KcjMq+jgkqGEWei/vYJKXR8RnwEz4beZV8NuoJKN
 iaMhUA8WfqT30+PcemUbuCA8xg9wm1+z8uatCVV/c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235862>

Hi,

On Thu, Oct 10, 2013 at 03:32:13PM +0200, Julien Carsique wrote:
> @@ -204,6 +206,9 @@ __git_ps1_show_upstream ()
>  		*)	    # diverged from upstream
>  			p=3D" u+${count#*	}-${count%	*}" ;;
>  		esac
> +		if [[ -n "$count" && -n "$name" ]]; then
> +			p+=3D" $(git rev-parse --abbrev-ref "$upstream" 2>/dev/null)"

The '+=3D' operator is not supported in all Bash versions we care about=
=2E
Please write this as p=3D"$p $(...)".

Thanks,
G=E1bor
