From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Use cases for 'git statistics'
Date: Wed, 14 May 2008 22:34:54 +0200
Message-ID: <200805142234.54600.jnareb@gmail.com>
References: <bd6139dc0805080851y2065bedfsf0f388cfd6d85929@mail.gmail.com> <200805131507.04912.jnareb@gmail.com> <bd6139dc0805130637saf704e1v2ab67c99da3078c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Sverre Rabbelier" <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 22:36:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwNhY-00013K-08
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 22:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbYENUfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 16:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbYENUfA
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 16:35:00 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:18764 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbYENUe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 16:34:59 -0400
Received: by nf-out-0910.google.com with SMTP id d3so36465nfc.21
        for <git@vger.kernel.org>; Wed, 14 May 2008 13:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=AvTcBc7W/6Z6+mIq97484hhIIkfAXMGxRMI6QyYqRe4=;
        b=MWreelJtARaOk4rX28jJtF8Kg5wr8r42qaz5bY6Apah8E2GaOIRZVT/XUAqlmhLqqr4NZxyeZZ6Qu0V7QHKzJhqQrFioIrXDqo64qj7IsUitCqDAQdOqIJ04pjVjipvWMICHbKajG7dxvGzycR8B5hR8QMqC5QJaW1sW72skqlA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FQb2wmjCah43+0eHQ2ONHvqCxbjz+1eDXnoD+d2u4mkKZ6qO8uB2WvwVkxndFUR0NebgInozppnQi1CcYgotbo7TzFTI/i7qxH+9t/CMHRwxE4tHt1J5MiTBiqh+KjZ6hQcM266FQ+afTe4GJOIdXEFoNT4Zkw+TS14z7pWYbLw=
Received: by 10.210.54.19 with SMTP id c19mr1414561eba.168.1210797297508;
        Wed, 14 May 2008 13:34:57 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.222.61])
        by mx.google.com with ESMTPS id c9sm2420773nfi.26.2008.05.14.13.34.53
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 14 May 2008 13:34:54 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <bd6139dc0805130637saf704e1v2ab67c99da3078c3@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82146>

On Tue, 13 May 2008, Sverre Rabbelier wrote:
> On Tue, May 13, 2008 at 3:07 PM, Jakub Narebski <jnareb@gmail.com> wrote:

[on helping maintainer decide how closely patch should be examined]

>>  Weighting different statistics, bayesian hypotesis/filtering, expert
>>  system, machine learning... I guess that would be quite a work to do
>>  it well.  Probably would require to calculate and adjust scoring of code
>>  (difficulity) and authors (skill), and matching them...
>>
>>  This is certainly in the "wishlist" scope.
> 
> Yeah, I think it would go in the 'c' of 'MoSCoW', but it could be very
> useful when done right.

Errr... what do you mean by 'MoSCoW'?

[here I think you cut a bit too much]
>>
>>  What I had in mind here, but didn't explain clear enough, was an
>>  extension to pickaxe search.  You want to find when current error
>>  message was created, even if the way of handling it (fprintf vs. die)
>>  changed, or if code was indented, or was moved.
> 
> I'm not familiar with pickaxe, what you suggest sounds like grepping
> the content also throughout history?

Documentation/glossary.txt (linked from git(7), in "Git User's Manual")

   pickaxe::
        The term <<def_pickaxe,pickaxe>> refers to an option to the diffcore
        routines that help select changes that add or delete a given text
        string. With the `--pickaxe-all` option, it can be used to view the full
        <<def_changeset,changeset>> that introduced or removed, say, a
        particular line of text. See linkgit:git-diff[1].

git-diff(1):

       -S<string>
              Look for differences that contain the change in <string>.

       --pickaxe-all
              When -S finds a change, show all the changes in that changeset, not
              just the files that contain the change in <string>.

       --pickaxe-regex
              Make the <string> not a plain string but an extended POSIX regex to
              match.

>>  Or find all error messages, in the order they were created, for example
>>  in git case to find ancient error messages and replace it by something
>>  more user-friendly (or less selective about choosing friends ;-).
> 
> I understand what you want, a search for specific content, from old to
> new, stopping when you have a match?

But let me elaborate a bit. What I wanted in my example is for each
die("<message>") and error("<message>") to have commit and date where
<message> was introduced (even if it was in fprintf(stderr, ...) then).

>>  Seriously, what I had in mind was to integrate author dates and commit
>>  dates into project management system scheduling.
> 
> I'm not sure what gain that would bring though, as it can only provide
> end dates, not 'starting work now' timestamps...

Well, if you use patch management system such like StGit, it could
trace when patch was created, when was refreshed, when was temporarily
abandoned (push, pop, float, new), ans when was finalized (commit or
clean).

But that is also in the realm of vague ideas, not concrete applications.
-- 
Jakub Narebski
Poland
