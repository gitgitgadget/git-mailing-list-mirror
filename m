From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH] files given on the command line are relative to $cwd
Date: Wed, 06 Aug 2008 22:14:19 +0200
Message-ID: <489A061B.7010508@free.fr>
References: <48997D2E.9030708@obry.net> <20080806104432.GG7121@bit.office.eurotux.com> <4899848C.6030800@obry.net> <7v3alirw6b.fsf@gitster.siamese.dyndns.org> <4899D119.1080403@obry.net> <7vy73aqe9m.fsf@gitster.siamese.dyndns.org> <7vr692oufw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>,
	Luciano Rocha <luciano@eurotux.com>, pascal@obry.net,
	Pierre Habouzit <madcoder@debian.org>,
	=?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 22:15:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQpPy-0008Fg-26
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 22:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761875AbYHFUOX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Aug 2008 16:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761841AbYHFUOW
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 16:14:22 -0400
Received: from smtp8-g19.free.fr ([212.27.42.65]:34964 "EHLO smtp8-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761733AbYHFUOV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 16:14:21 -0400
Received: from smtp8-g19.free.fr (localhost [127.0.0.1])
	by smtp8-g19.free.fr (Postfix) with ESMTP id F253E32A847;
	Wed,  6 Aug 2008 22:14:19 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 6B8A232A869;
	Wed,  6 Aug 2008 22:14:19 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <7vr692oufw.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91536>

Junio C Hamano a =E9crit :
> =20
>  static int parse_and_validate_options(int argc, const char *argv[],
> -				      const char * const usage[])
> +				      const char * const usage[],
> +				      const char *prefix)
>  {
>  	int f =3D 0;
> =20
>  	argc =3D parse_options(argc, argv, builtin_commit_options, usage, 0=
);
> +	logfile =3D parse_options_fix_filename(prefix, logfile);

It breaks the "git commit -F -" case, no?

Olivier.
