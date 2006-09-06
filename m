From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Some issues with current qgit on exit
Date: Wed, 6 Sep 2006 19:28:10 +0200
Message-ID: <e5bfff550609061028y25aeb928i2c49d4a5d1be7a60@mail.gmail.com>
References: <1157493650.2803.8.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 06 19:28:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL1CL-0006xk-5u
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 19:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbWIFR2W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 13:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbWIFR2W
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 13:28:22 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:58671 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751770AbWIFR2V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 13:28:21 -0400
Received: by py-out-1112.google.com with SMTP id n25so3751254pyg
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 10:28:20 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ruf1lOdYtGkOTImPDdLRpUWnzXBNEdIESf0so83eOLS+6xEGAchombRcaRVNl8iZZYLJAuFcm9jKVtYYkCt9ZYNsqtGw1tWoGOtGONJpaSBuTfbdLyhIQkMm6OyiGH8Z3KSAXl6wRmXhbhudV+QdBaGkGeJ6Py6L3EGdws1SyAI=
Received: by 10.35.127.7 with SMTP id e7mr15156737pyn;
        Wed, 06 Sep 2006 10:28:20 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Wed, 6 Sep 2006 10:28:10 -0700 (PDT)
To: "Pavel Roskin" <proski@gnu.org>
In-Reply-To: <1157493650.2803.8.camel@dv>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26544>

On 9/6/06, Pavel Roskin <proski@gnu.org> wrote:
> Hi, Marco!
>
Hello Pavel,

  nice to hear you again!

> The current qgit reports assertion failure on exit:
> ASSERT in tabWdg_currentChanged
>
> That's how you can trigger it:
>
> select one of the patches
> double click on the entry to open the "patch" tab
> double click on one of the modified files on the right
> switch back to the "rev list" or "patch" tab
> close qgit by Ctrl-Q
>
> I've tried to debug the problem.  MainImpl::currentTabType() returns -1.
> It's possible that the logic in that function is flawed, or maybe it
> doesn't work properly on exit.
>
> Another problem is segmentation fault when closing qgit with more that
> one file tab and the "rev list" tab selected:
>
> select one of the patches
> select "view file" in the pop-up menu on one of the files
> activate the "rev list" tab
> select "view file in new tab" on the same file
> activate the "rev list" tab
> close qgit by Ctrl-Q
>

Thanks for the very good bug reports. I have just  pushed the fix: it
was a bogus delayed delete on exit the origin of this issues.

I was planning (well, still I am) to release new version this week
end, and your bug report is arrived just in time ;-)

Thanks
Marco
