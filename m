From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Allow shell scripts to run with non-Bash /bin/sh
Date: Sat, 22 Sep 2007 06:06:25 +0200
Message-ID: <86tzpnwdha.fsf@lola.quinscape.zz>
References: <20070921214346.GF97288@void.codelabs.ru> <7vlkazh1ji.fsf@gitster.siamese.dyndns.org> <20070921214346.GF97288@void.codelabs.ru> <7v8x6zinjf.fsf@gitster.siamese.dyndns.org> <20070922035434.GA99140@void.codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 22 06:06:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYwGf-0004h4-RP
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 06:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbXIVEGs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2007 00:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbXIVEGs
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Sep 2007 00:06:48 -0400
Received: from main.gmane.org ([80.91.229.2]:40633 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750706AbXIVEGs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2007 00:06:48 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IYwGM-0006Hp-VN
	for git@vger.kernel.org; Sat, 22 Sep 2007 04:06:38 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 22 Sep 2007 04:06:38 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 22 Sep 2007 04:06:38 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:83akiffR03jHqwfylMRfLttt6LI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58915>

Eygene Ryabinkin <rea-git@codelabs.ru> writes:

>> That is, what does the shell say if you do this?
>> 
>> 	case Ultra in
>>         Super)
>>         	false ;;
>> 	Hyper)
>>         	true ;;
>> 	esac &&
>>         echo case returned ok
>
> It says 'case returned ok', so I will try to understand why it
> works here and does not work in the 'while' construct.

What you actually need to do is

false
case Ultra in
   Super)
   	false ;;
Hyper)
   	true ;;
esac && echo case returned ok


-- 
David Kastrup
