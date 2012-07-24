From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] test: some testcases failed if cwd is on a symlink
Date: Wed, 25 Jul 2012 06:06:04 +0800
Message-ID: <CANYiYbG6uTOUmPr7YyHc7VftDwSVOj0_gWtH_AKDiyxRMCahQg@mail.gmail.com>
References: <001c60538df409d94618e80cc3faaae586ccf053.1343116581.git.worldhello.net@gmail.com>
	<7vboj5gqqo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 00:06:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StnF6-0005pl-2b
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 00:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754483Ab2GXWGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 18:06:06 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:54462 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754309Ab2GXWGE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 18:06:04 -0400
Received: by yhmm54 with SMTP id m54so69949yhm.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 15:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=P0nTkRINu/+NLBAXM6rZ2rZ3ejwaBwiDMtcyrneY34c=;
        b=TAXlEuVIws8pGvH0MEwmrnx7e1qNt88QDnEXMm+8+rgAJ8gMyAI9wKkrY9wyBlLBoV
         LAEHH5modu7s39HQMwXUKnBcdPD47C2AQ4JecjBC8TCYh7gR5MOBL6a9AAfXKYyTCCbA
         ++gON/i5XZZDGMx0tMUX1iqpAV+JP78FEPwlbY1JkECLCD4LaXN6UQJTUpsqEFU2PwUV
         7CaBnopKm1E5rjYUhk9lzOrbY+VMxeyldLL+nzFJFieAy/U0Sb3wYmEafTkU2BEd0nNX
         MK5mzJ/3kXaQoJOMMNYztDTPNb6H+HDY86IpxRanUoZHoHEqncc2nS71iATvLZEiZyLd
         NIBw==
Received: by 10.43.126.1 with SMTP id gu1mr18734699icc.6.1343167564207; Tue,
 24 Jul 2012 15:06:04 -0700 (PDT)
Received: by 10.50.237.38 with HTTP; Tue, 24 Jul 2012 15:06:04 -0700 (PDT)
In-Reply-To: <7vboj5gqqo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202077>

2012/7/24 Junio C Hamano <gitster@pobox.com>:
> I wonder if running test in a real directory (in other words, "fix"
> your cwd) may be a simpler, more robust and generally a better
> solution, e.g. something silly like...
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index acda33d..7f6fb0a 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -15,6 +15,8 @@
>  # You should have received a copy of the GNU General Public License
>  # along with this program.  If not, see http://www.gnu.org/licenses/ .
>
> +cd "$(pwd -P)"
> +

Yes, it's much simpler.

-- 
Jiang Xin
