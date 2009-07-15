From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Dividing up a large merge.
Date: Tue, 14 Jul 2009 21:32:14 -0400
Message-ID: <32541b130907141832r5217183wc6a0494d6d77bc06@mail.gmail.com>
References: <20090714233246.GA25390@huya.quicinc.com> <3e8340490907141716j77df346es1f894d6a7f6cb0aa@mail.gmail.com> 
	<20090715002926.GA26630@huya.quicinc.com> <32541b130907141734o59d224i7e0f39aa8a85e8ef@mail.gmail.com> 
	<20090715011914.GA17100@huya.quicinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bryan Donlan <bdonlan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: davidb@quicinc.com
X-From: git-owner@vger.kernel.org Wed Jul 15 03:40:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQtTq-0001kU-5F
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 03:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbZGOBkO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jul 2009 21:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbZGOBkN
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 21:40:13 -0400
Received: from mail-gx0-f213.google.com ([209.85.217.213]:35380 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbZGOBkM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jul 2009 21:40:12 -0400
X-Greylist: delayed 458 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Jul 2009 21:40:12 EDT
Received: by gxk9 with SMTP id 9so1661881gxk.13
        for <git@vger.kernel.org>; Tue, 14 Jul 2009 18:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=hF5TfP5MzH1ku/AHkvC2ACVupJ32rIrk3gQFok4TV2w=;
        b=SlMxs3dwQI65J1opjpwv/Dz9x5a6FXm59HZOEGsdPjYNWkCdG8YBTc70/KCQmz8MVI
         KrhdgNYnZT+CUGQwFHKx4dZN0hZY1Bg6XQvvI+ESzx8LV+RwdOk5tr38mqNvHL939E2Y
         sGCKMOK5Vjx3PwD8FAmDKHkj/+IzRZHjGQYhY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=V9Ayz4K6I8pJ10ZgQ8zXXOWJiWCDC+/803teJ87VCLysX5K5wJHOiBYDR7upPZIXZX
         04LH9OF9lZsYnX6tVhxnIZvLwJdH0Jp48iBCkVYphgb70HEa20BpWlkdJOiR4VGhCZO4
         pKDO7tWQyQoA5PH7jNe153CJwdV1g1TkNB/lk=
Received: by 10.151.113.19 with SMTP id q19mr11374574ybm.245.1247621554060; 
	Tue, 14 Jul 2009 18:32:34 -0700 (PDT)
In-Reply-To: <20090715011914.GA17100@huya.quicinc.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123283>

On Tue, Jul 14, 2009 at 9:19 PM, <davidb@quicinc.com> wrote:
> On Tue, Jul 14, 2009 at 05:34:26PM -0700, Avery Pennarun wrote:
>> How about having one person do the merge, then commit it (including
>> conflict markers), then have other people just make a series of
>> commits removing the conflict markers?
>
> I guess this helps in some sense, but the intermediate result
> isn't going to build, and things like mergetool aren't going to
> work. =A0It's helpful for the individuals to have the full merge
> conflict available, or at least the stages of the files in
> question.

It sounds like you're going in circles a bit here.  You want the full
merge conflict available - but you want it to be able to build.

It sounds like the "git reset the unwanted subdirs" solution suggested
earlier is the only option that will really work.  You could simplify
life for your co-workers by writing a script to automate the steps, I
suppose.

You probably want all the individuals to use merge --squash, so that
you don't mark the history as merged until you're done.  Then you
combine all their work at the end and mark the commit as done using
'git merge -s ours'.

Avery
