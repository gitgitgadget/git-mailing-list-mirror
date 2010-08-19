From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (Aug 2010, #04; Wed, 18)
Date: Thu, 19 Aug 2010 10:06:55 +0200
Message-ID: <4C6CE61F.7060305@viscovery.net>
References: <7vfwyb8skr.fsf@alter.siamese.dyndns.org> <20100819030237.GE18922@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 10:07:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Om09X-000145-FE
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 10:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402Ab0HSIHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Aug 2010 04:07:06 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:32901 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071Ab0HSIHB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Aug 2010 04:07:01 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Om09I-0004nG-FA; Thu, 19 Aug 2010 10:06:56 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 2DC291660F;
	Thu, 19 Aug 2010 10:06:56 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.11) Gecko/20100711 Thunderbird/3.0.6
In-Reply-To: <20100819030237.GE18922@burratino>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153910>

Am 8/19/2010 5:02, schrieb Jonathan Nieder:
> Junio C Hamano wrote:
> 
>> * ab/compat-regex (2010-08-17) 5 commits
>>  - autoconf: don't use platform regex if it lacks REG_STARTEND
>>  - t/t7008-grep-binary.sh: un-TODO a test that needs REG_STARTEND
>>  - Change regerror() declaration from K&R style to ANSI C (C89)
>>  - compat/regex: get the gawk regex engine to compile within git
>>  - compat/regex: use the regex engine from gawk for compat
> 
> As Hannes noticed, the tip commit is bogus and the configure
> test gives the wrong result on platforms with missing or inferior
> regex.  Sorry about that.  Replacement is at $gmane/153782.

and I see these warnings:

In file included from compat/regex/regex.c:71:
compat/regex/regex_internal.c: In function 're_string_reconstruct':
compat/regex/regex_internal.c:696: warning: unused variable 'prev_valid_len'
In file included from compat/regex/regex.c:78:
compat/regex/regexec.c: In function 'check_arrival_add_next_nodes':
compat/regex/regexec.c:3062: warning: unused variable 'err'

This happens because RE_ENABLE_I18N is not defined by regex_internal.h. Is
this how it is supposed to be?

-- Hannes
