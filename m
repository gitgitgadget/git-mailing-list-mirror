From: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
Subject: Re: [PATCH] Retain multiple -q/-v occurrences in git pull
Date: Thu, 20 Nov 2008 00:00:14 +0100
Message-ID: <4ac8254d0811191500q4e06558aj79926ab9d2401e7f@mail.gmail.com>
References: <1226959770-4252-1-git-send-email-tuncer.ayaz@gmail.com>
	 <85647ef50811190346x11aea0fay3a8a7dfd8ddf6abc@mail.gmail.com>
	 <4ac8254d0811191447q7c9c475fka30a15c21b10524e@mail.gmail.com>
	 <4ac8254d0811191458r2a205be3w4a412553edc9b07f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Constantine Plotnikov" <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 00:01:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2w3A-0005Zv-Um
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 00:01:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbYKSXAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 18:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbYKSXAR
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 18:00:17 -0500
Received: from yw-out-2324.google.com ([74.125.46.28]:41231 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbYKSXAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 18:00:16 -0500
Received: by yw-out-2324.google.com with SMTP id 9so107848ywe.1
        for <git@vger.kernel.org>; Wed, 19 Nov 2008 15:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=KBAl6FuikktiATp+zy772qn5Lb5J2EqfnQlwP6Ah8w8=;
        b=rNORYmQm8KeQYl44G/4cZy14IHFvca5vkKSfSEOXgexeCuvcpYv0qGIpnfN5WvWMAE
         8N4i0V2IVYlDwepXq0Z4tKrP8OQy5PsvwuAVeqC+43IBqWXNO33oSuq/U6HeqbBGebpm
         PI5JzKnEnCykGyldQcHxI1Ffo0irQm4p9LiZg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ACH88pMkxAkr95nv8ghSwDdOzjQK9gmgGzYSoAUu60jGJWXoIAV0smHF3sTItdD7UW
         XjpFRmKv+HiYTSGGf6muTLxZvkINZebuKBFDikqAEFfYo3yN+kEIecdZs/vlKD7AsWPf
         bxmqdlsHLx+O/LW32UNX04Bd6I0WCDrJXKO60=
Received: by 10.64.213.8 with SMTP id l8mr1630532qbg.3.1227135614615;
        Wed, 19 Nov 2008 15:00:14 -0800 (PST)
Received: by 10.64.119.3 with HTTP; Wed, 19 Nov 2008 15:00:14 -0800 (PST)
In-Reply-To: <4ac8254d0811191458r2a205be3w4a412553edc9b07f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101380>

[re-sent due to propagated wrong Junio address. sorry.]

On Wed, Nov 19, 2008 at 12:46 PM, Constantine Plotnikov
<constantine.plotnikov@gmail.com> wrote:
> On Tue, Nov 18, 2008 at 1:09 AM, Tuncer Ayaz <tuncer.ayaz@gmail.com> wrote:
>> To support counting -q/-v options in git pull retain
>> them by concatenating.
>>
> [rest of message cut]
>
> By the way, there is yet another way to invoke git fetch. It is "git
> remote update". Possibly it should support "-v" and "-q" options for
> consistency as well.

Yes, we could add -q to builtin-remote and also make sure that it
passes the already existing -v and maybe a yet-to-be-added -q to
the fetch command.
I want to be first sure what the overall strategy regarding -q/-v is.

Right now we have some code which uses OPT__VERBOSE/OPT__QUIET
and some new code which uses the newly-added OPT__VERBOSITY.

These are the options I can see:
1) Use the old and new macros and decide in each module which one to use
2) Get rid off OPT__VERBOSE and OPT__QUIET and use OPT__VERBOSITY only
3) Think about new ways to handle all of this. Possibly some new print_* macros?

Any opinions?
