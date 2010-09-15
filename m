From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH 19/25] gettextize: git-reset reset_type_names messages
Date: Wed, 15 Sep 2010 12:17:56 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1009151216000.11791@ds9.cixit.se>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com> <1283456446-22577-20-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 15 13:18:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ovq08-00073f-9J
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 13:18:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417Ab0IOLSC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Sep 2010 07:18:02 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:54359 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751660Ab0IOLSA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Sep 2010 07:18:00 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o8FBHvFh028787
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 15 Sep 2010 13:17:57 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id o8FBHuGs028779;
	Wed, 15 Sep 2010 13:17:57 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <1283456446-22577-20-git-send-email-avarab@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Wed, 15 Sep 2010 13:17:57 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156231>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:

> Make the messages in git-reset that use the reset_type_names static
> array to be translatable by marking the array items with N_() and
> using _() later.

This is untranslatable for several languages. For Swedish it would suff=
ice=20
to move the " reset" part into the array:

> -	"mixed", "soft", "hard", "merge", "keep", NULL
> +	N_("mixed"), N_("soft"), N_("hard"), N_("merge"), N_("keep"), NULL
> };

changing it to

N_("mixed reset"), N_("soft reset"), ...

and changing this

> -		die("Cannot do a %s reset in the middle of a merge.",
> -		    reset_type_names[reset_type]);
> +		die(_("Cannot do a %s reset in the middle of a merge."),
> +		    _(reset_type_names[reset_type]));

into "... do a %s in ..", with similar changes for the others.

--=20
\\// Peter - http://www.softwolves.pp.se/
