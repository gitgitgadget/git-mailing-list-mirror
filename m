From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFH] QGit: how to cram a patch in a crowded screen
Date: Sat, 26 May 2007 10:34:52 +0100
Message-ID: <200705261034.53723.andyparkins@gmail.com>
References: <e5bfff550705260146q51350f40q1c80cfe8079f47c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Marco Costalba" <mcostalba@gmail.com>,
	"Pavel Roskin" <proski@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 26 11:35:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrsgN-0007Gv-Rg
	for gcvg-git@gmane.org; Sat, 26 May 2007 11:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259AbXEZJfZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 05:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753830AbXEZJfZ
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 05:35:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:12112 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259AbXEZJfY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 05:35:24 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1289186ugf
        for <git@vger.kernel.org>; Sat, 26 May 2007 02:35:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Ofe+2zpB/ARdkm1HULpc8SJ8GR+8F5+wdc8mrZ2kRUYlbhJRho0d5YDMaiTdcCMXw3PZPyayCBWufslsgaAA0QD2xvXgoBIgpW7gNShYfNx5ydZJ0u/yZm4rj90vC1XAmCd5Dr23d86mekLN7+9GTbJTTQCWZ2hUwbS1cyvb168=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=t6jumuMkJ62qdf0NvDuNeQCoZNbVxu1h/85BwL3j+4bLJrs7rHnxj8AZj2xHAha0YkgOLKFC9aD4/Wugu2fDgffvBeNFDlcuqg4hrdYcXv9/Jddm5dIlE9uLzopEiAQF2nQez6xxij28NPO7LmWTfqQw5ghiPm3e0LZYIH2tH6U=
Received: by 10.67.94.3 with SMTP id w3mr3564451ugl.1180172122630;
        Sat, 26 May 2007 02:35:22 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTP id 54sm9567945ugp.2007.05.26.02.35.19;
        Sat, 26 May 2007 02:35:19 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <e5bfff550705260146q51350f40q1c80cfe8079f47c6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48464>

On Saturday 2007, May 26, Marco Costalba wrote:

> We need some help, in terms of ideas, to better arrange the
> information to be shown in main view so to improve repo browsability.
>
> I could implement almost anything good comes up in this thread. But
> still I don't figure out myself what is the best solution.
>
> Any suggestion is greatly appreciated.

While reading this I was reminded of something Linus said recently.  The 
default form for exchanging patches is _not_ the diff; it's the email.  
The reason for this is that emails contain author information, log 
information and patch information.  I've often thought that one thing 
we can be reasonably sure of is that the log message will be small.  
Perhaps then, the best thing would be to show each revision in a 
similar manner to how one would view the patch as an email as Pavel 
suggests: all in one.  My patches that made the header information 
appear in a box were a stumble in that direction, making the header 
look a bit like an email header, what about going one step further and 
including the patch in that window as well?

For example, the log view widget would show:

<Header>
<Log Message>
<Patch>

All visually distinct to improve searching by eye (perhaps including 
clear separators between files patched).  Then the file list could 
include a "<header>" psuedo-file that would jump back to the top of the 
viewer.

I think a key feature would be that the log message shows up fast, and 
then the patch is loaded in the background - sometimes patches are big, 
but you still want to hop around revisions without waiting for the 
whole patch to load before you leap to the next view point.

Here's another option, keeping the patch tab, but putting the tab widget 
in the log view window.  That way the list would be visible and you 
would just switch between the log and the patch.

And another idea:  make the log window a tree widget, of sorts, a bit 
like kate in KDE is, each section would begin collapsed (perhaps), it 
would look like:

 + <Header>
 + <Log message>
 + <Patch>

And clicking on the + would expand that section; then for the patch 
itself:

 + <Patch>
   + <File1>
   + <File2>
   + <File3>

In this way the user could get an overview of all the changed files, and 
could view the changes for whatever subset they wanted.  It would 
probably be nice to default the header and log message to expanded, 
with the option to collapse them.




Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
