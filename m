From: Ferry Huberts <mailings@hupie.com>
Subject: Re: libreoffice merge issue ...
Date: Mon, 14 Feb 2011 18:26:36 +0100
Message-ID: <4D5965CC.4030706@hupie.com>
References: <1297699635.31477.253.camel@lenovo-w500>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Norbert Thiebaud <nthiebaud@gmail.com>,
	kendy <kendy@novell.com>
To: michael.meeks@novell.com
X-From: git-owner@vger.kernel.org Mon Feb 14 18:45:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp2UO-0003Uv-Nd
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 18:45:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231Ab1BNRp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 12:45:27 -0500
Received: from 82-197-206-98.dsl.cambrium.nl ([82.197.206.98]:57095 "EHLO
	mail.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750877Ab1BNRp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 12:45:26 -0500
X-Greylist: delayed 1125 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Feb 2011 12:45:25 EST
Received: from paul.internal.hupie.com (paul.internal.Hupie.com [192.168.180.1])
	by mail.internal.Hupie.com (Postfix) with ESMTP id A167958BD88;
	Mon, 14 Feb 2011 18:26:36 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Thunderbird/3.1.7
In-Reply-To: <1297699635.31477.253.camel@lenovo-w500>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166742>



On 02/14/2011 05:07 PM, Michael Meeks wrote:
> Hi guys,
> 
> We are having quite some fun merging git branches with LibreOffice, and
> I stumbled over this just now with master git with hash:
> 00e6ee724640701b32aca27cc930fd6409c87ae2
> 
> Setup (some large repos):
> 
> 	git clone git://anongit.freedesktop.org/libreoffice/libs-core
> 	git checkout integration/dev300_m98
> 	git remote add stage git://anongit.freedesktop.org/libreoffice/staging/@REPO@
> 	git fetch stage
> 
> 	Test[1]:
> 
> 	git merge stage/premerge/dev300_m98

the merge has detected a conflict and has annotated the conflicted
file(s). at least one of the conflicting files is
idl/source/cmptools/lex.cxx (you might want to do 'git mergetool' after
you have setup your merge tool)

> 	git diff idl/source/cmptools/lex.cxx
> 

you're diffing the 'unmerged, annotated' file against the original file
before the merge.

your merge is not yet complete, you'll have to resolve the conflicts first
and then commit


> 	yields:
> 
> @@@ -147,11 -147,7 +147,15 @@@ SvToken & SvToken::operator = ( const S
>   *************************************************************************/
>   void SvTokenStream::InitCtor()
>   {
> ++<<<<<<< HEAD
>  +#ifdef DOS
>  +    SetCharSet( CHARSET_ANSI );
>  +#else
>       SetCharSet( gsl_getSystemTextEncoding() );
>  +#endif
> ++=======
> ++    SetCharSet( gsl_getSystemTextEncoding() );
> ++>>>>>>> stage/premerge/dev300_m98


this is the annotation of the conflict

grtz

-- 
Ferry Huberts
