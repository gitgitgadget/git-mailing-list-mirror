From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Relative ls-files
Date: Wed, 23 Mar 2011 21:14:08 +0700
Message-ID: <AANLkTi=OJ_o2WQ2W6d30HXQZrg7=W70+fZWrbQPrAs=s@mail.gmail.com>
References: <AANLkTi=fP+jBpLuxst2rv02pYRmj4HOkv8Yenc-dR-N_@mail.gmail.com>
 <4D89D052.5030801@drmicha.warpmail.net> <AANLkTimc7gNKbh3C2hyMtFK6D1OWNALD+GvzmhG5cZrn@mail.gmail.com>
 <AANLkTimdLGgGXGRNVH5+X-cnhK2NWfWx9k0apt-6rr1Z@mail.gmail.com>
 <4D89DCBE.3060400@drmicha.warpmail.net> <AANLkTi=BrgZe47Bt5evr_qFzKBL=MY-6NmH22gsRurVV@mail.gmail.com>
 <7v7hbqgc7g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	demerphq <demerphq@gmail.com>, John Tapsell <johnflux@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 15:14:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2Opi-0000tT-Df
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 15:14:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600Ab1CWOOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 10:14:40 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43960 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965Ab1CWOOj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 10:14:39 -0400
Received: by wwa36 with SMTP id 36so10171667wwa.1
        for <git@vger.kernel.org>; Wed, 23 Mar 2011 07:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=fntgYZCF0b0pG3cLK+0Ul5aVhrU5N5cKVT2el0QiwFs=;
        b=LuvcdQx5me5nLg1BsT2EnYybVDu2Wj69noNqddS9v0nkgqqkF5fjpPHvMjsz5Rh/yo
         2XyukB4hLZfKE2l1xPTere12I8WLXm1cYnqWApHG6SPgMU7klKiuOBavMKC4t06Hv8H5
         Q8cy/jNRRg57XtBw2Fpg96SVjaLDqOb84enJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=U9cLVVTGFaaAS6evOih9ewGnswaduS4TXvtsruSQsPN0Qp/XA0Ilityq1tU63OCSfT
         zMp3CI/7J3r9ChAcBPjD2p52m0CisXHuHgiHyoLmSdHErgFU4isrciRo6+E5hZq7auVN
         jwaMUWpxmG9LxzYS54JEhM6sFEH2I5Rb7aSPI=
Received: by 10.216.242.134 with SMTP id i6mr1209209wer.81.1300889678238; Wed,
 23 Mar 2011 07:14:38 -0700 (PDT)
Received: by 10.216.163.202 with HTTP; Wed, 23 Mar 2011 07:14:08 -0700 (PDT)
In-Reply-To: <7v7hbqgc7g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169835>

On Wed, Mar 23, 2011 at 9:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Martin Langhoff <martin.langhoff@gmail.com> writes:
>
>> and the answer is git ls-files --with-tree=<treeish> | grep <regex> .
>> But the --with-tree param is so counterintuitive to me that I read the
>> manpage, everytime.
>
> Because --with-tree nor ls-files is the tool that was designed for.
>
> If you want to find out about a branch, why aren't you using "ls-tree -r"?

(off topic?)

"ls-tree -r" does not understand wildcards. Maybe it should not, but I
think read_tree_recursive() should use tree_entry_interesting(). The
function it uses for matching, match_tree_entry, looks like another
variant of t_e_interesting.
-- 
Duy
