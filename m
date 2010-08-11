From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 4/7] t/t5503-tagfollow: change from skip_all=* to prereq skip
Date: Wed, 11 Aug 2010 22:20:40 +0200
Message-ID: <201008112220.40864.j6t@kdbg.org>
References: <1281469968-25670-1-git-send-email-avarab@gmail.com> <1281469968-25670-5-git-send-email-avarab@gmail.com> <7vtyn1xaom.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 22:20:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjHn8-0001lR-9w
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 22:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757152Ab0HKUUp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 16:20:45 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:29091 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757072Ab0HKUUo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 16:20:44 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id B3653CDF89;
	Wed, 11 Aug 2010 22:20:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 3671B19F5FA;
	Wed, 11 Aug 2010 22:20:41 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <7vtyn1xaom.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153300>

On Mittwoch, 11. August 2010, Junio C Hamano wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> > diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
> > index bab1a53..8a298a6 100755
> > --- a/t/t5503-tagfollow.sh
> > +++ b/t/t5503-tagfollow.sh
> > @@ -6,8 +6,11 @@ test_description=3D'test automatic tag following'
> >
> >  case $(uname -s) in
> >  *MINGW*)
> > -	skip_all=3D"GIT_DEBUG_SEND_PACK not supported - skipping tests"
> > -	test_done
> > +	say "GIT_DEBUG_SEND_PACK not supported - skipping tests"
> > +	;;
> > +*)
> > +	test_set_prereq NOT_MINGW
> > +	;;
> >  esac
>
> To =C3=86var; isn't the prerequisite for these tests "does our git su=
pport send
> pack debugging?" not "are we not running on mingw?"  Let's call it
> DEBUG_SEND_PACK or something.
>
> To J6t; does the assumption here still hold, or do we support send pa=
ck
> debugging these days?

GIT_DEBUG_SEND_PACK is still not supported on Windows.

-- Hannes
