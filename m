From: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
Subject: Re: [PATCH] Remove dependency on IO::String from Git.pm test
Date: Wed, 18 Jun 2008 17:10:57 +0200
Message-ID: <b77c1dce0806180810r46a3e2a5i4eb228e6dc19613d@mail.gmail.com>
References: <1213796224-995-1-git-send-email-michael@ndrix.org>
	 <m37icmol6y.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Michael Hendricks" <michael@ndrix.org>, gitster@pobox.com,
	git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 17:12:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8zKE-0006p5-Js
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 17:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbYFRPK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 11:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751833AbYFRPK6
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 11:10:58 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:31217 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608AbYFRPK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 11:10:57 -0400
Received: by wf-out-1314.google.com with SMTP id 27so302005wfd.4
        for <git@vger.kernel.org>; Wed, 18 Jun 2008 08:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=FEggsYJXdQimApX6qF3TsG+mNp5bCdXQdB3034QQVf8=;
        b=L3/6m4AkpueasUITwpucDm6IxuGHYHPkTzFgUpykzb+F4ZgIpUTE+gy4gPBnfCJVui
         /Urae6Cw8LHk01yvzyvmTos/Zbj60Dui7d5x9ztBVEle3n5WH85bN0ml3vaRhDiBVWHy
         t4DetVbCiP1PFqqV/l/42G+7DuG42djEicCfk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=w54Lgt0l+2VBOwf8vH0MuIXORRO4pw5PmcDKNlJo6CHtx/GJsIsFcao1l/KENp1Ja1
         jIVl/KFRgv0V5RyKcjhrTBAlUHtpIKCEMxHnWMByJIO/Izu8ctnh6a21q57UV6g+CvtG
         4cEv8X4C5Qt5EyYoRrjQJg9PHMxE8putVxXTU=
Received: by 10.142.114.15 with SMTP id m15mr350868wfc.25.1213801857520;
        Wed, 18 Jun 2008 08:10:57 -0700 (PDT)
Received: by 10.142.11.3 with HTTP; Wed, 18 Jun 2008 08:10:57 -0700 (PDT)
In-Reply-To: <m37icmol6y.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85383>

2008/6/18 Jakub Narebski <jnareb@gmail.com>:
> Michael Hendricks <michael@ndrix.org> writes:
>
>> Instead of using IO::String to create an in-memory filehandle, use
>> open() with a scalar reference as the filename.  This feature has been
>> available since Perl 5.8.0 (which was released in 2002), so it should
>> be available pretty much everywhere by now.
>
> Besides if I understand correctly gitweb very much requires Perl >= 5.8
> because of required Unicode support.
>
> Nevertheless adding "use v5.8.0;" or "use 5.008_000;" would be I guess
> good idea.

"use 5.008;" is preferred form; "use v5.8.0" might yield obscure error
messages on perls < 5.6, which is not the desired result.
