From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 3/5] t/t5800-remote-helpers.sh: Skip with prereq on
	python <2.4
Date: Wed, 28 Jul 2010 20:16:02 -0500
Message-ID: <20100729011602.GG29156@dert.cs.uchicago.edu>
References: <1280313299-721-1-git-send-email-avarab@gmail.com> <1280313299-721-4-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 29 03:16:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeHjI-0006lb-3d
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 03:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116Ab0G2BQH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 21:16:07 -0400
Received: from camembert.cs.uchicago.edu ([128.135.164.153]:57857 "EHLO
	smtp.cs.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987Ab0G2BQF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 21:16:05 -0400
Received: from dert.cs.uchicago.edu (dert.cs.uchicago.edu [128.135.11.157])
	by smtp.cs.uchicago.edu (Postfix) with ESMTP id B0ECC9FF;
	Wed, 28 Jul 2010 20:16:02 -0500 (CDT)
Received: by dert.cs.uchicago.edu (Postfix, from userid 10442)
	id 7BC6BA6C2; Wed, 28 Jul 2010 20:16:02 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <1280313299-721-4-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152139>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Change the t/t5800-remote-helpers.sh test to skip with the the
> three-arg prereq form of test_expect_success instead of bailing out.

Right:

> +++ b/t/t5800-remote-helpers.sh
> @@ -13,13 +13,11 @@ if sys.hexversion < 0x02040000:
>      sys.exit(1)
>  '
>  then
> -	:
> -else
> -	skip_all=3D'skipping git remote-testgit tests: requires Python 2.4 =
or newer'
> -	test_done
> +    # Requires Python 2.4 or newer
> +	test_set_prereq PYTHON_24
>  fi

And as a bonus, this makes the test clearer.  Nice.

I would suggest dropping the "Requires Python 2.4" comment, or
maybe moving it somewhere else with a change to explain that
it is git-remote-testgit that requires Python =E2=89=A5 2.4
(rather than the remote helper facility in general).

The rest of the series looks good to me.

Thanks again,
Jonathan
