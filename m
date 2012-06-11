From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: How to pull force just one folder in dev tree?
Date: Mon, 11 Jun 2012 21:18:49 +0100
Organization: OPDS
Message-ID: <8F71F33B20804F85AC15F77A30855D1C@PhilipOakley>
References: <4FCE44D4.6050805@gmail.com> <7vlik1obdg.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>, "J.V." <jvsrvcs@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 22:18:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeB4A-0000Ab-W5
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 22:18:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976Ab2FKUSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 16:18:18 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:7558 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751812Ab2FKUSS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jun 2012 16:18:18 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AggMAPhR1k9cHlAC/2dsb2JhbABFixeoTQICgTCBCA+CBAEEAQEFCAEBLhEFCAEBIQsCAwUCAQMRAwEBAQolFAEECBACBgcPCAYBBwsIAgECAwEMBIUoBwGCIwkDDwevBA2JTopDYVCBBYNcYAOIDYUxiHKJbIR9gmGBVSM
X-IronPort-AV: E=Sophos;i="4.77,391,1336345200"; 
   d="scan'208";a="375220537"
Received: from host-92-30-80-2.as13285.net (HELO PhilipOakley) ([92.30.80.2])
  by out1.ip04ir2.opaltelecom.net with SMTP; 11 Jun 2012 21:18:16 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199716>

From: "Junio C Hamano" <gitster@pobox.com>
To: "J.V." <jvsrvcs@gmail.com>
Cc: <git@vger.kernel.org>
Sent: Tuesday, June 05, 2012 7:35 PM
Subject: Re: How to pull force just one folder in dev tree?


> "J.V." <jvsrvcs@gmail.com> writes:
>
>> If I am in my source code tree down deep in a directory at the
>> command
>> line, how do I pull from a repo and force overwrite all files locally
>> (and also get files that I deleted locally, just in the folder I am
>> in?)

I think the particular command for this case would be
    git checkout [-p|--patch] [<tree-ish>] [--] [<paths>.]
where the paths are defined as a pathspec (see git glossary for
details).

Though you should review how you got into this sticky situation and
consider  how you would adjust your workflow so you don't repeat the
problem.
e.g. creating a temporary branch earlier, with more commits or stashes.

>>
>> I do not want to do this for the entire repo, just the directory that
>> I am in and also on the branch I am in.  I am not in the 'master'
>> branch, but another branch.
>>
>> so
>>
>>  $git reset --hard HEAD
>>
>>  Would probably do my entire local repo and from 'master' (even if I
>> am not on master)?
>
> No. It asks "Please reset the index and the working tree files to
> match what I have in the commit I checked out".  If you are on the
> 'slave' branch, the index and the working tree files are updated to
> match the commit at the tip of the 'slave' branch.
>
> It is unclear what you are trying to do, but if you made random
> changes in files in your current directory (somewhere deep), all
> changes are crap and you regret making them, and you are wishing to
> go back to the state you started from, then the way to ask "I want
> everything in this directory checked out from my current branch" is
> to say:
>
> $ git checkout HEAD -- .
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> -----
> No virus found in this message.
> Checked by AVG - www.avg.com
> Version: 2012.0.2178 / Virus Database: 2433/5048 - Release Date:
> 06/05/12
>
