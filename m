From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: git grep doesn't follow symbolic link
Date: Tue, 10 Jan 2012 11:26:36 +0530
Message-ID: <CALkWK0=-LZH4MYhX50v-RWpGA2r+6q50YxsKaOxc0mJ__yuK7g@mail.gmail.com>
References: <CAPRVejc7xND_8Y=Pb5rYGEcaKYUaX7_WkSro-_EL8tTGxkfY3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Bertrand BENOIT <projettwk@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Jan 10 06:57:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkUhk-0007z5-9f
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 06:57:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659Ab2AJF47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 00:56:59 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63036 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab2AJF46 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 00:56:58 -0500
Received: by wgbdr10 with SMTP id dr10so2639069wgb.1
        for <git@vger.kernel.org>; Mon, 09 Jan 2012 21:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zDNVZcnrYrK7A6jJpSbiMH9YoSr+vbr5QphInyx8tAM=;
        b=JO9dAajVR6fnHlDTJ4MXNKsj5tofFlaDZSS6ckYXoCalN3mClbOiSv469VpN4yodEa
         RDQz0DiR19SkouubXf26qMdUJa00PnW0FQxyvTlSJ6Pq0qInMwTqeJiUKJJqtUe3+KTu
         1hymWbSRFuXHZ8SFHfub+RzzWLiUZCJ/jqy0k=
Received: by 10.180.103.2 with SMTP id fs2mr9559017wib.21.1326175017242; Mon,
 09 Jan 2012 21:56:57 -0800 (PST)
Received: by 10.216.175.3 with HTTP; Mon, 9 Jan 2012 21:56:36 -0800 (PST)
In-Reply-To: <CAPRVejc7xND_8Y=Pb5rYGEcaKYUaX7_WkSro-_EL8tTGxkfY3Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188221>

Hi Bertrand,

Bertrand BENOIT wrote:
> When using git grep, symbolic links are not followed.
> Is it a wanted behavior ?

I'd imagine so: symbolic links are not portable across different file
systems; Git's internal representation of a symbolic link is a file
containing the path of the file to be linked to.

> I've not found information about that in documentation, so I do a report.

Hm, the description says:

Look for specified patterns in the tracked files in the work tree, blobs
registered in the index file, or blobs in given tree objects.

Hm, "tracked files in the work tree" is definitely sub-optimal: "blobs
corresponding to the tracked files in the work tree" is probably
better.  Then again, I think the description is too cryptic for an
end-user: do you have any suggestions?  Have we mentioned how Git
handles symbolic links anywhere in the documentation?  If not, where
should this information go?

-- Ram
