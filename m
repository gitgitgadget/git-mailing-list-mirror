From: Eugene Sajine <euguess@gmail.com>
Subject: Re: Aliasing with parameters doesn't seem to work properly in git 
	1.7.0.5
Date: Thu, 3 Jun 2010 11:15:35 -0400
Message-ID: <AANLkTik0438juR__hD87KJlqRTYOIyCncnwZ0hF1_tDC@mail.gmail.com>
References: <AANLkTilEZknW7m0n3y8SX5oAaZiUTorgqfX3jTB8mnDC@mail.gmail.com>
	<AANLkTikWBzHLCQzC57bZQwCB6MxOYS8R5Y-UBZoh_ndS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 17:15:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKC92-0005A3-1l
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 17:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756029Ab0FCPPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 11:15:39 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:52318 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755182Ab0FCPPi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 11:15:38 -0400
Received: by fg-out-1718.google.com with SMTP id d23so488072fga.1
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 08:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=jxAnuYae2aOGKuoEd+FTTRE9H//W2kYaTqw2Uu6Ic+g=;
        b=Nxin0N0v1eCe+D+tNVCWUFQZbvm6qmp93YpYK4aKYjrfKrHoyG5htEt25bAXOFeE9j
         PAmxGQNpftdAQ5cYbV1OxC/2QAJg0YUOTfSOXgi584Yl/qcyXmIW5PuL5fpS8x7FFWs/
         RgIjNvdoP+Y6so36Uvxdq30MFZy/fNlCHnXco=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=lws15Z5OpBd3mZa4bjZIae/KWqva9Ghf/ZeuXBVt1E86TIeQBJCe77he4zhCjT6Buq
         chprYd19u+NJ8BTXSmJi5jkHm5QBrkh0XqhrAaJJUspafTSs3GcMjobWATl4q0Xjw78P
         xRgR7UtYyZQD5jCefhm9J/GWRzyQHvgZlZzy0=
Received: by 10.87.67.13 with SMTP id u13mr15960810fgk.66.1275578135876; Thu, 
	03 Jun 2010 08:15:35 -0700 (PDT)
Received: by 10.86.62.1 with HTTP; Thu, 3 Jun 2010 08:15:35 -0700 (PDT)
In-Reply-To: <AANLkTikWBzHLCQzC57bZQwCB6MxOYS8R5Y-UBZoh_ndS@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148332>

On Thu, Jun 3, 2010 at 10:55 AM, Jacob Helwig <jacob.helwig@gmail.com> wrote:
> On Thu, Jun 3, 2010 at 07:52, Eugene Sajine <euguess@gmail.com> wrote:
>> Hi,
>>
>> i'm trying to create an alias like this:
>>
>> cln = !sh -c 'git clone git://server/"$1"'
>>
>> the idea is to make a shortcut, so instead of command like this:
>>
>> $git clone git://server/folder/repo.git
>>
>> i can have something like this:
>>
>> $git cln folder/repo.git
>>
>> or even
>> $git cln folder/repo
>>
>> if the alias is like this:
>> cln = !sh -c 'git clone git://server/"$1".git'
>>
>> this doesn't work as it tries to initialize a repo called server.git
>> and then fails because "remote hang up unexpecedly"
>> is there something wrong in expansion of this alias or the alias
>> itself is not valid?
>>
>> Any ideas?
>>
>> Thanks,
>> Eugene
>
>
> You need " -" at the end of your alias for the parameters to get through.
>
> Try using:
>
> cln = !sh -c 'git clone git://server/"$1"' -
>
> or
>
> cln = !sh -c 'git clone git://server/"$1".git' -
>

This worked - thank you!!

Eugene
