From: E R <pc88mxer@gmail.com>
Subject: Re: help with git query
Date: Mon, 13 Apr 2009 15:57:26 -0500
Message-ID: <3a69fa7c0904131357w5ef6b8feu7aac503fdcc4486c@mail.gmail.com>
References: <3a69fa7c0904131151p35945ed3y58cba069bd801337@mail.gmail.com>
	 <d77df1110904131331p24f52220o74c401c97fbb904d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Nathan W. Panike" <nathan.panike@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 22:59:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtTF7-0002WK-De
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 22:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbZDMU5a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Apr 2009 16:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751731AbZDMU53
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 16:57:29 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:51962 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbZDMU52 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Apr 2009 16:57:28 -0400
Received: by qw-out-2122.google.com with SMTP id 8so2582264qwh.37
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 13:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OvCISKUZg/htOcljOGN3Hnn7JB8xVU83NJCVu0+Bd60=;
        b=aouhIbZwqrghnjk/4gcUb6tTB40lXr8acRNxQSWuxq/bibi5/z0wkZernmeity3xeT
         a4Rar7WImE5kYLFuTcD6PmaE61C5IGX5m7RjndCi7W7dLzII5ziYt1IOVhF+Ia7rVh5e
         brEUUJP1N1VJuQWjNnDgTP5YBcLUyKrV1otsg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cs61aGLpXlKyi6RGuPpnA9q2wuwnjt7OSD3cJi0zG0xSlUYqYye/OaXKvYmT5qERii
         xjMv0f2EUjimCaX+Sgma0yuZMn7UYCwkrnuiKv4qFrgHvTVplyBpruVkdBumiBItqSHB
         /MTYqEeMpO4mvmqgYfS3v2kcyiLUwKyI0UDiA=
Received: by 10.220.92.139 with SMTP id r11mr7081408vcm.15.1239656246515; Mon, 
	13 Apr 2009 13:57:26 -0700 (PDT)
In-Reply-To: <d77df1110904131331p24f52220o74c401c97fbb904d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116486>

Thanks - that's very helpful.

=46or the second question, is it possible to find the commit that
represents the merge in the master branch?

i.e.

   git merge-base XXX master

returns the commit in branch XXX that got merged into master. I'd like
to also find the commit that represents the merge in master.

On Mon, Apr 13, 2009 at 3:31 PM, Nathan W. Panike
<nathan.panike@gmail.com> wrote:
> On Mon, Apr 13, 2009 at 1:51 PM, E R <pc88mxer@gmail.com> wrote:
>> Hi,
>>
>> I'd like to generate the following report from git:
>>
>> for each branch:
>> =A0- info about the latest commit on that branch (date and time, mes=
sage, etc.)
>
> Depending on what you want to do---from a bash shell, you could do:
>
> for i in $(git branch -a | cut -b3-); do echo $i; git show -s $i; ech=
o; done
>
>> =A0- info about the last time it was merged into master
>
> for i in $(git branch -a | cut -b3-); do echo $i; git show -s $(git
> merge-base $i master); echo; done
>>
>> What commands can I run to figure this out? I think I can figure out
>> the first one - it's the second one I'm having trouble with.
>>
>> And if it would easier to do it from the C API (or something like th=
e
>> perl Git::PurePerl module) I'd be interested in knowing that, too.
>>
>> Thanks,
>> ER
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
