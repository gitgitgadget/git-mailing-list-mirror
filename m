From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Update Japanese translation
Date: Sun, 16 Mar 2008 00:25:22 -0400
Message-ID: <20080316042522.GI8410@spearce.org>
References: <200803141303.m2ED3nUj016918@mi1.bluebottle.com> <20080315050840.GF8410@spearce.org> <7vlk4ko7px.fsf@gitster.siamese.dyndns.org> <20080315062734.GG8410@spearce.org> <7v4pb8o2jd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Peter Karlsson <peter@softwolves.pp.se>,
	=?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 16 05:26:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JakSE-0005V3-SS
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 05:26:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbYCPEZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 00:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbYCPEZc
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 00:25:32 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38192 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067AbYCPEZb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 00:25:31 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JakR6-000744-2C; Sun, 16 Mar 2008 00:25:28 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 31D4220FBAE; Sun, 16 Mar 2008 00:25:23 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v4pb8o2jd.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77351>

Junio C Hamano <gitster@pobox.com> wrote:
> How about doing something like this?

Yea, this looks good.  Can I apply it?  SBO?
 
>  po/README |   62 +++++++++++++++++++++++++++++++++++++++++++++++++-----------
>  1 files changed, 50 insertions(+), 12 deletions(-)
> 
> diff --git a/po/README b/po/README
> index 9d8b736..8264079 100644
> --- a/po/README
> +++ b/po/README
> @@ -178,18 +178,6 @@ step.
>  
>  	$ msgmerge -U po/af.po po/git-gui.pot
>  
> -[NEEDSWORK: who is responsible for updating po/git-gui.pot file by
> -running xgettext?  IIRC, Christian recommended against running it
> -nilly-willy because it can become a source of unnecessary merge
> -conflicts.  Perhaps we should mention something like "
> -
> -The po/git-gui.pot file is updated by the internationalization
> -coordinator from time to time.  You _could_ update it yourself, but
> -translators are discouraged from doing so because we would want all
> -language teams to be working off of the same version of git-gui.pot.
> -
> -" here?]
> -
>  This updates po/af.po (again, replace "af" with your language
>  code) so that it contains msgid lines (i.e. the original) that
>  your translation did not have before.  There are a few things to
> @@ -207,3 +195,53 @@ watch out for:
>  
>   - New messages added to the software will have msgstr lines with empty
>     strings.  You would need to translate them.
> +
> +The po/git-gui.pot file is updated by the internationalization
> +coordinator from time to time.  You _could_ update it yourself, but
> +translators are discouraged from doing so because we would want all
> +language teams to be working off of the same version of git-gui.pot.
> +
> +****************************************************************
> +
> +This section is a note to the internationalization coordinator, and
> +translators do not have to worry about it too much.
> +
> +The message template file po/git-gui.pot needs to be kept up to date
> +relative to the software the translations apply to, and it is the
> +responsibility of the internationalization coordinator.
> +
> +When updating po/git-gui.pot file, however, _never_ run "msgmerge -U
> +po/xx.po" for individual language translations, unless you are absolutely
> +sure that there is no outstanding work on translation for language xx.
> +Doing so will create unnecessary merge conflicts and force needless
> +re-translation on translators.  The translator however may not have access
> +to the msgmerge tool, in which case the coordinator may run it for the
> +translator as a service.
> +
> +But mistakes do happen.  Suppose a translation was based on an older
> +version X, the POT file was updated at version Y and then msgmerge was run
> +at version Z for the language, and the translator sent in a patch based on
> +version X:
> +
> +         ? translated
> +        /       
> +    ---X---Y---Z (master)
> +
> +The coordinator could recover from such a mistake by first applying the
> +patch to X, replace the translated file in Z, and then running msgmerge
> +again based on the updated POT file and commit the result.  The sequence
> +would look like this:
> +
> +    $ git checkout X
> +    $ git am -s xx.patch
> +    $ git checkout master
> +    $ git checkout HEAD@{1} po/xx.po
> +    $ msgmerge -U po/xx.po po/git-gui.pot
> +    $ git commit -c HEAD@{1} po/xx.po
> +
> +State in the message that the translated messages are based on a slightly
> +older version, and msgmerge was run to incorporate changes to message
> +templates from the updated POT file.  The result needs to be further
> +translated, but at least the messages that were updated by the patch that
> +were not changed by the POT update will survive the process and do not
> +need to be re-translated.

-- 
Shawn.
